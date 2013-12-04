//
//  RFNSTargetActionPair.m
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.10.30.
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
#import "RFNSTargetActionPair.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RFNSTargetActionPair

#pragma mark - Initializing and Creating a RFNSTargetActionPair

- (instancetype)init
{
    if ((self = [super init]))
    {
        // Setting the default values.
        mAction = NULL;
        mOptions = RFNSTargetActionPairOptionWeakReference;
        mStrongTarget = nil;
        mWeakTarget = nil;
    }
    
    return self;
}

+ (instancetype)targetActionPair
{
    return [[self alloc] init];
}

- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    if ((self = [self init]))
    {
        // Setting the targer and the action.
        [self setTarget:target action:action];
    }
    
    return self;
}

+ (instancetype)targetActionPairWithTarget:(id)target action:(SEL)action
{
    return [[self alloc] initWithTarget:target action:action];
}

- (instancetype)initWithTarget:(id)target action:(SEL)action options:(RFNSTargetActionPairOptions)options
{
    if ((self = [self init]))
    {
        // Setting the options.
        self.options = options;
        
        // Setting the targer and the action.
        [self setTarget:target action:action];
    }
    
    return self;
}

+ (instancetype)targetActionPairWithTarget:(id)target action:(SEL)action options:(RFNSTargetActionPairOptions)options
{
    return [[self alloc] initWithTarget:target action:action options:options];
}

#pragma mark - Deallocating a RFNSTargetActionPair

- (void)dealloc
{
    // Releasing the strong target.
    mStrongTarget = nil;
    
    // Releasing the weak target.
    mWeakTarget = nil;
}

#pragma mark - Managing the RFNSTargetActionPair Object

- (id)target
{
    // We use the weak target.
    if (RENSTestOptionsWithMask(mOptions, RFNSTargetActionPairOptionReferenceMask, RFNSTargetActionPairOptionWeakReference))
    {
        // Returning the target.
        return mWeakTarget;
    }
    // We use the strong target.
    // RENSTestOptionsWithMask(mOptions, RFNSTargetActionPairOptionReferenceMask, RFNSTargetActionPairOptionStrongReference))
    else
    {
        // Returning the target.
        return mStrongTarget;
    }
}

- (void)setTarget:(id)target
{
    // We use the weak target.
    if (RENSTestOptionsWithMask(mOptions, RFNSTargetActionPairOptionReferenceMask, RFNSTargetActionPairOptionWeakReference))
    {
        // Saving the target.
        mWeakTarget = target;
    }
    // We use the strong target.
    // RENSTestOptionsWithMask(mOptions, RFNSTargetActionPairOptionReferenceMask, RFNSTargetActionPairOptionStrongReference))
    else
    {
        // Saving the target.
        mStrongTarget = target;
    }
}

- (SEL)action
{
    // Returing the action.
    return mAction;
}

- (void)setAction:(SEL)action
{
    // The new action
    mAction = action;
}

- (RFNSTargetActionPairOptions)options
{
    // Returing the options.
    return mOptions;
}

- (void)setOptions:(RFNSTargetActionPairOptions)options
{
    // The old options and the new options are different.
    if (mOptions != options)
    {
        // Saving the old options.
        RFNSTargetActionPairOptions oldOptions = mOptions;
        
        // Saving the new options.
        mOptions = options;
        
        // Saving the new options.
        RFNSTargetActionPairOptions newOptions = mOptions;
        
        // We have changed the reference type.
        if (RENSGetOptionsByMask(oldOptions, RFNSTargetActionPairOptionReferenceMask) != RENSGetOptionsByMask(newOptions, RFNSTargetActionPairOptionReferenceMask))
        {
            // The new reference type is weak.
            if (RENSTestOptionsWithMask(mOptions, RFNSTargetActionPairOptionReferenceMask, RFNSTargetActionPairOptionWeakReference))
            {
                // Changing the reference to the target.
                mWeakTarget = mStrongTarget;
                mStrongTarget = nil;
            }
            // The new reference type is strong.
            // RENSTestOptionsWithMask(mOptions, RFNSTargetActionPairOptionReferenceMask, RFNSTargetActionPairOptionStrongReference))
            else
            {
                // Changing the reference to the target.
                mStrongTarget = mWeakTarget;
                mWeakTarget = nil;
            }
        }
    }
}

- (void)setTarget:(id)target action:(SEL)action
{
    // Saving the target and the action.
    self.target = target;
    self.action = action;
}

- (void)setTarget:(id)target action:(SEL)action options:(RFNSTargetActionPairOptions)options
{
    // Saving the options.
    self.options = options;
    
    // Saving the target and the action.
    self.target = target;
    self.action = action;
}

@end
