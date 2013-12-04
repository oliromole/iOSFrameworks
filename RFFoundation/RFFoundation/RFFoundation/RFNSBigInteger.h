//
//  RFNSBigInteger.h
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.06.29.
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

@class NSString;

@class RFNSBigInteger;

typedef u_int32_t RFNSBigIntegerBaseType;
typedef u_int64_t RFNSBigInteger2BaseType;
typedef int64_t RFNSBigInteger2SignedBaseType;

#define RFNSBigIntegerBase 0x100000000ll

#define RFNSBigIntegerBaseBits 32
#define RFNSBigInteger2BaseBits 64

/*
 *
 *         1   1  1 1  1
 *        11   3  2 1  1
 *       111   7  3 1  1
 *      1111  15  4 1  2
 *     11111  31  5 1  2
 *    111111  63  6 1  2
 *   1111111 127  7 1  3
 *  11111111 255  8 1  3
 * 111111111 511  9 2  3
 *               10 2  4
 *               11 2  4
 *               12 2  4
 *               13 2  4
 *               14 2  5
 *               15 2  5
 *               16 2  5
 *               17 3  6
 *               18 3  6
 *               19 3  6
 *               20 3  7
 *               21 3  7
 *               22 3  7
 *               23 3  7
 *               24 4  8
 *               25 4  8
 *               26 4  8
 *               27 4  9
 *               28 4  9
 *               29 4  9
 *               30 4 10
 *               31 4 10
 *               32 4 10
 *               33 5 10
 *               34 5 11
 *
 */

#define RFNSBigInteger10Digits  10
#define RFNSBigInteger10Divisor 1000000000

/*
 *
 *           9                                  1001  1  4 1
 *          99                               1100011  2  7 1
 *         999                            1111100111  3 10 2
 *        9999                        10011100001111  4 14 2
 *       99999                     11000011010011111  5 17 3
 *      999999                  11110100001000111111  6 20 3
 *     9999999              100110001001011001111111  7 24 3
 *    99999999           101111101011110000011111111  8 27 4
 *   999999999        111011100110101100100111111111  9 30 4
 *  9999999999    1001010100000010111110001111111111 10 34 5
 * 99999999999 1011101001000011101101110011111111111 11 37 5
 *
 */

#define RFNSBigIntegerBaseDigits  9
#define RFNSBigIntegerBaseMultiplier 1000000000

//
//typedef u_int8_t RFNSBigIntegerBaseType;
//typedef u_int16_t RFNSBigInteger2BaseType;
//typedef int16_t RFNSBigInteger2SignedBaseType;
//
//#define RFNSBigIntegerBase 0x100
//
//#define RFNSBigIntegerBaseBits 8
//#define RFNSBigInteger2BaseBits 16
//
//#define RFNSBigInteger10Digits  3
//#define RFNSBigInteger10Divisor 100
//
//#define RFNSBigIntegerBaseDigits  2
//#define RFNSBigIntegerBaseMultiplier 100
//

@interface RFNSBigInteger : NSObject
//<
//NSCopying,
//NSMutableCopying
//>
{
@protected
    
    NSInteger               mCapacity;
    RFNSBigIntegerBaseType *mCoefficients;
    BOOL                    mIsNegative;
    NSInteger               mLength;
}

// Initializing and Creating a RFNSBigInteger

+ (id)bigInteger;

//- (id)initWithCoefficientsNoCopy:(RFNSBigIntegerBaseType *)coefficients capacity:(NSInteger)capacity length:(NSInteger)length isNegative:(BOOL)isNegative;
//+ (id)bigIntegerWithCoefficientsNoCopy:(RFNSBigIntegerBaseType *)coefficients capacity:(NSInteger)capacity length:(NSInteger)length isNegative:(BOOL)isNegative;

- (id)initWithChar:(signed char)value;
+ (id)bigIntegerWithChar:(signed char)value;

- (id)initWithUnsignedChar:(unsigned char)value;
+ (id)bigIntegerWithUnsignedChar:(unsigned char)value;

- (id)initWithShort:(short)value;
+ (id)bigIntegerWithShort:(short)value;

- (id)initWithUnsignedShort:(unsigned short)value;
+ (id)bigIntegerWithUnsignedShort:(unsigned short)value;

- (id)initWithInt:(int)value;
+ (id)bigIntegerWithInt:(int)value;

- (id)initWithUnsignedInt:(unsigned int)value;
+ (id)bigIntegerWithUnsignedInt:(unsigned int)value;

- (id)initWithLong:(long)value;
+ (id)bigIntegerWithLong:(long)value;

