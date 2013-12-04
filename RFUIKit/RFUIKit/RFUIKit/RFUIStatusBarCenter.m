//
//  RFUIStatusBarCenter.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.08.08.
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
#import "RFUIStatusBarCenter.h"

// Importing the project headers.
#import "RFUIStatusBarLayoutView.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NSString * const RFUIStatusBarCenterWillChangeStatusBarFrameNotification = @"RFUIStatusBarCenterWillChangeStatusBarFrameNotification";
NSString * const RFUIStatusBarCenterDidChangeStatusBarFrameNotification = @"RFUIStatusBarCenterDidChangeStatusBarFrameNotification";

NSString * const RFUIStatusBarCenterWillChangeStatusBarOrientationNotification = @"RFUIStatusBarCenterWillChangeStatusBarOrientationNotification";
NSString * const RFUIStatusBarCenterDidChangeStatusBarOrientationNotification = @"RFUIStatusBarCenterDidChangeStatusBarOrientationNotification";

static RFUIStatusBarCenter * volatile RFUIStatusBarCenter_SharedCenter = nil;

@implementation RFUIStatusBarCenter

#pragma mark - Getting the RFUIStatusBarCenter Instance

+ (RFUIStatusBarCenter *)sharedCenter
{
    if (!RFUIStatusBarCenter_SharedCenter)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RFUIStatusBarCenter_SharedCenter)
            {
                RFUIStatusBarCenter_SharedCenter = [[RFUIStatusBarCenter alloc] init];
            }
        }
    }
    
    return RFUIStatusBarCenter_SharedCenter;
}

#pragma mark - Initializing and Creating a RFUIStatusBarCenter

- (id)init
{
    if ((self = [super init]))
    {
        // Adding self as an observer on UIApplication Notifications.
        
        UIApplication *application = [UIApplication sharedApplication];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillChangeStatusBarFrameNotification:) name:UIApplicationWillChangeStatusBarFrameNotification object:application];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidChangeStatusBarFrameNotification:) name:UIApplicationDidChangeStatusBarFrameNotification object:application];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillChangeStatusBarOrientationNotification:) name:UIApplicationWillChangeStatusBarOrientationNotification object:application];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidChangeStatusBarOrientationNotification:) name:UIApplicationDidChangeStatusBarOrientationNotification object:application];
        
        mIsInterfaceOrientationChanging = NO;
        mIsFrameChanging = NO;
        mInterfaceOrientationBegin = application.statusBarOrientation;
        mInterfaceOrientationEnd = application.statusBarOrientation;
        mFrameBegin = application.statusBarFrame;
        mFrameEnd = application.statusBarFrame;
    }
    
    return self;
}

#pragma mark - Deallocating a RFUIStatusBarCenter

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Managing Status Bar Interface Orientation

- (UIInterfaceOrientation)interfaceOrientation
{
    UIApplication *application = [UIApplication sharedApplication];
    UIInterfaceOrientation interfaceOrientation = application.statusBarOrientation;
    return interfaceOrientation;
}

- (void)setInterfaceOrientation:(UIInterfaceOrientation)newInterfaceOrientation
{
    UIApplication *application = [UIApplication sharedApplication];
    UIInterfaceOrientation oldInterfaceOrientation = application.statusBarOrientation;
    
    if (oldInterfaceOrientation != newInterfaceOrientation)
    {
        application.statusBarOrientation = newInterfaceOrientation;
    }
}

- (void)setInterfaceOrientation:(UIInterfaceOrientation)newInterfaceOrientation animated:(BOOL)animated
{
    UIApplication *application = [UIApplication sharedApplication];
    UIInterfaceOrientation oldInterfaceOrientation = application.statusBarOrientation;
    
    if (oldInterfaceOrientation != newInterfaceOrientation)
    {
        [application setStatusBarOrientation:newInterfaceOrientation animated:animated];
    }
}

- (NSTimeInterval)interfaceOrientationAnimationDuration
{
    UIApplication *application = [UIApplication sharedApplication];
    NSTimeInterval interfaceOrientationAnimationDuration = application.statusBarOrientationAnimationDuration;
    return interfaceOrientationAnimationDuration;
}

#pragma mark - Controlling Status Bar Appearance

- (UIStatusBarStyle)style
{
    UIApplication *application = [UIApplication sharedApplication];
    UIStatusBarStyle style = application.statusBarStyle;
    return style;
}

- (void)setStyle:(UIStatusBarStyle)newStyle
{
    UIApplication *application = [UIApplication sharedApplication];
    UIStatusBarStyle oldStyle = application.statusBarStyle;
    
    if (oldStyle != newStyle)
    {
        application.statusBarStyle = newStyle;
    }
}

- (void)setStyle:(UIStatusBarStyle)newStyle animated:(BOOL)animated
{
    UIApplication *application = [UIApplication sharedApplication];
    UIStatusBarStyle oldStyle = application.statusBarStyle;
    
    if (oldStyle != newStyle)
    {
        [application setStatusBarStyle:newStyle animated:animated];
    }
}

