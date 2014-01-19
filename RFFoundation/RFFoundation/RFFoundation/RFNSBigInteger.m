//
//  RFNSBigInteger.m
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

// Importing the header.
#import "RFNSBigInteger.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RFNSBigInteger

+ (void)load
{
    // Initializing the global variables.
    RFNSBigIntegerNegativeOne = [[RFNSBigInteger alloc] initWithInteger:-1];
    RFNSBigIntegerZero = [[RFNSBigInteger alloc] initWithInteger:0];
    RFNSBigIntegerOne = [[RFNSBigInteger alloc] initWithInteger:1];
}

// Initializing and Creating a RFNSBigInteger

- (id)init
{
    if ((self = [super init]))
    {
        // Setting the zero value.
        mCapacity = 0;
        mCoefficients = NULL;
        mIsNegative = NO;
        mLength = 0;
    }
    
    return self;
}

+ (id)bigInteger
{
    return [[self alloc] init];
}

- (id)initWithCoefficientsNoCopy:(RFNSBigIntegerBaseType *)coefficients capacity:(NSInteger)capacity length:(NSInteger)length isNegative:(BOOL)isNegative
{
    if ((self = [super init]))
    {
        // Saving the arguments.
        mCapacity = capacity;
        mCoefficients = coefficients;
        mIsNegative = isNegative;
        mLength = length;
    }
    
    return self;
}

+ (id)bigIntegerWithCoefficientsNoCopy:(RFNSBigIntegerBaseType *)coefficients capacity:(NSInteger)capacity length:(NSInteger)length isNegative:(BOOL)isNegative
{
    return [[self alloc] initWithCoefficientsNoCopy:coefficients capacity:capacity length:length isNegative:isNegative];
}

