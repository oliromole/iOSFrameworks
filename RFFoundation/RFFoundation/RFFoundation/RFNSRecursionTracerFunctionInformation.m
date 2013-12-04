//
//  RFNSRecursionTracerFunctionInformation.h
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
#import "RFNSRecursionTracerFunctionInformation.h"

// Importing the project headers.
#import "RFNSRecursionTracer.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RFNSRecursionTracerFunctionInformation

#pragma mark - Initializing and Creating a RFNSRecursionTracerFunctionInformation

- (id)init
{
    if ((self = [super init]))
    {
        // Setting the default values.
        mFileName = nil;
        mFunctionName = nil;
        mLine = 0;
        mObject = nil;
    }
    
    return self;
}

- (id)initWithCFunctionName:(const char *)functionName fileName:(const char *)fileName line:(int)line argument:(id)argument
{
    if ((self = [self init]))
    {
        // Saving the arguments.
        self.fileName = [[NSString alloc] initWithCString:fileName encoding:NSUTF8StringEncoding];
        self.functionName = [[NSString alloc] initWithCString:functionName encoding:NSUTF8StringEncoding];
        self.line = line;
        self.object = argument;
    }
    
    return self;
}

#pragma mark - Deallocating a RFNSRecursionTracerFunctionInformation

- (void)dealloc
{
    // Releasing the file name.
    mFileName = nil;
    
    // Releasing the function name.
    mFunctionName = nil;
    
    // Releasing the object.
    mObject = nil;
}

#pragma mark - Manaing the RFNSRecursionTracerFunctionInformation Object

@synthesize fileName = mFileName;
@synthesize functionName = mFunctionName;
@synthesize line = mLine;
@synthesize object = mObject;

#pragma mark - Conforming the NSObject Protocol

#pragma mark Identifying and Comparing Objects

- (BOOL)isEqual:(id)object
{
    // Setting the default value.
    BOOL isEqual = NO;
    
    // The objec is the RFNSRecursionTracerFunctionInformation object.
    if ([object isKindOfClass:[RFNSRecursionTracerFunctionInformation class]])
    {
        // Casting the object ot the RFNSRecursionTracerFunctionInformation object.
        RFNSRecursionTracerFunctionInformation *rightFunctionInformation = (RFNSRecursionTracerFunctionInformation *)object;
        
        // Comparing the left function information with the right function information.
        
        isEqual = ((!mFileName == !rightFunctionInformation->mFileName) &&
                   (!mFunctionName == !rightFunctionInformation->mFunctionName) &&
                   (mLine == rightFunctionInformation->mLine) &&
                   (!mObject == !rightFunctionInformation->mObject));
        
        if (isEqual && mFileName && rightFunctionInformation->mFileName)
        {
            isEqual = [mFileName isEqual:rightFunctionInformation->mFileName];
        }
        
        if (isEqual && mFunctionName && rightFunctionInformation->mFunctionName)
        {
            isEqual = [mFunctionName isEqual:rightFunctionInformation->mFunctionName];
        }
        
        if (isEqual && mObject && rightFunctionInformation->mObject)
        {
            isEqual = [mObject isEqual:rightFunctionInformation->mObject];
        }
    }
    
    // Returning the result of compared function informations.
    return isEqual;
}

- (NSUInteger)hash
{
    // Calculating the hash.
    NSUInteger hash = (mFileName.hash ^
                       mFunctionName.hash ^
                       (NSUInteger)mLine ^
                       [mObject hash]);
    
    // Returning the hash.
    return hash;
}

#pragma mark Describing Objects

- (NSString *)description
{
    // Creating the desctiption.
    NSMutableString *description = [[NSMutableString alloc] init];
    RENSAssert(description, @"The method has a logical error.");
    
    // Beginning to trace the recursion.
    BOOL hasRecursion = RFNSDescriptionRecursionTracerBegin();
    
    // We have the recursion.
    if (hasRecursion)
    {
        // Appending the description for the recursive call.
        [description appendFormat:@"<%@ %p> (recursive call)", NSStringFromClass(self.class), self];
    }
    
    // We do not have the recursion.
    else
    {
        // Appending the description of the object.
        [description appendFormat:@"<%@ %p> {\n", NSStringFromClass(self.class), self];
        [description appendFormat:@"    mFileName = %@;\n", [mFileName.description stringByReplacingOccurrencesOfString:@"\n" withString:@"\n    "]];
        [description appendFormat:@"    mFunctionName = %@;\n", [mFunctionName.description stringByReplacingOccurrencesOfString:@"\n" withString:@"\n    "]];
        [description appendFormat:@"    mLine = %ld;\n", (long)mLine];
        [description appendFormat:@"    mObject = %@;\n", [[mObject description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\n    "]];
        [description appendFormat:@"}"];
    }
    
    // Ending to trace the recursion.
    RFNSDescriptionRecursionTracerEnd();
    
    // Returning the desctiption.
    return description;
}

@end
