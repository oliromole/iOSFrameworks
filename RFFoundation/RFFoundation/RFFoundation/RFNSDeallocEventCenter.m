//
//  RFNSDeallocEventCenter.m
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.11.06.
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
#import "RFNSDeallocEventCenter.h"

// Importing the project headers.
#import "RFNSDeallocEvent.h"
#import "RFNSDeallocEventCenterTargetAction.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>

// Importing the system headers.
#import <objc/runtime.h>

const void * RFNSDeallocEventCenterAssociationKey = &RFNSDeallocEventCenterAssociationKey;
const  void * RFNSDeallocEventCenterDeallocEventAssociationKey = &RFNSDeallocEventCenterDeallocEventAssociationKey;

@interface RFNSDeallocEventCenter ()

// Initializing and Creating a RFNSDeallocEventCenter

- (id)initForObject:(id)object;

@end

@implementation RFNSDeallocEventCenter

#pragma mark - Initializing and Creating a RFNSDeallocEventCenter

- (id)init
{
    RENSAssert(NO, @"The %@ class is used incorrectly.", NSStringFromClass([self class]));
    
    return nil;
}

- (id)initForObject:(id)object
{
    if (!object)
    {
        RENSAssert(object, @"The object argument is nil.");
        
        return nil;
    }
    
    if ((self = [super init]))
    {
        // Creating the dealloc event.
        RFNSDeallocEvent *deallocEvent = [[RFNSDeallocEvent alloc] initWithTarget:self action:@selector(deallocEventAction:)];
        
        // Saving the dealloc event.
        mDeallocEvent = deallocEvent;
        
        // Saving the object.
        mObject = object;
        
        // Setting the default values.
        mIsSentAction = NO;
        mTargetActions = [[NSMutableArray alloc] init];
        mVersionCounter = 0;
        
        // Associating the objects.
        objc_setAssociatedObject(object, RFNSDeallocEventCenterAssociationKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(object, RFNSDeallocEventCenterDeallocEventAssociationKey, deallocEvent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return self;
}

#pragma mark - Deallocating a RFNSDeallocEventCenter

- (void)dealloc
{
    // Sending the dealloc event action.
    [self sendDeallocEventActionIfNeeded];
    
    // Resetting the object
    mObject = nil;
    
    // Releasing the target actions.
    mTargetActions = nil;
}

#pragma mark - Accessing the RFNSDeallocEventCenter Object

- (id)object
{
    // Returning the object.
    return mObject;
}

#pragma mark - Preparing and Sending Action Messages

- (void)addTarget:(id)target action:(SEL)action
{
    // Addting the target and the action.
    [self addTarget:target action:action context:nil];
}

- (void)addTarget:(id)target action:(SEL)action context:(id)context
{
    if (!target)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The target argument is nil." userInfo:nil];
    }
    
    if (!action)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The action argument is NULL." userInfo:nil];
    }
    
    // Creating the target action.
    RFNSDeallocEventCenterTargetAction *targetAction = [[RFNSDeallocEventCenterTargetAction alloc] init];
    targetAction.action = action;
    targetAction.context = context;
    targetAction.target = target;
    targetAction.version = mVersionCounter;
    
    // Incrementing the version counter.
    mVersionCounter++;
    
    // Getting the index of the free place.
    NSUInteger indexOfTargetAction = [mTargetActions indexOfObject:[NSNull null]];
    
    // We have the free place.
    if (indexOfTargetAction != NSNotFound)
    {
        // Saving the created target action to the free place.
        mTargetActions[indexOfTargetAction] = targetAction;
    }
    // We do not have the free place.
    else
    {
        // Saving the created target action.
        [mTargetActions addObject:targetAction];
    }
}

- (void)removeTarget:(id)target action:(SEL)action
{
    // Removing the target and the action.
    [self removeTarget:target action:action context:nil];
}

- (void)removeTarget:(id)target action:(SEL)action context:(id)context;
{
    if (!target)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The target argument is nil." userInfo:nil];
    }
    
    // Saving the current value of the version counter.
    NSInteger versionCounter = mVersionCounter;
    
    // Removing the target actions.
    for (NSUInteger indexOfTargetAction = 0; indexOfTargetAction < mTargetActions.count; indexOfTargetAction++)
    {
        // Removing the target action.
        
        // Getting the target action.
        RFNSDeallocEventCenterTargetAction *targetAction = mTargetActions[indexOfTargetAction];
        
        // We have the target action.
        if ((targetAction != (id)[NSNull null]) &&
            (targetAction.version < versionCounter))
        {
            // Setting the default values.
            BOOL isEqual = YES;
            
            // Calculating the value that indicates that the target action matches to arguments.
            
            // We must compare the targets.
            if (isEqual && target)
            {
                // Comparing the targets.
                isEqual = (targetAction.target == target);
            }
            
            // We must compare the actions
            if (isEqual && action)
            {
                // Comparing the actions.
                isEqual = (targetAction.action == action);
            }
            
            // We must compare the context.
            if (isEqual && context)
            {
                // Comparing the context.
                isEqual = [targetAction.context isEqual:context];
            }
            
            // We must remove the target action.
            if (isEqual)
            {
                // Incrementing the version counter.
                mVersionCounter++;
                
                // Removing the target action.
                mTargetActions[indexOfTargetAction] = [NSNull null];
            }
        }
    }
}

