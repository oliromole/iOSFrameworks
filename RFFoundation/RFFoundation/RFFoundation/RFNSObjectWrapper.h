//
//  RFNSObjectWrapper.h
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.06.16.
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

// Importing the project headers.
#import "RFNSObjectWrapperOptions.h"

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>

@interface RFNSObjectWrapper : NSObject
<
NSCopying
>
{
@protected
    
    SEL                      mEqualSelector;
    SEL                      mHashSelector;
    RFNSObjectWrapperOptions mOptions;
    id __strong              mStrongObject;
    id __weak                mWeakObject;
}

// Initializing and Creating a RFNSObjectWrapper

+ (id)objectWrapper;

- (id)initWithObject:(id)object;
+ (id)objectWrapperWithObject:(id)object;

- (id)initWithObject:(id)object equalSelector:(SEL)equalSelector hashSelector:(SEL)hashSelector;
+ (id)objectWrapperWithObject:(id)object equalSelector:(SEL)equalSelector hashSelector:(SEL)hashSelector;

- (id)initWithOptions:(RFNSObjectWrapperOptions)options;
+ (id)objectWrapperWithOptions:(RFNSObjectWrapperOptions)options;

- (id)initWithObject:(id)object options:(RFNSObjectWrapperOptions)options;
+ (id)objectWrapperWithObject:(id)object options:(RFNSObjectWrapperOptions)options;

- (id)initWithObject:(id)object options:(RFNSObjectWrapperOptions)options equalSelector:(SEL)equalSelector hashSelector:(SEL)hashSelector;
+ (id)objectWrapperWithObject:(id)object options:(RFNSObjectWrapperOptions)options equalSelector:(SEL)equalSelector hashSelector:(SEL)hashSelector;

// Managing the Object.

- (id)object;
- (void)setObject:(id)object;
- (void)setObject:(id)object options:(RFNSObjectWrapperOptions)options;

- (RFNSObjectWrapperOptions)options;
- (void)setOptions:(RFNSObjectWrapperOptions)options;

- (void)setOptionStrongReference;
- (void)setOptionWeakReference;

- (void)setOptionCopy;
- (void)setOptionDeepCopy;
- (void)setOptionDeepMutableCopy;
- (void)setOptionNoCopy;

@property (nonatomic, readonly) SEL equalSelector;
@property (nonatomic, readonly) SEL hashSelector;
- (void)setEqualSelector:(SEL)equalSelector hashSelector:(SEL)hashSelector;

@end
