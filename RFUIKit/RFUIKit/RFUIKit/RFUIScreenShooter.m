//
//  RFUIScreenShooter.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.02.03.
//  Copyright (c) 2012 Roman Oliichuk. All rights reserved.
//

/*
 Copyright (C) 2012 Roman Oliichuk. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors
 may be used to endorse or promote products derived from this
 software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

// Importing the header.
#import "RFUIScreenShooter.h"

// Importing the external headers.
#import <RECoreGraphics/RECoreGraphics.h>
#import <REFoundation/REFoundation.h>
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

static RFUIScreenShooter * volatile RFUIScreenShooter_SharedShooter = nil;

@interface NSObject ()

@property (nonatomic, strong) UIWindow *mainWindow;

@end

@implementation RFUIScreenShooter

#pragma mark - Getting the RFUIScreenShooter Instance

+ (RFUIScreenShooter *)sharedShooter
{
    if (!RFUIScreenShooter_SharedShooter)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RFUIScreenShooter_SharedShooter)
            {
                RFUIScreenShooter_SharedShooter = [[RFUIScreenShooter alloc] init];
            }
        }
    }
    
    return RFUIScreenShooter_SharedShooter;
}

#pragma mark - Initializing and Creating a RFUIScreenShooter

- (id)init
{
    if ((self = [super init]))
    {
        // Adding self as an observer on UIWindow Notifications.
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidBecomeKeyNotification:) name:UIWindowDidBecomeKeyNotification];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResignKeyNotification:) name:UIWindowDidResignKeyNotification];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        
        mCompressionQuality = 0.75f;
        
        mImageNameDateFormatter = [[NSDateFormatter alloc] init];
        mImageNameDateFormatter.locale = locale;
        mImageNameDateFormatter.dateFormat = @"yyyy.MM.dd HH.mm.ss.SSS";
        
        mImageType = RFUIScreenShooterImageTypePNG;
        mSaveTimer = nil;
        mSaveTapGestureRecognizer = nil;
        mScreenshotGestureRecognizerSavingEnabled = NO;
        
        mScreenshotsPath = [[@"~/Documents/Screenshots" stringByExpandingTildeInPath] copy];
        
        NSError *error = nil;
        BOOL result = [fileManager createDirectoryAtPath:mScreenshotsPath withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (!result &&
            !(error && [error.domain isEqual:NSCocoaErrorDomain] && (error.code == NSFileWriteFileExistsError)))
        {
            NSLog(@"WARNING: The -[%@ %@] method can not create the directory at path:\n%@\nError:\n%@\nUserInfo:\n%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), mScreenshotsPath, error, error.userInfo);
        }
        
        mTimeInterval = 1.0;
    }
    
    return self;
}

#pragma mark - Deallocating a RFUIScreenShooter

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    mImageNameDateFormatter = nil;
    
    [mSaveTimer invalidate];
    mSaveTimer = nil;
    
    [mSaveTapGestureRecognizer removeTarget:self action:NULL];
    [mSaveTapGestureRecognizer removeFromView];
    mSaveTapGestureRecognizer = nil;
    
    mScreenshotsPath = nil;
}

#pragma mark - Configuring the RFUIScreenShooter Object

@synthesize compressionQuality = mCompressionQuality;
@synthesize imageType = mImageType;

- (NSString *)screenshotsPath
{
    return mScreenshotsPath;
}

- (void)setScreenshotsPath:(NSString *)screenshotsPath
{
    if (mScreenshotsPath != screenshotsPath)
    {
        mScreenshotsPath = [[screenshotsPath stringByExpandingTildeInPath] copy];
        
        if (!mScreenshotsPath)
        {
            mScreenshotsPath = [[@"~/Documents/Screenshots" stringByExpandingTildeInPath] copy];
        }
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSError *error = nil;
        BOOL result = [fileManager createDirectoryAtPath:mScreenshotsPath withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (!result &&
            !(error && [error.domain isEqual:NSCocoaErrorDomain] && (error.code == NSFileWriteFileExistsError)))
        {
            NSLog(@"WARNING: The -[%@ %@] method can not create the directory at path:\n%@\nError:\n%@\nUserInfo:\n%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), mScreenshotsPath, error, error.userInfo);
        }
    }
}

@synthesize timeInterval = mTimeInterval;

#pragma mark - Making a Screenshot

- (UIImage *)copyMakeScreenshotImage
{
    UIApplication *application = [UIApplication sharedApplication];
    
    // Getting the status bar orientation.
    
    UIInterfaceOrientation statusBarOrientation = application.statusBarOrientation;
    
    // Getting the windows.
    
    NSArray *windows = application.windows;
    
    // Getting the main window.
    
    id delegate = application.delegate;
    
    UIWindow *mainWindow = nil;
    
    if ([delegate respondsToSelector:@selector(window)])
    {
        mainWindow = [delegate performSelector:@selector(window)];
    }
    
    else if ([delegate respondsToSelector:@selector(mainWindow)])
    {
        mainWindow = [delegate performSelector:@selector(mainWindow)];
    }
    
    if (!mainWindow)
    {
        mainWindow = windows.firstObject;
    }
    
    // Getting the screenshot image size.
    
    CGSize screenshotImageSize;
    CGSize mainWindowSize;
    
    // Status bar orientation is portrait.
    if (UIInterfaceOrientationIsPortrait(statusBarOrientation))
    {
        if (mainWindow)
        {
            CGRect mainWindowBounds = mainWindow.bounds;
            
            screenshotImageSize.width = mainWindowBounds.size.width;
            screenshotImageSize.height = mainWindowBounds.size.height;
            
            mainWindowSize.width = mainWindowBounds.size.width;
            mainWindowSize.height = mainWindowBounds.size.height;
        }
        
        else
        {
            CGRect screenBounds= UI_MAIN_SCREEN_BOUNDS();
            
            screenshotImageSize.width = screenBounds.size.width;
            screenshotImageSize.height = screenBounds.size.height;
            
            mainWindowSize.width = screenBounds.size.width;
            mainWindowSize.height = screenBounds.size.height;
        }
    }
    
    // Status bar orientation is landscape.
    else
    {
        if (mainWindow)
        {
            CGRect mainWindowBounds = mainWindow.bounds;
            
            screenshotImageSize.width = mainWindowBounds.size.height;
            screenshotImageSize.height = mainWindowBounds.size.width;
            
            mainWindowSize.width = mainWindowBounds.size.width;
            mainWindowSize.height = mainWindowBounds.size.height;
        }
        
        else
        {
            CGRect screenBounds= UI_MAIN_SCREEN_BOUNDS();
            
            screenshotImageSize.width = screenBounds.size.height;
            screenshotImageSize.height = screenBounds.size.width;
            
            mainWindowSize.width = screenBounds.size.width;
            mainWindowSize.height = screenBounds.size.height;
        }
    }
    
    // Creating a screenshot image.
    
    CGFloat scale = UI_MAIN_SCREEN_SCALSE();
    
    UIGraphicsBeginImageContextWithOptions(screenshotImageSize, NO, scale);
    
    CGContextRef screenshotContextRef = UIGraphicsGetCurrentContext();
    
    // Setting current transformation matrix (CTM).
    
    CGAffineTransform screenshotContextAffineTransform = CGAffineTransformIdentity;
    
    if (statusBarOrientation == UIInterfaceOrientationPortrait)
    {
        screenshotContextAffineTransform.a = 1.0f;
        screenshotContextAffineTransform.b = 0.0f;
        screenshotContextAffineTransform.c = 0.0f;
        screenshotContextAffineTransform.d = 1.0f;
        screenshotContextAffineTransform.tx = 0.0f;
        screenshotContextAffineTransform.ty = 0.0f;
    }
    
    else if (statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        screenshotContextAffineTransform.a = -1.0f;
        screenshotContextAffineTransform.b = 0.0f;
        screenshotContextAffineTransform.c = 0.0f;
        screenshotContextAffineTransform.d = -1.0f;
        screenshotContextAffineTransform.tx = screenshotImageSize.width;
        screenshotContextAffineTransform.ty = screenshotImageSize.height;
    }
    
    else if (statusBarOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        screenshotContextAffineTransform.a = 0.0f;
        screenshotContextAffineTransform.b = -1.0f;
        screenshotContextAffineTransform.c = 1.0f;
        screenshotContextAffineTransform.d = 0.0f;
        screenshotContextAffineTransform.tx = 0.0f;
        screenshotContextAffineTransform.ty = screenshotImageSize.height;
    }
    
    else if (statusBarOrientation == UIInterfaceOrientationLandscapeRight)
    {
        screenshotContextAffineTransform.a = 0.0f;
        screenshotContextAffineTransform.b = 1.0f;
        screenshotContextAffineTransform.c = -1.0f;
        screenshotContextAffineTransform.d = 0.0f;
        screenshotContextAffineTransform.tx = screenshotImageSize.width;
        screenshotContextAffineTransform.ty = 0.0f;
    }
    
    CGContextSetTransformCTM(screenshotContextRef, screenshotContextAffineTransform);
    
    // Rendering the windows.
    
    for (NSUInteger index = 0; index < windows.count; index++)
    {
        UIWindow *window = [windows objectAtIndex:index];
        
        // Rednering the window.
        
        UIGraphicsBeginImageContextWithOptions(mainWindowSize, NO, scale);
        
        CGContextRef windowContextRef = UIGraphicsGetCurrentContext();
        
        CALayer *windowLayer = window.layer;
        [windowLayer renderInContext:windowContextRef];
        
        CGImageRef windowImageRef = CGBitmapContextCreateImage(windowContextRef);
        
        UIGraphicsEndImageContext();
        windowContextRef = NULL;
        
        // Drawing the window image.
        
        CGRect windowImageFrame;
        windowImageFrame.origin.x = 0.0f;
        windowImageFrame.origin.y = 0.0f;
        windowImageFrame.size.width = scale * mainWindowSize.width;
        windowImageFrame.size.height = scale * mainWindowSize.height;
        
        CGContextDrawImage(screenshotContextRef, windowImageFrame, windowImageRef);
        
        CGImageRelease(windowImageRef);
        windowImageRef = NULL;
    }
    
    // Gettimg the screenshot image.
    
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return screenshotImage;
}

- (UIImage *)makeScreenshotImage
{
    UIImage *screenshot = [self copyMakeScreenshotImage];
    return screenshot;
}

#pragma mark - Saving a Screenshot

- (BOOL)screenshotGestureRecognizerSavingEnabled
{
    return mScreenshotGestureRecognizerSavingEnabled;
}

- (void)setScreenshotGestureRecognizerSavingEnabled:(BOOL)screenshotGestureRecognizerSavingEnabled
{
    if (mScreenshotGestureRecognizerSavingEnabled != screenshotGestureRecognizerSavingEnabled)
    {
        mScreenshotGestureRecognizerSavingEnabled = screenshotGestureRecognizerSavingEnabled;
        
        if (mSaveTapGestureRecognizer)
        {
            [mSaveTapGestureRecognizer removeTarget:self action:NULL];
            [mSaveTapGestureRecognizer removeFromView];
            mSaveTapGestureRecognizer = nil;
        }
        
        if (mScreenshotGestureRecognizerSavingEnabled)
        {
            UIApplication *application = [UIApplication sharedApplication];
            UIWindow *keyWindow = application.keyWindow;
            
            if (keyWindow)
            {
                mSaveTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveTapGestureRecognizerAction:)];
                mSaveTapGestureRecognizer.numberOfTapsRequired = 3;
                mSaveTapGestureRecognizer.numberOfTouchesRequired = 1;
                
                [keyWindow addGestureRecognizer:mSaveTapGestureRecognizer];
            }
        }
    }
}

- (void)saveTapGestureRecognizerAction:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (tapGestureRecognizer && (tapGestureRecognizer == mSaveTapGestureRecognizer))
    {
        [self saveScreenshotImage];
    }
}

- (BOOL)saveScreenshotImage
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0];
    
    NSString *dateString = [mImageNameDateFormatter stringFromDate:date];
    
    NSMutableString *imageName = [[NSMutableString alloc] init];
    [imageName appendString:@"Screenshot "];
    [imageName appendString:dateString];
    
    CGFloat scale = UI_MAIN_SCREEN_SCALSE();
    
    if (scale == 2.0f)
    {
        [imageName appendFormat:@"@%.0fx", scale];
    }
    
    if (mImageType == RFUIScreenShooterImageTypePNG)
    {
        [imageName appendString:@".png"];
    }
    
    else if (mImageType == RFUIScreenShooterImageTypeJPEG)
    {
        [imageName appendString:@".jpg"];
    }
    
    BOOL result = [self saveScreenshotImageWithName:imageName];
    
    return result;
}

- (BOOL)saveScreenshotImageWithPath:(NSString *)imagePath
{
    BOOL result = NO;
    
    if (imagePath.length > 0)
    {
        UIImage *screenshotImage = [self copyMakeScreenshotImage];
        
        if (screenshotImage)
        {
            NSData *screenshotData = nil;
            
            if (mImageType == RFUIScreenShooterImageTypePNG)
            {
                screenshotData = UIImagePNGRepresentation(screenshotImage);
            }
            
            else if (mImageType == RFUIScreenShooterImageTypeJPEG)
            {
                screenshotData = UIImageJPEGRepresentation(screenshotImage, mCompressionQuality);
            }
            
            if (screenshotData)
            {
                result = [screenshotData writeToFile:imagePath atomically:YES];
            }
        }
    }
    
    return result;
}

- (BOOL)saveScreenshotImageWithName:(NSString *)imageName
{
    NSString *imagePath = [mScreenshotsPath stringByAppendingPathComponent:imageName];
    BOOL result = [self saveScreenshotImageWithPath:imagePath];
    return result;
}

#pragma mark - Saving Screenshots

- (BOOL)isSaving
{
    BOOL isSaving = (mSaveTimer != nil);
    return isSaving;
}

- (void)saveTimerAction:(NSTimer *)timer
{
    if (timer && (timer == mSaveTimer))
    {
        [self saveScreenshotImage];
    }
}

- (void)startSaving
{
    if (!mSaveTimer)
    {
        mSaveTimer = [NSTimer timerWithTimeInterval:mTimeInterval target:self selector:@selector(saveTimerAction:) repeats:YES];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        
        [runLoop addTimer:mSaveTimer forMode:NSRunLoopCommonModes];
        [runLoop addTimer:mSaveTimer forMode:UITrackingRunLoopMode];
    }
}

- (void)stopSaving
{
    if (mSaveTimer)
    {
        [mSaveTimer invalidate];
        mSaveTimer = nil;
    }
}

#pragma mark - Notifications

#pragma mark - UIWindow Notifications

- (void)windowDidBecomeKeyNotification:(NSNotification *)notification
{
    if (NSNotificationEqualToNotificationName(notification, UIWindowDidBecomeKeyNotification))
    {
        if (mScreenshotGestureRecognizerSavingEnabled)
        {
            if (mSaveTapGestureRecognizer)
            {
                [mSaveTapGestureRecognizer removeTarget:self action:NULL];
                [mSaveTapGestureRecognizer removeFromView];
                mSaveTapGestureRecognizer = nil;
            }
            
            if (mScreenshotGestureRecognizerSavingEnabled)
            {
                UIApplication *application = [UIApplication sharedApplication];
                NSArray *windows = application.windows;
                
                UIWindow *keyWindow = nil;
                
                for (UIWindow *window in windows)
                {
                    if (window.keyWindow)
                    {
                        keyWindow = window;
                        break;
                    }
                }
                
                if (keyWindow)
                {
                    mSaveTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveTapGestureRecognizerAction:)];
                    mSaveTapGestureRecognizer.numberOfTapsRequired = 3;
                    mSaveTapGestureRecognizer.numberOfTouchesRequired = 1;
                    
                    [keyWindow addGestureRecognizer:mSaveTapGestureRecognizer];
                }
            }
        }
    }
}

- (void)windowDidResignKeyNotification:(NSNotification *)notification
{
    if (NSNotificationEqualToNotificationName(notification, UIWindowDidResignKeyNotification))
    {
        if (mSaveTapGestureRecognizer)
        {
            UIWindow *window = (UIWindow *)mSaveTapGestureRecognizer.view;
            
            if (!window || ![window respondsToSelector:@selector(keyWindow)] || !window.keyWindow)
            {
                [mSaveTapGestureRecognizer removeTarget:self action:NULL];
                [mSaveTapGestureRecognizer removeFromView];
                mSaveTapGestureRecognizer = nil;
            }
        }
    }
}

@end
