//
//  RFNSKeyWrapper.m
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.05.13.
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
#import "RFNSKeyWrapper.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RFNSKeyWrapper

#pragma mark - Initializing and Creating a RFNSKeyWrapper

- (id)init
{
    if ((self = [self initWithKey:nil equalSelector:NULL hashSelector:NULL]))
    {
    }
    
    return self;
}

- (id)initWithKey:(id)key
{
    return [self initWithKey:key equalSelector:@selector(isEqual:) hashSelector:@selector(hash)];
}

+ (id)keyWrapperWithKey:(id)key
{
    return [[self alloc] initWithKey:key];
}

- (id)initWithKey:(id)key equalSelector:(SEL)equalSelector hashSelector:(SEL)hashSelector
{
    // Validating the key agrument.
    if (!key)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The key argument is nil." userInfo:nil];
    }
    
    // Validating the equalSelector agrument and the hashSelector argument.
    if (!equalSelector ^ !hashSelector)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"The equalSelector argument and the hashSelector argument pair are invalid. The equalSelector argument: %@. The hashSelector argument %@", NSStringFromSelector(equalSelector), NSStringFromSelector(hashSelector)] userInfo:nil];
    }
    
    if ((self = [super init]))
    {
        // Saving the argument values.
        mEqualSelector = equalSelector;
        mHashSelector = hashSelector;
        mKey = key;
    }
    
    return self;
}

+ (id)keyWrapperWithKey:(id)key equalSelector:(SEL)equalSelector hashSelector:(SEL)hashSelector;
{
    return [[self alloc] initWithKey:key equalSelector:equalSelector hashSelector:hashSelector];
}

#pragma mark - Accessing the RFNSKeyWrapper Object

@synthesize key = mKey;
@synthesize equalSelector = mEqualSelector;
@synthesize hashSelector = mHashSelector;

#pragma mark - Conforming the NSCopying Protocol

- (id)copyWithZone:(NSZone *)zone
{
#pragma unused(zone)
    
    return self;
}

#pragma mark - Conforming the NSObject Protocol

#pragma mark Identifying and Comparing Objects

- (BOOL)isEqual:(id)object
{
    // Setting the default value.
    BOOL isEqual = NO;
    
    // The objec is the RFNSKeyWrapper object.
    if ([object isKindOfClass:[RFNSKeyWrapper class]])
    {
        // Casting the object ot the RFNSKeyWrapper object.
        RFNSKeyWrapper *rightKeyWrapper = (RFNSKeyWrapper *)object;
        
        // We have the left key.
        if (mKey)
        {
            // We have the specified equal selector.
            if (mEqualSelector)
            {
                // Getting the equal implementation.
                BOOL (*equalImplementation)(id, SEL, id) = (BOOL (*)(id, SEL, id))[mKey methodForSelector:mEqualSelector];
                
                // We have not the equal implementation.
                if (!equalImplementation)
                {
                    @throw [NSException exceptionWithName:NSGenericException reason:[NSString stringWithFormat:@"The leftObject arguement is not implemented the method -[%@ %@].", NSStringFromClass([mKey class]), NSStringFromSelector(mEqualSelector)] userInfo:nil];
                }
                
                // Comparing the left key with the right key.
                isEqual = equalImplementation(mKey, mEqualSelector, rightKeyWrapper->mKey);
            }
            
            // We do not have the specified equal selector.
            // We must use the default equal selector.
            else
            {
                // Comparing the left key with the right key.
                isEqual = [mKey isEqual:rightKeyWrapper->mKey];
            }
        }
    }
    
    // Returning the result of compared keys.
    return isEqual;
}

- (NSUInteger)hash
{
    // Setting the default values.
    NSUInteger hash = 0;
    
    // We have the key.
    if (mKey)
    {
        // We have the specified hash selector.
        if (mHashSelector)
        {
            // Getting the hash implementation.
            NSUInteger (*hashImplementation)(id, SEL) = (NSUInteger (*)(id, SEL))[mKey methodForSelector:mHashSelector];
            
            // We have not the hash implementation.
            if (!hashImplementation)
            {
                @throw [NSException exceptionWithName:NSGenericException reason:[NSString stringWithFormat:@"The leftObject arguement is not implemented the method -[%@ %@].", NSStringFromClass([mKey class]), NSStringFromSelector(mHashSelector)] userInfo:nil];
            }
            
            // Hashing the key.
            hash = hashImplementation(mKey, mHashSelector);
        }
        
        // We do not have the specified hash selector.
        // We must use the default hash selector.
        else
        {
            // Hashing the key.
            hash = [mKey hash];
        }
    }
    
    // Returning the hash of the key.
    return hash;
}

@end
