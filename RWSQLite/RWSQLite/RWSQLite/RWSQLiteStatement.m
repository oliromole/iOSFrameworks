//
//  RWSQLiteStatement.m
//  RWSQLite
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.06.23.
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
#import "RWSQLiteStatement.h"

// Importing the project headers.
#import "RWSQLiteData.h"
#import "RWSQLiteRow.h"
#import "RWSQLiteString.h"
#import "RWSQLiteZeroData.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

// Importing the system headers.
#import <objc/message.h>
#import <objc/runtime.h>

Class RWSQLiteNSDataClass;
Class RWSQLiteNSNullClass;
Class RWSQLiteNSNumberClass;
Class RWSQLiteNSStringClass;
Class RWSQLiteZeroDataClass;

NSNumber * RWSQLiteNSNumberLongLongNegativeOne = nil;
NSNumber * RWSQLiteNSNumberLongLongPositiveOne = nil;
NSNumber * RWSQLiteNSNumberLongLongZero = nil;

@implementation RWSQLiteStatement

#pragma mark - Initializing a Class

+ (void)load
{
    RWSQLiteNSDataClass = [NSData class];
    RWSQLiteNSNullClass = [NSNull class];
    RWSQLiteNSNumberClass = [NSNumber class];
    RWSQLiteNSStringClass = [NSString class];
    RWSQLiteZeroDataClass = [RWSQLiteZeroData class];
    
    RWSQLiteNSNumberLongLongNegativeOne = [[NSNumber alloc] initWithLongLong:-1ll];
    RWSQLiteNSNumberLongLongPositiveOne = [[NSNumber alloc] initWithLongLong:1ll];
    RWSQLiteNSNumberLongLongZero = [[NSNumber alloc] initWithLongLong:0ll];
}

#pragma mark - Initializing and Creating a RWSQLiteStatement

