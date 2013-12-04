//
//  RWUUID.h
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

// Importing the project headers.
#import "RWUUIDRepresentation.h"

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>

@class NSString;

@interface RWUUID : NSObject <NSCoding, NSCopying, NSMutableCopying>
{
@protected
    
    RWUUIDRepresentation mUUIDRepresentation;
}

// Initializing and Creating a RWUUID

+ (id)UUID;

- (id)initWithNull;
+ (id)UUIDWithNull;

- (id)initWithGenerate;
+ (id)UUIDWithGenerate;

- (id)initWithGenerateRandom;
+ (id)UUIDWithGenerateRandom;

- (id)initWithGenerateTime;
+ (id)UUIDWithGenerateTime;

- (id)initWithCUuid:(uuid_t)cUuid;
+ (id)UUIDWithCUuid:(uuid_t)cUuid;

- (id)initWithUUID:(RWUUID *)otherUUID;
+ (id)UUIDWithUUID:(RWUUID *)otherUUID;

- (id)initWithString:(NSString *)aString;
+ (id)UUIDWithString:(NSString *)aString;

+ (id)null;

// Getting C UUID

- (void)getCUuid:(uuid_t)cUuid;

// Checking the UUID

@property (nonatomic, readonly) BOOL isNull;

// Comparing UUIDs

- (NSComparisonResult)compare:(RWUUID *)rightUUID;
- (BOOL)isEqualToUUID:(RWUUID *)rightUUID;

// Getting the String Representation

- (NSString *)string;
- (NSString *)uppercaseString;
- (NSString *)lowercaseString;

@end

@interface RWMutableUUID : RWUUID
{
@protected
    
}

// Setting C UUID

- (void)setCUuid:(uuid_t)cUuid;
- (void)setUUID:(RWUUID *)otherUUID;

// Generating a new UUID

- (void)generate;
- (void)generateRandom;
- (void)generateTime;

@end