- (BOOL)hidden
{
    UIApplication *application = [UIApplication sharedApplication];
    BOOL hidden = application.statusBarHidden;
    return hidden;
}

- (void)setHidden:(BOOL)newHidden
{
    UIApplication *application = [UIApplication sharedApplication];
    BOOL oldHidden = application.statusBarHidden;
    
    if (oldHidden != newHidden)
    {
        application.statusBarHidden = newHidden;
    }
}

- (void)setHidden:(BOOL)newHidden withAnimation:(UIStatusBarAnimation)animation
{
    UIApplication *application = [UIApplication sharedApplication];
    BOOL oldHidden = application.statusBarHidden;
    
    if (oldHidden != newHidden)
    {
        [application setStatusBarHidden:newHidden withAnimation:animation];
    }
}

- (CGRect)frame
{
    UIApplication *application = [UIApplication sharedApplication];
    CGRect frame = application.statusBarFrame;
    return frame;
}

#pragma mark - Getting the Information of Status Bar Interface Orientation

@synthesize interfaceOrientationBegin = mInterfaceOrientationBegin;
@synthesize interfaceOrientationEnd = mInterfaceOrientationEnd;
@synthesize isInterfaceOrientationChanging = mIsInterfaceOrientationChanging;

#pragma mark - Getting the Information of Status Bar Frame

@synthesize frameBegin = mFrameBegin;
@synthesize frameEnd = mFrameEnd;
@synthesize isFrameChanging = mIsFrameChanging;

#pragma mark - Sending RFUIStatusBarCenter Events

- (void)sendStatusBarCenterWillChangeStatusBarFrameMessageToView:(UIView *)view
{
    if ([view isKindOfClass:[RFUIStatusBarLayoutView class]])
    {
        RFUIStatusBarLayoutView *statusBarLayoutView = (RFUIStatusBarLayoutView *)view;
        
        [statusBarLayoutView statusBarCenterWillChangeStatusBarFrame];
    }
    
    else
    {
        NSArray *subviews = [view.subviews copy];
        
        for (NSUInteger index = 0; index < subviews.count; index++)
        {
            UIView *subview = [subviews objectAtIndex:index];
            
            [self sendStatusBarCenterWillChangeStatusBarFrameMessageToView:subview];
        }
    }
}

- (void)sendStatusBarCenterWillChangeStatusBarFrameMessageToAllWindows
{
    NSArray *windows = [[UIApplication sharedApplication].windows copy];
    
    for (NSUInteger index = 0; index < windows.count; index++)
    {
        UIWindow *window = [windows objectAtIndex:index];
        
        [self sendStatusBarCenterWillChangeStatusBarFrameMessageToView:window];
    }
}

- (void)sendStatusBarCenterDidChangeStatusBarFrameMessageToView:(UIView *)view
{
    if ([view isKindOfClass:[RFUIStatusBarLayoutView class]])
    {
        RFUIStatusBarLayoutView *statusBarLayoutView = (RFUIStatusBarLayoutView *)view;
        
        [statusBarLayoutView statusBarCenterDidChangeStatusBarFrame];
    }
    
    else
    {
        NSArray *subviews = [view.subviews copy];
        
        for (NSUInteger index = 0; index < subviews.count; index++)
        {
            UIView *subview = [subviews objectAtIndex:index];
            
            [self sendStatusBarCenterDidChangeStatusBarFrameMessageToView:subview];
        }
    }
}

- (void)sendStatusBarCenterDidChangeStatusBarFrameMessageToAllWindows
{
    NSArray *windows = [[UIApplication sharedApplication].windows copy];
    
    for (NSUInteger index = 0; index < windows.count; index++)
    {
        UIWindow *window = [windows objectAtIndex:index];
        
        [self sendStatusBarCenterDidChangeStatusBarFrameMessageToView:window];
    }
}

- (void)sendStatusBarCenterWillChangeStatusBarOrientationMessageToView:(UIView *)view
{
    if ([view isKindOfClass:[RFUIStatusBarLayoutView class]])
    {
        RFUIStatusBarLayoutView *statusBarLayoutView = (RFUIStatusBarLayoutView *)view;
        
        [statusBarLayoutView statusBarCenterWillChangeStatusBarOrientationFrame];
    }
    
    else
    {
        NSArray *subviews = [view.subviews copy];
        
        for (NSUInteger index = 0; index < subviews.count; index++)
        {
            UIView *subview = [subviews objectAtIndex:index];
            
            [self sendStatusBarCenterWillChangeStatusBarOrientationMessageToView:subview];
        }
    }
}

- (void)sendStatusBarCenterWillChangeStatusBarOrientationMessageToAllWindows
{
    NSArray *windows = [[UIApplication sharedApplication].windows copy];
    
    for (NSUInteger index = 0; index < windows.count; index++)
    {
        UIWindow *window = [windows objectAtIndex:index];
        
        [self sendStatusBarCenterWillChangeStatusBarOrientationMessageToView:window];
    }
}

