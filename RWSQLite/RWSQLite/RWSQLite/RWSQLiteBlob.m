//
//  RWSQLiteBlob.m
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
#import "RWSQLiteBlob.h"

// Importing the project headers.
#import "RWSQLiteError.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RWSQLiteBlob

#pragma mark - Initializing and Creating a RWSQLiteBlob

- (id)init
{
    self = [super init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    mSqlite3_blob = NULL;
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)liteBlob
{
    return [[self alloc] init];
}

- (id)initWithSqliteBlob:(sqlite3_blob *)sqliteBlob
{
    self = [self init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    [self setSqlite3_blob:sqliteBlob];
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)liteBlobWithSqliteBlob:(sqlite3_blob *)sqliteBlob
{
    return [[self alloc] initWithSqliteBlob:sqliteBlob];
}

#pragma mark - Deallocating a RWSQLiteStatement

- (void)dealloc
{
    sqlite3_blob_close(mSqlite3_blob);
    mSqlite3_blob = NULL;
}

#pragma mark - Managing the sqlite3_blob

- (sqlite3_blob *)sqlite3_blob
{
    return mSqlite3_blob;
}

- (void)setSqlite3_blob:(sqlite3_blob *)sqlite3_blob;
{
    if (mSqlite3_blob != sqlite3_blob)
    {
        mSqlite3_blob = sqlite3_blob;
    }
}

#pragma mark - Reopening the Blob Object.

- (BOOL)reopenWithRowIdentifier:(SInt64)rowIdentifier error:(NSError **)pError
{
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_blob)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_blob_reopen(mSqlite3_blob, (sqlite3_int64)rowIdentifier);
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(NULL, resultCode);
        }
        
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

#pragma mark - Closing the Blob Object

- (BOOL)closeError:(NSError **)pError
{
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_blob)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_blob_close(mSqlite3_blob);
    
    if ((resultCode != RWSQLiteResultCodeSuccess) &&
        (resultCode != RWSQLiteResultCodeRow) &&
        (resultCode != RWSQLiteResultCodeDone))
    {
        if (pError)
        {
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(NULL, resultCode);
        }
        
        goto jmp_exit;
    }
    
    mSqlite3_blob = NULL;
    
    success = YES;
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

#pragma mark - Testing Data

- (NSUInteger)lengthError:(NSError **)pError
{
    NSError    *error = nil;
    NSUInteger  length = 0;
    int         result = 0;
    
    if (!mSqlite3_blob)
    {
        goto jmp_exit;
    }
    
    result = sqlite3_blob_bytes(mSqlite3_blob);
    
    if (result < 0)
    {
        length = NSNotFound;
    }
    
    else
    {
        length = (NSUInteger)result;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return length;
}

#pragma mark - Reading the Data

- (NSMutableData *)copyReadDataLenght:(NSUInteger)length offset:(NSUInteger)offset error:(NSError **)pError
{
    void               *cData = NULL;
    NSMutableData      *data = nil;
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    
    if (!mSqlite3_blob)
    {
        goto jmp_exit;
    }
    
    if (length > INT_MAX)
    {
        goto jmp_exit;
    }
    
    if (offset > INT_MAX)
    {
        goto jmp_exit;
    }
    
    if ((offset + length) > INT_MAX)
    {
        goto jmp_exit;
    }
    
    cData = malloc((size_t)length);
    
    if (!cData)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_blob_read(mSqlite3_blob, cData, (int)length, (int)offset);
    
    if ((resultCode != RWSQLiteResultCodeSuccess) &&
        (resultCode != RWSQLiteResultCodeRow) &&
        (resultCode != RWSQLiteResultCodeDone))
    {
        if (pError)
        {
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(NULL, resultCode);
        }
        
        goto jmp_exit;
    }
    
    data = [[NSMutableData alloc] initWithBytesNoCopy:cData length:length freeWhenDone:YES];
    
    cData = NULL;
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    free(cData);
    cData = NULL;
    
    return data;
}

- (NSMutableData *)readDataLenght:(NSUInteger)length offset:(NSUInteger)offset error:(NSError **)pError
{
    NSMutableData *data = [self copyReadDataLenght:length offset:offset error:pError];
    return data;
}

#pragma mark - Writing the Data

- (BOOL)writeData:(NSData *)data offset:(NSUInteger)offset error:(NSError **)pError
{
    const void         *cData = NULL;
    NSError            *error = nil;
    NSUInteger          length = 0;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_blob)
    {
        goto jmp_exit;
    }
    
    if (!data)
    {
        goto jmp_exit;
    }
    
    cData = data.bytes;
    length = data.length;
    
    if (!cData)
    {
        goto jmp_exit;
    }
    
    if (length > INT_MAX)
    {
        goto jmp_exit;
    }
    
    if (offset > INT_MAX)
    {
        goto jmp_exit;
    }
    
    if ((offset + length) > INT_MAX)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_blob_write(mSqlite3_blob, cData, (int)length, (int)offset);
    
    if ((resultCode != RWSQLiteResultCodeSuccess) &&
        (resultCode != RWSQLiteResultCodeRow) &&
        (resultCode != RWSQLiteResultCodeDone))
    {
        if (pError)
        {
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(NULL, resultCode);
        }
        
        goto jmp_exit;
    }
    
    success = YES;
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

@end
