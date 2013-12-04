//
//  RENSDate.m
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.06.14.
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
#import "RENSDate.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation NSDate (NSDateRENSDate)

#pragma mark - Getting Time Intervals

+ (NSTimeInterval)timeIntervalSinceDate:(NSDate *)sinceDate
{
    // Calculating the time interval between the current date and the another given date.
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0];
    NSTimeInterval timeIntervalSinceDate = [date timeIntervalSinceDate:sinceDate];
    
    // Returning the time interval between the current date and the another given date.
    return timeIntervalSinceDate;
}

+ (NSTimeInterval)timeIntervalSince1970
{
    // Calculating the time interval between the current date and the reference date, 1 January 1970, GMT.
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0];
    NSTimeInterval timeIntervalSince1970 = [date timeIntervalSince1970];
    
    // Returning the time interval between the current date and the reference date, 1 January 1970, GMT.
    return timeIntervalSince1970;
}

+ (NSTimeInterval)timeIntervalSinceTimeInterval1970:(NSTimeInterval)timeInterval
{
    // Calculating the time interval between the current date and the reference time interval which is 1 January 1970, GMT.
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0];
    NSTimeInterval timeIntervalSince1970 = [date timeIntervalSince1970] - timeInterval;
    
    // Returning the time interval between the current date and the reference date, 1 January 1970, GMT.
    return timeIntervalSince1970;
}

@end
