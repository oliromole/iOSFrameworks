//
//  RENSNotificationQueue.m
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.08.23.
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
#import "RENSNotificationQueue.h"

// Importing the project headers.
#import "RENSInvocation.h"
#import "RENSNotification.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation NSNotificationQueue (NSNotificationQueueRENSNotificationQueue)

#pragma mark - Managing Notifications

- (void)enqueueNotificationName:(NSString *)aName object:(id)anObject postingStyle:(NSPostingStyle)postingStyle
{
    NSNotification * notification = [NSNotification notificationWithName:aName object:anObject];
    
    [self enqueueNotification:notification postingStyle:postingStyle];
}

- (void)enqueueNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo postingStyle:(NSPostingStyle)postingStyle
{
    NSNotification * notification = [NSNotification notificationWithName:aName object:anObject userInfo:aUserInfo];
    
    [self enqueueNotification:notification postingStyle:postingStyle];
}

- (void)enqueueNotificationName:(NSString *)aName object:(id)anObject postingStyle:(NSPostingStyle)postingStyle coalesceMask:(NSUInteger)coalesceMask forModes:(NSArray *)modes
{
    NSNotification * notification = [NSNotification notificationWithName:aName object:anObject];
    
    [self enqueueNotification:notification postingStyle:postingStyle coalesceMask:coalesceMask forModes:modes];
}

- (void)enqueueNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo postingStyle:(NSPostingStyle)postingStyle coalesceMask:(NSUInteger)coalesceMask forModes:(NSArray *)modes
{
    NSNotification * notification = [NSNotification notificationWithName:aName object:anObject userInfo:aUserInfo];
    
    [self enqueueNotification:notification postingStyle:postingStyle coalesceMask:coalesceMask forModes:modes];
}

- (void)dequeueNotificationsMatching:(NSNotification *)notification
{
    [self dequeueNotificationsMatching:notification coalesceMask:NSNotificationCoalescingOnNameAndSender];
}

- (void)dequeueNotificationsMatchingName:(NSString *)aName
{
    NSObject *object = [[NSObject alloc] init];
    
    NSNotification *notification = [NSNotification notificationWithName:aName object:object];
    
    [self dequeueNotificationsMatching:notification coalesceMask:NSNotificationCoalescingOnName];
}

- (void)dequeueNotificationsMatchingObject:(id)anObject
{
    NSNotification *notification = [NSNotification notificationWithName:@"NSNotificationName" object:anObject];
    
    [self dequeueNotificationsMatching:notification coalesceMask:NSNotificationCoalescingOnSender];
}

- (void)dequeueNotificationsMatchingName:(NSString *)aName object:(id)anObject
{
    NSNotification *notification = [NSNotification notificationWithName:aName object:anObject];
    
    [self dequeueNotificationsMatching:notification coalesceMask:NSNotificationCoalescingOnNameAndSender];
}

- (void)dequeueNotificationsMatchingName:(NSString *)aName object:(id)anObject coalesceMask:(NSUInteger)coalesceMask
{
    NSNotification *notification = [NSNotification notificationWithName:aName object:anObject];
    
    [self dequeueNotificationsMatching:notification coalesceMask:coalesceMask];
}

- (void)dequeueNotificationsMatchingName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo coalesceMask:(NSUInteger)coalesceMask
{
    NSNotification *notification = [NSNotification notificationWithName:aName object:anObject userInfo:aUserInfo];
    
    [self dequeueNotificationsMatching:notification coalesceMask:coalesceMask];
}

@end

@implementation NSInvocation (NSInvocationRENSNotificationQueue)

#pragma mark - Dispatching an Invocation

- (void)invokeWithTarget:(id)target postingStyle:(NSPostingStyle)postingStyle
{
    if (!target)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The target argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(invocationInvokeNotification:) name:NSInvocationInvokeNotification object:self];
    
    NSNotificationQueue *notificationQueue = [NSNotificationQueue defaultQueue];
    [notificationQueue enqueueNotificationName:NSInvocationInvokeNotification
                                        object:self
                                      userInfo:(@{
                                                  NSInvocationInvokeInovationKey : self,
                                                  NSInvocationInvokeTargetKey : target
                                                  })
                                  postingStyle:postingStyle];
}

- (void)invokePostingStyle:(NSPostingStyle)postingStyle
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(invocationInvokeNotification:) name:NSInvocationInvokeNotification object:self];
    
    NSNotificationQueue *notificationQueue = [NSNotificationQueue defaultQueue];
    [notificationQueue enqueueNotificationName:NSInvocationInvokeNotification
                                        object:self
                                      userInfo:(@{
                                                  NSInvocationInvokeInovationKey : self
                                                  })
                                  postingStyle:postingStyle];
}