- (id)initWithChar:(signed char)value
{
    if ((self = [super init]))
    {
        // Calculating the sign.
        
        if (value < 0)
        {
            mIsNegative = YES;
            
            value = -value;
        }
        
        else
        {
            mIsNegative = NO;
        }
        
        // Calculating the capacity.
        mCapacity = (sizeof(value) / sizeof(RFNSBigIntegerBaseType)) + (((sizeof(value) % sizeof(RFNSBigIntegerBaseType)) == 0) ? 0 : 1);
        
        // Allocating memory for the coefficients.
        mCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(mCoefficients, @"Low memory.");
        
        // Copying the coefficients.
        memset(mCoefficients, 0, (size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        memcpy(mCoefficients, &value, sizeof(value));
        
        // Calculating the length.
        
        mLength = 0;
        
        for (NSInteger index = mCapacity - 1; index > -1; index--)
        {
            if (mCoefficients[index] != 0)
            {
                mLength = index + 1;
                
                break;
            }
        }
    }
    
    return self;
}

+ (id)bigIntegerWithChar:(signed char)value
{
    return [[self alloc] initWithChar:value];
}

- (id)initWithUnsignedChar:(unsigned char)value
{
    if ((self = [super init]))
    {
        // Setting the sign.
        mIsNegative = NO;
        
        // Calculating the capacity.
        mCapacity = (sizeof(value) / sizeof(RFNSBigIntegerBaseType)) + (((sizeof(value) % sizeof(RFNSBigIntegerBaseType)) == 0) ? 0 : 1);
        
        // Allocating memory for the coefficients.
        mCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(mCoefficients, @"Low memory.");
        
        // Copying the coefficients.
        memset(mCoefficients, 0, (size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        memcpy(mCoefficients, &value, sizeof(value));
        
        // Calculating the length.
        
        mLength = 0;
        
        for (NSInteger index = mCapacity - 1; index > -1; index--)
        {
            if (mCoefficients[index] != 0)
            {
                mLength = index + 1;
                
                break;
            }
        }
    }
    
    return self;
}

+ (id)bigIntegerWithUnsignedChar:(unsigned char)value
{
    return [[self alloc] initWithUnsignedChar:value];
}

- (id)initWithShort:(short)value
{
    if ((self = [super init]))
    {
        // Calculating the sign.
        
        if (value < 0)
        {
            mIsNegative = YES;
            
            value = -value;
        }
        
        else
        {
            mIsNegative = NO;
        }
        
        // Calculating the capacity.
        mCapacity = (sizeof(value) / sizeof(RFNSBigIntegerBaseType)) + (((sizeof(value) % sizeof(RFNSBigIntegerBaseType)) == 0) ? 0 : 1);
        
        // Allocating memory for the coefficients.
        mCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(mCoefficients, @"Low memory.");
        
        // Copying the coefficients.
        memset(mCoefficients, 0, (size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        memcpy(mCoefficients, &value, sizeof(value));
        
        // Calculating the length.
        
        mLength = 0;
        
        for (NSInteger index = mCapacity - 1; index > -1; index--)
        {
            if (mCoefficients[index] != 0)
            {
                mLength = index + 1;
                
                break;
            }
        }
    }
    
    return self;
}

+ (id)bigIntegerWithShort:(short)value
{
    return [[self alloc] initWithShort:value];
}

- (id)initWithUnsignedShort:(unsigned short)value
{
    if ((self = [super init]))
    {
        // Setting the sign.
        mIsNegative = NO;
        
        // Calculating the capacity.
        mCapacity = (sizeof(value) / sizeof(RFNSBigIntegerBaseType)) + (((sizeof(value) % sizeof(RFNSBigIntegerBaseType)) == 0) ? 0 : 1);
        
        // Allocating memory for the coefficients.
        mCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(mCoefficients, @"Low memory.");
        
        // Copying the coefficients.
        memset(mCoefficients, 0, (size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        memcpy(mCoefficients, &value, sizeof(value));
        
        // Calculating the length.
        
        mLength = 0;
        
        for (NSInteger index = mCapacity - 1; index > -1; index--)
        {
            if (mCoefficients[index] != 0)
            {
                mLength = index + 1;
                
                break;
            }
        }
    }
    
    return self;
}

+ (id)bigIntegerWithUnsignedShort:(unsigned short)value
{
    return [[self alloc] initWithUnsignedShort:value];
}

- (id)initWithInt:(int)value
{
    if ((self = [super init]))
    {
        // Calculating the sign.
        
        if (value < 0)
        {
            mIsNegative = YES;
            
            value = -value;
        }
        
        else
        {
            mIsNegative = NO;
        }
        
        // Calculating the capacity.
        mCapacity = (sizeof(value) / sizeof(RFNSBigIntegerBaseType)) + (((sizeof(value) % sizeof(RFNSBigIntegerBaseType)) == 0) ? 0 : 1);
        
        // Allocating memory for the coefficients.
        mCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(mCoefficients, @"Low memory.");
        
        // Copying the coefficients.
        memset(mCoefficients, 0, (size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        memcpy(mCoefficients, &value, sizeof(value));
        
        // Calculating the length.
        
        mLength = 0;
        
        for (NSInteger index = mCapacity - 1; index > -1; index--)
        {
            if (mCoefficients[index] != 0)
            {
                mLength = index + 1;
                
                break;
            }
        }
    }
    
    return self;
}

+ (id)bigIntegerWithInt:(int)value
{
    return [[self alloc] initWithInt:value];
}

- (id)initWithUnsignedInt:(unsigned int)value
{
    if ((self = [super init]))
    {
        // Setting the sign.
        mIsNegative = NO;
        
        // Calculating the capacity.
        mCapacity = (sizeof(value) / sizeof(RFNSBigIntegerBaseType)) + (((sizeof(value) % sizeof(RFNSBigIntegerBaseType)) == 0) ? 0 : 1);
        
        // Allocating memory for the coefficients.
        mCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(mCoefficients, @"Low memory.");
        
        // Copying the coefficients.
        memset(mCoefficients, 0, (size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        memcpy(mCoefficients, &value, sizeof(value));
        
        // Calculating the length.
        
        mLength = 0;
        
        for (NSInteger index = mCapacity - 1; index > -1; index--)
        {
            if (mCoefficients[index] != 0)
            {
                mLength = index + 1;
                
                break;
            }
        }
    }
    
    return self;
}

+ (id)bigIntegerWithUnsignedInt:(unsigned int)value
{
    return [[self alloc] initWithUnsignedInt:value];
}

- (id)initWithLong:(long)value
{
    if ((self = [super init]))
    {
        // Calculating the sign.
        
        if (value < 0l)
        {
            mIsNegative = YES;
            
            value = -value;
        }
        
        else
        {
            mIsNegative = NO;
        }
        
        // Calculating the capacity.
        mCapacity = (sizeof(value) / sizeof(RFNSBigIntegerBaseType)) + (((sizeof(value) % sizeof(RFNSBigIntegerBaseType)) == 0) ? 0 : 1);
        
        // Allocating memory for the coefficients.
        mCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(mCoefficients, @"Low memory.");
        
        // Copying the coefficients.
        memset(mCoefficients, 0, (size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        memcpy(mCoefficients, &value, sizeof(value));
        
        // Calculating the length.
        
        mLength = 0;
        
        for (NSInteger index = mCapacity - 1; index > -1; index--)
        {
            if (mCoefficients[index] != 0)
            {
                mLength = index + 1;
                
                break;
            }
        }
    }
    
    return self;
}

+ (id)bigIntegerWithLong:(long)value
{
    return [[self alloc] initWithLong:value];
}

- (id)initWithUnsignedLong:(unsigned long)value
{
    if ((self = [super init]))
    {
        // Setting the sign.
        mIsNegative = NO;
        
        // Calculating the capacity.
        mCapacity = (sizeof(value) / sizeof(RFNSBigIntegerBaseType)) + (((sizeof(value) % sizeof(RFNSBigIntegerBaseType)) == 0) ? 0 : 1);
        
        // Allocating memory for the coefficients.
        mCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(mCoefficients, @"Low memory.");
        
        // Copying the coefficients.
        memset(mCoefficients, 0, (size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        memcpy(mCoefficients, &value, sizeof(value));
        
        // Calculating the length.
        
        mLength = 0;
        
        for (NSInteger index = mCapacity - 1; index > -1; index--)
        {
            if (mCoefficients[index] != 0)
            {
                mLength = index + 1;
                
                break;
            }
        }
    }
    
    return self;
}

+ (id)bigIntegerWithUnsignedLong:(unsigned long)value
{
    return [[self alloc] initWithUnsignedLong:value];
}

- (id)initWithLongLong:(long long)value
{
    if ((self = [super init]))
    {
        // Calculating the sign.
        
        if (value < 0ll)
        {
            mIsNegative = YES;
            
            value = -value;
        }
        
        else
        {
            mIsNegative = NO;
        }
        
        // Calculating the capacity.
        mCapacity = (sizeof(value) / sizeof(RFNSBigIntegerBaseType)) + (((sizeof(value) % sizeof(RFNSBigIntegerBaseType)) == 0) ? 0 : 1);
        
        // Allocating memory for the coefficients.
        mCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(mCoefficients, @"Low memory.");
        
        // Copying the coefficients.
        memset(mCoefficients, 0, (size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        memcpy(mCoefficients, &value, sizeof(value));
        
        // Calculating the length.
        
        mLength = 0;
        
        for (NSInteger index = mCapacity - 1; index > -1; index--)
        {
            if (mCoefficients[index] != 0)
            {
                mLength = index + 1;
                
                break;
            }
        }
    }
    
    return self;
}

+ (id)bigIntegerWithLongLong:(long long)value
{
    return [[self alloc] initWithLongLong:value];
}

- (id)initWithUnsignedLongLong:(unsigned long long)value
{
    if ((self = [super init]))
    {
        // Setting the sign.
        mIsNegative = NO;
        
        // Calculating the capacity.
        mCapacity = (sizeof(value) / sizeof(RFNSBigIntegerBaseType)) + (((sizeof(value) % sizeof(RFNSBigIntegerBaseType)) == 0) ? 0 : 1);
        
        // Allocating memory for the coefficients.
        mCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(mCoefficients, @"Low memory.");
        
        // Copying the coefficients.
        memset(mCoefficients, 0, (size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        memcpy(mCoefficients, &value, sizeof(value));
        
        // Calculating the length.
        
        mLength = 0;
        
        for (NSInteger index = mCapacity - 1; index > -1; index--)
        {
            if (mCoefficients[index] != 0)
            {
                mLength = index + 1;
                
                break;
            }
        }
    }
    
    return self;
}

+ (id)bigIntegerWithUnsignedLongLong:(unsigned long long)value
{
    return [[self alloc] initWithUnsignedLongLong:value];
}

- (id)initWithInteger:(NSInteger)value
{
    if ((self = [super init]))
    {
        // Calculating the sign.
        
        if (value < 0)
        {
            mIsNegative = YES;
            
            value = -value;
        }
        
        else
        {
            mIsNegative = NO;
        }
        
        // Calculating the capacity.
        mCapacity = (sizeof(value) / sizeof(RFNSBigIntegerBaseType)) + (((sizeof(value) % sizeof(RFNSBigIntegerBaseType)) == 0) ? 0 : 1);
        
        // Allocating memory for the coefficients.
        mCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(mCoefficients, @"Low memory.");
        
        // Copying the coefficients.
        memset(mCoefficients, 0, (size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        memcpy(mCoefficients, &value, sizeof(value));
        
        // Calculating the length.
        
        mLength = 0;
        
        for (NSInteger index = mCapacity - 1; index > -1; index--)
        {
            if (mCoefficients[index] != 0)
            {
                mLength = index + 1;
                
                break;
            }
        }
    }
    
    return self;
}

+ (id)bigIntegerWithInteger:(NSInteger)value
{
    return [[self alloc] initWithInteger:value];
}

- (id)initWithUnsignedInteger:(NSUInteger)value
{
    if ((self = [super init]))
    {
        // Setting the sign.
        mIsNegative = NO;
        
        // Calculating the capacity.
        mCapacity = (sizeof(value) / sizeof(RFNSBigIntegerBaseType)) + (((sizeof(value) % sizeof(RFNSBigIntegerBaseType)) == 0) ? 0 : 1);
        
        // Allocating memory for the coefficients.
        mCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(mCoefficients, @"Low memory.");
        
        // Copying the coefficients.
        memset(mCoefficients, 0, (size_t)mCapacity * sizeof(RFNSBigIntegerBaseType));
        memcpy(mCoefficients, &value, sizeof(value));
        
        // Calculating the length.
        
        mLength = 0;
        
        for (NSInteger index = mCapacity - 1; index > -1; index--)
        {
            if (mCoefficients[index] != 0)
            {
                mLength = index + 1;
                
                break;
            }
        }
    }
    
    return self;
}

+ (id)bigIntegerWithUnsignedInteger:(NSUInteger)value
{
    return [[self alloc] initWithUnsignedInteger:value];
}

- (id)initWithString:(NSString *)string
{
    if ((self = [super init]))
    {
        RENSAssert(string, @"The string arguments is nil.");
        RENSAssert((string.length > 0), @"The string length is 0.");
        
        NSInteger stringLength = (NSInteger)string.length;
        
        NSInteger coefficientsCapacity = (stringLength / RFNSBigIntegerBaseDigits) + 1;
        NSInteger coefficientsLength = 0;
        
        RFNSBigIntegerBaseType *coefficients = (RFNSBigIntegerBaseType *)malloc((size_t)coefficientsCapacity * sizeof(RFNSBigIntegerBaseType));
        RENSAssert(coefficients, @"Low memory.");
        
        memset(coefficients, 0, (size_t)coefficientsCapacity * sizeof(RFNSBigIntegerBaseType));
        
        NSInteger charactersCapacity = ((2048 / RFNSBigIntegerBaseDigits) / sizeof(unichar));
        NSInteger charactersLocation = 0;
        NSInteger charactersLength = 0;
        
        unichar characters[charactersCapacity];
        
        BOOL isNegative = NO;
        
        unichar firstCharacter = [string characterAtIndex:0];
        
        if (firstCharacter == L'-')
        {
            charactersLength = 1;
            
            isNegative = YES;
        }
        
        else if (firstCharacter == L'+')
        {
            charactersLength = 1;
            
            isNegative = NO;
        }
        
        RENSAssert(((charactersLocation + charactersLength) < stringLength), @"The string is invalid. The string is %@", string);
        
        while ((charactersLocation + charactersLength) < stringLength)
        {
            charactersLocation += charactersLength;
            charactersLength = (((charactersLocation + charactersCapacity) <= stringLength) ? charactersCapacity : (stringLength - charactersLocation));
            
            [string getCharacters:characters range:NSMakeRange((NSUInteger)charactersLocation, (NSUInteger)charactersLength)];
            
            unichar *charactersBegin = characters;
            unichar *charactersEnd = characters + charactersLength;
            unichar *charactersEnd2 = charactersBegin;
            
            while (charactersBegin < charactersEnd)
            {
                if ((charactersEnd2 += RFNSBigIntegerBaseDigits) < charactersEnd)
                {
                    RFNSBigIntegerBaseType addition = 0;
                    
                    while (charactersBegin < charactersEnd2)
                    {
                        RENSAssert(((*charactersBegin >= L'0') && (*charactersBegin <= L'9')), @"The character is invalid. The character is %lu", (unsigned long)*charactersBegin);
                        
                        addition = (addition * 10) + (*charactersBegin++ - L'0');
                    }
                    
                    RFNSBigInteger2BaseType total = 0;
                    
                    for (NSInteger index = 0; index < coefficientsLength; index++)
                    {
                        coefficients[index] = (RFNSBigIntegerBaseType)(total += coefficients[index] * (RFNSBigInteger2BaseType)RFNSBigIntegerBaseMultiplier);
                        total >>= RFNSBigIntegerBaseBits;
                    }
                    
                    if (total)
                    {
                        coefficients[coefficientsLength++] = (RFNSBigIntegerBaseType)total;
                    }
                    
                    if (coefficientsLength)
                    {
                        coefficients[0] += addition;
                    }
                    
                    else
                    {
                        coefficients[0] = addition;
                        coefficientsLength++;
                    }
                }
                
                else
                {
                    charactersEnd2 = charactersEnd;
                    
                    RFNSBigIntegerBaseType addition = 0;
                    RFNSBigIntegerBaseType multiplier = 1;
                    
                    while (charactersBegin < charactersEnd2)
                    {
                        RENSAssert(((*charactersBegin >= L'0') && (*charactersBegin <= L'9')), @"The character is invalid. The character is %lu", (unsigned long)*charactersBegin);
                        
                        addition = (addition * 10) + (*charactersBegin++ - L'0');
                        multiplier *= 10;
                    }
                    
                    RFNSBigInteger2BaseType total = 0;
                    
                    for (NSInteger index = 0; index < coefficientsLength; index++)
                    {
                        coefficients[index] = (RFNSBigIntegerBaseType)(total += coefficients[index] * (RFNSBigInteger2BaseType)multiplier);
                        total >>= RFNSBigIntegerBaseBits;
                    }
                    
                    if (total)
                    {
                        coefficients[coefficientsLength++] = (RFNSBigIntegerBaseType)total;
                    }
                    
                    if (coefficientsLength)
                    {
                        coefficients[0] += addition;
                    }
                    
                    else
                    {
                        coefficients[0] = addition;
                        coefficientsLength++;
                    }
                }
            }
        }
        
        while ((coefficientsLength > 0) && !coefficients[coefficientsLength - 1])
        {
            coefficientsLength--;
        }
        
        if (!coefficientsLength)
        {
            isNegative = NO;
        }
        
        mCapacity = coefficientsCapacity;
        mCoefficients = coefficients;
        mIsNegative = isNegative;
        mLength = coefficientsLength;
    }
    
    return self;
}

+ (id)bigIntegerWithString:(NSString *)string
{
    return [[self alloc] initWithString:string];
}

+ (id)negativeOne
{
    // Returning the big integer for -1.
    return RFNSBigIntegerNegativeOne;
}

+ (id)zero
{
    // Returning the big integer for 0.
    return RFNSBigIntegerZero;
}

+ (id)one
{
    // Returning the big integer for 1.
    return RFNSBigIntegerZero;
}

#pragma mark - Deallocating a RFNSBigInteger

- (void)dealloc
{
    // Freeing the memory for the coefficients
    free(mCoefficients);
    mCoefficients = NULL;
}

// Performing Arithmetic

- (RFNSBigInteger *)copyBigIntegerByAdding:(RFNSBigInteger *)rightBigInteger
{
    RENSAssert(rightBigInteger, @"The bigInteger argument is nil.");
    
    RFNSBigIntegerBaseType *leftCoefficients = mCoefficients;
    BOOL                    leftIsNegative = mIsNegative;
    NSInteger               leftLength = mLength;
    
    RFNSBigIntegerBaseType *rightCoefficients = rightBigInteger->mCoefficients;
    BOOL                    rightIsNegative = rightBigInteger->mIsNegative;
    NSInteger               rightLength = rightBigInteger->mLength;
    
    NSInteger minimumLength = MIN(leftLength, rightLength);
    NSInteger maximumLength = MAX(leftLength, rightLength);
    
    NSInteger resultCapacity = maximumLength + 1;
    BOOL      resultIsNegative = NO;
    NSInteger resultLength = 0;
    
    RFNSBigIntegerBaseType *resultCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)resultCapacity * sizeof(RFNSBigIntegerBaseType));
    RENSAssert(resultCoefficients, @"Low memory.");
    
    if (leftIsNegative == rightIsNegative)
    {
        resultIsNegative = leftIsNegative;
        
        RFNSBigInteger2BaseType total = 0;
        
        for (; resultLength < minimumLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + leftCoefficients[resultLength] + rightCoefficients[resultLength]);
        }
        
        for (; resultLength < leftLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + leftCoefficients[resultLength]);
        }
        
        for (; resultLength < rightLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + rightCoefficients[resultLength]);
        }
        
        if ((total = (total >> RFNSBigIntegerBaseBits)))
        {
            resultCoefficients[resultLength++] = (RFNSBigIntegerBaseType)total;
        }
    }
    
    else if (leftIsNegative)
    {
        resultIsNegative = NO;
        
        RFNSBigInteger2SignedBaseType total = 0;
        
        for (; resultLength < minimumLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) - leftCoefficients[resultLength] + rightCoefficients[resultLength]);
        }
        
        for (; resultLength < leftLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) - leftCoefficients[resultLength]);
        }
        
        for (; resultLength < rightLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + rightCoefficients[resultLength]);
        }
        
        if ((total = (total >> RFNSBigIntegerBaseBits)))
        {
            resultCoefficients[resultLength++] = (RFNSBigIntegerBaseType)total;
        }
        
        if ((total >> RFNSBigIntegerBaseBits))
        {
            resultIsNegative = YES;
            
            RFNSBigInteger2BaseType total2 = RFNSBigIntegerBase;
            
            for (NSInteger index = 0; index < resultLength; index++)
            {
                resultCoefficients[index] = (RFNSBigIntegerBaseType)(total2 = (total2 >> RFNSBigIntegerBaseBits) + ~resultCoefficients[index]);
            }
        }
        
        while ((resultLength > 0) && !resultCoefficients[resultLength - 1])
        {
            resultLength--;
        }
    }
    
    // (rightIsNegative)
    else
    {
        resultIsNegative = NO;
        
        RFNSBigInteger2SignedBaseType total = 0;
        
        for (; resultLength < minimumLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + leftCoefficients[resultLength] - rightCoefficients[resultLength]);
        }
        
        for (; resultLength < leftLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + leftCoefficients[resultLength]);
        }
        
        for (; resultLength < rightLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) - rightCoefficients[resultLength]);
        }
        
        if ((total = (total >> RFNSBigIntegerBaseBits)))
        {
            resultCoefficients[resultLength++] = (RFNSBigIntegerBaseType)total;
        }
        
        if ((total >> RFNSBigIntegerBaseBits))
        {
            resultIsNegative = YES;
            
            RFNSBigInteger2BaseType total2 = RFNSBigIntegerBase;
            
            for (NSInteger index = 0; index < resultLength; index++)
            {
                resultCoefficients[index] = (RFNSBigIntegerBaseType)(total2 = (total2 >> RFNSBigIntegerBaseBits) + ~resultCoefficients[index]);
            }
        }
        
        while ((resultLength > 0) && !resultCoefficients[resultLength - 1])
        {
            resultLength--;
        }
    }
    
    if (!resultLength)
    {
        mIsNegative = NO;
    }
    
    RFNSBigInteger *resultBigInteger = [[RFNSBigInteger alloc] initWithCoefficientsNoCopy:resultCoefficients capacity:resultCapacity length:resultLength isNegative:resultIsNegative];
    
    return resultBigInteger;
}

- (RFNSBigInteger *)bigIntegerByAdding:(RFNSBigInteger *)rightBigInteger
{
    RFNSBigInteger *resultBigInteger = [self copyBigIntegerByAdding:rightBigInteger];
    return resultBigInteger;
}

- (RFNSBigInteger *)copyBigIntegerBySubtracting:(RFNSBigInteger *)rightBigInteger
{
    RENSAssert(rightBigInteger, @"The bigInteger argument is nil.");
    
    RFNSBigIntegerBaseType *leftCoefficients = mCoefficients;
    BOOL                    leftIsNegative = mIsNegative;
    NSInteger               leftLength = mLength;
    
    RFNSBigIntegerBaseType *rightCoefficients = rightBigInteger->mCoefficients;
    BOOL                    rightIsNegative = !rightBigInteger->mIsNegative;
    NSInteger               rightLength = rightBigInteger->mLength;
    
    NSInteger minimumLength = MIN(leftLength, rightLength);
    NSInteger maximumLength = MAX(leftLength, rightLength);
    
    NSInteger resultCapacity = maximumLength + 1;
    BOOL      resultIsNegative = NO;
    NSInteger resultLength = 0;
    
    RFNSBigIntegerBaseType *resultCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)resultCapacity * sizeof(RFNSBigIntegerBaseType));
    RENSAssert(resultCoefficients, @"Low memory.");
    
    if (leftIsNegative == rightIsNegative)
    {
        resultIsNegative = leftIsNegative;
        
        RFNSBigInteger2BaseType total = 0;
        
        for (; resultLength < minimumLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + leftCoefficients[resultLength] + rightCoefficients[resultLength]);
        }
        
        for (; resultLength < leftLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + leftCoefficients[resultLength]);
        }
        
        for (; resultLength < rightLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + rightCoefficients[resultLength]);
        }
        
        if ((total = (total >> RFNSBigIntegerBaseBits)))
        {
            resultCoefficients[resultLength++] = (RFNSBigIntegerBaseType)total;
        }
    }
    
    else if (leftIsNegative)
    {
        resultIsNegative = NO;
        
        RFNSBigInteger2SignedBaseType total = 0;
        
        for (; resultLength < minimumLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) - leftCoefficients[resultLength] + rightCoefficients[resultLength]);
        }
        
        for (; resultLength < leftLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) - leftCoefficients[resultLength]);
        }
        
        for (; resultLength < rightLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + rightCoefficients[resultLength]);
        }
        
        if ((total = (total >> RFNSBigIntegerBaseBits)))
        {
            resultCoefficients[resultLength++] = (RFNSBigIntegerBaseType)total;
        }
        
        if ((total >> RFNSBigIntegerBaseBits))
        {
            resultIsNegative = YES;
            
            RFNSBigInteger2BaseType total2 = RFNSBigIntegerBase;
            
            for (NSInteger index = 0; index < resultLength; index++)
            {
                resultCoefficients[index] = (RFNSBigIntegerBaseType)(total2 = (total2 >> RFNSBigIntegerBaseBits) + ~resultCoefficients[index]);
            }
        }
        
        while ((resultLength > 0) && !resultCoefficients[resultLength - 1])
        {
            resultLength--;
        }
    }
    
    // (rightIsNegative)
    else
    {
        resultIsNegative = NO;
        
        RFNSBigInteger2SignedBaseType total = 0;
        
        for (; resultLength < minimumLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + leftCoefficients[resultLength] - rightCoefficients[resultLength]);
        }
        
        for (; resultLength < leftLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + leftCoefficients[resultLength]);
        }
        
        for (; resultLength < rightLength; resultLength++)
        {
            resultCoefficients[resultLength] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) - rightCoefficients[resultLength]);
        }
        
        if ((total = (total >> RFNSBigIntegerBaseBits)))
        {
            resultCoefficients[resultLength++] = (RFNSBigIntegerBaseType)total;
        }
        
        if ((total >> RFNSBigIntegerBaseBits))
        {
            resultIsNegative = YES;
            
            RFNSBigInteger2BaseType total2 = RFNSBigIntegerBase;
            
            for (NSInteger index = 0; index < resultLength; index++)
            {
                resultCoefficients[index] = (RFNSBigIntegerBaseType)(total2 = (total2 >> RFNSBigIntegerBaseBits) + ~resultCoefficients[index]);
            }
        }
        
        while ((resultLength > 0) && !resultCoefficients[resultLength - 1])
        {
            resultLength--;
        }
    }
    
    if (!resultLength)
    {
        mIsNegative = NO;
    }
    
    RFNSBigInteger *resultBigInteger = [[RFNSBigInteger alloc] initWithCoefficientsNoCopy:resultCoefficients capacity:resultCapacity length:resultLength isNegative:resultIsNegative];
    
    return resultBigInteger;
}

