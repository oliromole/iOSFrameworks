//
//  RFUIScreenShooter.h
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

// Importing the project headers.
#import "RFUIScreenShooterImageType.h"

// Importing the system headers.
#import <CoreGraphics/CGBase.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSDate.h>

@class NSDateFormatter;
@class NSString;
@class NSTimer;
@class UIImage;
@class UITapGestureRecognizer;

@interface RFUIScreenShooter : NSObject
{
@private
    
    CGFloat                     mCompressionQuality;
    NSDateFormatter            *mImageNameDateFormatter;
    RFUIScreenShooterImageType  mImageType;
    NSTimer                    *mSaveTimer;
    UITapGestureRecognizer     *mSaveTapGestureRecognizer;
    BOOL                        mScreenshotGestureRecognizerSavingEnabled;
    NSString                   *mScreenshotsPath;
    NSTimeInterval              mTimeInterval;
}

// Getting the RFUIScreenShooter Instance

+ (RFUIScreenShooter *)sharedShooter;

// Configuring the RFUIScreenShooter Object

@property (nonatomic)       CGFloat                     compressionQuality; // Default is 0.75f.
@property (nonatomic)       RFUIScreenShooterImageType  imageType;          // Default is RFUIScreenShooterImageTypePNG.
@property (nonatomic, copy) NSString                   *screenshotsPath;    // Default is expanded path "~/Documents/Screenshots".
@property (nonatomic)       NSTimeInterval              timeInterval;       // Default is 1.0.

// Making a Screenshot

- (UIImage *)copyMakeScreenshotImage;
- (UIImage *)makeScreenshotImage;

// Saving a Screenshot

@property (nonatomic) BOOL screenshotGestureRecognizerSavingEnabled; // Default is NO.

- (BOOL)saveScreenshotImage;
- (BOOL)saveScreenshotImageWithPath:(NSString *)imagePath;
- (BOOL)saveScreenshotImageWithName:(NSString *)imageName;

// Saving Screenshots

@property (nonatomic, readonly) BOOL isSaving;

- (void)startSaving;
- (void)stopSaving;

@end
