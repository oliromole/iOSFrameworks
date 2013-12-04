//
//  RWUUID.m
//  RWUUID
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2011.08.28.
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
#import "RWUUID.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>

// Importing the system headers.
#import <pthread.h>

static RWUUID *kRWUUID_Null = nil;

static pthread_mutex_t RWUUID_UUID_Generate_Mutext;

@implementation RWUUID

#pragma mark - Initializing a Class

+ (void)load
{
    pthread_mutexattr_t mutextAttr;
    int                 result = 0;
    
    result = pthread_mutexattr_init(&mutextAttr);
    RENSAssert((result == 0), @"The RWUUID category can not initialize a mutex attribute.");
    
    result = pthread_mutexattr_setpshared(&mutextAttr, PTHREAD_PROCESS_PRIVATE );
    RENSAssert((result == 0), @"The RWUUID category can not set a process-shared of the mutex attribute.");
    
    result = pthread_mutexattr_settype(&mutextAttr, PTHREAD_MUTEX_NORMAL);
    RENSAssert((result == 0), @"The RWUUID category can not set a type of the mutex attribute.");
    
    result = pthread_mutex_init(&RWUUID_UUID_Generate_Mutext, &mutextAttr);
    RENSAssert((result == 0), @"The RWUUID category can not initialize a mutex.");
    
    result = pthread_mutexattr_destroy(&mutextAttr);
    RENSAssert((result == 0), @"The RWUUID category can not destroy the mutex attribute.");
}

#pragma mark - Initializing a Class

+ (void)initialize
{
    if (self == [RWUUID class])
    {
        kRWUUID_Null = [[RWUUID alloc] initWithNull];
    }
}

#pragma mark - Initializing and Creating a RWUUID

- (id)init
{
    return [self initWithNull];
}

+ (id)UUID
{
    return [[self alloc] init];
}

- (id)initWithNull
{
    if ((self = [super init]))
    {
        uuid_clear(mUUIDRepresentation.cUuid);
    }
    
    return self;
}

+ (id)UUIDWithNull
{
    return [[self alloc] initWithNull];
}

- (id)initWithGenerate
{
    if ((self = [super init]))
    {
        int result = 0;
        
        result = pthread_mutex_lock(&RWUUID_UUID_Generate_Mutext);
        RENSAssert((result == 0), @"The %@ method can not lock the mutex.", NSStringFromSelector(_cmd));
        
        uuid_generate(mUUIDRepresentation.cUuid);
        
        result = pthread_mutex_unlock(&RWUUID_UUID_Generate_Mutext);
        RENSAssert((result == 0), @"The %@ method can not unlock the mutex.", NSStringFromSelector(_cmd));
    }
    
    return self;
}

+ (id)UUIDWithGenerate
{
    return [[self alloc] initWithGenerate];
}

- (id)initWithGenerateRandom
{
    if ((self = [super init]))
    {
        int result = 0;
        
        result = pthread_mutex_lock(&RWUUID_UUID_Generate_Mutext);
        RENSAssert((result == 0), @"The %@ method can not lock the mutex.", NSStringFromSelector(_cmd));
        
        uuid_generate_random(mUUIDRepresentation.cUuid);
        
        result = pthread_mutex_unlock(&RWUUID_UUID_Generate_Mutext);
        RENSAssert((result == 0), @"The %@ method can not unlock the mutex.", NSStringFromSelector(_cmd));
    }
    
    return self;
}

+ (id)UUIDWithGenerateRandom
{
    return [[self alloc] initWithGenerateRandom];
}

- (id)initWithGenerateTime
{
    if ((self = [super init]))
    {
        int result = 0;
        
        result = pthread_mutex_lock(&RWUUID_UUID_Generate_Mutext);
        RENSAssert((result == 0), @"The %@ method can not lock the mutex.", NSStringFromSelector(_cmd));
        
        uuid_generate_time(mUUIDRepresentation.cUuid);
        
        result = pthread_mutex_unlock(&RWUUID_UUID_Generate_Mutext);
        RENSAssert((result == 0), @"The %@ method can not unlock the mutex.", NSStringFromSelector(_cmd));
    }
    
    return self;
}

+ (id)UUIDWithGenerateTime
{
    return [[self alloc] initWithGenerateTime];
}

