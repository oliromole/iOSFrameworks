//
//  RENSException.h
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.01.14.
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
#import <Foundation/NSException.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSString.h>

#define RENSAssert(condition, format, ...) \
do \
{ \
    if (!(condition)) \
    { \
        NSString *_rens_assert_message = [NSString stringWithFormat:(format), ##__VA_ARGS__]; \
        _rens_assert_message = _rens_assert_message; \
         \
        NSAssert1(condition, @"%@", _rens_assert_message); \
    } \
} \
while (0)

#define RENSCAssert(condition, format, ...) \
do \
{ \
    if (!(condition)) \
    { \
        NSString *_rensc_assert_message = [NSString stringWithFormat:(format), ##__VA_ARGS__]; \
        _rensc_assert_message = _rensc_assert_message; \
         \
        NSCAssert1(NO, @"%@", _rensc_assert_message); \
    } \
} \
while (0)

#if NS_BLOCKS_AVAILABLE

typedef void (^RENSAbortBlock)(NSString *format, ...);
typedef void (^RENSAssertBlock)(BOOL condition, NSString *format, ...);
typedef void (^RENSWarnBlock)(BOOL condition, NSString *format, ...);

#endif