- (id)init
{
    self = [super init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    mSqlite3_stmt = NULL;
    mStringEncoding = RWSQLiteStringEncodingUTF8;
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)liteStatement
{
    return [[self alloc] init];
}

- (id)initWithSqliteStatement:(sqlite3_stmt *)sqliteStatement
{
    self = [self init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    [self setSqlite3_stmt:sqliteStatement];
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)liteStatementWithSqliteStatement:(sqlite3_stmt *)sqliteStatement
{
    return [[self alloc] initWithSqliteStatement:sqliteStatement];
}

#pragma mark - Deallocating a RWSQLiteStatement

- (void)dealloc
{
    sqlite3_finalize(mSqlite3_stmt);
    mSqlite3_stmt = NULL;
}

#pragma mark - Managing the sqlite3_stmt

- (sqlite3_stmt *)sqlite3_stmt
{
    return mSqlite3_stmt;
}

- (void)setSqlite3_stmt:(sqlite3_stmt *)sqlite3_stmt
{
    if (mSqlite3_stmt != sqlite3_stmt)
    {
        mSqlite3_stmt = sqlite3_stmt;
    }
}

- (RWSQLiteStringEncoding)stringEncoding
{
    return mStringEncoding;
}

- (void)setStringEncoding:(RWSQLiteStringEncoding)stringEncoding
{
    if (mStringEncoding != stringEncoding)
    {
        mStringEncoding = stringEncoding;
    }
}

#pragma mark - Retrieving Statement SQL

- (NSString *)copyCommand
{
    NSString *command = nil;
    const char *cCommand = NULL;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    // TODO: Is encoding correcly.
    
    cCommand = sqlite3_sql(mSqlite3_stmt);
    
    command = RWSQLiteNSStringCreateWithCString(cCommand, RWSQLiteStringEncodingUTF8);
    
    if (!cCommand ^ !command)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    return command;
}

- (NSString *)command
{
    NSString *command = [self copyCommand];
    return command;
}

#pragma mark - Determining if an SQL Statement Writes the Database

- (BOOL)isReadonly
{
    BOOL isReaonly = YES;
    int  result = 0;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    result = sqlite3_stmt_readonly(mSqlite3_stmt);
    
    isReaonly = (result != 0);
    
jmp_exit:
    
    return isReaonly;
}

#pragma mark - Binding Values To Prepared Statements

- (BOOL)bindData:(NSData *)aData atIndex:(NSUInteger)index copied:(BOOL)copied error:(NSError **)pError
{
    NSError            *error = nil;
    const void         *bytes = NULL;
    NSUInteger          numberOfBytes = 0;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    if (aData)
    {
        bytes = [aData bytes];
        numberOfBytes = [aData length];
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_bind_blob(mSqlite3_stmt, ((int)index + 1), bytes, (int)numberOfBytes, (copied ? SQLITE_TRANSIENT : SQLITE_STATIC));
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(sqlite, resultCode);
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

- (BOOL)bindData:(NSData *)aData forName:(NSString *)name copied:(BOOL)copied error:(NSError **)pError
{
    NSUInteger  bindIndex = NSNotFound;
    NSError    *error = nil;
    BOOL        success = NO;
    
    bindIndex = [self bindIndexFromName:name];
    
    if (bindIndex == NSNotFound)
    {
        goto jmp_exit;
    }
    
    success = [self bindData:aData atIndex:bindIndex copied:copied error:(pError ? &error : nil)];
    
    if (!success)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindDouble:(double)aDouble atIndex:(NSUInteger)index error:(NSError **)pError
{
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_bind_double(mSqlite3_stmt, ((int)index + 1), aDouble);
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(sqlite, resultCode);
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

- (BOOL)bindDouble:(double)aDouble forName:(NSString *)name error:(NSError **)pError
{
    NSUInteger  bindIndex = NSNotFound;
    NSError    *error = nil;
    BOOL        success = NO;
    
    bindIndex = [self bindIndexFromName:name];
    
    if (bindIndex == NSNotFound)
    {
        goto jmp_exit;
    }
    
    success = [self bindDouble:aDouble atIndex:bindIndex error:(pError ? &error : nil)];
    
    if (!success)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindInt:(int)anInt atIndex:(NSUInteger)index error:(NSError **)pError
{
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_bind_int(mSqlite3_stmt, ((int)index + 1), anInt);
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(sqlite, resultCode);
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

- (BOOL)bindInt:(int)anInt forName:(NSString *)name error:(NSError **)pError
{
    NSUInteger  bindIndex = NSNotFound;
    NSError    *error = nil;
    BOOL        success = NO;
    
    bindIndex = [self bindIndexFromName:name];
    
    if (bindIndex == NSNotFound)
    {
        goto jmp_exit;
    }
    
    success = [self bindInt:anInt atIndex:bindIndex error:(pError ? &error : nil)];
    
    if (!success)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindInt64:(SInt64)anInt64 atIndex:(NSUInteger)index error:(NSError **)pError
{
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_bind_int64(mSqlite3_stmt, ((int)index + 1), (sqlite3_int64)anInt64);
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(sqlite, resultCode);
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

- (BOOL)bindInt64:(SInt64)anInt64 forName:(NSString *)name error:(NSError **)pError
{
    NSUInteger  bindIndex = NSNotFound;
    NSError    *error = nil;
    BOOL        success = NO;
    
    bindIndex = [self bindIndexFromName:name];
    
    if (bindIndex == NSNotFound)
    {
        goto jmp_exit;
    }
    
    success = [self bindInt64:anInt64 atIndex:bindIndex error:(pError ? &error : nil)];
    
    if (!success)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindNullAtIndex:(NSUInteger)index error:(NSError **)pError
{
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_bind_null(mSqlite3_stmt, ((int)index + 1));
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(sqlite, resultCode);
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

- (BOOL)bindNullForName:(NSString *)name error:(NSError **)pError
{
    NSUInteger  bindIndex = NSNotFound;
    NSError    *error = nil;
    BOOL        success = NO;
    
    bindIndex = [self bindIndexFromName:name];
    
    if (bindIndex == NSNotFound)
    {
        goto jmp_exit;
    }
    
    success = [self bindNullForName:name error:(pError ? &error : nil)];
    
    if (!success)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindString:(NSString *)aString atIndex:(NSUInteger)index error:(NSError **)pError
{
    void               *cString = NULL;
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    cString = RWSQLiteCStringCreateWithNSString(aString, mStringEncoding);
    
    if (!cString ^ !aString)
    {
        goto jmp_exit;
    }
    
    if (RWSQLiteStringEncodingIsUTF8(mStringEncoding))
    {
        resultCode = (RWSQLiteResultCode)sqlite3_bind_text(mSqlite3_stmt, ((int)index + 1), (char *)cString, -1, SQLITE_TRANSIENT);
    }
    
    else
    {
        resultCode = (RWSQLiteResultCode)sqlite3_bind_text16(mSqlite3_stmt, ((int)index + 1), cString, -1, SQLITE_TRANSIENT);
    }
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(sqlite, resultCode);
        }
        
        goto jmp_exit;
    }
    
    success = YES;
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    free(cString);
    cString = NULL;
    
    return success;
}

- (BOOL)bindString:(NSString *)aString forName:(NSString *)name error:(NSError **)pError
{
    NSUInteger  bindIndex = NSNotFound;
    NSError    *error = nil;
    BOOL        success = NO;
    
    bindIndex = [self bindIndexFromName:name];
    
    if (bindIndex == NSNotFound)
    {
        goto jmp_exit;
    }
    
    success = [self bindString:aString atIndex:bindIndex error:(pError ? &error : nil)];
    
    if (!success)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindZeroDataAtIndex:(NSUInteger)index length:(NSUInteger)length error:(NSError **)pError
{
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    if (((int)length) < 0)
    {
        goto  jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_bind_zeroblob(mSqlite3_stmt, ((int)index + 1), (int)length);
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(sqlite, resultCode);
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

- (BOOL)bindZeroDataForName:(NSString *)name length:(NSUInteger)length error:(NSError **)pError
{
    NSUInteger  bindIndex = NSNotFound;
    NSError    *error = nil;
    BOOL        success = NO;
    
    bindIndex = [self bindIndexFromName:name];
    
    if (bindIndex == NSNotFound)
    {
        goto jmp_exit;
    }
    
    success = [self bindZeroDataAtIndex:bindIndex length:length error:(pError ? &error : nil)];
    
    if (!success)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindNumber:(NSNumber *)number atIndex:(NSUInteger)index error:(NSError **)pError
{
    NSError    *error = nil;
    const char *objCType = NULL;
    BOOL        success = NO;
    
    if (!number)
    {
        goto jmp_exit;
    }
    
    objCType = [number objCType];
    
    // The number is double.
    if ((strcmp(objCType, "d") == 0) ||
        (strcmp(objCType, "f") == 0))
    {
        double doubleValue = number.doubleValue;
        
        success = [self bindDouble:doubleValue atIndex:index error:(pError ? &error : nil)];
    }
    
    // The number is integer 64.
    else
    {
        SInt64 int64 = number.longLongValue;
        
        success = [self bindInt64:int64 atIndex:index error:(pError ? &error : nil)];
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindNumber:(NSNumber *)number forName:(NSString *)name error:(NSError **)pError
{
    NSUInteger  bindIndex = NSNotFound;
    NSError    *error = nil;
    BOOL        success = NO;
    
    bindIndex = [self bindIndexFromName:name];
    
    if (bindIndex == NSNotFound)
    {
        goto jmp_exit;
    }
    
    success = [self bindNumber:number atIndex:bindIndex error:(pError ? &error : nil)];
    
    if (!success)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindObject:(id)object atIndex:(NSUInteger)index copied:(BOOL)copied error:(NSError **)pError
{
    NSError *error = nil;
    BOOL     success = NO;
    
    if (!object)
    {
        goto jmp_exit;
    }
    
    if ([object isKindOfClass:RWSQLiteNSStringClass])
    {
        success = [self bindString:object atIndex:index error:(pError ? &error : nil)];
    }
    
    else if ([object isKindOfClass:RWSQLiteNSNumberClass])
    {
        success = [self bindNumber:object atIndex:index error:(pError ? &error : nil)];
    }
    
    else if ([object isKindOfClass:RWSQLiteNSDataClass])
    {
        success = [self bindData:object atIndex:index copied:copied error:(pError ? &error : nil)];
    }
    
    else if ([object isKindOfClass:RWSQLiteNSNullClass])
    {
        success = [self bindNullAtIndex:index error:(pError ? &error : nil)];
    }
    
    else if ([object isKindOfClass:RWSQLiteZeroDataClass])
    {
        RWSQLiteZeroData *zeroData = (RWSQLiteZeroData *)object;
        
        success = [self bindZeroDataAtIndex:index length:zeroData.length error:(pError ? &error : nil)];
    }
    
    else
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindObject:(id)object forName:(NSString *)name copied:(BOOL)copied error:(NSError **)pError
{
    NSUInteger  bindIndex = NSNotFound;
    NSError    *error = nil;
    BOOL        success = NO;
    
    bindIndex = [self bindIndexFromName:name];
    
    if (bindIndex == NSNotFound)
    {
        goto jmp_exit;
    }
    
    success = [self bindObject:object atIndex:bindIndex copied:copied error:(pError ? &error : nil)];
    
    if (!success)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindValues:(NSDictionary *)values copied:(BOOL)copied error:(NSError **)pError
{
    NSError *error = nil;
    BOOL     success = NO;
    
    if (values)
    {
        for (NSString *key in [values keyEnumerator])
        {
            id value = [values objectForKey:key];
            
            success = [self bindObject:value forName:key copied:copied error:(pError ? &error : nil)];
            
            if (!success)
            {
                goto jmp_exit;
            }
        }
    }
    
    success = YES;
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindObject:(id)bindObject selectors:(NSDictionary *)selectors copied:(BOOL)copied error:(NSError **)pError
{
    NSError *error = nil;
    BOOL     success = NO;
    
    if (bindObject)
    {
        if (!selectors)
        {
            goto jmp_exit;
        }
        
        for (NSString *key in [selectors keyEnumerator])
        {
            NSValue *selectorValue = [selectors objectForKey:key];
            
            SEL selector = (SEL)[selectorValue pointerValue];
            
            if (!selector)
            {
                goto jmp_exit;
            }
            
            IMP method = [bindObject methodForSelector:selector];
            
            if (!method)
            {
                goto jmp_exit;
            }
            
            id value = ((id (*)(id, SEL))method)(bindObject, selector);
            
            success = [self bindObject:value forName:key copied:copied error:(pError ? &error : nil)];
            
            if (!success)
            {
                goto jmp_exit;
            }
        }
    }
    
    success = YES;
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (BOOL)bindObject:(id)bindObject copied:(BOOL)copied error:(NSError **)pError
{
    NSInteger   bindCount = 0;
    const char *cBindName = NULL;
    NSError    *error = nil;
    BOOL        success = NO;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    bindCount = (NSInteger)self.bindCount;
    
    if (bindCount > 0)
    {
        if (!bindObject)
        {
            goto jmp_exit;
        }
        
        for (NSInteger bindIndex = 0; bindIndex < bindCount; bindIndex++)
        {
            cBindName = sqlite3_bind_parameter_name(mSqlite3_stmt, (int)(bindIndex + 1));
            
            if (!cBindName)
            {
                goto jmp_exit;
            }
            
            SEL selector = RWSQLiteGetterCacheGetSelectorForParameter([bindObject class], cBindName);
            
            if (!selector)
            {
                goto jmp_exit;
            }
            
            id object = ((id (*)(id self, SEL _cmd))objc_msgSend)(bindObject, selector);
            
            success = [self bindObject:object atIndex:(NSUInteger)bindIndex copied:copied error:(pError ? &error : nil)];
            
            if (!success)
            {
                goto jmp_exit;
            }
        }
    }
    
    success = YES;
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

#pragma mark - Getting Data Binding

#pragma mark Getting a Number of SQL Parameters

- (NSUInteger)bindCount
{
    NSUInteger bindCount = 0;
    int result = 0;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    result = sqlite3_bind_parameter_count(mSqlite3_stmt);
    
    if (result < 0)
    {
        bindCount = 0;
    }
    
    else
    {
        bindCount = (NSUInteger)result;
    }
    
jmp_exit:
    
    return bindCount;
}

#pragma mark Name of a Host Parameter

- (NSString *)copyBindNameAtIndex:(NSUInteger)atIndex
{
    const char *cBindName = NULL;
    NSString   *bindName = nil;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    cBindName = sqlite3_bind_parameter_name(mSqlite3_stmt, (int)(atIndex + 1));
    
    bindName = RWSQLiteNSStringCreateWithCString(cBindName, RWSQLiteStringEncodingUTF8);
    
    if (!cBindName ^ !bindName)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    return bindName;
}

- (NSString *)bindNameAtIndex:(NSUInteger)atIndex
{
    NSString *bindName = [self copyBindNameAtIndex:atIndex];
    return bindName;
}

#pragma mark Getting Index of a Parameter with a Given Name

- (NSUInteger)bindIndexFromName:(NSString *)aName
{
    char       *cName = NULL;
    NSUInteger  bindIndex = NSNotFound;
    int         result = 0;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    cName = (char *)RWSQLiteCStringCreateWithNSString(aName, RWSQLiteStringEncodingUTF8);
    
    if (!cName ^ !aName)
    {
        goto jmp_exit;
    }
    
    result = sqlite3_bind_parameter_index(mSqlite3_stmt, cName);
    
    if (result <= 0)
    {
        bindIndex = NSNotFound;
    }
    
    else
    {
        bindIndex = (NSUInteger)(result - 1);
    }
    
jmp_exit:
    
    free(cName);
    cName = NULL;
    
    return bindIndex;
}

#pragma mark - Resetting All Bindings on a Prepared Statement

- (BOOL)clearBindingsError:(NSError **)pError
{
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_clear_bindings(mSqlite3_stmt);
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(sqlite, resultCode);
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

#pragma mark - Getting Result Data

#pragma mark Getting Number of Columns in a Result Set

- (NSUInteger)columnCount
{
    NSUInteger columnCount = 0;
    int result = 0;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    result = sqlite3_column_count(mSqlite3_stmt);
    
    if (result < 0)
    {
        columnCount = NSNotFound;
    }
    
    else
    {
        columnCount = (NSUInteger)result;
    }
    
jmp_exit:
    
    return columnCount;
}

#pragma mark - Getting Column Names in a Result Set

- (NSString *)copyColumnNameAtIndex:(NSUInteger)atIndex error:(NSError **)pError
{
    NSError    *error = nil;
    const void *cColumnName = NULL;
    NSString   *nsColumnName = nil;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    cColumnName = sqlite3_column_name(mSqlite3_stmt, (int)atIndex);
    
    nsColumnName = RWSQLiteNSStringCreateWithCString(cColumnName, RWSQLiteStringEncodingUTF8);
    
    if (!cColumnName ^ !nsColumnName)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqlite(sqlite);
        }
        
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return nsColumnName;
}

- (NSString *)columnNameAtIndex:(NSUInteger)atIndex error:(NSError **)pError
{
    NSString *columnName = [self copyColumnNameAtIndex:atIndex error:pError];
    return columnName;
}

#pragma mark - Getting Declared Datatype of a Query Result

- (NSString *)copyColumnDecltypeNameAtIndex:(NSUInteger)atIndex
{
    const char *cColumnDecltype = NULL;
    NSString   *columnDecltype = nil;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    cColumnDecltype = sqlite3_column_decltype(mSqlite3_stmt, (int)atIndex);
    
    columnDecltype = RWSQLiteNSStringCreateWithCString(cColumnDecltype, RWSQLiteStringEncodingUTF8);
    
    if (!cColumnDecltype ^ !columnDecltype)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    return columnDecltype;
}

- (NSString *)columnDecltypeTableNameAtIndex:(NSUInteger)atIndex
{
    NSString *columnDecltype = [self copyColumnDecltypeNameAtIndex:atIndex];
    return columnDecltype;
}

#pragma mark - Evaluating An SQL Statement

- (RWSQLiteResultCode)stepError:(NSError **)pError
{
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeError;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_step(mSqlite3_stmt);
    
    if ((resultCode != RWSQLiteResultCodeSuccess) &&
        (resultCode != RWSQLiteResultCodeRow) &&
        (resultCode != RWSQLiteResultCodeDone))
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(sqlite, resultCode);
        }
        
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return resultCode;
}

#pragma mark - Getting Number of Columns in a Result Set in the Current Row

- (NSUInteger)dataCount
{
    NSUInteger dataCount = 0;
    int result = 0;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    result = sqlite3_data_count(mSqlite3_stmt);
    
    if (result < 0)
    {
        dataCount = NSNotFound;
    }
    
    else
    {
        dataCount = (NSUInteger)result;
    }
    
jmp_exit:
    
    return dataCount;
}

#pragma mark - Getting Result Values from a Query

- (NSData *)copyDataAtIndex:(NSUInteger)index error:(NSError **)pError
{
    const void *bytes = NULL;
    NSError    *error = nil;
    NSData     *data = nil;
    NSUInteger  numberOfBytes = 0;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    bytes = sqlite3_column_blob(mSqlite3_stmt, (int)index);
    
    if (bytes)
    {
        numberOfBytes = (NSUInteger)sqlite3_column_bytes(mSqlite3_stmt, (int)index);
        
        data = RWSQLiteNSDataCreateWithCData(bytes, (int)numberOfBytes);
        
        if (!bytes ^ !data)
        {
            goto jmp_exit;
        }
    }
    
    else
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqlite(sqlite);
        }
        
        if (error)
        {
            goto jmp_exit;
        }
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return data;
}

- (NSData *)dataAtIndex:(NSUInteger)index error:(NSError **)pError
{
    NSData *data = [self copyDataAtIndex:index error:pError];
    return data;
}

- (double)doubleAtIndex:(NSUInteger)index error:(NSError **)pError
{
    double   doubleValue = 0.0;
    NSError *error = nil;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    doubleValue = sqlite3_column_double(mSqlite3_stmt, (int)index);
    
    if (doubleValue == 0.0)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqlite(sqlite);
        }
        
        if (error)
        {
            goto jmp_exit;
        }
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return doubleValue;
}

- (int)intAtIndex:(NSUInteger)index error:(NSError **)pError
{
    int     intValue = 0;
    NSError *error = nil;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    intValue = sqlite3_column_int(mSqlite3_stmt, (int)index);
    
    if (intValue == 0)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqlite(sqlite);
        }
        
        if (error)
        {
            goto jmp_exit;
        }
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return intValue;
}

- (SInt64)int64AtIndex:(NSUInteger)index error:(NSError **)pError
{
    SInt64   int64Value = 0LL;
    NSError *error = nil;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    int64Value = sqlite3_column_int64(mSqlite3_stmt, (int)index);
    
    if (int64Value == 0LL)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqlite(sqlite);
        }
        
        if (error)
        {
            goto jmp_exit;
        }
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return int64Value;
}

- (NSString *)copyStringAtIndex:(NSUInteger)index error:(NSError **)pError
{
    const void *cString = NULL;
    NSError    *error = nil;
    NSString   *nsString = nil;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    if (RWSQLiteStringEncodingIsUTF8(mStringEncoding))
    {
        cString = sqlite3_column_text(mSqlite3_stmt, (int)index);
    }
    
    else
    {
        cString = sqlite3_column_text16(mSqlite3_stmt, (int)index);
    }
    
    if (!cString)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqlite(sqlite);
        }
        
        if (error)
        {
            goto jmp_exit;
        }
    }
    
    nsString = RWSQLiteNSStringCreateWithCString(cString, mStringEncoding);
    
    if (!cString ^ !nsString)
    {
        goto jmp_exit;
    }
    
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return nsString;
}

- (NSString *)stringAtIndex:(NSUInteger)index error:(NSError **)pError
{
    NSString *string = [self copyStringAtIndex:index error:pError];
    return string;
}

- (RWSQLiteDataType)dataTypeAtIndex:(NSUInteger)index error:(NSError **)pError
{
    RWSQLiteDataType  dataType = RWSQLiteDataTypeInteger;
    NSError          *error = nil;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    dataType = (RWSQLiteDataType)sqlite3_column_type(mSqlite3_stmt, (int)index);
    
    if (dataType == 0)
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqlite(sqlite);
        }
        
        if (error)
        {
            goto jmp_exit;
        }
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return dataType;
}

- (NSNumber *)copyNumberAtIndex:(NSUInteger)index error:(NSError **)pError
{
    NSError  *error = nil;
    NSNumber *number = nil;
    
    RWSQLiteDataType dataType = [self dataTypeAtIndex:index error:&error];
    
    if (!RWSQLiteDataTypeIsValid(dataType))
    {
        goto jmp_exit;
    }
    
    if (dataType == RWSQLiteDataTypeInteger)
    {
        SInt64 int64Value = [self int64AtIndex:index error:&error];
        
        if ((int64Value == 0) && error)
        {
            goto jmp_exit;
        }
        
        switch (int64Value)
        {
            case -1ll:
                number = RWSQLiteNSNumberLongLongNegativeOne;
                break;
                
            case 0ll:
                number = RWSQLiteNSNumberLongLongZero;
                break;
                
            case 1ll:
                number = RWSQLiteNSNumberLongLongPositiveOne;
                break;
                
            default:
                number = [[NSNumber alloc] initWithLongLong:int64Value];
                break;
        }
        
        if (!number)
        {
            goto jmp_exit;
        }
    }
    
    else if (dataType == RWSQLiteDataTypeDouble)
    {
        double doubleValue = [self doubleAtIndex:index error:&error];
        
        if ((doubleValue == 0.0) && error)
        {
            goto jmp_exit;
        }
        
        number = [[NSNumber alloc] initWithDouble:doubleValue];
        
        if (!number)
        {
            goto jmp_exit;
        }
    }
    
    else
    {
        // The future can be changed.
        
        double doubleValue = [self doubleAtIndex:index error:&error];
        
        if ((doubleValue == 0.0) && error)
        {
            goto jmp_exit;
        }
        
        number = [[NSNumber alloc] initWithDouble:doubleValue];
        
        if (!number)
        {
            goto jmp_exit;
        }
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return number;
}

- (NSNumber *)numberAtIndex:(NSUInteger)index error:(NSError **)pError
{
    NSNumber *number = [self copyNumberAtIndex:index error:pError];
    return number;
}

- (id)copyObjectAtIndex:(NSUInteger)index error:(NSError **)pError
{
    NSError *error = nil;
    id       object = nil;
    
    RWSQLiteDataType dataType = [self dataTypeAtIndex:index error:&error];
    
    if (!RWSQLiteDataTypeIsValid(dataType))
    {
        goto jmp_exit;
    }
    
    if (dataType == RWSQLiteDataTypeString)
    {
        object = [self copyStringAtIndex:index error:(pError ? &error : nil)];
    }
    
    else if ((dataType == RWSQLiteDataTypeInteger) ||
             (dataType == RWSQLiteDataTypeDouble))
    {
        object = [self copyNumberAtIndex:index error:(pError ? &error : nil)];
    }
    
    else if (dataType == RWSQLiteDataTypeData)
    {
        object = [self copyDataAtIndex:index error:(pError ? &error : nil)];
    }
    
    else if (dataType == RWSQLiteDataTypeNull)
    {
        object = [NSNull null];
    }
    
    // Data type is unknown type.
    else
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return object;
}

- (id)objectAtIndex:(NSUInteger)index error:(NSError **)pError
{
    id object = [self copyObjectAtIndex:index error:pError];
    return object;
}

- (NSMutableDictionary *)copyValuesError:(NSError **)pError
{
    NSString            *columnName = nil;
    NSError             *error = nil;
    NSUInteger           numberOfColumns = 0;
    id                   object = nil;
    NSMutableDictionary *values = nil;
    
    numberOfColumns = self.columnCount;
    
    if (numberOfColumns == NSNotFound)
    {
        goto jmp_error;
    }
    
    values = [[NSMutableDictionary alloc] initWithCapacity:numberOfColumns];
    
    if (!values)
    {
        goto jmp_error;
    }
    
    for (NSUInteger indexOfColumn = 0; indexOfColumn < numberOfColumns; indexOfColumn++)
    {
        columnName = [self copyColumnNameAtIndex:indexOfColumn error:(pError ? &error : nil)];
        
        if (!columnName)
        {
            goto jmp_error;
        }
        
        object = [self copyObjectAtIndex:indexOfColumn error:(pError ? &error : nil)];
        
        if (!object)
        {
            goto jmp_error;
        }
        
        [values setObject:object forKey:columnName];
    }
    
    if (pError)
    {
        *pError = error;
    }
    
    return values;
    
jmp_error:
    
    if (pError)
    {
        *pError = error;
    }
    
    values = nil;
    
    return values;
}

- (NSMutableDictionary *)valuesError:(NSError **)pError
{
    NSMutableDictionary *values = [self copyValuesError:pError];
    return values;
}

- (id)copyObjectClass:(Class)cls error:(NSError **)pError
{
    const void *cColumnName = NULL;
    NSError    *error = nil;
    id          immutableObject = nil;
    id          mutalbeObject = nil;
    NSUInteger  numberOfColumns = 0;
    id          object = nil;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    if (!cls)
    {
        goto jmp_exit;
    }
    
    numberOfColumns = self.columnCount;
    
    if (numberOfColumns == NSNotFound)
    {
        goto jmp_exit;
    }
    
    mutalbeObject = [[cls alloc] init];
    
    if (!mutalbeObject)
    {
        goto jmp_exit;
    }
    
    for (NSUInteger indexOfColumn = 0; indexOfColumn < numberOfColumns; indexOfColumn++)
    {
        cColumnName = sqlite3_column_name(mSqlite3_stmt, (int)indexOfColumn);
        
        if (!cColumnName)
        {
            if (pError)
            {
                sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
                
                error = RWSQLiteNSErrorCreateWithSqlite(sqlite);
            }
            
            goto jmp_exit;
        }
        
        object = [self copyObjectAtIndex:indexOfColumn error:(pError ? &error : nil)];
        
        if (!object)
        {
            goto jmp_exit;
        }
        
        SEL selector = RWSQLiteSetterCacheGetSelectorForParameter([mutalbeObject class], cColumnName);
        
        if (!selector)
        {
            goto jmp_exit;
        }
        
        ((void (*)(id self, SEL _cmd, id object))objc_msgSend)(mutalbeObject, selector, object);
    }
    
    immutableObject = mutalbeObject;
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return immutableObject;
}

- (id)objectClass:(Class)cls error:(NSError **)pError
{
    id object = [self copyObjectClass:(Class)cls error:pError];
    return object;
}

#pragma mark - Destroying a Prepared Statement Object

- (BOOL)finalizeError:(NSError **)pError
{
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_finalize(mSqlite3_stmt);
    
    if ((resultCode != RWSQLiteResultCodeSuccess) &&
        (resultCode != RWSQLiteResultCodeRow) &&
        (resultCode != RWSQLiteResultCodeDone))
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(sqlite, resultCode);
        }
        
        goto jmp_exit;
    }
    
    mSqlite3_stmt = NULL;
    
    success = YES;
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

#pragma mark - Resetting a Prepared Statement Object

- (BOOL)resetError:(NSError **)pError
{
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3_stmt)
    {
        goto jmp_exit;
    }
    
    success = YES;
    
    resultCode = (RWSQLiteResultCode)sqlite3_reset(mSqlite3_stmt);
    
    if ((resultCode != RWSQLiteResultCodeSuccess) &&
        (resultCode != RWSQLiteResultCodeRow) &&
        (resultCode != RWSQLiteResultCodeDone))
    {
        if (pError)
        {
            sqlite3 *sqlite = sqlite3_db_handle(mSqlite3_stmt);
            
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(sqlite, resultCode);
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

#pragma mark - Executing the SQL Statement

- (BOOL)executeNonQueryWithBindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSError            *error = nil;
    BOOL                result = NO;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode  resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    result = [self bindValues:bindValues copied:NO error:(pError ? &error : nil)];
    
    if (!result)
    {
        goto jmp_exit;
    }
    
    resultCodeOrExtendedResultCode = [self stepError:(pError ? &error : nil)];
    
    resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
    
    if ((resultCode != RWSQLiteResultCodeSuccess) &&
        (resultCode != RWSQLiteResultCodeRow) &&
        (resultCode != RWSQLiteResultCodeDone))
    {
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

- (id)copyExecuteScalarWithBindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSError            *error = nil;
    BOOL                result = NO;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode  resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    id                  resultObject = nil;
    
    result = [self bindValues:bindValues copied:NO error:(pError ? &error : nil)];
    
    if (!result)
    {
        goto jmp_exit;
    }
    
    resultCodeOrExtendedResultCode = [self stepError:(pError ? &error : nil)];
    
    resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
    
    if ((resultCode != RWSQLiteResultCodeSuccess) &&
        (resultCode != RWSQLiteResultCodeRow) &&
        (resultCode != RWSQLiteResultCodeDone))
    {
        goto jmp_exit;
    }
    
    if (resultCode == RWSQLiteResultCodeRow)
    {
        NSUInteger numberOfColumns = self.dataCount;
        
        if (numberOfColumns > 0)
        {
            resultObject = [self copyObjectAtIndex:0 error:(pError ? &error : nil)];
            
            if (!resultObject)
            {
                goto jmp_exit;
            }
        }
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return resultObject;
}

- (id)executeScalarWithBindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    id resultObject = [self copyExecuteScalarWithBindValues:bindValues error:pError];
    return resultObject;
}

- (NSMutableArray *)copyExecuteWithBindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSError             *error = nil;
    NSUInteger           indexOfRow = 0;
    BOOL                 result = NO;
    RWSQLiteResultCode   resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode   resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    NSMutableArray      *rows = nil;
    NSMutableDictionary *values = nil;
    
    result = [self bindValues:bindValues copied:NO error:(pError ? &error : nil)];
    
    if (!result)
    {
        goto jmp_error;
    }
    
    rows = [[NSMutableArray alloc] init];
    
    do
    {
        resultCodeOrExtendedResultCode = [self stepError:(pError ? &error : nil)];
        
        resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
        
        if ((resultCode != RWSQLiteResultCodeSuccess) &&
            (resultCode != RWSQLiteResultCodeRow) &&
            (resultCode != RWSQLiteResultCodeDone))
        {
            goto jmp_error;
        }
        
        if (resultCode == RWSQLiteResultCodeRow)
        {
            values = [self copyValuesError:(pError ? &error : nil)];
            
            if (!values)
            {
                goto jmp_error;
            }
            
            [rows addObject:values];
            
            values = nil;
        }
        
        indexOfRow++;
    } while (resultCode == RWSQLiteResultCodeRow);
    
    if (pError)
    {
        *pError = error;
    }
    
    return rows;
    
jmp_error:
    
    if (pError)
    {
        *pError = error;
    }
    
    rows = nil;
    
    return rows;
}

- (NSMutableArray *)executeWithBindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSMutableArray *rows = [self copyExecuteWithBindValues:bindValues error:pError];
    return rows;
}

- (BOOL)executeWithBindValues:(NSDictionary *)bindValues enumerateRowsUsingBlock:(void (^)(NSDictionary *values, NSUInteger index, BOOL *stop))enumerateRowsBlock error:(NSError **)pError
{
    NSError             *error = nil;
    NSUInteger           indexOfRow = 0;
    BOOL                 result = NO;
    RWSQLiteResultCode   resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode   resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    BOOL                 stop = NO;
    BOOL                 success = NO;
    NSMutableDictionary *values = nil;
    
    result = [self bindValues:bindValues copied:NO error:(pError ? &error : nil)];
    
    if (!result)
    {
        goto jmp_exit;
    }
    
    do
    {
        resultCodeOrExtendedResultCode = [self stepError:(pError ? &error : nil)];
        
        resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
        
        if ((resultCode != RWSQLiteResultCodeSuccess) &&
            (resultCode != RWSQLiteResultCodeRow) &&
            (resultCode != RWSQLiteResultCodeDone))
        {
            goto jmp_exit;
        }
        
        if (resultCode == RWSQLiteResultCodeRow)
        {
            values = [self copyValuesError:(pError ? &error : nil)];
            
            if (!values)
            {
                goto jmp_exit;
            }
            
            enumerateRowsBlock(values, indexOfRow, &stop);
            
            values = nil;
        }
        
        indexOfRow++;
    } while (!stop && (resultCode == RWSQLiteResultCodeRow));
    
    success = YES;
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    values = nil;
    
    return success;
}

- (BOOL)executeNonQueryWithBindObject:(id)bindObject error:(NSError **)pError
{
    NSError            *error = nil;
    BOOL                result = NO;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode  resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    result = [self bindObject:bindObject copied:NO error:(pError ? &error : nil)];
    
    if (!result)
    {
        goto jmp_exit;
    }
    
    resultCodeOrExtendedResultCode = [self stepError:(pError ? &error : nil)];
    
    resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
    
    if ((resultCode != RWSQLiteResultCodeSuccess) &&
        (resultCode != RWSQLiteResultCodeRow) &&
        (resultCode != RWSQLiteResultCodeDone))
    {
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

- (id)copyExecuteScalarWithClass:(Class)cls bindObject:(id)bindObject error:(NSError **)pError
{
    NSError            *error = nil;
    id                  object = nil;
    BOOL                result = NO;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode  resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    
    result = [self bindObject:bindObject copied:NO error:(pError ? &error : nil)];
    
    if (!result)
    {
        goto jmp_exit;
    }
    resultCodeOrExtendedResultCode = [self stepError:(pError ? &error : nil)];
    
    resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
    
    if ((resultCode != RWSQLiteResultCodeSuccess) &&
        (resultCode != RWSQLiteResultCodeRow) &&
        (resultCode != RWSQLiteResultCodeDone))
    {
        goto jmp_exit;
    }
    
    if (resultCode == RWSQLiteResultCodeRow)
    {
        NSUInteger numberOfColumns = self.dataCount;
        
        if (numberOfColumns > 0)
        {
            object = [self copyObjectClass:cls error:(pError ? &error : nil)];
            
            if (!object)
            {
                goto jmp_exit;
            }
        }
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return object;
}

- (id)executeScalarWithClass:(Class)cls bindObject:(id)bindObject error:(NSError **)pError
{
    id object = [self copyExecuteScalarWithClass:cls bindObject:bindObject error:pError];
    return object;
}

- (NSMutableArray *)copyExecuteWithClass:(Class)cls bindObject:(id)bindObject error:(NSError **)pError
{
    NSError            *error = nil;
    NSUInteger          indexOfRow = 0;
    id                  object = nil;
    BOOL                result = NO;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode  resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    NSMutableArray     *rows = nil;
    
    result = [self bindObject:bindObject copied:NO error:(pError ? &error : nil)];
    
    if (!result)
    {
        goto jmp_error;
    }
    
    rows = [[NSMutableArray alloc] init];
    
    do
    {
        resultCodeOrExtendedResultCode = [self stepError:(pError ? &error : nil)];
        
        resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
        
        if ((resultCode != RWSQLiteResultCodeSuccess) &&
            (resultCode != RWSQLiteResultCodeRow) &&
            (resultCode != RWSQLiteResultCodeDone))
        {
            goto jmp_error;
        }
        
        if (resultCode == RWSQLiteResultCodeRow)
        {
            object = [self copyObjectClass:cls error:(pError ? &error : nil)];
            
            if (!object)
            {
                goto jmp_error;
            }
            
            [rows addObject:object];
            
            object = nil;
        }
        
        indexOfRow++;
    } while (resultCode == RWSQLiteResultCodeRow);
    
    if (pError)
    {
        *pError = error;
    }
    
    return rows;
    
jmp_error:
    
    if (pError)
    {
        *pError = error;
    }
    
    rows = nil;
    
    return rows;
}

- (NSMutableArray *)executeWithClass:(Class)cls bindObject:(id)bindObject error:(NSError **)pError
{
    NSMutableArray *rows = [self copyExecuteWithClass:cls bindObject:bindObject error:pError];
    return rows;
}

- (BOOL)executeWithClass:(Class)cls bindObject:(id)bindObject enumerateRowsUsingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))enumerateRowsBlock error:(NSError **)pError
{
    NSError            *error = nil;
    NSUInteger          indexOfRow = 0;
    id                  object = nil;
    BOOL                result = NO;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode  resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    BOOL                stop = NO;
    BOOL                success = NO;
    
    result = [self bindObject:bindObject copied:NO error:(pError ? &error : nil)];
    
    if (!result)
    {
        goto jmp_exit;
    }
    
    do
    {
        resultCodeOrExtendedResultCode = [self stepError:(pError ? &error : nil)];
        
        resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
        
        if ((resultCode != RWSQLiteResultCodeSuccess) &&
            (resultCode != RWSQLiteResultCodeRow) &&
            (resultCode != RWSQLiteResultCodeDone))
        {
            goto jmp_exit;
        }
        
        if (resultCode == RWSQLiteResultCodeRow)
        {
            object = [self copyObjectClass:cls error:(pError ? &error : nil)];
            
            if (!object)
            {
                goto jmp_exit;
            }
            
            enumerateRowsBlock(object, indexOfRow, &stop);
            
            object = nil;
        }
        
        indexOfRow++;
    } while (!stop && (resultCode == RWSQLiteResultCodeRow));
    
    success = YES;
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

- (id)copyExecuteScalarWithClass:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSError            *error = nil;
    id                  object = nil;
    BOOL                result = NO;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode  resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    
    result = [self bindValues:bindValues copied:NO error:(pError ? &error : nil)];
    
    if (!result)
    {
        goto jmp_exit;
    }
    
    resultCodeOrExtendedResultCode = [self stepError:(pError ? &error : nil)];
    
    resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
    
    if ((resultCode != RWSQLiteResultCodeSuccess) &&
        (resultCode != RWSQLiteResultCodeRow) &&
        (resultCode != RWSQLiteResultCodeDone))
    {
        goto jmp_exit;
    }
    
    if (resultCode == RWSQLiteResultCodeRow)
    {
        NSUInteger numberOfColumns = self.dataCount;
        
        if (numberOfColumns > 0)
        {
            object = [self copyObjectClass:cls error:(pError ? &error : nil)];
            
            if (!object)
            {
                goto jmp_exit;
            }
        }
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return object;
}

- (id)executeScalarWithClass:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    id object = [self copyExecuteScalarWithClass:cls bindValues:bindValues error:pError];
    return object;
}

- (NSMutableArray *)copyExecuteWithClass:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSError            *error = nil;
    NSUInteger          indexOfRow = 0;
    id                  object = nil;
    BOOL                result = NO;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode  resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    NSMutableArray     *rows = nil;
    
    result = [self bindValues:bindValues copied:NO error:(pError ? &error : nil)];
    
    if (!result)
    {
        goto jmp_error;
    }
    
    rows = [[NSMutableArray alloc] init];
    
    do
    {
        resultCodeOrExtendedResultCode = [self stepError:(pError ? &error : nil)];
        
        resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
        
        if ((resultCode != RWSQLiteResultCodeSuccess) &&
            (resultCode != RWSQLiteResultCodeRow) &&
            (resultCode != RWSQLiteResultCodeDone))
        {
            goto jmp_error;
        }
        
        if (resultCode == RWSQLiteResultCodeRow)
        {
            object = [self copyObjectClass:cls error:(pError ? &error : nil)];
            
            if (!object)
            {
                goto jmp_error;
            }
            
            [rows addObject:object];
            
            object = nil;
        }
        
        indexOfRow++;
    } while (resultCode == RWSQLiteResultCodeRow);
    
    if (pError)
    {
        *pError = error;
    }
    
    return rows;
    
jmp_error:
    
    if (pError)
    {
        *pError = error;
    }
    
    rows = nil;
    
    return rows;
}

- (NSMutableArray *)executeWithClass:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSMutableArray *rows = [self copyExecuteWithClass:cls bindValues:bindValues error:pError];
    return rows;
}

- (BOOL)executeWithClass:(Class)cls bindValues:(NSDictionary *)bindValues enumerateRowsUsingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))enumerateRowsBlock error:(NSError **)pError
{
    NSError            *error = nil;
    NSUInteger          indexOfRow = 0;
    id                  object = nil;
    BOOL                result = NO;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode  resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    BOOL                stop = NO;
    BOOL                success = NO;
    
    result = [self bindValues:bindValues copied:NO error:(pError ? &error : nil)];
    
    if (!result)
    {
        goto jmp_exit;
    }
    
    do
    {
        resultCodeOrExtendedResultCode = [self stepError:(pError ? &error : nil)];
        
        resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
        
        if ((resultCode != RWSQLiteResultCodeSuccess) &&
            (resultCode != RWSQLiteResultCodeRow) &&
            (resultCode != RWSQLiteResultCodeDone))
        {
            goto jmp_exit;
        }
        
        if (resultCode == RWSQLiteResultCodeRow)
        {
            object = [self copyObjectClass:cls error:(pError ? &error : nil)];
            
            if (!object)
            {
                goto jmp_exit;
            }
            
            enumerateRowsBlock(object, indexOfRow, &stop);
            
            object = nil;
        }
        
        indexOfRow++;
    } while (!stop && (resultCode == RWSQLiteResultCodeRow));
    
    success = YES;
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return success;
}

#pragma mark - Conforming the NSObject Protocol

#pragma mark Identifying and Comparing Objects

- (BOOL)isEqual:(id)object
{
    BOOL isEqual = (mSqlite3_stmt && object && [object isKindOfClass:[RWSQLiteStatement class]] && (mSqlite3_stmt == ((RWSQLiteStatement *)object)->mSqlite3_stmt));
    return isEqual;
}

- (NSUInteger)hash
{
    NSUInteger hash = (NSUInteger)mSqlite3_stmt;
    return hash;
}

@end
