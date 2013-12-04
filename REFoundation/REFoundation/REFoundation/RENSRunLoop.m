//
//  RENSRunLoop.m
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

// Importing the header.
#import "RENSRunLoop.h"

// Importing the project headers.
#import "RENSInvocation.h"
#import "RENSThread.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation NSObject (NSObjectRENSRunLoop)

#pragma mark - Scheduling Messages

- (void)performInvocation:(NSInvocation *)invocation order:(NSUInteger)order
{
    [invocation performSelector:@selector(invokeWithTarget:) withObject:self order:order];
}

- (void)performInvocation:(NSInvocation *)invocation order:(NSUInteger)order modes:(NSArray *)modes
{
    [invocation performSelector:@selector(invokeWithTarget:) withObject:self order:order modes:modes];
}

- (void)performSelector:(SEL)selector order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocation:invocation order:order];
}

- (void)performSelector:(SEL)selector order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocation:invocation order:order modes:modes];
}

- (void)performSelector:(SEL)selector withObject:(id)object order:(NSUInteger)order
{
    NSMutableArray *modes = [[NSMutableArray alloc] init];
    [modes addObject:NSRunLoopCommonModes];
    
    [self performSelector:selector withObject:object order:order modes:modes];
}

- (void)performSelector:(SEL)selector withObject:(id)object order:(NSUInteger)order modes:(NSArray *)modes
{
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop performSelector:selector target:self argument:object order:order modes:modes];
}

- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocation:invocation order:order];
}

- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocation:invocation order:order modes:modes];
}

- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocation:invocation order:order];
}

- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocation:invocation order:order modes:modes];
}

- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocation:invocation order:order];
}

- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocation:invocation order:order modes:modes];
}

- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocation:invocation order:order];
}

- (void)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocation:invocation order:order modes:modes];
}

#pragma mark - Scheduling Messages on a Thread

- (void)performInvocation:(NSInvocation *)invocation onThread:(NSThread *)thread order:(NSUInteger)order
{
    NSInvocation *invocation2 = [NSInvocation invocationWithTarget:self selector:@selector(performInvocation:order:) arguments:&invocation, &order];
    [invocation2 performSelector:@selector(invoke) onThread:thread withObject:nil waitUntilDone:NO];
}

- (void)performInvocation:(NSInvocation *)invocation onThread:(NSThread *)thread order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation2 = [NSInvocation invocationWithTarget:self selector:@selector(performInvocation:order:modes:) arguments:&invocation, &order, &modes];
    [invocation2 performSelector:@selector(invoke) onThread:thread withObject:nil waitUntilDone:NO modes:modes];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocation:invocation onThread:thread order:order];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocation:invocation onThread:thread order:order modes:modes];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object];
    [self performInvocation:invocation onThread:thread order:order];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object];
    [self performInvocation:invocation onThread:thread order:order modes:modes];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocation:invocation onThread:thread order:order];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocation:invocation onThread:thread order:order modes:modes];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocation:invocation onThread:thread order:order];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocation:invocation onThread:thread order:order modes:modes];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocation:invocation onThread:thread order:order];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocation:invocation onThread:thread order:order modes:modes];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocation:invocation onThread:thread order:order];
}

- (void)performSelector:(SEL)selector onThread:(NSThread *)thread withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocation:invocation onThread:thread order:order modes:modes];
}

#pragma mark - Scheduling Messages on Main Thread

- (void)performInvocationOnMainThread:(NSInvocation *)invocation order:(NSUInteger)order
{
    NSInvocation *invocation2 = [NSInvocation invocationWithTarget:self selector:@selector(performInvocation:order:) arguments:&invocation, &order];
    [invocation2 performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:NO];
}

- (void)performInvocationOnMainThread:(NSInvocation *)invocation order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation2 = [NSInvocation invocationWithTarget:self selector:@selector(performInvocation:order:modes:) arguments:&invocation, &order, &modes];
    [invocation2 performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:NO modes:modes];
}

- (void)performSelectorOnMainThread:(SEL)selector order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocationOnMainThread:invocation order:order];
}

