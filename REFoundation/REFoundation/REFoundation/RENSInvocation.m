//
//  RENSInvocation.m
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

// Importing the header.
#import "RENSInvocation.h"

// Importing the project headers.
#import "RENSThread.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation NSInvocation (NSInvocationRENSInvocation)

#pragma mark - Initializing and Creating a NSInvocation

+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature selector:(SEL)selector
{
    if (!methodSignature)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: method signature argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    if (!selector)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: selector argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    NSInvocation *invocation = [self invocationWithMethodSignature:methodSignature];
    
    if (invocation)
    {
        invocation.selector = selector;
    }
    
    return invocation;
}

+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature selector:(SEL)selector arguments:(void *)pArgument0, ...
{
    if (!methodSignature)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: method signature argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    if (!selector)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: selector argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    NSInvocation *invocation = [self invocationWithMethodSignature:methodSignature];
    
    if (invocation)
    {
        invocation.selector = selector;
        
        NSInteger numberOfArguments = (NSInteger)methodSignature.numberOfArguments;
        
        if (numberOfArguments > 2)
        {
            [invocation setArgument:pArgument0 atIndex:2];
            
            if (numberOfArguments > 3)
            {
                va_list valist;
                va_start(valist, pArgument0);
                
                for (NSInteger indexOfArgument = 3; indexOfArgument < numberOfArguments; indexOfArgument++)
                {
                    void *pArgument = va_arg(valist, void *);
                    
                    [invocation setArgument:pArgument atIndex:indexOfArgument];
                }
                
                va_end(valist);
            }
        }
        
        [invocation retainArguments];
    }
    
    return invocation;
}

+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature selector:(SEL)selector retainedArguments:(BOOL)retainedArguments arguments:(void *)pArgument0, ...
{
    if (!methodSignature)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: method signature argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    if (!selector)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: selector argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    NSInvocation *invocation = [self invocationWithMethodSignature:methodSignature];
    
    if (invocation)
    {
        invocation.selector = selector;
        
        NSInteger numberOfArguments = (NSInteger)methodSignature.numberOfArguments;
        
        if (numberOfArguments > 2)
        {
            [invocation setArgument:pArgument0 atIndex:2];
            
            if (numberOfArguments > 3)
            {
                va_list valist;
                va_start(valist, pArgument0);
                
                for (NSInteger indexOfArgument = 3; indexOfArgument < numberOfArguments; indexOfArgument++)
                {
                    void *pArgument = va_arg(valist, void *);
                    
                    [invocation setArgument:pArgument atIndex:indexOfArgument];
                }
                
                va_end(valist);
            }
        }
        
        if (retainedArguments)
        {
            [invocation retainArguments];
        }
    }
    
    return invocation;
}

+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature target:(id)tagert selector:(SEL)selector
{
    if (!methodSignature)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: method signature argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    if (!tagert)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: tagert argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    if (!selector)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: selector argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    NSInvocation *invocation = [self invocationWithMethodSignature:methodSignature];
    
    if (invocation)
    {
        invocation.selector = selector;
        invocation.target = tagert;
    }
    
    return invocation;
}

+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature target:(id)tagert selector:(SEL)selector arguments:(void *)pArgument0, ...
{
    if (!methodSignature)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: method signature argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    if (!tagert)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: tagert argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    if (!selector)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: selector argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    NSInvocation *invocation = [self invocationWithMethodSignature:methodSignature];
    
    if (invocation)
    {
        invocation.selector = selector;
        invocation.target = tagert;
        
        NSInteger numberOfArguments = (NSInteger)methodSignature.numberOfArguments;
        
        if (numberOfArguments > 2)
        {
            [invocation setArgument:pArgument0 atIndex:2];
            
            if (numberOfArguments > 3)
            {
                va_list valist;
                va_start(valist, pArgument0);
                
                for (NSInteger indexOfArgument = 3; indexOfArgument < numberOfArguments; indexOfArgument++)
                {
                    void *pArgument = va_arg(valist, void *);
                    
                    [invocation setArgument:pArgument atIndex:indexOfArgument];
                }
                
                va_end(valist);
            }
        }
        
        [invocation retainArguments];
    }
    
    return invocation;
}

