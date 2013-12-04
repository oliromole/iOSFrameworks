//
//  RFCABridgeAnimationDelegate.m
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

// Importing the header.
#import "RFCABridgeAnimationDelegate.h"

// Importing the system headers.
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@implementation RFCABridgeAnimationDelegate

#pragma mark - Initializing and Creating a RFCABridgeAnimationDelegate

- (id)init
{
    if ((self = [super init]))
    {
        // Setting the default values.
        mDelegate = nil;
    }
    
    return self;
}

#pragma mark - Deallocating a RFCABridgeAnimationDelegate

- (void)dealloc
{
    mDelegate = nil;
}

#pragma mark - Managing the Delegate

@synthesize delegate = mDelegate;

#pragma mark - Conforming the CAAnimationDelegate Protocol

- (void)animationDidStart:(CAAnimation *)animation
{
    // Getting the delegate.
    id<RFCABridgeAnimationDelegate> delegate = self.delegate;
    
    // We can tell the delegate that the animation begins its active duration.
    if ([delegate conformsToProtocol:@protocol(RFCABridgeAnimationDelegate)] &&
        [delegate respondsToSelector:@selector(bridgeAnimationDelegate:animationDidStart:)])
    {
        // Telling the delegate that the animation begins its active duration.
        [delegate bridgeAnimationDelegate:self animationDidStart:animation];
    }
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished
{
    // Getting the delegate.
    id<RFCABridgeAnimationDelegate> delegate = self.delegate;
    
    // We can tell the delegate that the animation completes its active duration or is removed from the object it is attached to.
    if ([delegate conformsToProtocol:@protocol(RFCABridgeAnimationDelegate)] &&
        [delegate respondsToSelector:@selector(bridgeAnimationDelegate:animationDidStop:finished:)])
    {
        // Telling the delegate that the animation completes its active duration or is removed from the object it is attached to.
        [delegate bridgeAnimationDelegate:self animationDidStop:animation finished:finished];
    }
}

@end