- (void)performSelectorOnMainThread:(SEL)selector order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocationOnMainThread:invocation order:order modes:modes];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object];
    [self performInvocationOnMainThread:invocation order:order];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object];
    [self performInvocationOnMainThread:invocation order:order modes:modes];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocationOnMainThread:invocation order:order];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocationOnMainThread:invocation order:order modes:modes];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocationOnMainThread:invocation order:order];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocationOnMainThread:invocation order:order modes:modes];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocationOnMainThread:invocation order:order];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocationOnMainThread:invocation order:order modes:modes];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocationOnMainThread:invocation order:order];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocationOnMainThread:invocation order:order modes:modes];
}

#pragma mark - Scheduling Messages on Second Thread

- (void)performInvocationOnSecondThread:(NSInvocation *)invocation order:(NSUInteger)order
{
    NSInvocation *invocation2 = [NSInvocation invocationWithTarget:self selector:@selector(performInvocation:order:) arguments:&invocation, &order];
    [invocation2 performSelectorOnSecondThread:@selector(invoke) withObject:nil waitUntilDone:NO];
}

- (void)performInvocationOnSecondThread:(NSInvocation *)invocation order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation2 = [NSInvocation invocationWithTarget:self selector:@selector(performInvocation:order:modes:) arguments:&invocation, &order, &modes];
    [invocation2 performSelectorOnSecondThread:@selector(invoke) withObject:nil waitUntilDone:NO modes:modes];
}

- (void)performSelectorOnSecondThread:(SEL)selector order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocationOnSecondThread:invocation order:order];
}

- (void)performSelectorOnSecondThread:(SEL)selector order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocationOnSecondThread:invocation order:order modes:modes];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object];
    [self performInvocationOnSecondThread:invocation order:order];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object];
    [self performInvocationOnSecondThread:invocation order:order modes:modes];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocationOnSecondThread:invocation order:order];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocationOnSecondThread:invocation order:order modes:modes];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocationOnSecondThread:invocation order:order];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocationOnSecondThread:invocation order:order modes:modes];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocationOnSecondThread:invocation order:order];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocationOnSecondThread:invocation order:order modes:modes];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocationOnSecondThread:invocation order:order];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 order:(NSUInteger)order modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocationOnSecondThread:invocation order:order modes:modes];
}

#pragma mark - Scheduling and Canceling Messages on Current Run Loop

- (void)performSelectorOnCurrentRunLoop:(SEL)selector
{
    [self performSelectorOnCurrentRunLoop:selector withObject:nil];
}

- (void)performSelectorOnCurrentRunLoop:(SEL)selector order:(NSUInteger)order
{
    [self performSelectorOnCurrentRunLoop:selector withObject:nil order:order];
}

- (void)performSelectorOnCurrentRunLoop:(SEL)selector order:(NSUInteger)order modes:(NSArray *)modes
{
    [self performSelectorOnCurrentRunLoop:selector withObject:nil order:order modes:modes];
}

- (void)cancelPerformSelectorOnCurrentRunLoop:(SEL)selector
{
    [self cancelPerformSelectorOnCurrentRunLoop:selector withObject:nil];
}

- (void)performSelectorOnCurrentRunLoop:(SEL)selector withObject:(id)object
{
    [self performSelectorOnCurrentRunLoop:selector withObject:object order:0];
}

- (void)performSelectorOnCurrentRunLoop:(SEL)selector withObject:(id)object order:(NSUInteger)order
{
    NSMutableArray *modes = [[NSMutableArray alloc] init];
    [modes addObject:NSRunLoopCommonModes];
    
    [self performSelectorOnCurrentRunLoop:selector withObject:object order:order modes:modes];
}

- (void)performSelectorOnCurrentRunLoop:(SEL)selector withObject:(id)object order:(NSUInteger)order modes:(NSArray *)modes;
{
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop performSelector:selector target:self argument:object order:order modes:modes];
}

- (void)cancelPerformSelectorOnCurrentRunLoop:(SEL)selector withObject:(id)object;
{
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop cancelPerformSelector:selector target:self argument:object];
}

- (void)cancelPerformSelectorsOnCurrentRunLoop
{
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop cancelPerformSelectorsWithTarget:self];
}

@end

@implementation NSRunLoop (NSRunLoopRENSRunLoop)

#pragma mark - Scheduling and Canceling Messages

- (void)performSelector:(SEL)selector target:(id)target order:(NSUInteger)order modes:(NSArray *)modes
{
    [self performSelector:selector target:target argument:nil order:order modes:modes];
}

- (void)cancelPerformSelector:(SEL)selector target:(id)target
{
    [self cancelPerformSelector:selector target:target argument:nil];
}

@end
