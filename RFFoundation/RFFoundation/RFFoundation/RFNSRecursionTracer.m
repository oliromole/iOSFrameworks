//
//  RFNSRecursionTracer.m
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.06.20.
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
#import "RFNSRecursionTracer.h"

// Importing the project headers.
#import "RFNSRecursionTracerFunctionInformation.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

NSString *RFNSRecursionTracerRFNSRecursionTracersKey = @"RFNSRecursionTracerRFNSRecursionTracersKey";

@implementation RFNSRecursionTracer

#pragma mark - Initializing and Creating a RFNSRecursionTracer

- (id)init
{
    return [self initWithIdentifier:nil];
}

+ (id)recursionTrace
{
    return [[self alloc] init];
}

- (id)initWithIdentifier:(NSString *)identifier
{
    // Correcting the identifier.
    identifier = (identifier ?: RFNSRecursionTracerDefaultIdentifier);
    
    // Getting the RFNSRecursionTracer instance for the current thread.
    NSThread *thread = [NSThread currentThread];
    NSMutableDictionary *threadDictionary = thread.threadDictionary;
    NSMutableDictionary *recursionTracers = [threadDictionary objectForKey:RFNSRecursionTracerRFNSRecursionTracersKey];
    RFNSRecursionTracer *recursionTracer = recursionTracers[identifier];
    
    // We have the RFNSRecursionTracer instance for the current thread.
    if (recursionTracer)
    {
        // Releasing the self;
        self = nil;
        
        // Returning the RFNSRecursionTracer instance for the current thread.
        return recursionTracer;
    }
    
    if ((self = [super init]))
    {
        // Craeting the array of the function infomation.
        mFunctionInfomations = [[NSMutableArray alloc] init];
        
        // Saving the identifier.
        mIdentifier = [identifier copy];
        
        // We have the dictionary of the recursion tracers.
        if (recursionTracers)
        {
            // Saving the recursion tracer.
            recursionTracers[mIdentifier] = self;
        }
        
        // We do not have the dictionary of the recursion tracers.
        else
        {
            // Creating the dictionary of the recursion tracers.
            recursionTracers = [[NSMutableDictionary alloc] init];
            recursionTracers[mIdentifier] = self;
            
            // Saving the dictionary of the recursion tracers.
            threadDictionary[RFNSRecursionTracerRFNSRecursionTracersKey] = recursionTracers;
        }
    }
    
    return self;
}

+ (id)recursionTracerWithIdentifier:(NSString *)identifier
{
    // Correcting the identifier.
    identifier = (identifier ?: RFNSRecursionTracerDefaultIdentifier);
    
    // Getting the RFNSRecursionTracer instance for the current thread.
    NSThread *thread = [NSThread currentThread];
    NSMutableDictionary *threadDictionary = thread.threadDictionary;
    NSMutableDictionary *recursionTracers = [threadDictionary objectForKey:RFNSRecursionTracerRFNSRecursionTracersKey];
    RFNSRecursionTracer *recursionTracer = recursionTracers[identifier];
    
    // We have the RFNSRecursionTracer instance for the current thread.
    if (recursionTracer)
    {
        return recursionTracer;
    }
    
    // We do not have the RFNSRecursionTracer instance for the current thread.
    else
    {
        // Returning the RFNSRecursionTracer instance for the current thread.
        return [[self alloc] initWithIdentifier:identifier];
    }
}

#pragma mark - Dealocating a RFNSRecursionTracer

- (void)dealloc
{
    // Releasing the dictionary of the function informations.
    mFunctionInfomations = nil;
    
    // Releasing the identifier.
    mIdentifier = nil;
}

#pragma mark - Tracing a Function

- (BOOL)beginTraceFunction:(const char *)functionName fileName:(const char *)fileName line:(int)line argument:(id)argument
{
    if (!functionName)
    {
        @throw [NSException exceptionWithName:NSGenericException reason:@"The functionName argument is nil." userInfo:nil];
    }
    
    if (!fileName)
    {
        @throw [NSException exceptionWithName:NSGenericException reason:@"The fileName argument is nil." userInfo:nil];
    }
    
    // Creating the function information.
    RFNSRecursionTracerFunctionInformation *functionInformation = [[RFNSRecursionTracerFunctionInformation alloc] initWithCFunctionName:functionName fileName:fileName line:line argument:argument];
    
    // Calculating the value which indicate that we have a recursive call.
    NSUInteger indexOfFunctionInformation = [mFunctionInfomations indexOfObject:functionInformation];
    BOOL hasRecursion = (indexOfFunctionInformation != NSNotFound);
    
    // Saving the function infomation.
    [mFunctionInfomations addObject:functionInformation];
    
    // Returning the value which indicate that we have a recursive call.
    return hasRecursion;
}

- (void)endTrace
{
    if (mFunctionInfomations.count == 0)
    {
        @throw [NSException exceptionWithName:NSGenericException reason:@"The method has a logical error. You must call the method: beginTraceFunction:fileName:line:argument: before to call the mehtod endTrace." userInfo:nil];
    }
    
    // Removeing the last function information.
    [mFunctionInfomations removeLastObject];
    
    // We do not have any function infomation.
    if (mFunctionInfomations.count == 0)
    {
        // Getting the thread dictionary for the current thread.
        NSThread *thread = [NSThread currentThread];
        NSMutableDictionary *threadDictionary = thread.threadDictionary;
        
        // Getting the dictionary of the recursion tracers.
        NSMutableDictionary *recursionTracers = [threadDictionary objectForKey:RFNSRecursionTracerRFNSRecursionTracersKey];
        
        // Removing the recursion tracer from the dictionary.
        [recursionTracers removeObjectForKey:mIdentifier];
        
        // The dictionary does not have any recursion tracer.
        if (recursionTracers.count == 0)
        {
            // Remove the dictionry from the thread dictionary.
            [threadDictionary removeObjectForKey:RFNSRecursionTracerRFNSRecursionTracersKey];
        }
    }
}

@end

NSString * const RFNSRecursionTracerDefaultIdentifier = @"RFNSRecursionTracerDefaultIdentifier";
NSString * const RFNSRecursionTracerDescriptionIdentifier = @"RFNSRecursionTracerDescriptionIdentifier";