+ (NSInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature target:(id)tagert selector:(SEL)selector retainedArguments:(BOOL)retainedArguments arguments:(void *)pArgument0, ...
{
    if (!methodSignature)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: method signature argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    if (!tagert)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: tagert argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    if (!selector)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: selector argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    NSInvocation *invocation = [self invocationWithMethodSignature:methodSignature];
    
    if (invocation)
    {
        invocation.selector = selector;
        invocation.target = tagert;
        
        NSInteger numberOfArguments = (NSInteger)methodSignature.numberOfArguments;
        
        if (numberOfArguments > 2)
        {
            [invocation setArgument:pArgument0 atIndex:2];
            
            if (numberOfArguments > 3)
            {
                va_list valist;
                va_start(valist, pArgument0);
                
                for (NSInteger indexOfArgument = 3; indexOfArgument < numberOfArguments; indexOfArgument++)
                {
                    void *pArgument = va_arg(valist, void *);
                    
                    [invocation setArgument:pArgument atIndex:indexOfArgument];
                }
                
                va_end(valist);
            }
        }
        
        if (retainedArguments)
        {
            [invocation retainArguments];
        }
    }
    
    return invocation;
}

+ (NSInvocation *)invocationWithTarget:(id)tagert selector:(SEL)selector
{
    if (!tagert)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: tagert argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    if (!selector)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: selector argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    NSInvocation *invocation = nil;
    
    if (tagert && selector)
    {
        NSMethodSignature *methodSignature = [tagert methodSignatureForSelector:selector];
        
        if (!methodSignature)
        {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"The %@ method is not found in the target.", NSStringFromSelector(selector)] userInfo:nil];
        }
        
        invocation = [self invocationWithMethodSignature:methodSignature];
        
        if (invocation)
        {
            invocation.selector = selector;
            invocation.target = tagert;
        }
    }
    
    return invocation;
}

+ (NSInvocation *)invocationWithTarget:(id)tagert selector:(SEL)selector arguments:(void *)pArgument0, ...
{
    if (!tagert)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: tagert argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    if (!selector)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: selector argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    NSInvocation *invocation = nil;
    
    if (tagert && selector)
    {
        NSMethodSignature *methodSignature = [tagert methodSignatureForSelector:selector];
        
        if (!methodSignature)
        {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"The %@ method is not found in the target.", NSStringFromSelector(selector)] userInfo:nil];
        }
        
        invocation = [self invocationWithMethodSignature:methodSignature];
        
        if (invocation)
        {
            invocation.selector = selector;
            invocation.target = tagert;
            
            NSInteger numberOfArguments = (NSInteger)methodSignature.numberOfArguments;
            
            if (numberOfArguments > 2)
            {
                [invocation setArgument:pArgument0 atIndex:2];
                
                if (numberOfArguments > 3)
                {
                    va_list valist;
                    va_start(valist, pArgument0);
                    
                    for (NSInteger indexOfArgument = 3; indexOfArgument < numberOfArguments; indexOfArgument++)
                    {
                        void *pArgument = va_arg(valist, void *);
                        
                        [invocation setArgument:pArgument atIndex:indexOfArgument];
                    }
                    
                    va_end(valist);
                }
            }
            
            [invocation retainArguments];
        }
    }
    
    return invocation;
}

+ (NSInvocation *)invocationWithTarget:(id)tagert selector:(SEL)selector retainedArguments:(BOOL)retainedArguments arguments:(void *)pArgument0, ...
{
    if (!tagert)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: tagert argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    if (!selector)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: selector argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    NSInvocation *invocation = nil;
    
    if (tagert && selector)
    {
        NSMethodSignature *methodSignature = [tagert methodSignatureForSelector:selector];
        
        if (!methodSignature)
        {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"The %@ method is not found in the target.", NSStringFromSelector(selector)] userInfo:nil];
        }
        
        invocation = [self invocationWithMethodSignature:methodSignature];
        
        if (invocation)
        {
            invocation.selector = selector;
            invocation.target = tagert;
            
            NSInteger numberOfArguments = (NSInteger)methodSignature.numberOfArguments;
            
            if (numberOfArguments > 2)
            {
                [invocation setArgument:pArgument0 atIndex:2];
                
                if (numberOfArguments > 3)
                {
                    va_list valist;
                    va_start(valist, pArgument0);
                    
                    for (NSInteger indexOfArgument = 3; indexOfArgument < numberOfArguments; indexOfArgument++)
                    {
                        void *pArgument = va_arg(valist, void *);
                        
                        [invocation setArgument:pArgument atIndex:indexOfArgument];
                    }
                    
                    va_end(valist);
                }
            }
            
            if (retainedArguments)
            {
                [invocation retainArguments];
            }
        }
    }
    
    return invocation;
}

@end

@implementation NSObject (NSObjectRENSInvocation)

#pragma mark - Sending Messages