- (void)sendStatusBarCenterDidChangeStatusBarOrientationMessageToView:(UIView *)view
{
    if ([view isKindOfClass:[RFUIStatusBarLayoutView class]])
    {
        RFUIStatusBarLayoutView *statusBarLayoutView = (RFUIStatusBarLayoutView *)view;
        
        [statusBarLayoutView statusBarCenterDidChangeStatusBarOrientationFrame];
    }
    
    else
    {
        NSArray *subviews = [view.subviews copy];
        
        for (NSUInteger index = 0; index < subviews.count; index++)
        {
            UIView *subview = [subviews objectAtIndex:index];
            
            [self sendStatusBarCenterDidChangeStatusBarOrientationMessageToView:subview];
        }
    }
}

- (void)sendStatusBarCenterDidChangeStatusBarOrientationMessageToAllWindows
{
    NSArray *windows = [[UIApplication sharedApplication].windows copy];
    
    for (NSUInteger index = 0; index < windows.count; index++)
    {
        UIWindow *window = [windows objectAtIndex:index];
        
        [self sendStatusBarCenterDidChangeStatusBarOrientationMessageToView:window];
    }
}

#pragma mark - Notifications

#pragma mark UIApplication Notifications

- (void)applicationWillChangeStatusBarFrameNotification:(NSNotification *)notification
{
    UIApplication *application = [UIApplication sharedApplication];
    
    if (NSNotificationEqualToNotificationNameAndObject(notification, UIApplicationWillChangeStatusBarFrameNotification, application))
    {
        NSDictionary *userInfo = [notification userInfo];
        
        mFrameBegin = application.statusBarFrame;
        
        NSValue *mFrameEndValue = [userInfo objectForKey:UIApplicationStatusBarFrameUserInfoKey];
        mFrameEnd = [mFrameEndValue CGRectValue];
        
        mIsFrameChanging = YES;
        
        [self sendStatusBarCenterWillChangeStatusBarFrameMessageToAllWindows];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RFUIStatusBarCenterWillChangeStatusBarFrameNotification object:self userInfo:nil];
    }
}

- (void)applicationDidChangeStatusBarFrameNotification:(NSNotification *)notification
{
    UIApplication *application = [UIApplication sharedApplication];
    
    if (NSNotificationEqualToNotificationNameAndObject(notification, UIApplicationDidChangeStatusBarFrameNotification, application))
    {
        NSDictionary *userInfo = [notification userInfo];
        
        NSValue *frameBeginValue = [userInfo objectForKey:UIApplicationStatusBarFrameUserInfoKey];
        mFrameBegin = [frameBeginValue CGRectValue];
        
        mFrameEnd = application.statusBarFrame;
        
        mIsFrameChanging = NO;
        
        [self sendStatusBarCenterDidChangeStatusBarFrameMessageToAllWindows];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RFUIStatusBarCenterDidChangeStatusBarFrameNotification object:self userInfo:nil];
    }
}

- (void)applicationWillChangeStatusBarOrientationNotification:(NSNotification *)notification
{
    UIApplication *application = [UIApplication sharedApplication];
    
    if (NSNotificationEqualToNotificationNameAndObject(notification, UIApplicationWillChangeStatusBarOrientationNotification, application))
    {
        NSDictionary *userInfo = [notification userInfo];
        
        mInterfaceOrientationBegin = application.statusBarOrientation;
        
        NSNumber *interfaceOrientationEndNumber = [userInfo objectForKey:UIApplicationStatusBarOrientationUserInfoKey];
        mInterfaceOrientationEnd = (UIInterfaceOrientation)[interfaceOrientationEndNumber integerValue];
        
        mIsInterfaceOrientationChanging = YES;
        
        [self sendStatusBarCenterWillChangeStatusBarOrientationMessageToAllWindows];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RFUIStatusBarCenterWillChangeStatusBarOrientationNotification object:self userInfo:nil];
    }
}

- (void)applicationDidChangeStatusBarOrientationNotification:(NSNotification *)notification
{
    UIApplication *application = [UIApplication sharedApplication];
    
    if (NSNotificationEqualToNotificationNameAndObject(notification, UIApplicationDidChangeStatusBarOrientationNotification, application))
    {
        NSDictionary *userInfo = [notification userInfo];
        
        NSNumber *interfaceOrientationBeginNumber = [userInfo objectForKey:UIApplicationStatusBarOrientationUserInfoKey];
        mInterfaceOrientationBegin = (UIInterfaceOrientation)[interfaceOrientationBeginNumber integerValue];
        
        mInterfaceOrientationEnd = application.statusBarOrientation;
        
        mIsInterfaceOrientationChanging = NO;
        
        [self sendStatusBarCenterDidChangeStatusBarOrientationMessageToAllWindows];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RFUIStatusBarCenterDidChangeStatusBarOrientationNotification object:self userInfo:nil];
    }
}

@end