- (id)initWithUnsignedLong:(unsigned long)value;
+ (id)bigIntegerWithUnsignedLong:(unsigned long)value;

- (id)initWithLongLong:(long long)value;
+ (id)bigIntegerWithLongLong:(long long)value;

- (id)initWithUnsignedLongLong:(unsigned long long)value;
+ (id)bigIntegerWithUnsignedLongLong:(unsigned long long)value;

- (id)initWithInteger:(NSInteger)value;
+ (id)bigIntegerWithInteger:(NSInteger)value;

- (id)initWithUnsignedInteger:(NSUInteger)value;
+ (id)bigIntegerWithUnsignedInteger:(NSUInteger)value;

- (id)initWithString:(NSString *)string;
+ (id)bigIntegerWithString:(NSString *)string;

+ (id)negativeOne;
+ (id)zero;
+ (id)one;

// Performing Arithmetic

- (RFNSBigInteger *)copyBigIntegerByAdding:(RFNSBigInteger *)bigInteger;
- (RFNSBigInteger *)bigIntegerByAdding:(RFNSBigInteger *)bigInteger;

- (RFNSBigInteger *)copyBigIntegerBySubtracting:(RFNSBigInteger *)bigInteger;
- (RFNSBigInteger *)bigIntegerBySubtracting:(RFNSBigInteger *)bigInteger;

- (RFNSBigInteger *)copyBigIntegerByMultiplyingBy:(RFNSBigInteger *)bigInteger;
- (RFNSBigInteger *)bigIntegerByMultiplyingBy:(RFNSBigInteger *)bigInteger;

//- (RFNSBigInteger *)copyBigIntegerByDividingBy:(RFNSBigInteger *)bigInteger;
//- (RFNSBigInteger *)bigIntegerByDividingBy:(RFNSBigInteger *)bigInteger;

// Retrieving String Representation
//
//- (NSString *)stringValue;

// Comparing RFNSBigInteger Objects
//
//- (NSComparisonResult)compare:(RFNSBigInteger *)rightBigInteger;
//
//- (BOOL)isEqualToBigInteger:(RFNSBigInteger *)bigInteger;

@end

#define RFNSBigIntegerCast(number) NSObjectCast(number, RFNSBigInteger)

FOUNDATION_EXTERN RFNSBigInteger * RFNSBigIntegerNegativeOne;
FOUNDATION_EXTERN RFNSBigInteger * RFNSBigIntegerZero;
FOUNDATION_EXTERN RFNSBigInteger * RFNSBigIntegerOne;
//
//NS_INLINE RFNSBigInteger *RFNSBigIntegerMin(RFNSBigInteger *leftBigInteger, RFNSBigInteger *rightBigInteger)
//{
//    RENSCAssert(leftBigInteger, @"The leftBigInteger argument is nil.");
//    RENSCAssert(rightBigInteger, @"The rightBigInteger argument is nil.");
//
//    RFNSBigInteger *minBigInteger = (([leftBigInteger compare:rightBigInteger] == NSOrderedAscending) ? leftBigInteger : rightBigInteger);
//    return minBigInteger;
//}
//
//NS_INLINE RFNSBigInteger *RFNSBigIntegerMax(RFNSBigInteger *leftBigInteger, RFNSBigInteger *rightBigInteger)
//{
//    RENSCAssert(leftBigInteger, @"The leftBigInteger argument is nil.");
//    RENSCAssert(rightBigInteger, @"The rightBigInteger argument is nil.");
//
//    RFNSBigInteger *maxBigInteger = (([leftBigInteger compare:rightBigInteger] == NSOrderedAscending) ? leftBigInteger : rightBigInteger);
//    return maxBigInteger;
//}
//
//@interface RFNSMutableBigInteger : RFNSBigInteger
//{
//@protected
//
//}
//
//// Performing Arithmetic
//
//- (RFNSBigInteger *)copyAdd:(RFNSBigInteger *)bigInteger;
//- (RFNSBigInteger *)add:(RFNSBigInteger *)bigInteger;
//
//- (RFNSBigInteger *)copySubtract:(RFNSBigInteger *)bigInteger;
//- (RFNSBigInteger *)subtract:(RFNSBigInteger *)bigInteger;
//
//- (RFNSBigInteger *)copyMultiply:(RFNSBigInteger *)bigInteger;
//- (RFNSBigInteger *)multiply:(RFNSBigInteger *)bigInteger;
//
//- (RFNSBigInteger *)copyDivide:(RFNSBigInteger *)bigInteger;
//- (RFNSBigInteger *)divide:(RFNSBigInteger *)bigInteger;
//
//@end