- (RFNSBigInteger *)bigIntegerBySubtracting:(RFNSBigInteger *)rightBigInteger
{
    RFNSBigInteger *resultBigInteger = [self copyBigIntegerBySubtracting:rightBigInteger];
    return resultBigInteger;
}

- (RFNSBigInteger *)copyBigIntegerByMultiplyingBy:(RFNSBigInteger *)rightBigInteger
{
    RENSAssert(rightBigInteger, @"The bigInteger argument is nil.");
    
    RFNSBigIntegerBaseType *leftCoefficients = mCoefficients;
    BOOL                    leftIsNegative = mIsNegative;
    NSInteger               leftLength = mLength;
    
    RFNSBigIntegerBaseType *rightCoefficients = rightBigInteger->mCoefficients;
    BOOL                    rightIsNegative = rightBigInteger->mIsNegative;
    NSInteger               rightLength = rightBigInteger->mLength;
    
    NSInteger resultCapacity = leftLength + rightLength;
    BOOL      resultIsNegative = (leftIsNegative ^ rightIsNegative);
    NSInteger resultLength = resultCapacity;
    
    RFNSBigIntegerBaseType *resultCoefficients = (RFNSBigIntegerBaseType *)malloc((size_t)resultCapacity * sizeof(RFNSBigIntegerBaseType));
    RENSAssert(resultCoefficients, @"Low memory.");
    
    memset(resultCoefficients, 0, (size_t)resultCapacity * sizeof(RFNSBigIntegerBaseType));
    
    for (NSInteger indexOfLeftCoefficient = 0; indexOfLeftCoefficient < leftLength; indexOfLeftCoefficient++)
    {
        RFNSBigInteger2BaseType total = 0;
        
        for (NSInteger indexOfRightCoefficient = 0; indexOfRightCoefficient < rightLength; indexOfRightCoefficient++)
        {
            resultCoefficients[indexOfLeftCoefficient + indexOfRightCoefficient] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + ((RFNSBigInteger2BaseType)leftCoefficients[indexOfLeftCoefficient] * rightCoefficients[indexOfRightCoefficient]) + resultCoefficients[indexOfLeftCoefficient + indexOfRightCoefficient]);
        }
        
        resultCoefficients[indexOfLeftCoefficient + rightLength] = (RFNSBigIntegerBaseType)(total >> RFNSBigIntegerBaseBits);
    }
    
    while ((resultLength > 0) && !resultCoefficients[resultLength - 1])
    {
        resultLength--;
    }
    
    if (!resultLength)
    {
        mIsNegative = NO;
    }
    
    RFNSBigInteger *resultBigInteger = [[RFNSBigInteger alloc] initWithCoefficientsNoCopy:resultCoefficients capacity:resultCapacity length:resultLength isNegative:resultIsNegative];
    
    return resultBigInteger;
}

