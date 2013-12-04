//
//  RENSRunLoop.h
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.06.09.
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
#import <Foundation/NSRunLoop.h>

@class NSArray;
@class NSInvocation;
@class NSThread;

@interface NSObject (NSObjectRENSRunLoop)

// Scheduling Messages

- (void)performInvocation:(NSInvocation *)invocation order:(NSUInteger)order;
- (void)performInvocation:(NSInvocation *)invocation order:(NSUInteger)order modes:(NSArray *)modes;

- (void)performSelector:(SEL)selector order:(NSUInteger)order;
- (void)performSelector:(SEL)selector order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelector:(SEL)selector withObject:(id)object order:(NSUInteger)order;
- (void)performSelector:(SEL)selector withObject:(id)object order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order;
- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order;
- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order;
- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order;
- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order modes:(NSArray *)modes;

// Scheduling Messages on a Thread

- (void)performInvocation:(NSInvocation *)invocation onThread:(NSThread *)thread order:(NSUInteger)order;
- (void)performInvocation:(NSInvocation *)invocation onThread:(NSThread *)thread order:(NSUInteger)order modes:(NSArray *)modes;

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread order:(NSUInteger)order;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object order:(NSUInteger)order;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order;
- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order modes:(NSArray *)modes;

// Scheduling Messages on Main Thread

- (void)performInvocationOnMainThread:(NSInvocation *)invocation order:(NSUInteger)order;
- (void)performInvocationOnMainThread:(NSInvocation *)invocation order:(NSUInteger)order modes:(NSArray *)modes;

- (void)performSelectorOnMainThread:(SEL)selector order:(NSUInteger)order;
- (void)performSelectorOnMainThread:(SEL)selector order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object order:(NSUInteger)order;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order modes:(NSArray *)modes;

// Scheduling Messages on Second Thread

- (void)performInvocationOnSecondThread:(NSInvocation *)invocation order:(NSUInteger)order;
- (void)performInvocationOnSecondThread:(NSInvocation *)invocation order:(NSUInteger)order modes:(NSArray *)modes;

- (void)performSelectorOnSecondThread:(SEL)selector order:(NSUInteger)order;
- (void)performSelectorOnSecondThread:(SEL)selector order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object order:(NSUInteger)order;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order modes:(NSArray *)modes;

// Scheduling and Canceling Messages on Current Run Loop

- (void)performSelectorOnCurrentRunLoop:(SEL)selector;
- (void)performSelectorOnCurrentRunLoop:(SEL)selector order:(NSUInteger)order;
- (void)performSelectorOnCurrentRunLoop:(SEL)selector order:(NSUInteger)order modes:(NSArray *)modes;
- (void)cancelPerformSelectorOnCurrentRunLoop:(SEL)selector;
- (void)performSelectorOnCurrentRunLoop:(SEL)selector withObject:(id)object;
- (void)performSelectorOnCurrentRunLoop:(SEL)selector withObject:(id)object order:(NSUInteger)order;
- (void)performSelectorOnCurrentRunLoop:(SEL)selector withObject:(id)object order:(NSUInteger)order modes:(NSArray *)modes;;
- (void)cancelPerformSelectorOnCurrentRunLoop:(SEL)selector withObject:(id)object;
- (void)cancelPerformSelectorsOnCurrentRunLoop;

@end

@interface NSRunLoop (NSRunLoopRENSRunLoop)

// Scheduling and Canceling Messages
- (void)performSelector:(SEL)aSelector target:(id)target order:(NSUInteger)order modes:(NSArray *)modes;
- (void)cancelPerformSelector:(SEL)aSelector target:(id)target;

@end
