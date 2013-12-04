//
//  RENSTimer.m
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.08.23.
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
#import "RENSTimer.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation NSTimer (NSTimerRENSTimer)

#pragma mark - Initializing and Creating a NSTimer

- (id)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector
{
    return [self initWithFireDate:date interval:timeInterval target:target selector:selector userInfo:nil repeats:NO];
}

- (id)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector repeats:(BOOL)repeated
{
    return [self initWithFireDate:date interval:timeInterval target:target selector:selector userInfo:nil repeats:repeated];
}

- (id)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo
{
    return [self initWithFireDate:date interval:timeInterval target:target selector:selector userInfo:userInfo repeats:NO];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval invocation:(NSInvocation *)invocation
{
    return [self timerWithTimeInterval:timeInterval invocation:invocation repeats:NO];
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval invocation:(NSInvocation *)invocation
{
    return [self scheduledTimerWithTimeInterval:timeInterval invocation:invocation repeats:NO];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector
{
    return [self timerWithTimeInterval:timeInterval target:target selector:selector userInfo:nil repeats:NO];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector repeats:(BOOL)repeated
{
    return [self timerWithTimeInterval:timeInterval target:target selector:selector userInfo:nil repeats:repeated];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo
{
    return [self timerWithTimeInterval:timeInterval target:target selector:selector userInfo:userInfo repeats:NO];
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector
{
    return [self scheduledTimerWithTimeInterval:timeInterval target:target selector:selector userInfo:nil repeats:NO];
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector repeats:(BOOL)repeated
{
    return [self scheduledTimerWithTimeInterval:timeInterval target:target selector:selector userInfo:nil repeats:repeated];
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo
{
    return [self scheduledTimerWithTimeInterval:timeInterval target:target selector:selector userInfo:userInfo repeats:NO];
}

@end
