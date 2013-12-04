//
//  RFNSBlockInvocation.m
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.07.06.
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
#import "RFNSBlockInvocation.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RFNSBlockInvocation

#pragma mark - Initializing and Creating a RFNSBlockInvocation

+ (RFNSBlockInvocation *)blockInvocation
{
    SEL selector = @selector(invokeBlockWithTarget:);
    
    if (!selector)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: selector argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    NSMethodSignature *methodSignature = [self instanceMethodSignatureForSelector:selector];
    
    if (!methodSignature)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"The %@ method is not found in the target.", NSStringFromSelector(selector)] userInfo:nil];
    }
    
    RFNSBlockInvocation *blockInvocation = (RFNSBlockInvocation *)[self invocationWithMethodSignature:methodSignature];
    
    if (blockInvocation)
    {
        blockInvocation->mAllowAddBlockCounter = 0;
        
        blockInvocation->mBlocks = [[NSMutableArray alloc] init];
        
        blockInvocation.selector = selector;
        blockInvocation.target = blockInvocation;
        [blockInvocation setArgument:&blockInvocation atIndex:2];
        //[blockInvocation retainArguments]; // This is retained himself.
    }
    
    return blockInvocation;
}

+ (RFNSBlockInvocation *)blockInvocationWithBlock:(void (^)(void))block
{
    if (!block)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The block argument is nil." userInfo:nil];
    }
    
    RFNSBlockInvocation *blockInvocation = [self blockInvocation];
    [blockInvocation addExecutionBlock:block];
    
    return blockInvocation;
}

#pragma mark - Deallocating a RFNSBlockInvocation

- (void)dealloc
{
    mBlocks = nil;
}

#pragma mark - Configuring an Invocation Object

- (void)retainArguments
{
    // This stub.
    //@throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"The %@ class is used incorrectly.", NSStringFromClass([self class])] userInfo:nil];
    //[super retainArguments]; // This is retained himself.
}

#pragma mark - Managing the RFNSBlockInvocation Object

- (NSMutableArray *)copyExecutionBlocks
{
    NSMutableArray *executionBlocks = [mBlocks mutableCopy];
    return executionBlocks;
}

- (NSMutableArray *)executionBlocks
{
    NSMutableArray *executionBlocks = [self copyExecutionBlocks];
    return executionBlocks;
}

- (void)addExecutionBlock:(void (^)(void))block
{
    if (!block)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The block argument is nil." userInfo:nil];
    }
    
    if (mAllowAddBlockCounter != 0)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The block argument is invalid." userInfo:nil];
    }
    
    void (^block2)(void) = [block copy];
    
    [mBlocks addObject:block2];
    
    block2 = NULL;
    block2 = block2;
}

#pragma mark - Invoking the Block

- (void)invokeBlock
{
    mAllowAddBlockCounter++;
    
    for (NSUInteger index = 0; index < mBlocks.count; index++)
    {
        void (^block)(void) = [mBlocks objectAtIndex:index];
        block();
    }
    
    mAllowAddBlockCounter--;
}

- (void)invokeBlockWithTarget:(id)target
{
    if (!target)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"The %@ class is used incorrectly.", NSStringFromClass([self class])] userInfo:nil];
    }
    
    if (target != self)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"The %@ class is used incorrectly.", NSStringFromClass([self class])] userInfo:nil];
    }
    
    [self invokeBlock];
}

- (void)setExecutionBlocks:(NSMutableArray *)executionBlocks
{
    if (!executionBlocks)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The executionBlocks argument is nil." userInfo:nil];
    }
    
    if (mBlocks != executionBlocks)
    {
        [mBlocks setArray:executionBlocks];
    }
}

@end

@implementation NSObject (NSObjectRFNSBlockInvocation)

#pragma mark - Sending Messages

- (void)invokeBlockWithTarget:(id)target
{
    if (!target)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"The %@ class is used incorrectly.", NSStringFromClass([self class])] userInfo:nil];
    }
    
    if (![target isKindOfClass:[RFNSBlockInvocation class]])
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"The %@ class is used incorrectly.", NSStringFromClass([self class])] userInfo:nil];
    }
    
    RFNSBlockInvocation *blockInvocation = target;
    [blockInvocation invokeBlockWithTarget:target];
}

