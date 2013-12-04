//
//  RFNSWeakInvocation.m
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.08.13.
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
#import "RFNSWeakInvocation.h"

// Importing the project headers.
#import "RFNSObjectWrapper.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RFNSWeakInvocation

#pragma mark - Initializing and Creating a RFNSWeakInvocation

+ (RFNSWeakInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature
{
    // Creating the invocation
    RFNSWeakInvocation *invocation = (RFNSWeakInvocation *)[super invocationWithMethodSignature:methodSignature];
    
    // We have created the invocation.
    if (invocation)
    {
        // Getting the number of arguments.
        NSUInteger numberOfArguments = methodSignature.numberOfArguments;
        
        // Creating the array of the argument wrappers for weak or strong references.
        invocation->mArgumentWrappers1 = [[NSMutableArray alloc] initWithCapacity:numberOfArguments];
        
        // Creating the array of the argument wrappers for strong references.
        invocation->mArgumentWrappers2 = [[NSMutableArray alloc] initWithCapacity:numberOfArguments];
        
        // Enumerating the arguments to fill the array of the argument wrappers.
        for (NSUInteger indexOfArgument = 0; indexOfArgument < numberOfArguments; indexOfArgument++)
        {
            // Getting the type encoding for the argument.
            const char *argumentType = [methodSignature getArgumentTypeAtIndex:indexOfArgument];
            
            // The argument is an object.
            if (strcmp(argumentType, "@") == 0)
            {
                // Creating the argument wrapper for weak or strong reference.
                RFNSObjectWrapper *argumentWrapper1 = [[RFNSObjectWrapper alloc] initWithOptions:(RFNSObjectWrapperOptionWeakReference)];
                
                // Creating the argument wrapper for strong reference.
                RFNSObjectWrapper *argumentWrapper2 = [[RFNSObjectWrapper alloc] initWithOptions:(0)];
                
                // Saving the argument wrappers.
                [invocation->mArgumentWrappers1 addObject:argumentWrapper1];
                [invocation->mArgumentWrappers2 addObject:argumentWrapper2];
            }
            
            // The argument is not an object.
            else
            {
                // Saving the value that indicates the argumet is not an object.
                [invocation->mArgumentWrappers1 addObject:[NSNull null]];
                [invocation->mArgumentWrappers2 addObject:[NSNull null]];
            }
        }
    }
    
    // Returning the new created invocation.
    return invocation;
}

#pragma mark - Deallocating a RFNSWeakInvocation

- (void)dealloc
{
    // Releasing the argument wrappers #1.
    mArgumentWrappers1 = nil;
    
    // Releasing the argument wrappers #2.
    mArgumentWrappers2 = nil;
}

#pragma mark - Configuring an Invocation Object

- (void)retainArguments
{
    // This stub.
}

- (BOOL)argumentsRetained
{
    // Getting the value that indicates that arguments are retained.
    BOOL argumentsRetained = [super argumentsRetained];
    
    // Returning the value that indicates that arguments are retained.
    return argumentsRetained;
}

- (BOOL)targetWeakReferece
{
    // Getting the value that indicates that we have saved a weak reference on the target.
    BOOL targetWeakReferece = [self argumentWeakRefereceAtIndex:0];
    
    // Returning the value that indicates that we have saved a weak reference on the target.
    return targetWeakReferece;
}

- (void)setTargetWeakReferece:(BOOL)targetWeakReferece
{
    // Setting the weak or strong reference on the target.
    [self setArgumentWeakReferece:targetWeakReferece atIndex:0];
}

- (BOOL)argumentWeakRefereceAtIndex:(NSInteger)index
{
    // Getting the value that indicates that we have saved a weak reference on the argument.
    RFNSObjectWrapper *argumentWrapper1 = mArgumentWrappers1[(NSUInteger)index];
    BOOL argumentWeakReferece = ((argumentWrapper1.options & RFNSObjectWrapperOptionReferenceMask) == RFNSObjectWrapperOptionWeakReference);
    
    // Returning the value that indicates that we have saved a weak reference on the argument.
    return argumentWeakReferece;
}

- (void)setArgumentWeakReferece:(BOOL)argumentWeakReferece atIndex:(NSInteger)index
{
    // Getting the argument wrapper.
    RFNSObjectWrapper *argumentWrapper1 = mArgumentWrappers1[(NSUInteger)index];
    
    // We must have weak reference on the argument.
    if (argumentWeakReferece)
    {
        // Setting the weak reference on the argument.
        [argumentWrapper1 setOptionWeakReference];
    }
    
    // We must have strong reference on the argument.
    else
    {
        // Setting the strong reference on the argument.
        [argumentWrapper1 setOptionStrongReference];
    }
}

- (void)getArgument:(void *)argumentLocation atIndex:(NSInteger)index
{
    // Getting the argument wrapper.
    RFNSObjectWrapper *argumentWrapper1 = mArgumentWrappers1[(NSUInteger)index];
    
    // The argument is not an object.
    if (argumentWrapper1 == (id)[NSNull null])
    {
        // Getting the argument located at the index.
        [super getArgument:argumentLocation atIndex:index];
    }
    
    // The argument is an object.
    else
    {
        // Getting the argument located at the index.
        *((id __unsafe_unretained *)argumentLocation) = argumentWrapper1.object;
    }
}

- (void)setArgument:(void *)argumentLocation atIndex:(NSInteger)index
{
    // Getting the argument wrapper.
    RFNSObjectWrapper *argumentWrapper1 = mArgumentWrappers1[(NSUInteger)index];
    
    // The argument is not an object.
    if (argumentWrapper1 == (id)[NSNull null])
    {
        // Setting the argument at the index.
        [super setArgument:argumentLocation atIndex:index];
    }
    
    // The argument is an object.
    else
    {
        // Setting the argument at the index.
        argumentWrapper1.object = *((id __unsafe_unretained *)argumentLocation);
    }
}

// Dispatching an Invocation

- (void)invoke
{
    // Getting the number of arguments.
    NSUInteger numberOfArguments = mArgumentWrappers1.count;
    
    // Saving strong references on the arguments.
    
    // Enumerating the arguments.
    for (NSUInteger indexOfArgument = 0; indexOfArgument < numberOfArguments; indexOfArgument++)
    {
        // Getting the argument wrapper #1.
        RFNSObjectWrapper *argumentWrapper1 = mArgumentWrappers1[indexOfArgument];
        
        // The argument is an object.
        if (argumentWrapper1 != (id)[NSNull null])
        {
            // Getting the argument wrapper #2.
            RFNSObjectWrapper *argumentWrapper2 = mArgumentWrappers1[indexOfArgument];
            
            // Getting the object of the argument.
            id object = argumentWrapper1.object;
            
            // Setting the strong reference on the object.
            argumentWrapper2.object = object;
            
            // Setting the argument.
            [super setArgument:&object atIndex:(NSInteger)indexOfArgument];
        }
    }
    
    // Sending the receiver’s message (with arguments) to its target and setting the return value.
    [super invoke];
    
    // Resetting the strong references on the arguments.
    
    // Enumerating the arguments.
    for (NSUInteger indexOfArgument = 0; indexOfArgument < numberOfArguments; indexOfArgument++)
    {
        // Getting the argument wrapper #1.
        RFNSObjectWrapper *argumentWrapper1 = mArgumentWrappers1[indexOfArgument];
        
        // The argument is an object.
        if (argumentWrapper1 != (id)[NSNull null])
        {
            // Getting the argument wrapper #2.
            RFNSObjectWrapper *argumentWrapper2 = mArgumentWrappers1[indexOfArgument];
            
            // Setting the default value.
            id object = nil;
            
            // Resetting the argument.
            [super setArgument:&object atIndex:(NSInteger)indexOfArgument];
            
            // Resetting the strong reference on the object.
            argumentWrapper2.object = object;
        }
    }
}

- (void)invokeWithTarget:(id)target
{
    // Invoking with the target.
    [super invokeWithTarget:target];
}

@end
