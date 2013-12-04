//
//  RFCABridgeAnimationDelegate.h
//  RFQuartzCore
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.10.22.
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

@class CAAnimation;

@protocol RFCABridgeAnimationDelegate;

@interface RFCABridgeAnimationDelegate : NSObject
{
@protected
    
    id<RFCABridgeAnimationDelegate> __weak mDelegate;
}

// Managing the Delegate

/*!
 @property delegate
 @abstract The delegate of the bridge animation delegate object.
 @discussion The delegate must adopt the RFCABridgeAnimationDelegate protocol. The RFCABridgeAnimationDelegate class, which does not retain the delegate, invokes each protocol method the delegate implements.
 */
@property (nonatomic, weak) id<RFCABridgeAnimationDelegate> delegate;

@end

@protocol RFCABridgeAnimationDelegate <NSObject>

@optional

/*!
 @method bridgeAnimationDelegate:animationDidStart:
 @discussion Called when the animation begins its active duration.
 @param bridgeAnimationDelegate An object that serves as a bridge.
 @param animation The CAAnimation instance that started animating.
 */
- (void)bridgeAnimationDelegate:(RFCABridgeAnimationDelegate *)bridgeAnimationDelegate animationDidStart:(CAAnimation *)animation;

/*!
 @method bridgeAnimationDelegate:animationDidStop:finished:
 @discussion Called when the animation completes its active duration or is removed from the object it is attached to.
 @param bridgeAnimationDelegate An object that serves as a bridge.
 @param animation The CAAnimation instance that started animating.
 */
- (void)bridgeAnimationDelegate:(RFCABridgeAnimationDelegate *)bridgeAnimationDelegate animationDidStop:(CAAnimation *)animation finished:(BOOL)finished;

@end