- (void)performBlock:(void (^)(void))block
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocation:blockInvocation];
}

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocation:blockInvocation afterDelay:delay];
}

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay inModes:(NSArray *)modes
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocation:blockInvocation afterDelay:delay inModes:modes];
}

- (void)performBlock:(void (^)(void))block order:(NSUInteger)order
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocation:blockInvocation order:order];
}

- (void)performBlock:(void (^)(void))block order:(NSUInteger)order modes:(NSArray *)modes
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocation:blockInvocation order:order modes:modes];
}

- (void)performBlock:(void (^)(void))block postingStyle:(NSPostingStyle)postingStyle
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocation:blockInvocation postingStyle:postingStyle];
}

#pragma mark - Sending Messages in Background

- (void)performBlockInBackground:(void (^)(void))block
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocationInBackground:blockInvocation];
}

#pragma mark - Sending Messages on a Thread

- (void)performBlock:(void (^)(void))block onThread:(NSThread *)thread order:(NSUInteger)order
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocation:blockInvocation onThread:thread order:order];
}

- (void)performBlock:(void (^)(void))block onThread:(NSThread *)thread order:(NSUInteger)order modes:(NSArray *)modes
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocation:blockInvocation onThread:thread order:order modes:modes];
}

- (void)performBlock:(void (^)(void))block onThread:(NSThread *)thread postingStyle:(NSPostingStyle)postingStyle
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocation:blockInvocation onThread:thread postingStyle:postingStyle];
}

- (void)performBlock:(void (^)(void))block onThread:(NSThread *)thread waitUntilDone:(BOOL)wait
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocation:blockInvocation onThread:thread waitUntilDone:wait];
}

- (void)performBlock:(void (^)(void))block onThread:(NSThread *)thread waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocation:blockInvocation onThread:thread waitUntilDone:wait modes:modes];
}

#pragma mark - Sending Messages on the Main Thread

- (void)performBlockOnMainThread:(void (^)(void))block order:(NSUInteger)order
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocationOnMainThread:blockInvocation order:order];
}

- (void)performBlockOnMainThread:(void (^)(void))block order:(NSUInteger)order modes:(NSArray *)modes
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocationOnMainThread:blockInvocation order:order modes:modes];
}

- (void)performBlockOnMainThread:(void (^)(void))block postingStyle:(NSPostingStyle)postingStyle
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocationOnMainThread:blockInvocation postingStyle:postingStyle];
}

- (void)performBlockOnMainThread:(void (^)(void))block waitUntilDone:(BOOL)wait
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocationOnMainThread:blockInvocation waitUntilDone:wait];
}

- (void)performBlockOnMainThread:(void (^)(void))block waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocationOnMainThread:blockInvocation waitUntilDone:wait modes:modes];
}

#pragma mark - Sending Messages on the Second Thread

- (void)performBlockOnSecondThread:(void (^)(void))block order:(NSUInteger)order
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocationOnSecondThread:blockInvocation order:order];
}

- (void)performBlockOnSecondThread:(void (^)(void))block order:(NSUInteger)order modes:(NSArray *)modes
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocationOnSecondThread:blockInvocation order:order modes:modes];
}

- (void)performBlockOnSecondThread:(void (^)(void))block postingStyle:(NSPostingStyle)postingStyle
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocationOnSecondThread:blockInvocation postingStyle:postingStyle];
}

- (void)performBlockOnSecondThread:(void (^)(void))block waitUntilDone:(BOOL)wait
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocationOnSecondThread:blockInvocation waitUntilDone:wait];
}

- (void)performBlockOnSecondThread:(void (^)(void))block waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    RFNSBlockInvocation *blockInvocation = [RFNSBlockInvocation blockInvocationWithBlock:block];
    [self performInvocationOnSecondThread:blockInvocation waitUntilDone:wait modes:modes];
}

@end
