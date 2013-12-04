//
//  RFUINetworkActivityIndicator.h
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2011.08.30.
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

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>

@class NSRecursiveLock;
@class NSString;

@class RFUINetworkActivityIndicator;

@interface RFUINetworkActivityIndicator : NSObject
{
    NSInteger        mCondition;
    NSRecursiveLock *mLock;
    BOOL             mNeedsBlink;
    BOOL             mNeedsUpdate;
}

// Getting the RFUIKeyboardCenter Instance

+ (RFUINetworkActivityIndicator *)sharedIndicator;

// Returning the Condition

@property (atomic, readonly) NSInteger condition;

// Showing and Hiding and Blinking the Indicator

- (void)blink;

- (void)show;
- (void)showWithBlinked:(BOOL)blinked;
- (void)showWithCondition:(NSInteger)condition;
- (void)showWithCondition:(NSInteger)condition blinked:(BOOL)blinked;

- (void)hide;
- (void)hideWithBlinked:(BOOL)blinked;
- (void)hideWithCondition:(NSInteger)condition;
- (void)hideWithCondition:(NSInteger)condition blinked:(BOOL)blinked;

- (void)hidden:(BOOL)hidden;
- (void)hidden:(BOOL)hidden blinked:(BOOL)blinked;
- (void)hidden:(BOOL)hidden condition:(NSInteger)condition;
- (void)hidden:(BOOL)hidden condition:(NSInteger)condition blinked:(BOOL)blinked;

@end

FOUNDATION_EXTERN NSString * const RFUINetworkActivityIndicatorDidBlinkNotification;
FOUNDATION_EXTERN NSString * const RFUINetworkActivityIndicatorDidHideNotification;
FOUNDATION_EXTERN NSString * const RFUINetworkActivityIndicatorDidShowNotification;