- (id)initWithCUuid:(uuid_t)cUuid
{
    if ((self = [super init]))
    {
        uuid_copy(mUUIDRepresentation.cUuid, cUuid);
    }
    
    return self;
}

+ (id)UUIDWithCUuid:(uuid_t)cUuid
{
    return [[self alloc] initWithCUuid:cUuid];
}

- (id)initWithUUID:(RWUUID *)otherUUID
{
    if (!otherUUID)
    {
        goto jmp_error;
    }
    
    self = [super init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    uuid_copy(otherUUID->mUUIDRepresentation.cUuid, mUUIDRepresentation.cUuid);
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)UUIDWithUUID:(RWUUID *)otherUUID
{
    return [[self alloc] initWithUUID:otherUUID];
}

- (id)initWithString:(NSString *)aString
{
    uuid_string_t cUuidString;
    int           result = 0;
    
    if (aString || (aString.length != 36))
    {
        goto jmp_error;
    }
    
    if (![aString getCString:cUuidString maxLength:sizeof(uuid_string_t) encoding:NSUTF8StringEncoding])
    {
        goto jmp_error;
    }
    
    if (strlen(cUuidString) != 36)
    {
        goto jmp_error;
    }
    
    self = [super init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    result = uuid_parse(cUuidString, mUUIDRepresentation.cUuid);
    
    if (result != 0)
    {
        goto jmp_error;
    }
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)UUIDWithString:(NSString *)aString
{
    return [[self alloc] initWithString:aString];
}

+ (id)null
{
    return kRWUUID_Null;
}

#pragma mark - Deallocating a RWUUID

- (void)dealloc
{
}

#pragma mark - Getting C UUID

- (void)getCUuid:(uuid_t)cUuid
{
    if (cUuid)
    {
        uuid_copy(cUuid, mUUIDRepresentation.cUuid);
    }
}

#pragma mark - Checking the UUID

- (BOOL)isNull
{
    BOOL isNull = (uuid_is_null(mUUIDRepresentation.cUuid) == 1);
    
    return isNull;
}

#pragma mark - Comparing UUIDs

- (NSComparisonResult)compare:(RWUUID *)rightUuid
{
    NSComparisonResult comparisonResult = NSOrderedDescending;
    
    if (rightUuid)
    {
        int result = uuid_compare(mUUIDRepresentation.cUuid, rightUuid->mUUIDRepresentation.cUuid);
        
        comparisonResult = ((result < 0) ? NSOrderedAscending : ((result == 0) ? NSOrderedSame : NSOrderedDescending));
    }
    
    return comparisonResult;
}

- (BOOL)isEqualToUUID:(RWUUID *)rightUuid
{
    BOOL isEqual = NO;
    
    if (rightUuid)
    {
        isEqual = (uuid_compare(mUUIDRepresentation.cUuid, rightUuid->mUUIDRepresentation.cUuid) == 0);
    }
    
    return isEqual;
}

#pragma mark - Getting the String Representation

- (NSString *)string
{
    uuid_string_t cUuidString;
    
    uuid_unparse(mUUIDRepresentation.cUuid, cUuidString);
    
    NSString *string = [[NSString alloc] initWithUTF8String:cUuidString];
    
    return string;
}

- (NSString *)uppercaseString
{
    uuid_string_t cUuidString;
    
    uuid_unparse_upper(mUUIDRepresentation.cUuid, cUuidString);
    
    NSString *uppercaseString = [[NSString alloc] initWithUTF8String:cUuidString];
    
    return uppercaseString;
}

- (NSString *)lowercaseString
{
    uuid_string_t cUuidString;
    
    uuid_unparse_lower(mUUIDRepresentation.cUuid, cUuidString);
    
    NSString *lowercaseString = [[NSString alloc] initWithUTF8String:cUuidString];
    
    return lowercaseString;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if (aCoder.allowsKeyedCoding)
    {
        [aCoder encodeBytes:mUUIDRepresentation.cUuid length:sizeof(uuid_t) forKey:@"UUID"];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    const uint8_t *bytes = NULL;
    NSUInteger     numberOfBytes = 0;
    
    if (!aDecoder)
    {
        goto jmp_error;
    }
    
    if (!aDecoder.allowsKeyedCoding)
    {
        goto jmp_error;
    }
    
    self = [super init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    if (![aDecoder containsValueForKey:@"UUID"])
    {
        goto jmp_error;
    }
    
    bytes = [aDecoder decodeBytesForKey:@"UUID" returnedLength:&numberOfBytes];
    
    if (!bytes || (numberOfBytes != sizeof(uuid_t)))
    {
        goto jmp_error;
    }
    
    uuid_copy(mUUIDRepresentation.cUuid, bytes);
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

#pragma mark - Conforming the NSCopying Protocol

- (id)copyWithZone:(NSZone *)zone
{
    RWUUID *uuid = nil;
    
    if ([self isMemberOfClass:[RWUUID class]])
    {
        uuid = self;
    }
    
    else
    {
        uuid = [[RWUUID allocWithZone:zone] initWithCUuid:mUUIDRepresentation.cUuid];
    }
    
    return uuid;
}

#pragma mark - Conforming the NSMutableCopying Protocol

- (id)mutableCopyWithZone:(NSZone *)zone
{
    //    RWMutableUUID *mutableUUID = [[RWMutableUUID allocWithZone:zone] initWithUUID:self];
    RWMutableUUID *mutableUUID = [[RWMutableUUID allocWithZone:zone] initWithCUuid:mUUIDRepresentation.cUuid];
    return mutableUUID;
}

#pragma mark - Conforming NSObject Protocol

#pragma mark Identifying and Comparing Objects

- (BOOL)isEqual:(id)object
{
    BOOL isEqual = NO;
    
    if ([object isKindOfClass:[RWUUID class]])
    {
        isEqual = [self isEqualToUUID:object];
    }
    
    return isEqual;
}

- (NSUInteger)hash
{
    NSUInteger hash = (mUUIDRepresentation.values32[0] ^
                       mUUIDRepresentation.values32[1] ^
                       mUUIDRepresentation.values32[2] ^
                       mUUIDRepresentation.values32[3]);
    
    return hash;
}

- (NSString *)description
{
    uuid_string_t cUuidString;
    
    uuid_unparse(mUUIDRepresentation.cUuid, cUuidString);
    
    NSString *description = [[NSString alloc] initWithUTF8String:cUuidString];
    
    return description;
}

@end

@implementation RWMutableUUID

#pragma mark - Setting C UUID

- (void)setCUuid:(uuid_t)cUuid
{
    uuid_copy(mUUIDRepresentation.cUuid, cUuid);
}

- (void)setUUID:(RWUUID *)otherUUID
{
    if (otherUUID)
    {
        uuid_copy(mUUIDRepresentation.cUuid, otherUUID->mUUIDRepresentation.cUuid);
    }
    
    else
    {
        uuid_clear(mUUIDRepresentation.cUuid);
    }
}

#pragma mark - Generating a New UUID

- (void)generate
{
    int result = 0;
    
    result = pthread_mutex_lock(&RWUUID_UUID_Generate_Mutext);
    RENSAssert((result == 0), @"The %@ method can not lock the mutex.", NSStringFromSelector(_cmd));
    
    uuid_generate(mUUIDRepresentation.cUuid);
    
    result = pthread_mutex_unlock(&RWUUID_UUID_Generate_Mutext);
    RENSAssert((result == 0), @"The %@ method can not unlock the mutex.", NSStringFromSelector(_cmd));
}

- (void)generateRandom
{
    int result = 0;
    
    result = pthread_mutex_lock(&RWUUID_UUID_Generate_Mutext);
    RENSAssert((result == 0), @"The %@ method can not lock the mutex.", NSStringFromSelector(_cmd));
    
    uuid_generate_random(mUUIDRepresentation.cUuid);
    
    result = pthread_mutex_unlock(&RWUUID_UUID_Generate_Mutext);
    RENSAssert((result == 0), @"The %@ method can not unlock the mutex.", NSStringFromSelector(_cmd));
}

- (void)generateTime
{
    int result = 0;
    
    result = pthread_mutex_lock(&RWUUID_UUID_Generate_Mutext);
    RENSAssert((result == 0), @"The %@ method can not lock the mutex.", NSStringFromSelector(_cmd));
    
    uuid_generate_time(mUUIDRepresentation.cUuid);
    
    result = pthread_mutex_unlock(&RWUUID_UUID_Generate_Mutext);
    RENSAssert((result == 0), @"The %@ method can not unlock the mutex.", NSStringFromSelector(_cmd));
}

@end
