//
//  RFMKSproutAnimation.m
//  RFMapKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.10.16.
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
#import "RFMKSproutAnimation.h"

// Importing the external headers.
#import <RECoreGraphics/RECoreGraphics.h>
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@implementation RFMKSproutAnimation

#pragma mark - Initializing and Creating a RFMKSproutAnimation

- (id)init
{
    if ((self = [super init]))
    {
        // Setting the default values.
        mAnimationTimeInterval = 0.25;
        mBetweenAnimationTimeInterval = 0.01;
        mDelay = 0.0;
        mDelayCounter = 0;
        mDelayTimeInterval = 0.0;
        mMinimumSize = CGSizeOne;
    }
    
    return self;
}

#pragma mark - Deallocating a RFMKSproutAnimation

- (void)dealloc
{
}

#pragma mark - Configuring the Sprout Animation

@synthesize animationTimeInterval = mAnimationTimeInterval;
@synthesize betweenAnimationTimeInterval = mBetweenAnimationTimeInterval;
@synthesize minimumSize = mMinimumSize;

#pragma mark - Marks the beginning of a begin/end animation block.

- (NSTimeInterval)beginDelay
{
    // Declaring some variables.
    NSTimeInterval delay;
    
    // Incrementing the delay counter.
    mDelayCounter++;
    
    // It is the first beginning delay at this time.
    if (mDelayCounter == 1)
    {
        // Saving the first time interval.
        mDelayTimeInterval = [NSDate timeIntervalSince1970];
        
        // Calculating the delay.
        delay = mDelay;
        mDelay = mBetweenAnimationTimeInterval;
    }
    
    // It is the N beginning delay at this time.
    else
    {
        // Calculating the correction time interval for the delay.
        NSTimeInterval correctionTimeInterval = [NSDate timeIntervalSinceTimeInterval1970:mDelayTimeInterval];
        
        // Calculating the delay.
        delay = mDelay - correctionTimeInterval;
        mDelay = mDelay + mBetweenAnimationTimeInterval;
    }
    
    // The delay is invalid.
    // We must correct the delay.
    if (delay < 0.0)
    {
        // Correcting the delay.
        delay = 0.0;
    }
    
    // Returning the delay.
    return delay;
}

- (void)endDelay
{
    // Decrementing the delay counter.
    mDelayCounter--;
    
    // We ended all delay at this time.
    if (mDelayCounter == 0)
    {
        // Setting the values.
        mDelay = 0.0;
        mDelayTimeInterval = 0.0;
    }
}

#pragma mark - Configuring a View

- (CGAffineTransform)fromTransformWithSize:(CGSize)size
{
    CGSize minimumSize = CGSizeIntersection(size, mMinimumSize);
    
    CGAffineTransform fromTransform;
    fromTransform.a = minimumSize.width / size.width;
    fromTransform.b = 0.0f;
    fromTransform.c = 0.0f;
    fromTransform.d = minimumSize.height / size.height;
    fromTransform.tx = 0.0f;
    fromTransform.ty = size.height / 2.0f;
    
    return fromTransform;
}

- (CGAffineTransform)toTransformWithSize:(CGSize)size
{
#pragma unused(size)
    
    return CGAffineTransformIdentity;
}

- (CATransform3D)fromTransform3DWithSize:(CGSize)size
{
    CGSize minimumSize = CGSizeIntersection(size, mMinimumSize);
    
    CATransform3D fromTransform3D = CATransform3DIdentity;
    fromTransform3D.m11 = minimumSize.width / size.width;
    fromTransform3D.m12 = 0.0f;
    fromTransform3D.m13 = 0.0f;
    fromTransform3D.m14 = 0.0f;
    fromTransform3D.m21 = size.height / 2.0f;
    fromTransform3D.m22 = minimumSize.height / size.height;
    fromTransform3D.m23 = 0.0f;
    fromTransform3D.m24 = 0.0f;
    fromTransform3D.m31 = 0.0f;
    fromTransform3D.m32 = 0.0f;
    fromTransform3D.m33 = 1.0f;
    fromTransform3D.m34 = 0.0f;
    fromTransform3D.m41 = 0.0f;
    fromTransform3D.m42 = 0.0f;
    fromTransform3D.m43 = 0.0f;
    fromTransform3D.m44 = 1.0f;
    
    return fromTransform3D;
}

- (CATransform3D)toTransform3DWithSize:(CGSize)size
{
#pragma unused(size)
    
    return CATransform3DIdentity;
}

@end
