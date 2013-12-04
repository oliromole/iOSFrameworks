//
//  RFNSStopwatch.m
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2010.09.24.
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
#import "RFNSStopwatch.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RFNSStopwatch

#pragma mark - Initializing and Creating a RFNSStopwatch

- (id)init
{
    if ((self = [super init]))
    {
        mElapsed = 0.0;
        mStartDate = nil;
    }
    
    return self;
}

+ (id)stopwatch
{
    return [[self alloc] init];
}

#pragma mark - Deallocating a RFNSStopwatch

- (void)dealloc
{
    mStartDate = nil;
}

#pragma mark - Accessing the RFNSStopwatch Object

- (double)elapsed
{
    return mElapsed;
}

- (BOOL)isRunning
{
    return (mStartDate != nil);
}

#pragma mark - Managing the Work Stopwatch

- (void)reset
{
    mElapsed = 0.0;
    
    mStartDate = nil;
}

- (void)restart
{
    mElapsed = 0.0;
    
    mStartDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0];
}

- (void)start
{
    if (!mStartDate)
    {
        mStartDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0];
    }
}

- (void)stop
{
    if (mStartDate)
    {
        mElapsed -= [mStartDate timeIntervalSinceNow];
        
        mStartDate = nil;
    }
}

@end
