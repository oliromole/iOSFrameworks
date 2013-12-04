//
//  RENSNumber.m
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.07.20.
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
#import "RENSNumber.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

NSNumber * NSNumberCharNegativeOne = nil;
NSNumber * NSNumberShortNegativeOne = nil;
NSNumber * NSNumberIntNegativeOne = nil;
NSNumber * NSNumberLongNegativeOne = nil;
NSNumber * NSNumberLongLongNegativeOne = nil;
NSNumber * NSNumberFloatNegativeOne = nil;
NSNumber * NSNumberDoubleNegativeOne = nil;
NSNumber * NSNumberIntegerNegativeOne = nil;

NSNumber * NSNumberCharZero = nil;
NSNumber * NSNumberUnsignedCharZero = nil;
NSNumber * NSNumberShortZero = nil;
NSNumber * NSNumberUnsignedShortZero = nil;
NSNumber * NSNumberIntZero = nil;
NSNumber * NSNumberUnsignedIntZero = nil;
NSNumber * NSNumberLongZero = nil;
NSNumber * NSNumberUnsignedLongZero = nil;
NSNumber * NSNumberLongLongZero = nil;
NSNumber * NSNumberUnsignedLongLongZero = nil;
NSNumber * NSNumberFloatZero = nil;
NSNumber * NSNumberDoubleZero = nil;
NSNumber * NSNumberIntegerZero = nil;
NSNumber * NSNumberUnsignedIntegerZero = nil;

NSNumber * NSNumberCharOne = nil;
NSNumber * NSNumberUnsignedCharOne = nil;
NSNumber * NSNumberShortOne = nil;
NSNumber * NSNumberUnsignedShortOne = nil;
NSNumber * NSNumberIntOne = nil;
NSNumber * NSNumberUnsignedIntOne = nil;
NSNumber * NSNumberLongOne = nil;
NSNumber * NSNumberUnsignedLongOne = nil;
NSNumber * NSNumberLongLongOne = nil;
NSNumber * NSNumberUnsignedLongLongOne = nil;
NSNumber * NSNumberFloatOne = nil;
NSNumber * NSNumberDoubleOne = nil;
NSNumber * NSNumberIntegerOne = nil;
NSNumber * NSNumberUnsignedIntegerOne = nil;

NSNumber * NSNumberBoolNO = nil;
NSNumber * NSNumberBoolYES = nil;

@implementation NSNumber (NSNumberRENSNumber)

#pragma mark - Initializing a Class

+ (void)load
{
    NSNumberCharNegativeOne = [[NSNumber alloc] initWithChar:(char)(-1)];
    NSNumberShortNegativeOne = [[NSNumber alloc] initWithShort:(short)(-1)];
    NSNumberIntNegativeOne = [[NSNumber alloc] initWithInt:-1];
    NSNumberLongNegativeOne = [[NSNumber alloc] initWithLong:-1l];
    NSNumberLongLongNegativeOne = [[NSNumber alloc] initWithLongLong:-1ll];
    NSNumberFloatNegativeOne = [[NSNumber alloc] initWithFloat:-1.0f];
    NSNumberDoubleNegativeOne = [[NSNumber alloc] initWithDouble:-1.0];
    NSNumberIntegerNegativeOne = [[NSNumber alloc] initWithInteger:(NSInteger)(-1)];
    
    NSNumberCharZero = [[NSNumber alloc] initWithChar:(char)0];
    NSNumberUnsignedCharZero = [[NSNumber alloc] initWithUnsignedChar:(unsigned char)0];
    NSNumberShortZero = [[NSNumber alloc] initWithShort:(short)0];
    NSNumberUnsignedShortZero = [[NSNumber alloc] initWithUnsignedShort:(unsigned short)0];
    NSNumberIntZero = [[NSNumber alloc] initWithInt:0];
    NSNumberUnsignedIntZero = [[NSNumber alloc] initWithUnsignedInt:0];
    NSNumberLongZero = [[NSNumber alloc] initWithLong:0l];
    NSNumberUnsignedLongZero = [[NSNumber alloc] initWithUnsignedLong:0lu];
    NSNumberLongLongZero = [[NSNumber alloc] initWithLongLong:0ll];
    NSNumberUnsignedLongLongZero = [[NSNumber alloc] initWithUnsignedLongLong:0llu];
    NSNumberFloatZero = [[NSNumber alloc] initWithFloat:0.0f];
    NSNumberDoubleZero = [[NSNumber alloc] initWithDouble:0.0];
    NSNumberIntegerZero = [[NSNumber alloc] initWithInteger:(NSInteger)0];
    NSNumberUnsignedIntegerZero = [[NSNumber alloc] initWithUnsignedInteger:(NSUInteger)0];
    
    NSNumberCharOne = [[NSNumber alloc] initWithChar:(char)1];
    NSNumberUnsignedCharOne = [[NSNumber alloc] initWithUnsignedChar:(unsigned char)1];
    NSNumberShortOne = [[NSNumber alloc] initWithShort:(short)1];
    NSNumberUnsignedShortOne = [[NSNumber alloc] initWithUnsignedShort:(unsigned short)1];
    NSNumberIntOne = [[NSNumber alloc] initWithInt:1];
    NSNumberUnsignedIntOne = [[NSNumber alloc] initWithUnsignedInt:1];
    NSNumberLongOne = [[NSNumber alloc] initWithLong:1l];
    NSNumberUnsignedLongOne = [[NSNumber alloc] initWithUnsignedLong:1lu];
    NSNumberLongLongOne = [[NSNumber alloc] initWithLongLong:1ll];
    NSNumberUnsignedLongLongOne = [[NSNumber alloc] initWithUnsignedLongLong:1llu];
    NSNumberFloatOne = [[NSNumber alloc] initWithFloat:1.0f];
    NSNumberDoubleOne = [[NSNumber alloc] initWithDouble:1.0];
    NSNumberIntegerOne = [[NSNumber alloc] initWithInteger:(NSInteger)1];
    NSNumberUnsignedIntegerOne = [[NSNumber alloc] initWithUnsignedInteger:(NSUInteger)1];
    
    NSNumberBoolNO = [[NSNumber alloc] initWithBool:NO];
    NSNumberBoolYES = [[NSNumber alloc] initWithBool:YES];
}

#pragma mark - Comparing NSNumber Objects

+ (NSComparisonResult)compareLeftNumber:(NSNumber *)leftNumber rightNumber:(NSNumber *)rightNumber
{
    NSComparisonResult comparisonResult;
    
    if (leftNumber && rightNumber)
    {
        comparisonResult = [leftNumber compare:rightNumber];
    }
    
    else if (!leftNumber && rightNumber)
    {
        comparisonResult = NSOrderedAscending;
    }
    
    else if (leftNumber && !rightNumber)
    {
        comparisonResult = NSOrderedDescending;
    }
    
    // !leftNumber && !rightNumber.
    else
    {
        comparisonResult = NSOrderedSame;
    }
    
    return comparisonResult;
}

@end
