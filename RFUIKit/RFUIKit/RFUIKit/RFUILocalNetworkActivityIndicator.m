//
//  RFUILocalNetworkActivityIndicator.m
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

// Importing the header.
#import "RFUILocalNetworkActivityIndicator.h"

// Importing the project headers.
#import "RFUINetworkActivityIndicator.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RFUILocalNetworkActivityIndicator

#pragma mark - and Initializing and RFUILocalNetworkActivityIndicator

- (id)init
{
    if ((self = [super init]))
    {
        mCondition = 0;
        mIsNetworkActivityIndicatorShown = NO;
        mLock = nil;
        mNeedsBlink = NO;
        mNeedsUpdate = NO;
    }
    
    return self;
}

+ (id)localNetworkActivityIndicator
{
    return [[self alloc] init];
}

#pragma mark - Deallocating a RFUILocalNetworkActivityIndicator

- (void)dealloc
{
    RFUINetworkActivityIndicator *networkActivityIndicator = [RFUINetworkActivityIndicator sharedIndicator];
    
    if (mIsNetworkActivityIndicatorShown)
    {
        mIsNetworkActivityIndicatorShown = NO;
        [networkActivityIndicator hideWithCondition:1 blinked:NO];
    }
    
    mLock = nil;
}

#pragma mark - Updateing the Indecator

- (void)update
{
    BOOL isMainThread = [NSThread isMainThread];
    
    if (!isMainThread)
    {
        [self performSelectorOnMainThread:_cmd waitUntilDone:NO];
        return;
    }
    
    [mLock lock];
    
    NSInteger condition = mCondition;
    BOOL needsBlink = mNeedsBlink;
    
    mNeedsBlink = NO;
    mNeedsUpdate = NO;
    
    BOOL needsBlinkNetworkActivityIndicator = NO;
    BOOL needsHideNetworkActivityIndicator = NO;
    BOOL needsShowNetworkActivityIndicator = NO;
    
    if (mIsNetworkActivityIndicatorShown)
    {
        if (condition > 0)
        {
            if (needsBlink)
            {
                needsBlinkNetworkActivityIndicator = YES;
            }
        }
        
        else
        {
            mIsNetworkActivityIndicatorShown = NO;
            needsHideNetworkActivityIndicator = YES;
        }
    }
    
    else
    {
        if (condition > 0)
        {
            mIsNetworkActivityIndicatorShown = YES;
            needsShowNetworkActivityIndicator = YES;
        }
    }
    
    [mLock unlock];
    
    RFUINetworkActivityIndicator *networkActivityIndicator = [RFUINetworkActivityIndicator sharedIndicator];
    
    if (needsShowNetworkActivityIndicator)
    {
        [networkActivityIndicator showWithCondition:1 blinked:needsBlink];
    }
    
    if (needsHideNetworkActivityIndicator)
    {
        [networkActivityIndicator hideWithCondition:1 blinked:needsBlink];
    }
    
    if (needsBlinkNetworkActivityIndicator)
    {
        [networkActivityIndicator blink];
    }
}

#pragma mark - Returning the Condition

- (NSInteger)condition
{
    [mLock lock];
    
    NSInteger condition = mCondition;
    
    [mLock unlock];
    
    return condition;
}

#pragma mark - Showing and Hiding and Blinking the Indicator

- (void)blink
{
    BOOL needsUpdate = NO;
    
    [mLock lock];
    
    if ((mCondition > 0) && !mNeedsBlink)
    {
        BOOL oldNeedsUpdate = mNeedsUpdate;
        
        mNeedsBlink = YES;
        mNeedsUpdate |= mNeedsBlink;
        
        BOOL newNeedsUpdate = mNeedsUpdate;
        
        needsUpdate |= (oldNeedsUpdate ^ newNeedsUpdate);
    }
    
    [mLock unlock];
    
    if (needsUpdate)
    {
        [self update];
    }
}

- (void)show
{
    [self showWithCondition:1 blinked:NO];
}

- (void)showWithBlinked:(BOOL)blinked
{
    [self showWithCondition:1 blinked:blinked];
}

- (void)showWithCondition:(NSInteger)condition
{
    [self showWithCondition:condition blinked:NO];
}

- (void)showWithCondition:(NSInteger)condition blinked:(BOOL)blinked
{
    [self hidden:NO condition:condition blinked:blinked];
}

- (void)hide
{
    [self hideWithCondition:1 blinked:NO];
}

- (void)hideWithBlinked:(BOOL)blinked
{
    [self hideWithCondition:1 blinked:blinked];
}

- (void)hideWithCondition:(NSInteger)condition
{
    [self hideWithCondition:condition blinked:NO];
}

- (void)hideWithCondition:(NSInteger)condition blinked:(BOOL)blinked
{
    [self hidden:YES condition:condition blinked:blinked];
}

- (void)hidden:(BOOL)hidden
{
    [self hidden:hidden condition:1 blinked:NO];
}

- (void)hidden:(BOOL)hidden blinked:(BOOL)blinked
{
    [self hidden:hidden condition:1 blinked:blinked];
}

- (void)hidden:(BOOL)hidden condition:(NSInteger)condition
{
    [self hidden:hidden condition:condition blinked:NO];
}

- (void)hidden:(BOOL)hidden condition:(NSInteger)condition blinked:(BOOL)blinked
{
    BOOL needsUpdate = NO;
    
    [mLock lock];
    
    NSInteger oldCondition = mCondition;
    
    mCondition += (hidden ? -condition : condition);
    RENSAssert((mCondition >= 0), @"The %@ class is used incorrectly.", NSStringFromClass([self class]));
    
    NSInteger newCondtion = mCondition;
    
    BOOL oldNeedsUpdate = mNeedsUpdate;
    
    mNeedsBlink |= blinked;
    mNeedsUpdate |= mNeedsBlink;
    mNeedsUpdate |= ((oldCondition > 0) ^ (newCondtion > 0));
    
    BOOL newNeedsUpdate = mNeedsUpdate;
    
    needsUpdate |= (oldNeedsUpdate ^ newNeedsUpdate);
    
    [mLock unlock];
    
    if (needsUpdate)
    {
        [self update];
    }
}

@end
