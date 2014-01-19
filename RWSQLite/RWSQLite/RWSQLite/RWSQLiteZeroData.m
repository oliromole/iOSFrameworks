//
//  RWSQLiteZeroData.m
//  RWSQLite
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2014.01.19.
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
#import "RWSQLiteZeroData.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RWSQLiteZeroData

#pragma mark - Initializing and Creating a RWSQLiteZeroData

- (id)init
{
    self = [super init];
    
    if (!self)
    {
        goto jmp_exit;
    }
    
    mLength = 0;
    
jmp_exit:
    
    return self;
}

+ (id)liteZeroData
{
    return [[self alloc] init];
}

- (id)initWithLength:(NSUInteger)length
{
    self = [super init];
    
    if (!self)
    {
        goto jmp_exit;
    }
    
    mLength = length;
    
jmp_exit:
    
    return self;
}

+ (id)liteZeroDataWithLength:(NSUInteger)length
{
    return [[self alloc] initWithLength:length];
}

#pragma mark - Deallocating a RWSQLiteZeroData

- (void)dealloc
{
}

#pragma mark - Testing Zero Data

- (NSUInteger)length
{
    return mLength;
}

@end

@implementation RWSQLiteMutableZeroData : RWSQLiteZeroData

#pragma mark - Modifying Data

- (void)setLength:(NSUInteger)length
{
    if (mLength != length)
    {
        mLength = length;
    }
}

@end
