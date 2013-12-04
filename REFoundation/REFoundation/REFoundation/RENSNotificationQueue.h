//
//  RENSNotificationQueue.h
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

// Importing the system headers.
#import <Foundation/NSInvocation.h>
#import <Foundation/NSNotificationQueue.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>

@class NSDictionary;
@class NSNotification;
@class NSString;
@class NSThread;

enum
{
    NSNotificationCoalescingOnNameAndSender = (NSNotificationCoalescingOnName | NSNotificationCoalescingOnSender)
};

@interface NSNotificationQueue (NSNotificationQueueRENSNotificationQueue)

// Managing Notifications

- (void)enqueueNotificationName:(NSString *)aName object:(id)anObject postingStyle:(NSPostingStyle)postingStyle;
- (void)enqueueNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo postingStyle:(NSPostingStyle)postingStyle;
- (void)enqueueNotificationName:(NSString *)aName object:(id)anObject postingStyle:(NSPostingStyle)postingStyle coalesceMask:(NSUInteger)coalesceMask forModes:(NSArray *)modes;
- (void)enqueueNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo postingStyle:(NSPostingStyle)postingStyle coalesceMask:(NSUInteger)coalesceMask forModes:(NSArray *)modes;

- (void)dequeueNotificationsMatching:(NSNotification *)notification;
- (void)dequeueNotificationsMatchingName:(NSString *)aName;
- (void)dequeueNotificationsMatchingObject:(id)anObject;
- (void)dequeueNotificationsMatchingName:(NSString *)aName object:(id)anObject;
- (void)dequeueNotificationsMatchingName:(NSString *)aName object:(id)anObject coalesceMask:(NSUInteger)coalesceMask;
- (void)dequeueNotificationsMatchingName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo coalesceMask:(NSUInteger)coalesceMask;

@end

@interface NSInvocation (NSInvocationRENSNotificationQueue)

// Dispatching an Invocation

- (void)invokeWithTarget:(id)target postingStyle:(NSPostingStyle)postingStyle;
- (void)invokePostingStyle:(NSPostingStyle)postingStyle;

@end

FOUNDATION_EXTERN NSString * const NSInvocationInvokeNotification;
FOUNDATION_EXTERN NSString * const NSInvocationInvokeInovationKey;
FOUNDATION_EXTERN NSString * const NSInvocationInvokeTargetKey;

@interface NSObject (NSObjectRENSNotificationQueue)

// Sending Messages

- (void)performInvocation:(NSInvocation *)invocation postingStyle:(NSPostingStyle)postingStyle;

- (void)performSelector:(SEL)selector postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelector:(SEL)selector withObject:(id)object postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 postingStyle:(NSPostingStyle)postingStyle;

// Sending Messages on a Thread

- (void)performInvocation:(NSInvocation *)invocation onThread:(NSThread *)thread postingStyle:(NSPostingStyle)postingStyle;

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 postingStyle:(NSPostingStyle)postingStyle;

// Sending Messages on the Main Thread

- (void)performInvocationOnMainThread:(NSInvocation *)invocation postingStyle:(NSPostingStyle)postingStyle;

- (void)performSelectorOnMainThread:(SEL)selector postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 postingStyle:(NSPostingStyle)postingStyle;

// Sending Messages on the Second Thread

- (void)performInvocationOnSecondThread:(NSInvocation *)invocation postingStyle:(NSPostingStyle)postingStyle;

- (void)performSelectorOnSecondThread:(SEL)selector postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 postingStyle:(NSPostingStyle)postingStyle;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 postingStyle:(NSPostingStyle)postingStyle;

@end