- (RFNSBigInteger *)bigIntegerByMultiplyingBy:(RFNSBigInteger *)rightBigInteger
{
    RFNSBigInteger *resultBigInteger = [self copyBigIntegerByMultiplyingBy:rightBigInteger];
    return resultBigInteger;
}
//
//- (RFNSBigInteger *)copyBigIntegerByDividingBy:(RFNSBigInteger *)rightBigInteger
//{
//    RENSAssert(rightBigInteger, @"The bigInteger argument is nil.");
//
//    RFNSBigIntegerBaseType *leftCoefficients = mCoefficients;
//    BOOL                    leftIsNegative = mIsNegative;
//    NSInteger               leftLength = mLength;
//
//    RFNSBigIntegerBaseType *rightCoefficients = rightBigInteger->mCoefficients;
//    BOOL                    rightIsNegative = rightBigInteger->mIsNegative;
//    NSInteger               rightLength = rightBigInteger->mLength;
//
//    if (!rightLength)
//    {
//        @throw [NSException exceptionWithName:NSRangeException reason:@"You try to divide by zero." userInfo:nil];
//    }
//
//    if (leftLength < rightLength)
//    {
//        return RFNSBigIntegerZero;
//    }
//
//    RFNSBigInteger2BaseType scale = (RFNSBigInteger2BaseType)RFNSBigIntegerBase / ((RFNSBigInteger2BaseType)rightCoefficients[rightLength - 1] + 1);
//
//    if (scale > 1)
//    {
//        RFNSBigIntegerBaseType *leftCoefficients2 = (RFNSBigIntegerBaseType *)malloc(((size_t)leftLength + 1) * sizeof(RFNSBigIntegerBaseType));
//        RENSAssert(leftCoefficients2, @"Low memory.");
//
//        RFNSBigInteger2BaseType total = 0;
//
//        for (NSInteger indexOfLeftCoefficient = 0; indexOfLeftCoefficient < leftLength; indexOfLeftCoefficient++)
//        {
//            leftCoefficients2[indexOfLeftCoefficient] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + (scale * leftCoefficients[indexOfLeftCoefficient]));
//        }
//
//        if ((total = (total >> RFNSBigIntegerBaseBits)))
//        {
//            leftCoefficients2[leftLength++] = (RFNSBigIntegerBaseType)total;
//        }
//
//        leftCoefficients = leftCoefficients2;
//
//        RFNSBigIntegerBaseType *rightCoefficients2 = (RFNSBigIntegerBaseType *)malloc(((size_t)rightLength + 1) * sizeof(RFNSBigIntegerBaseType));
//        RENSAssert(rightCoefficients2, @"Low memory.");
//
//        total = 0;
//
//        for (NSInteger indexOfRightCoefficient = 0; indexOfRightCoefficient < rightLength; indexOfRightCoefficient++)
//        {
//            rightCoefficients2[indexOfRightCoefficient] = (RFNSBigIntegerBaseType)(total = (total >> RFNSBigIntegerBaseBits) + (scale * rightCoefficients[indexOfRightCoefficient]));
//        }
//
//        if ((total = (total >> RFNSBigIntegerBaseBits)))
//        {
//            rightCoefficients2[rightLength++] = (RFNSBigIntegerBaseType)total;
//        }
//
//        rightCoefficients = rightCoefficients2;
//    }
//
//    // (scale <= 1)
//    else
//    {
//        RFNSBigIntegerBaseType *leftCoefficients2 = (RFNSBigIntegerBaseType *)malloc((size_t)leftLength * sizeof(RFNSBigIntegerBaseType));
//        RENSAssert(leftCoefficients2, @"Low memory.");
//
//        memcpy(leftCoefficients2, leftCoefficients, (size_t)leftLength * sizeof(RFNSBigIntegerBaseType));
//
//        leftCoefficients = leftCoefficients2;
//    }
//
//    //quotient
//    //remainder
//    //guess
//
//    for (NSInteger indexOfLeftCoefficient = leftLength;
//         ; indexOfLeftCoefficient--)
//    {
//        RFNSBigInteger2BaseType quotientGuess = (((RFNSBigInteger2BaseType)RFNSBigIntegerBase * leftCoefficients[indexOfLeftCoefficient]) + leftCoefficients[indexOfLeftCoefficient - 1]) / rightCoefficients[rightLength - 1];
//        RFNSBigInteger2BaseType remainder = (((RFNSBigInteger2BaseType)RFNSBigIntegerBase * leftCoefficients[indexOfLeftCoefficient]) + leftCoefficients[indexOfLeftCoefficient - 1]) - (quotientGuess * rightCoefficients[rightLength - 1]);
//
//        while (remainder < (RFNSBigInteger2BaseType)RFNSBigIntegerBase)
//        {
//            if (((quotientGuess * rightCoefficients[rightLength - 2]) > ((RFNSBigInteger2BaseType)RFNSBigIntegerBase * remainder)) || (quotientGuess == (RFNSBigInteger2BaseType)RFNSBigIntegerBase))
//            {
//                quotientGuess--;
//                remainder += rightCoefficients[rightLength - 1];
//            }
//
//            else
//            {
//                break;
//            }
//        }
//
//        for (NSInteger indexOfRightCoefficient = 0; indexOfRightCoefficient < rightLength; indexOfRightCoefficient++)
//        {
//
//        }
//
//
//    }
//
//
//}
//
//- (RFNSBigInteger *)bigIntegerByDividingBy:(RFNSBigInteger *)rightBigInteger
//{
//    RFNSBigInteger *resultBigInteger = [self copyBigIntegerByDividingBy:rightBigInteger];
//    return resultBigInteger;
//}