#pragma mark - Notitications

#pragma mark NSInvocation Notitications

- (void)invocationInvokeNotification:(NSNotification *)notitication
{
    if (NSNotificationEqualToNotificationNameAndObject(notitication, NSInvocationInvokeNotification, self))
    {
        NSDictionary *userInfo = notitication.userInfo;
        id invokeTarget = userInfo[NSInvocationInvokeTargetKey];
        
        if (invokeTarget)
        {
            [self invokeWithTarget:invokeTarget];
        }
        
        else
        {
            [self invoke];
        }
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter removeObserver:self name:NSInvocationInvokeNotification object:self];
    }
}

@end

NSString * const NSInvocationInvokeNotification = @"NSInvocationInvokeNotification";
NSString * const NSInvocationInvokeInovationKey = @"NSInvocationInvokeInovationKey";
NSString * const NSInvocationInvokeTargetKey = @"NSInvocationInvokeTargetKey";

@implementation NSObject (NSObjectRENSNotificationQueue)

#pragma mark - Sending Messages

- (void)performInvocation:(NSInvocation *)invocation postingStyle:(NSPostingStyle)postingStyle
{
    if (!invocation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The invocation argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    [invocation invokeWithTarget:self postingStyle:postingStyle];
}

- (void)performSelector:(SEL)selector postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [invocation invokePostingStyle:postingStyle];
}

- (void)performSelector:(SEL)selector withObject:(id)object postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object];
    [invocation invokePostingStyle:postingStyle];
}

- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [invocation invokePostingStyle:postingStyle];
}

- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [invocation invokePostingStyle:postingStyle];
}

- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [invocation invokePostingStyle:postingStyle];
}

- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5, nil];
    [invocation invokePostingStyle:postingStyle];
}

#pragma mark - Sending Messages on a Thread

- (void)performInvocation:(NSInvocation *)invocation onThread:(NSThread *)thread postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation2 = [NSInvocation invocationWithTarget:self selector:@selector(performInvocation:postingStyle:) arguments:&invocation, &postingStyle];
    [self performInvocation:invocation2 onThread:thread waitUntilDone:NO];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocation:invocation onThread:thread postingStyle:postingStyle];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object];
    [self performInvocation:invocation onThread:thread postingStyle:postingStyle];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocation:invocation onThread:thread postingStyle:postingStyle];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocation:invocation onThread:thread postingStyle:postingStyle];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocation:invocation onThread:thread postingStyle:postingStyle];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocation:invocation onThread:thread postingStyle:postingStyle];
}

#pragma mark - Sending Messages on the Main Thread

- (void)performInvocationOnMainThread:(NSInvocation *)invocation postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation2 = [NSInvocation invocationWithTarget:self selector:@selector(performInvocation:postingStyle:) arguments:&invocation, &postingStyle];
    [self performInvocationOnMainThread:invocation2 waitUntilDone:NO];
}

- (void)performSelectorOnMainThread:(SEL)selector postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocationOnMainThread:invocation postingStyle:postingStyle];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object];
    [self performInvocationOnMainThread:invocation postingStyle:postingStyle];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocationOnMainThread:invocation postingStyle:postingStyle];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocationOnMainThread:invocation postingStyle:postingStyle];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocationOnMainThread:invocation postingStyle:postingStyle];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocationOnMainThread:invocation postingStyle:postingStyle];
}

#pragma mark - Sending Messages on the Second Thread

- (void)performInvocationOnSecondThread:(NSInvocation *)invocation postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation2 = [NSInvocation invocationWithTarget:self selector:@selector(performInvocation:postingStyle:) arguments:&invocation, &postingStyle];
    [self performInvocationOnSecondThread:invocation2 waitUntilDone:NO];
}

- (void)performSelectorOnSecondThread:(SEL)selector postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocationOnSecondThread:invocation postingStyle:postingStyle];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object];
    [self performInvocationOnSecondThread:invocation postingStyle:postingStyle];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocationOnSecondThread:invocation postingStyle:postingStyle];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocationOnSecondThread:invocation postingStyle:postingStyle];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocationOnSecondThread:invocation postingStyle:postingStyle];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 postingStyle:(NSPostingStyle)postingStyle
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocationOnSecondThread:invocation postingStyle:postingStyle];
}

@end
