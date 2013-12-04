//
//  RFNSRecursionTracer.h
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

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>

@class NSMutableArray;
@class NSString;

@interface RFNSRecursionTracer : NSObject
{
@protected
    
    NSMutableArray *mFunctionInfomations;
    NSString       *mIdentifier;
}

// Initializing and Creating a RFNSRecursionTracer

+ (id)recursionTrace;

- (id)initWithIdentifier:(NSString *)identifier;
+ (id)recursionTracerWithIdentifier:(NSString *)identifier;

// Tracing a Function

- (BOOL)beginTraceFunction:(const char *)functionName fileName:(const char *)fileName line:(int)line argument:(id)argument;
- (void)endTrace;

@end

#define RFNSRecursionTracerBeginWithIdentifier(identifier) [[RFNSRecursionTracer recursionTracerWithIdentifier:identifier] beginTraceFunction:__PRETTY_FUNCTION__ fileName:__FILE__ line:__LINE__ argument:nil]
#define RFNSRecursionTracerBeginWithIdentifierAndObject(identifier, object) [[RFNSRecursionTracer recursionTracerWithIdentifier:identifier] beginTraceFunction:__PRETTY_FUNCTION__ fileName:__FILE__ line:__LINE__ argument:object]
#define RFNSRecursionTracerEndWithIdentifier(identifier)  [[RFNSRecursionTracer recursionTracerWithIdentifier:identifier] endTrace];

#define RFNSRecursionTracerBegin() RFNSRecursionTracerBeginWithIdentifier(nil)
#define RFNSRecursionTracerBeginWithObject(object) RFNSRecursionTracerBeginWithIdentifierAndObject(nil, object);
#define RFNSRecursionTracerEnd() RFNSRecursionTracerEndWithIdentifier(nil)

#define RFNSDescriptionRecursionTracerBegin() RFNSRecursionTracerBeginWithIdentifier(RFNSRecursionTracerDescriptionIdentifier)
#define RFNSDescriptionRecursionTracerEnd() RFNSRecursionTracerEndWithIdentifier(RFNSRecursionTracerDescriptionIdentifier)

FOUNDATION_EXTERN NSString * const RFNSRecursionTracerDefaultIdentifier;
FOUNDATION_EXTERN NSString * const RFNSRecursionTracerDescriptionIdentifier;