#pragma mark - Conforming the NSObject Protocol

#pragma mark Describing Objects

- (NSString *)description
{
    NSInteger decriptionCapacity = (mLength + 1) * RFNSBigInteger10Digits;
    
    NSInteger cDescriptionLength = 0;
    
    unichar *cDescription = (unichar *)malloc((size_t)decriptionCapacity * sizeof(unichar));
    RENSAssert(cDescription, @"Low memory.");
    
    memset(cDescription, 0, (size_t)decriptionCapacity * sizeof(char));
    
    NSInteger coefficientsCapacity = mLength;
    
    NSInteger coefficientsLength = mLength;
    
    RFNSBigIntegerBaseType *coefficients = (RFNSBigIntegerBaseType *)malloc((size_t)coefficientsCapacity);
    RENSAssert(coefficients, @"Low memory.");
    
    memcpy(coefficients, mCoefficients, (size_t)coefficientsLength * sizeof(RFNSBigIntegerBaseType));
    
    while (coefficientsLength > 0)
    {
        RFNSBigInteger2BaseType remainder = 0ll;
        
        for (NSInteger index = coefficientsLength - 1; index > -1; index--)
        {
            // remainder -= ...            \\ It is valid.
            // remainder = remainder - ... \\ It is invalid!!!
            coefficients[index] = (RFNSBigIntegerBaseType)((remainder = remainder * (RFNSBigInteger2BaseType)RFNSBigIntegerBase + coefficients[index]) / RFNSBigInteger10Divisor);
            remainder -= (coefficients[index] * (RFNSBigInteger2BaseType)RFNSBigInteger10Divisor);
        }
        
        if (!coefficients[coefficientsLength - 1])
        {
            coefficientsLength--;
        }
        
        RFNSBigIntegerBaseType remainder2 = (RFNSBigIntegerBaseType)remainder;
        
        for (NSInteger index = (RFNSBigInteger10Digits - 1); index > 0; index--)
        {
            cDescription[cDescriptionLength++] = L'0' + (remainder2 % 10);
            remainder2 /= 10;
        }
    };
    
    free(coefficients);
    coefficients = NULL;
    
    while ((cDescriptionLength > 0) && (cDescription[cDescriptionLength - 1] == L'0'))
    {
        cDescriptionLength--;
    }
    
    if (cDescriptionLength == 0)
    {
        cDescription[cDescriptionLength++] = L'0';
    }
    
    else if (mIsNegative && (mLength != 0))
    {
        cDescription[cDescriptionLength++] = L'-';
    }
    
    unichar *cDescription1 = cDescription;
    unichar *cDescription2 = (cDescription + cDescriptionLength - 1);
    
    while (cDescription1 < cDescription2)
    {
        unichar character = *cDescription1;
        *cDescription1++ = *cDescription2;
        *cDescription2-- = character;
    }
    
    NSString *nsDescription = [[NSString alloc] initWithCharactersNoCopy:cDescription length:(NSUInteger)cDescriptionLength freeWhenDone:YES];
    
    return nsDescription;
}

@end

RFNSBigInteger * RFNSBigIntegerNegativeOne = nil;
RFNSBigInteger * RFNSBigIntegerZero = nil;
RFNSBigInteger * RFNSBigIntegerOne = nil;