#pragma mark - Actions

- (void)deallocEventAction:(RFNSDeallocEvent *)deallocEvent
{
#pragma unused(deallocEvent)
    
    // Sending the dealloc event action.
    [self sendDeallocEventActionIfNeeded];
}

#pragma mark - Sending the Dealloc Event Action

- (void)sendDeallocEventActionIfNeeded
{
    // The dealloc event action is not sent.
    if (!mIsSentAction)
    {
        // Setting the value that the dealloc event action is sent.
        mIsSentAction = YES;
        
        // Saving the current value of the vertion counter.
        NSInteger versionCounter = mVersionCounter;
        
        // Sending the dealloc event action to the all target.
        for (NSUInteger indexOfTargetAction = 0; indexOfTargetAction < mTargetActions.count; indexOfTargetAction++)
        {
            // Sending the dealloc event action to the target.
            
            // Getting the target action.
            RFNSDeallocEventCenterTargetAction *targetAction = mTargetActions[indexOfTargetAction];
            
            // We have the target action.
            if ((targetAction != (id)[NSNull null]) &&
                (targetAction.version < versionCounter))
            {
                // Getting the target and the action.
                id target = targetAction.target;
                SEL action = targetAction.action;
                id context = targetAction.context;
                
                // We have the targer and the action.
                if (target && action)
                {
                    // Getting the implementation.
                    void (*implementation)(id self, SEL _cmd, RFNSDeallocEventCenter *deallocEventCenter, id context) = (void (*)(id self, SEL _cmd, RFNSDeallocEventCenter *deallocEventCenter, id context))[target methodForSelector:action];
                    
                    // We have the implementation.
                    if (implementation)
                    {
                        // Sending the action to the target.
                        implementation(target, action, self, context);
                    }
                }
            }
        }
    }
}

@end

@implementation NSObject (NSObjectRFNSDeallocEventCenter)

#pragma mark - Getting the dealloc event center.

- (RFNSDeallocEventCenter *)deallocEventCenter
{
    // Getting the dealloc event center.
    RFNSDeallocEventCenter *deallocEventCenter = objc_getAssociatedObject(self, RFNSDeallocEventCenterAssociationKey);
    
    // We do not have the dealloc event center.
    if (!deallocEventCenter)
    {
        // Creating the dealloc event center.
        deallocEventCenter = [[RFNSDeallocEventCenter alloc] initForObject:self];
    }
    
    // Returning the dealloc event center.
    return deallocEventCenter;
}

#pragma mark - Preparing Action Message.

- (void)addTarget:(id)targer deallocEventAction:(SEL)action
{
    // Adding the target and the action.
    RFNSDeallocEventCenter *deallocEventCenter = self.deallocEventCenter;
    [deallocEventCenter addTarget:targer action:action];
}

- (void)addTarget:(id)targer deallocEventAction:(SEL)action context:(id)context
{
    // Adding the target and the action and the context.
    RFNSDeallocEventCenter *deallocEventCenter = self.deallocEventCenter;
    
    [deallocEventCenter addTarget:targer action:action context:context];
}

- (void)removeTarget:(id)targer deallocEventAction:(SEL)action
{
    // Removing the target and the action.
    RFNSDeallocEventCenter *deallocEventCenter = self.deallocEventCenter;
    [deallocEventCenter removeTarget:targer action:action];
}

- (void)removeTarget:(id)targer deallocEventAction:(SEL)action context:(id)context
{
    // Removing the target and the action and the context.
    RFNSDeallocEventCenter *deallocEventCenter = self.deallocEventCenter;
    [deallocEventCenter removeTarget:targer action:action context:context];
}

@end
