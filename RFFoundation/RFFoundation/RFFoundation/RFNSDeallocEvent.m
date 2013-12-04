//
//  RFNSDeallocEvent.m
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.11.03.
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
#import "RFNSDeallocEvent.h"

// Importing the project headers.
#import "RFNSTargetActionPair.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RFNSDeallocEvent

#pragma mark - Initializing and Creating a RFNSDeallocEvent

- (id)init
{
    if ((self = [super init]))
    {
        // Setting the default values.
        mAction = NULL;
        mTarget = nil;
    }
    
    return self;
}

+ (id)deallocEvent
{
    return [[self alloc] init];
}

- (id)initWithTarget:(id)target action:(SEL)action
{
    if ((self = [self init]))
    {
        // Saving the target and the action.
        self.target = target;
        self.action = action;
    }
    
    return self;
}

+ (id)deallocEventWithTarget:(id)target action:(SEL)action
{
    return [[self alloc] initWithTarget:target action:action];
}

#pragma mark - Deallocating a RFNSDeallocEvent

- (void)dealloc
{
    // Getting the target and the action.
    id target = mTarget;
    SEL action = mAction;
    
    // We have the targer and the action.
    if (target && action)
    {
        // Getting the implementation.
        void (*implementation)(id self, SEL _cmd, RFNSDeallocEvent *deallocEvent) = (void (*)(id self, SEL _cmd, RFNSDeallocEvent *deallocEvent))[target methodForSelector:action];
        
        // We have the implementation.
        if (implementation)
        {
            // Sending the action to the target.
            implementation(target, action, self);
        }
    }
    
    // Resetting the target.
    mTarget = nil;
}

#pragma mark - Getting and Setting Properties

- (id)target
{
    // Returning the target.
    return mTarget;
}

- (void)setTarget:(id)target
{
    // Saving the target.
    mTarget = target;
}

- (SEL)action
{
    // Returing the action.
    return mAction;
}

- (void)setAction:(SEL)action
{
    // Saving the action.
    mAction = action;
}

@end