- (id)performInvocation:(NSInvocation *)invocation
{
    if (!invocation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The invocation argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    [invocation invokeWithTarget:self];
    
    NSMethodSignature *methodSignature = invocation.methodSignature;
    
    NSUInteger methodReturnLength = methodSignature.methodReturnLength;
    
    NSUInteger numberOfIDs = (methodReturnLength + sizeof(id) - 1) / sizeof(id);
    
    if (numberOfIDs == 0)
    {
        numberOfIDs = 1;
    }
    
    id ids[numberOfIDs];
    memset(ids, 0, (numberOfIDs * sizeof(id)));
    
    if (methodReturnLength > 0)
    {
        [invocation getReturnValue:ids];
    }
    
    id returnValue = ids[0];
    return returnValue;
}

- (void)performInvocation:(NSInvocation *)invocation returnValue:(void *)returnLocation
{
    if (!invocation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The invocation argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    [invocation invokeWithTarget:self];
    
    if (returnLocation)
    {
        [invocation getReturnValue:returnLocation];
    }
}

- (void)performInvocation:(NSInvocation *)invocation onThread:(NSThread *)thread waitUntilDone:(BOOL)wait
{
    if (!invocation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The invocation argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    [invocation performSelector:@selector(invokeWithTarget:) onThread:thread withObject:self waitUntilDone:wait];
}

- (void)performInvocation:(NSInvocation *)invocation onThread:(NSThread *)thread waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    if (!invocation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The invocation argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    [invocation performSelector:@selector(invokeWithTarget:) onThread:thread withObject:self waitUntilDone:wait modes:modes];
}

- (void)performInvocation:(NSInvocation *)invocation afterDelay:(NSTimeInterval)delay
{
    if (!invocation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The invocation argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    [invocation performSelector:@selector(invokeWithTarget:) withObject:self afterDelay:delay];
}

- (void)performInvocation:(NSInvocation *)invocation afterDelay:(NSTimeInterval)delay inModes:(NSArray *)modes
{
    if (!invocation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The invocation argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    [invocation performSelector:@selector(invokeWithTarget:) withObject:self afterDelay:delay inModes:modes];
}

- (void)performInvocationInBackground:(NSInvocation *)invocation
{
    if (!invocation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The invocation argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    [invocation performSelectorInBackground:@selector(invokeWithTarget:) withObject:self];
}

- (void)performInvocationOnMainThread:(NSInvocation *)invocation waitUntilDone:(BOOL)wait
{
    if (!invocation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The invocation argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    [invocation performSelectorOnMainThread:@selector(invokeWithTarget:) withObject:self waitUntilDone:wait];
}

- (void)performInvocationOnMainThread:(NSInvocation *)invocation waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    if (!invocation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The invocation argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    [invocation performSelectorOnMainThread:@selector(invokeWithTarget:) withObject:self waitUntilDone:wait modes:modes];
}

- (void)performInvocationOnSecondThread:(NSInvocation *)invocation waitUntilDone:(BOOL)wait
{
    if (!invocation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The invocation argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    [invocation performSelectorOnSecondThread:@selector(invokeWithTarget:) withObject:self waitUntilDone:wait];
}

- (void)performInvocationOnSecondThread:(NSInvocation *)invocation waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    if (!invocation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: The invocation argument can not be nil.", NSStringFromClass(self.class), NSStringFromSelector(_cmd)] userInfo:nil];
    }
    
    [invocation performSelectorOnSecondThread:@selector(invokeWithTarget:) withObject:self waitUntilDone:wait modes:modes];
}

#pragma mark - Sending Messages on the Main Thread

- (void)performSelectorOnMainThread:(SEL)selector waitUntilDone:(BOOL)wait
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocationOnMainThread:invocation waitUntilDone:wait];
}

- (void)performSelectorOnMainThread:(SEL)selector waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocationOnMainThread:invocation waitUntilDone:wait modes:modes];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 waitUntilDone:(BOOL)wait
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocationOnMainThread:invocation waitUntilDone:wait];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocationOnMainThread:invocation waitUntilDone:wait modes:modes];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 waitUntilDone:(BOOL)wait
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocationOnMainThread:invocation waitUntilDone:wait];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocationOnMainThread:invocation waitUntilDone:wait modes:modes];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 waitUntilDone:(BOOL)wait
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocationOnMainThread:invocation waitUntilDone:wait];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocationOnMainThread:invocation waitUntilDone:wait modes:modes];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 waitUntilDone:(BOOL)wait
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocationOnMainThread:invocation waitUntilDone:wait];
}

- (void)performSelectorOnMainThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocationOnMainThread:invocation waitUntilDone:wait modes:modes];
}

#pragma mark - Sending Messages on the Second Thread

- (void)performSelectorOnSecondThread:(SEL)selector waitUntilDone:(BOOL)wait
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocationOnSecondThread:invocation waitUntilDone:wait];
}

- (void)performSelectorOnSecondThread:(SEL)selector waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector];
    [self performInvocationOnSecondThread:invocation waitUntilDone:wait modes:modes];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 waitUntilDone:(BOOL)wait
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocationOnSecondThread:invocation waitUntilDone:wait];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2];
    [self performInvocationOnSecondThread:invocation waitUntilDone:wait modes:modes];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 waitUntilDone:(BOOL)wait
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocationOnSecondThread:invocation waitUntilDone:wait];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3];
    [self performInvocationOnSecondThread:invocation waitUntilDone:wait modes:modes];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 waitUntilDone:(BOOL)wait
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocationOnSecondThread:invocation waitUntilDone:wait];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4];
    [self performInvocationOnSecondThread:invocation waitUntilDone:wait modes:modes];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 waitUntilDone:(BOOL)wait
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocationOnSecondThread:invocation waitUntilDone:wait];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5 waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self selector:selector arguments:&object1, &object2, &object3, &object4, &object5];
    [self performInvocationOnSecondThread:invocation waitUntilDone:wait modes:modes];
}

@end
