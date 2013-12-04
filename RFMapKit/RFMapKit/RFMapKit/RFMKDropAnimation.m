//
//  RFMKDropAnimation.m
//  RFMapKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.08.10.
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
#import "RFMKDropAnimation.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>
#import <REMapKit/REMapKit.h>

// Importing the system headers.
#import <UIKit/UIKit.h>

// Importing the system headers.
#import <libkern/OSAtomic.h>

volatile BOOL RFMKDropAnimationIsInitialized = NO;

CGPoint RFMKDropAnimationDropOffset = {0.0f, 0.0f};
CGPoint RFMKDropAnimationShadowOffset = {0.0f, 0.0f};

NSTimeInterval       RFMKDropAnimationTimeInterval = 1.0;
NSTimeInterval       RFMKDropAnimationDelay = 0.0;
volatile int32_t     RFMKDropAnimationDelayCounter = 0;
volatile OSSpinLock  RFMKDropAnimationDelaySpinLock = 0;
NSTimeInterval       RFMKDropAnimationDelayStep = 0.0;
NSTimeInterval       RFMKDropAnimationDelayTimeInterval = 0;

void RFMKDropAnimationInitialize(void);

void RFMKDropAnimationInitialize(void)
{
    // We need to initialize the RFMKDropAnimation.
    if (!RFMKDropAnimationIsInitialized)
    {
        // Getting the Singleton Synchronizer instance.
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        // Locking the critical section.
        @synchronized(singletonSynchronizer)
        {
            // We need to initialize the RFMKDropAnimation.
            if (!RFMKDropAnimationIsInitialized)
            {
                // Getting the screen bounds.
                CGRect screenBounds = [UIScreen mainScreen].bounds;
                
                // Calculating the drop offset.
                RFMKDropAnimationDropOffset.x = 0;
                RFMKDropAnimationDropOffset.y = -(MAX(screenBounds.size.width, screenBounds.size.height));
                
                // Calculating the shaow length.
                double shadowLength = ((RFMKDropAnimationDropOffset.y * sin(M_PI - RE_MK_MAP_VIEW_SHADOW_ANDGEL - RE_MK_MAP_VIEW_SUN_ANGEL)) / sin(RE_MK_MAP_VIEW_SUN_ANGEL));
                
                // Calculating the shadow offset
                RFMKDropAnimationShadowOffset.x = RFMKDropAnimationDropOffset.x -((CGFloat)(shadowLength * sin(RE_MK_MAP_VIEW_SHADOW_ANDGEL)));
                RFMKDropAnimationShadowOffset.y = ((CGFloat)(shadowLength * cos(RE_MK_MAP_VIEW_SHADOW_ANDGEL)));
                
                // Setting the default timer interval.
                RFMKDropAnimationTimeInterval = 1.0;
                
                // Setting the default delay,
                RFMKDropAnimationDelay = 0.0f;
                RFMKDropAnimationDelayCounter = 0;
                RFMKDropAnimationDelaySpinLock = 0;
                RFMKDropAnimationDelayStep = 0.1;
                RFMKDropAnimationDelayTimeInterval = 0.0;
                
                // Setting the flag that RFMKDropAnimation is initiaized.
                RFMKDropAnimationIsInitialized = YES;
            }
        }
    }
}

CGPoint RFMKDropAnimationGetDropOffset(void)
{
    // Initializing the drop animation.
    RFMKDropAnimationInitialize();
    
    // Returning the drop offset.
    return RFMKDropAnimationDropOffset;
}

CGPoint RFMKDropAnimationGetShadowOffset(void)
{
    // Initializing the drop animation.
    RFMKDropAnimationInitialize();
    
    // Returning the shadow offset.
    return RFMKDropAnimationShadowOffset;
}

NSTimeInterval RFMKDropAnimationGetTimeInterval(void)
{
    // Initializing the drop animation.
    RFMKDropAnimationInitialize();
    
    // Returning the time interval.
    return RFMKDropAnimationTimeInterval;
}

NSTimeInterval RFMKDropAnimationBeginDelay(void)
{
    // Initializing the drop animation.
    RFMKDropAnimationInitialize();
    
    // Locking the critical section.
    OSSpinLockLock(&RFMKDropAnimationDelaySpinLock);
    
    // Incrementing the delay counter.
    int32_t delayCounter = OSAtomicIncrement32Barrier(&RFMKDropAnimationDelayCounter);
    RENSCAssert(delayCounter > 0, @"The RFMKDropAnimation is used incorrectly.");
    
    // Declaring some variables.
    NSTimeInterval delay;
    
    // It is the first beginning delay at this time.
    if (delayCounter == 1)
    {
        // Saving the first time interval.
        RFMKDropAnimationDelayTimeInterval = [NSDate timeIntervalSince1970];
        
        // Calculating the delay.
        delay = RFMKDropAnimationDelay;
        RFMKDropAnimationDelay = RFMKDropAnimationDelay + RFMKDropAnimationDelayStep;
    }
    
    // It is the N beginning delay at this time.
    else
    {
        // Calculating the correction time interval for the delay.
        NSTimeInterval correctionTimeInterval = [NSDate timeIntervalSinceTimeInterval1970:RFMKDropAnimationDelayTimeInterval];
        
        // Calculating the delay.
        delay = RFMKDropAnimationDelay - correctionTimeInterval;
        RFMKDropAnimationDelay = RFMKDropAnimationDelay + RFMKDropAnimationDelayStep;
    }
    
    // The delay is invalid.
    // We must correct the delay.
    if (delay < 0.0)
    {
        // Correcting the delay.
        delay = 0.0;
    }
    
    // Unlocking the critical section.
    OSSpinLockUnlock(&RFMKDropAnimationDelaySpinLock);
    
    // Returning the delay.
    return delay;
}

void RFMKDropAnimationEndDelay(void)
{
    // Initializing the drop animation.
    RFMKDropAnimationInitialize();
    
    // Locking the critical section.
    OSSpinLockLock(&RFMKDropAnimationDelaySpinLock);
    
    // Decrementing the delay counter.
    int32_t delayCounter = OSAtomicDecrement32Barrier(&RFMKDropAnimationDelayCounter);
    RENSCAssert(delayCounter >= 0, @"The RFMKDropAnimation is used incorrectly.");
    
    // We ended all delay at this time.
    if (delayCounter == 0)
    {
        // Setting the values.
        RFMKDropAnimationDelay = 0.0;
        RFMKDropAnimationDelayTimeInterval = 0.0;
    }
    
    // Unlocking the critical section.
    OSSpinLockUnlock(&RFMKDropAnimationDelaySpinLock);
}
