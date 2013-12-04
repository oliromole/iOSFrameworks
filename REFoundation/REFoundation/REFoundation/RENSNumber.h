//
//  RENSNumber.h
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

// Importing the project headers.
#import "RENSException.h"
#import "RENSObject.h"

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSValue.h>

@class NSNumber;

@interface NSNumber (NSNumberRENSNumber)

// Comparing NSNumber Objects

+ (NSComparisonResult)compareLeftNumber:(NSNumber *)leftNumber rightNumber:(NSNumber *)rightNumber;

@end

#define NSNumberCast(number) NSObjectCast(number, NSNumber)

FOUNDATION_EXTERN NSNumber * NSNumberCharNegativeOne;
FOUNDATION_EXTERN NSNumber * NSNumberShortNegativeOne;
FOUNDATION_EXTERN NSNumber * NSNumberIntNegativeOne;
FOUNDATION_EXTERN NSNumber * NSNumberLongNegativeOne;
FOUNDATION_EXTERN NSNumber * NSNumberLongLongNegativeOne;
FOUNDATION_EXTERN NSNumber * NSNumberFloatNegativeOne;
FOUNDATION_EXTERN NSNumber * NSNumberDoubleNegativeOne;
FOUNDATION_EXTERN NSNumber * NSNumberIntegerNegativeOne;

FOUNDATION_EXTERN NSNumber * NSNumberCharZero;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedCharZero;
FOUNDATION_EXTERN NSNumber * NSNumberShortZero;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedShortZero;
FOUNDATION_EXTERN NSNumber * NSNumberIntZero;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedIntZero;
FOUNDATION_EXTERN NSNumber * NSNumberLongZero;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedLongZero;
FOUNDATION_EXTERN NSNumber * NSNumberLongLongZero;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedLongLongZero;
FOUNDATION_EXTERN NSNumber * NSNumberFloatZero;
FOUNDATION_EXTERN NSNumber * NSNumberDoubleZero;
FOUNDATION_EXTERN NSNumber * NSNumberIntegerZero;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedIntegerZero;

FOUNDATION_EXTERN NSNumber * NSNumberCharOne;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedCharOne;
FOUNDATION_EXTERN NSNumber * NSNumberShortOne;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedShortOne;
FOUNDATION_EXTERN NSNumber * NSNumberIntOne;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedIntOne;
FOUNDATION_EXTERN NSNumber * NSNumberLongOne;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedLongOne;
FOUNDATION_EXTERN NSNumber * NSNumberLongLongOne;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedLongLongOne;
FOUNDATION_EXTERN NSNumber * NSNumberFloatOne;
FOUNDATION_EXTERN NSNumber * NSNumberDoubleOne;
FOUNDATION_EXTERN NSNumber * NSNumberIntegerOne;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedIntegerOne;

FOUNDATION_EXTERN NSNumber * NSNumberBoolNO;
FOUNDATION_EXTERN NSNumber * NSNumberBoolYES;

#define NSNumberBoolFromBool(value) ((value) ? NSNumberBoolYES : NSNumberBoolNO)
#define NSNumberCharFromBool(value) ((value) ? NSNumberCharOne : NSNumberCharZero)
#define NSNumberUnsignedCharFromBool(value) ((value) ? NSNumberUnsignedCharOne : NSNumberUnsignedCharZero)
#define NSNumberShortFromBool(value) ((value) ? NSNumberShortOne : NSNumberShortZero)
#define NSNumberUnsignedShortFromBool(value) ((value) ? NSNumberUnsignedShortOne : NSNumberUnsignedShortZero)
#define NSNumberIntFromBool(value) ((value) ? NSNumberIntOne : NSNumberIntZero)
#define NSNumberUnsignedIntFromBool(value) ((value) ? NSNumberUnsignedIntOne : NSNumberUnsignedIntZero)
#define NSNumberLongFromBool(value) ((value) ? NSNumberLongOne : NSNumberLongZero)
#define NSNumberUnsignedLongFromBool(value) ((value) ? NSNumberUnsignedLongOne : NSNumberUnsignedLongZero)
#define NSNumberLongLongFromBool(value) ((value) ? NSNumberLongLongOne : NSNumberLongLongZero)
#define NSNumberUnsignedLongLongFromBool(value) ((value) ? NSNumberUnsignedLongLongOne : NSNumberUnsignedLongLongZero)
#define NSNumberFloatFromBool(value) ((value) ? NSNumberFloatOne : NSNumberFloatZero)
#define NSNumberUnsignedFloatFromBool(value) ((value) ? NSNumberUnsignedFloatOne : NSNumberUnsignedFloatZero)
#define NSNumberDoubleFromBool(value) ((value) ? NSNumberDoubleOne : NSNumberDoubleZero)
#define NSNumberUnsignedDoubleFromBool(value) ((value) ? NSNumberUnsignedDoubleOne : NSNumberUnsignedDoubleZero)
#define NSNumberIntegerFromBool(value) ((value) ? NSNumberIntegerOne : NSNumberIntegerZero)
#define NSNumberUnsignedIntegerFromBool(value) ((value) ? NSNumberUnsignedIntegerOne : NSNumberUnsignedIntegerZero)

NS_INLINE BOOL NSBoolFromNumberChar(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberCharZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberUnsignedChar(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberUnsignedCharZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberShort(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberShortZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberUnsignedShort(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberUnsignedShortZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberInt(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberIntZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberUnsignedInt(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberUnsignedIntZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberLong(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberLongZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberUnsignedLong(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberUnsignedLongZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberLongLong(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberLongLongZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberUnsignedLongLong(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberUnsignedLongLongZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberFloat(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberFloatZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberDouble(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberDoubleZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberInteger(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberIntegerZero]);
    return boolValue;
}

NS_INLINE BOOL NSBoolFromNumberUnsignedInteger(NSNumber *value)
{
    BOOL boolValue = (value && ![value isEqual:NSNumberUnsignedIntegerZero]);
    return boolValue;
}

NS_INLINE NSNumber *NSNumberMin(NSNumber *leftNumber, NSNumber *rightNumber)
{
    RENSCAssert(leftNumber, @"The leftNumber argument is nil.");
    RENSCAssert(rightNumber, @"The rightNumber argument is nil.");
    
    NSNumber *minNumber = (([leftNumber compare:rightNumber] == NSOrderedAscending) ? leftNumber : rightNumber);
    return minNumber;
}

NS_INLINE NSNumber *NSNumberMax(NSNumber *leftNumber, NSNumber *rightNumber)
{
    RENSCAssert(leftNumber, @"The leftNumber argument is nil.");
    RENSCAssert(rightNumber, @"The rightNumber argument is nil.");
    
    NSNumber *maxNumber = (([leftNumber compare:rightNumber] == NSOrderedDescending) ? leftNumber : rightNumber);
    return maxNumber;
}
