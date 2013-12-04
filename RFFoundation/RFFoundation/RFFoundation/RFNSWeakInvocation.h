//
//  RFNSWeakInvocation.h
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

// Importing the system headers.
#import <Foundation/NSInvocation.h>
#import <Foundation/NSObjCRuntime.h>

@class NSMethodSignature;
@class NSMutableArray;

@class RFNSWeakInvocation;

@interface RFNSWeakInvocation : NSInvocation
{
@protected
    
    NSMutableArray *mArgumentWrappers1;
    NSMutableArray *mArgumentWrappers2;
}

// Initializing and Creating a RFNSWeakInvocation

+ (RFNSWeakInvocation *)invocationWithMethodSignature:(NSMethodSignature *)methodSignature;

// Configuring an Invocation Object

- (void)retainArguments; // This method is ignored.
- (BOOL)argumentsRetained; // Always returns NO.

- (BOOL)targetWeakReferece;
- (void)setTargetWeakReferece:(BOOL)targetWeakReferece;

- (BOOL)argumentWeakRefereceAtIndex:(NSInteger)index;
- (void)setArgumentWeakReferece:(BOOL)argumentWeakReferece atIndex:(NSInteger)index;

- (void)getArgument:(void *)argumentLocation atIndex:(NSInteger)index;
- (void)setArgument:(void *)argumentLocation atIndex:(NSInteger)index;

// Dispatching an Invocation

- (void)invoke; // The method is not thread safe!
- (void)invokeWithTarget:(id)target; // The method is not thread safe!

@end
