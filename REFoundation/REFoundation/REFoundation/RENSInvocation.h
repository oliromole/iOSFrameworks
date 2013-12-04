//
//  RENSInvocation.h
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.08.15.
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
#import <Foundation/NSDate.h>
#import <Foundation/NSInvocation.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>

@class NSArray;
@class NSInvocation;
@class NSMethodSignature;
@class NSThread;

@interface NSInvocation (NSInvocationRENSInvocation)

// Initializing and Creating a NSInvocation

+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature selector:(SEL)selector;
+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature selector:(SEL)selector arguments:(void *)argumentLocation1, ...;
+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature selector:(SEL)selector retainedArguments:(BOOL)retainedArguments arguments:(void *)argumentLocation1, ...;
+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature target:(id)tagert selector:(SEL)selector;
+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature target:(id)tagert selector:(SEL)selector arguments:(void *)argumentLocation1, ...;
+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature target:(id)tagert selector:(SEL)selector retainedArguments:(BOOL)retainedArguments arguments:(void *)argumentLocation1, ...;
+ (NSInvocation *)invocationWithTarget:(id)tagert selector:(SEL)selector;
+ (NSInvocation *)invocationWithTarget:(id)tagert selector:(SEL)selector arguments:(void *)argumentLocation1, ...;
+ (NSInvocation *)invocationWithTarget:(id)tagert selector:(SEL)selector retainedArguments:(BOOL)retainedArguments arguments:(void *)argumentLocation1, ...;

@end

@interface NSObject (NSObjectRENSInvocation)

// Sending Messages

- (id)performInvocation:(NSInvocation *)invocation;
- (void)performInvocation:(NSInvocation *)invocation returnValue:(void *)returnLocation;
- (void)performInvocation:(NSInvocation *)invocation onThread:(NSThread *)thread waitUntilDone:(BOOL)wait;
- (void)performInvocation:(NSInvocation *)invocation onThread:(NSThread *)thread waitUntilDone:(BOOL)wait modes:(NSArray *)modes;
- (void)performInvocation:(NSInvocation *)invocation afterDelay:(NSTimeInterval)delay;
- (void)performInvocation:(NSInvocation *)invocation afterDelay:(NSTimeInterval)delay inModes:(NSArray *)modes;
- (void)performInvocationInBackground:(NSInvocation *)invocation;
- (void)performInvocationOnMainThread:(NSInvocation *)invocation waitUntilDone:(BOOL)wait;
- (void)performInvocationOnMainThread:(NSInvocation *)invocation waitUntilDone:(BOOL)wait modes:(NSArray *)modes;
- (void)performInvocationOnSecondThread:(NSInvocation *)invocation waitUntilDone:(BOOL)wait;
- (void)performInvocationOnSecondThread:(NSInvocation *)invocation waitUntilDone:(BOOL)wait modes:(NSArray *)modes;

// Sending Messages on the Main Thread

- (void)performSelectorOnMainThread:(SEL)selector waitUntilDone:(BOOL)wait;
- (void)performSelectorOnMainThread:(SEL)selector waitUntilDone:(BOOL)wait modes:(NSArray *)modes;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 waitUntilDone:(BOOL)wait;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 waitUntilDone:(BOOL)wait modes:(NSArray *)modes;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 waitUntilDone:(BOOL)wait;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 waitUntilDone:(BOOL)wait modes:(NSArray *)modes;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 waitUntilDone:(BOOL)wait;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 waitUntilDone:(BOOL)wait modes:(NSArray *)modes;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 waitUntilDone:(BOOL)wait;
- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 waitUntilDone:(BOOL)wait modes:(NSArray *)modes;

// Sending Messages on the Second Thread

- (void)performSelectorOnSecondThread:(SEL)selector waitUntilDone:(BOOL)wait;
- (void)performSelectorOnSecondThread:(SEL)selector waitUntilDone:(BOOL)wait modes:(NSArray *)modes;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 waitUntilDone:(BOOL)wait;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 waitUntilDone:(BOOL)wait modes:(NSArray *)modes;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 waitUntilDone:(BOOL)wait;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 waitUntilDone:(BOOL)wait modes:(NSArray *)modes;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 waitUntilDone:(BOOL)wait;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 waitUntilDone:(BOOL)wait modes:(NSArray *)modes;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 waitUntilDone:(BOOL)wait;
- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 waitUntilDone:(BOOL)wait modes:(NSArray *)modes;

@end
