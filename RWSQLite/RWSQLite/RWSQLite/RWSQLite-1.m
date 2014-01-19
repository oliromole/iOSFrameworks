//
//  RWSQLite-1.m
//  RWSQLite
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.06.22.
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
#import "RWSQLite-1.h"

// Importing the project headers.
#import "RWSQLiteBlob.h"
#import "RWSQLiteError.h"
#import "RWSQLiteLibraryConfigurationOptions.h"
#import "RWSQLiteLimit.h"
#import "RWSQLiteMutex.h"
#import "RWSQLiteStatement.h"
#import "RWSQLiteString.h"
#import "RWSQLiteURL.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RWSQLite

#pragma mark - Initaliazing and Creating a RWSQLite

- (id)init
{
    self = [super init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    mSqlite3 = NULL;
    mStringEncoding = RWSQLiteStringEncodingUTF8;
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)lite
{
    return [[self alloc] init];
}

- (id)initWithSqlite3:(sqlite3 *)sqlite3
{
    self = [self init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    [self setSqlite3:sqlite3];
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)liteWithSqlite3:(sqlite3 *)sqlite3
{
    return [[self alloc] initWithSqlite3:sqlite3];
}

- (id)initWithContentsOfFile:(NSString *)path fileOpenOperations:(RWSQLiteFileOpenOperations)fileOpenOperations virtualFileSystem:(NSString *)virtualFileSystem error:(NSError **)pError
{
    char               *cPath = NULL;
    char               *cVirtualFileSystem = NULL;
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeError;
    sqlite3            *sqlite3 = NULL;
    
    cPath = (char *)RWSQLiteCStringCreateWithNSString(path, RWSQLiteStringEncodingUTF8);
    
    if (!cPath ^ !path)
    {
        goto jmp_error;
    }
    
    fileOpenOperations &= ~(RWSQLiteFileOpenOperationURI);
    
    cVirtualFileSystem = (char *)RWSQLiteCStringCreateWithNSString(virtualFileSystem, RWSQLiteStringEncodingUTF8);
    
    if (!cVirtualFileSystem ^ !virtualFileSystem)
    {
        goto jmp_error;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_open_v2(cPath, &sqlite3, (int)fileOpenOperations, cVirtualFileSystem);
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            error = [[NSError alloc] initWithDomain:RWSQLiteResultCodeErrorDomain code:resultCode userInfo:nil];
        }
        
        goto jmp_error;
    }
    
    self = [self initWithSqlite3:sqlite3];
    
    if (self)
    {
        sqlite3 = NULL;
    }
    
    else
    {
        goto jmp_error;
    }
    
    if (pError)
    {
        *pError = error;
    }
    
    free(cPath);
    cPath = NULL;
    
    free(cVirtualFileSystem);
    cVirtualFileSystem = NULL;
    
    sqlite3_close(sqlite3);
    sqlite3 = NULL;
    
    return self;
    
jmp_error:
    
    if (pError)
    {
        *pError = error;
    }
    
    free(cPath);
    cPath = NULL;
    
    free(cVirtualFileSystem);
    cVirtualFileSystem = NULL;
    
    sqlite3_close(sqlite3);
    sqlite3 = NULL;
    
    self = nil;
    
    return self;
}

+ (id)liteWithContentsOfFile:(NSString *)path fileOpenOperations:(RWSQLiteFileOpenOperations)fileOpenOperations virtualFileSystem:(NSString *)virtualFileSystem error:(NSError **)pError
{
    return [[self alloc] initWithContentsOfFile:path fileOpenOperations:fileOpenOperations virtualFileSystem:virtualFileSystem error:pError];
}

- (id)initWithContentsOfURL:(NSURL *)url fileOpenOperations:(RWSQLiteFileOpenOperations)fileOpenOperations virtualFileSystem:(NSString *)virtualFileSystem error:(NSError **)pError
{
    char               *cURL = NULL;
    char               *cVirtualFileSystem = NULL;
    NSError            *error = NULL;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeError;
    sqlite3            *sqlite3 = NULL;
    
    cURL = RWSQLiteCStringCreateWithNSURL(url);
    
    if (!cURL ^ !url)
    {
        goto jmp_error;
    }
    
    fileOpenOperations |= RWSQLiteFileOpenOperationURI;
    
    cVirtualFileSystem = (char *)RWSQLiteCStringCreateWithNSString(virtualFileSystem, RWSQLiteStringEncodingUTF8);
    
    if (!cVirtualFileSystem ^ !virtualFileSystem)
    {
        goto jmp_error;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_open_v2(cURL, &sqlite3, (int)fileOpenOperations, cVirtualFileSystem);
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(mSqlite3, resultCode);
        }
        
        goto jmp_error;
    }
    
    self = [self initWithSqlite3:sqlite3];
    
    if (self)
    {
        sqlite3 = NULL;
    }
    
    else
    {
        goto jmp_error;
    }
    
    if (pError)
    {
        *pError = error;
    }
    
    free(cURL);
    cURL = NULL;
    
    free(cVirtualFileSystem);
    cVirtualFileSystem = NULL;
    
    sqlite3_close(sqlite3);
    sqlite3 = NULL;
    
    return self;
    
jmp_error:
    
    if (pError)
    {
        *pError = error;
    }
    
    free(cURL);
    cURL = NULL;
    
    free(cVirtualFileSystem);
    cVirtualFileSystem = NULL;
    
    sqlite3_close(sqlite3);
    sqlite3 = NULL;
    
    self = nil;
    
    return self;
}

+ (id)liteWithContentsOfURL:(NSURL *)url fileOpenOperations:(RWSQLiteFileOpenOperations)fileOpenOperations virtualFileSystem:(NSString *)virtualFileSystem error:(NSError **)pError
{
    return [[self alloc] initWithContentsOfURL:url fileOpenOperations:fileOpenOperations virtualFileSystem:virtualFileSystem error:pError];
}

#pragma mark - Deallocating a RWSQLite

- (void)dealloc
{
    if (mSqlite3)
    {
        RWSQLiteResultCode resultCode = (RWSQLiteResultCode)sqlite3_close(mSqlite3);
        
        if (resultCode != RWSQLiteResultCodeSuccess)
        {
            // TODO: Implements lazy of closing the database.
            NSLog(@"");
        }
        
        mSqlite3 = NULL;
    }
}

#pragma mark - Configuring The SQLite Library

+ (RWSQLiteLibraryThreadsafeMode)threadsafeMode
{
    RWSQLiteLibraryThreadsafeMode threadsafeMode = (RWSQLiteLibraryThreadsafeMode)sqlite3_threadsafe();
    return threadsafeMode;
}

+ (BOOL)setThreadsafeMode:(RWSQLiteLibraryThreadsafeMode)threadsafeMode
{
    RWSQLiteLibraryConfigurationOptions configurationOptions;
    RWSQLiteResultCode                  resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode                  resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    BOOL                                success = NO;
    
    if (!RWSQLiteLibraryThreadsafeModeIsValid(threadsafeMode))
    {
        goto jmp_exit;
    }
    
    configurationOptions = RWSQLiteLibraryConfigurationOptionsFromThreadsafeMode(threadsafeMode);
    resultCodeOrExtendedResultCode = (RWSQLiteResultCode)sqlite3_config((int)configurationOptions);
    resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
    success = (resultCode == RWSQLiteResultCodeSuccess);
    
jmp_exit:
    
    return success;
}

#pragma mark - Managing the sqlite3

- (sqlite3 *)sqlite3
{
    return mSqlite3;
}

- (void)setSqlite3:(sqlite3 *)sqlite3
{
    if (mSqlite3 != sqlite3)
    {
        mSqlite3 = sqlite3;
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

#pragma mark - Configuring the SQLite Object

- (BOOL)setBusyTimeout:(NSInteger)milliseconds error:(NSError **)pError
{
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    RWSQLiteResultCode  resultCodeOrExtendedResultCode = RWSQLiteResultCodeSuccess;
    BOOL                success = NO;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    resultCodeOrExtendedResultCode = (RWSQLiteResultCode)sqlite3_busy_timeout(mSqlite3, (int)milliseconds);
    
    resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
    
    if ((resultCode != RWSQLiteResultCodeSuccess) &&
        (resultCode != RWSQLiteResultCodeRow) &&
        (resultCode != RWSQLiteResultCodeDone))
    {
        if (pError)
        {
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(mSqlite3, resultCode);
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

- (BOOL)recursiveTriggerError:(NSError **)pError
{
    NSError  *error = nil;
    BOOL      recursiveTrigger = NO;
    NSNumber *recursiveTriggerNumber = nil;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    recursiveTriggerNumber = [self copyExecuteScalarWithCommand:@"PRAGMA recursive_triggers" bindValues:nil error:(pError ? &error : nil)];
    
    if (!recursiveTriggerNumber)
    {
        goto jmp_exit;
    }
    
    recursiveTrigger = (recursiveTriggerNumber.longLongValue == 1ll);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return recursiveTrigger;
}

- (BOOL)setRecursiveTrigger:(BOOL)newRecursiveTrigger error:(NSError **)pError
{
    NSString *command = nil;
    NSError  *error = nil;
    BOOL      result = NO;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    if (newRecursiveTrigger)
    {
        command = @"PRAGMA recursive_triggers = 1";
    }
    
    else
    {
        command = @"PRAGMA recursive_triggers = 0";
    }
    
    result = [self executeNonQueryWithCommand:command bindValues:nil error:(pError ? &error : nil)];
    
    if (!result)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return result;
}

#pragma mark - Configuring the Limits

- (NSInteger)limitLengthError:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  limitLength = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    limitLength = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitLength, -1);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return limitLength;
}

- (NSInteger)setLimitLength:(NSInteger)newLimitLength error:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  oldLimitLength = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    oldLimitLength = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitSQLLength, (int)newLimitLength);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return oldLimitLength;
}

- (NSInteger)limitSQLLengthError:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  limitSQLLength = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    limitSQLLength = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitSQLLength, -1);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return limitSQLLength;
}

- (NSInteger)setLimitSQLLength:(NSInteger)newLimitSQLLength error:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  oldLimitSQLLength = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    oldLimitSQLLength = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitSQLLength, (int)newLimitSQLLength);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return oldLimitSQLLength;
}

- (NSInteger)limitColumnError:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  limitColumn = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    limitColumn = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitColumn, -1);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return limitColumn;
}

- (NSInteger)setLimitColumn:(NSInteger)newLimitColumn error:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  oldLimitColumn = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    oldLimitColumn = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitColumn, (int)newLimitColumn);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return oldLimitColumn;
}

- (NSInteger)limitExpressionDepthError:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  limitExpressionDepth = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    limitExpressionDepth = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitExpressionDepth, -1);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return limitExpressionDepth;
}

- (NSInteger)setLimitExpressionDepth:(NSInteger)newLimitExpressionDepth error:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  oldLimitExpressionDepth = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    oldLimitExpressionDepth = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitExpressionDepth, (int)newLimitExpressionDepth);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return oldLimitExpressionDepth;
}

- (NSInteger)limitCompoundSelectError:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  limitCompoundSelect = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    limitCompoundSelect = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitCompoundSelect, -1);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return limitCompoundSelect;
}

- (NSInteger)setLimitCompoundSelect:(NSInteger)newLimitCompoundSelect error:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  oldLimitCompoundSelect = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    oldLimitCompoundSelect = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitCompoundSelect, (int)newLimitCompoundSelect);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return oldLimitCompoundSelect;
}

- (NSInteger)limitVDBEOPError:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  limitVDBEOP = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    limitVDBEOP = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitVDBEOP, -1);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return limitVDBEOP;
}

- (NSInteger)setLimitVDBEOP:(NSInteger)newLimitVDBEOP error:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  oldLimitVDBEOP = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    oldLimitVDBEOP = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitVDBEOP, (int)newLimitVDBEOP);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return oldLimitVDBEOP;
}

- (NSInteger)limitFunctionArgumentsError:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  limitFunctionArguments = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    limitFunctionArguments = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitFunctionArguments, -1);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return limitFunctionArguments;
}

- (NSInteger)setLimitFunctionArguments:(NSInteger)newLimitFunctionArguments error:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  oldLimitFunctionArguments = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    oldLimitFunctionArguments = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitFunctionArguments, (int)newLimitFunctionArguments);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return oldLimitFunctionArguments;
}

- (NSInteger)limitAttachedError:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  limitAttached = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    limitAttached = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitAttached, -1);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return limitAttached;
}

- (NSInteger)setLimitAttached:(NSInteger)newLimitAttached error:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  oldLimitAttached = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    oldLimitAttached = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitAttached, (int)newLimitAttached);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return oldLimitAttached;
}

- (NSInteger)limitLikePatternLengthError:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  limitLikePatternLength = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    limitLikePatternLength = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitLikePatternLength, -1);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return limitLikePatternLength;
}

- (NSInteger)setLimitLikePatternLength:(NSInteger)newLimitLikePatternLength error:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  oldLimitLikePatternLength = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    oldLimitLikePatternLength = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitLikePatternLength, (int)newLimitLikePatternLength);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return oldLimitLikePatternLength;
}

- (NSInteger)limitVariableNumberError:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  limitVariableNumber = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    limitVariableNumber = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitVariableNumber, -1);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return limitVariableNumber;
}

- (NSInteger)setLimitVariableNumber:(NSInteger)newLimitVariableNumber error:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  oldLimitVariableNumber = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    oldLimitVariableNumber = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitVariableNumber, (int)newLimitVariableNumber);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return oldLimitVariableNumber;
}

- (NSInteger)limitTriggerDepthError:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  limitTriggerDepth = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    limitTriggerDepth = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitTriggerDapth, -1);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return limitTriggerDepth;
}

- (NSInteger)setLimitTriggerDepth:(NSInteger)newLimitTriggerDepth error:(NSError **)pError
{
    NSError   *error = nil;
    NSInteger  oldLimitTriggerDepth = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    oldLimitTriggerDepth = (NSInteger)sqlite3_limit(mSqlite3, (int)RWSQLiteLimitTriggerDapth, (int)newLimitTriggerDepth);
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return oldLimitTriggerDepth;
}

#pragma mark - Closing A Database Connection

- (BOOL)closeError:(NSError **)pError
{
#pragma unused(pError)
    
    RWSQLiteResultCode resultCode = RWSQLiteResultCodeSuccess;
    BOOL               success = NO;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_close(mSqlite3);
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        goto jmp_exit;
    }
    
    mSqlite3 = NULL;
    
    success = YES;
    
jmp_exit:
    
    return success;
}

#pragma mark - Getting the Last Error

- (NSError *)copyLastError
{
    NSError *lastError = RWSQLiteNSErrorCreateWithSqlite(mSqlite3);
    return lastError;
}

- (NSError *)lastError
{
    NSError *lastError = [self copyLastError];
    return lastError;
}

#pragma mark - Getting the Last Insert Rowid

- (SInt64)lastInsertRowIdentifier
{
    SInt64 lastInsertRowIdentifier = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    lastInsertRowIdentifier = sqlite3_last_insert_rowid(mSqlite3);
    
    if (lastInsertRowIdentifier == 0LL)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    return lastInsertRowIdentifier;
}

#pragma mark - Getting the Number of Rows Changed

- (NSInteger)numberOfChangedRows
{
    NSInteger numberOfChangedRows = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    numberOfChangedRows = (NSInteger)sqlite3_changes(mSqlite3);
    
jmp_exit:
    
    return numberOfChangedRows;
}

#pragma mark - Getting the Total of Rows Changed

- (NSInteger)totalOfChangedRows
{
    NSInteger totalOfChangedRows = 0;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    totalOfChangedRows = (NSInteger)sqlite3_total_changes(mSqlite3);
    
jmp_exit:
    
    return totalOfChangedRows;
}

#pragma mark - Interrupting A Long-Running Query

- (void)interrupt
{
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    sqlite3_interrupt(mSqlite3);
    
jmp_exit:
    
    return;
}

#pragma mark - Creating the Statement

- (RWSQLiteStatement *)copyStatementWithCommand:(NSString *)command error:(NSError **)pError
{
    char               *cCommand = NULL;
    char               *cCommandTail = NULL;
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    sqlite3_stmt       *sqliteStatement = NULL;
    RWSQLiteStatement  *statement = nil;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    cCommand = RWSQLiteCStringCreateWithNSString(command, RWSQLiteStringEncodingUTF8);
    
    if (!cCommand ^ !command)
    {
        goto jmp_exit;
    }
    
    resultCode = (RWSQLiteResultCode)sqlite3_prepare_v2(mSqlite3, (char *)cCommand, -1, &sqliteStatement, (const char **)&cCommandTail);
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(mSqlite3, resultCode);
        }
        
        goto jmp_exit;
    }
    
    statement = [[RWSQLiteStatement alloc] initWithSqliteStatement:sqliteStatement];
    
    if (statement)
    {
        statement.stringEncoding = mStringEncoding;
        
        sqliteStatement = NULL;
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
    
    free(cCommand);
    cCommand = NULL;
    
    sqlite3_finalize(sqliteStatement);
    sqliteStatement = NULL;
    
    return statement;
}

- (RWSQLiteStatement *)statementWithCommand:(NSString *)command error:(NSError **)pError
{
    RWSQLiteStatement *statement = [self copyStatementWithCommand:command error:pError];
    return statement;
}

#pragma mark - Retrieving the Mutex for the Database Connection

- (RWSQLiteMutex *)copyMutex
{
    RWSQLiteMutex *mutex = nil;
    
    if (mSqlite3)
    {
        sqlite3_mutex *sqliteMutex = sqlite3_db_mutex(mSqlite3);
        
        if (sqliteMutex)
        {
            mutex = [[RWSQLiteMutex alloc] initWithSqliteMutex:sqliteMutex needsFree:NO];
        }
    }
    
    return mutex;
}

- (RWSQLiteMutex *)mutex
{
    RWSQLiteMutex *mutex = [self copyMutex];
    return mutex;
}

#pragma mark - Beginning, Committing, Rollbacking the Transaction.

- (BOOL)beginTransactionError:(NSError **)pError
{
    NSError *error = nil;
    BOOL     success = NO;
    
    success = [self executeNonQueryWithCommand:@"BEGIN TRANSACTION" bindValues:nil error:(pError ? &error : nil)];
    
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

- (BOOL)beginDeferredTransactionError:(NSError **)pError
{
    NSError *error = nil;
    BOOL     success = NO;
    
    success = [self executeNonQueryWithCommand:@"BEGIN DEFERRED TRANSACTION" bindValues:nil error:(pError ? &error : nil)];
    
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

- (BOOL)beginImmediateTransactionError:(NSError **)pError
{
    NSError *error = nil;
    BOOL     success = NO;
    
    success = [self executeNonQueryWithCommand:@"BEGIN IMMEDIATE TRANSACTION" bindValues:nil error:(pError ? &error : nil)];
    
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

- (BOOL)beginExclusiveTransactionError:(NSError **)pError
{
    NSError *error = nil;
    BOOL     success = NO;
    
    success = [self executeNonQueryWithCommand:@"BEGIN EXCLUSIVE TRANSACTION" bindValues:nil error:(pError ? &error : nil)];
    
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

- (BOOL)commitTransactionError:(NSError **)pError
{
    NSError *error = nil;
    BOOL     success = NO;
    
    success = [self executeNonQueryWithCommand:@"COMMIT TRANSACTION" bindValues:nil error:(pError ? &error : nil)];
    
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

- (BOOL)endTransactionError:(NSError **)pError
{
    NSError *error = nil;
    BOOL     success = NO;
    
    success = [self executeNonQueryWithCommand:@"END TRANSACTION" bindValues:nil error:(pError ? &error : nil)];
    
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

- (BOOL)rollbackTransactionError:(NSError **)pError
{
    NSError *error = nil;
    BOOL     success = NO;
    
    success = [self executeNonQueryWithCommand:@"ROLLBACK TRANSACTION" bindValues:nil error:(pError ? &error : nil)];
    
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

- (BOOL)rollbackTransactionToSavepoint:(NSString *)savepoint error:(NSError **)pError
{
    NSMutableString *command = nil;
    NSError         *error = nil;
    BOOL             success = NO;
    
    command = [[NSMutableString alloc] init];
    
    if (!command)
    {
        goto jmp_exit;
    }
    
    if (!savepoint)
    {
        goto jmp_exit;
    }
    
    [command appendString:@"ROLLBACK TRANSACTION TO SAVEPOINT "];
    [command appendString:savepoint];
    
    success = [self executeNonQueryWithCommand:command bindValues:nil error:(pError ? &error : nil)];
    
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

- (BOOL)savepoint:(NSString *)savepoint error:(NSError **)pError
{
    NSMutableString *command = nil;
    NSError         *error = nil;
    BOOL             success = NO;
    
    command = [[NSMutableString alloc] init];
    
    if (!command)
    {
        goto jmp_exit;
    }
    
    if (!savepoint)
    {
        goto jmp_exit;
    }
    
    [command appendString:@"SAVEPOINT "];
    [command appendString:savepoint];
    
    success = [self executeNonQueryWithCommand:command bindValues:nil error:(pError ? &error : nil)];
    
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

- (BOOL)releaseSavepoint:(NSString *)savepoint error:(NSError **)pError
{
    NSMutableString *command = nil;
    NSError         *error = nil;
    BOOL             success = NO;
    
    command = [[NSMutableString alloc] init];
    
    if (!command)
    {
        goto jmp_exit;
    }
    
    if (!savepoint)
    {
        goto jmp_exit;
    }
    
    [command appendString:@"RELEASE SAVEPOINT "];
    [command appendString:savepoint];
    
    success = [self executeNonQueryWithCommand:command bindValues:nil error:(pError ? &error : nil)];
    
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

#pragma mark - Executing the SQL Command

- (BOOL)executeNonQueryWithCommand:(NSString *)command bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSError           *error = nil;
    RWSQLiteStatement *statement = nil;
    BOOL               success = NO;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    statement = [self copyStatementWithCommand:command error:(pError ? &error : nil)];
    
    if (!statement)
    {
        goto jmp_exit;
    }
    
    success = [statement executeNonQueryWithBindValues:bindValues error:(pError ? &error : nil)];
    
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

- (id)copyExecuteScalarWithCommand:(NSString *)command bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSError           *error = nil;
    id                 resultObject = nil;
    RWSQLiteStatement *statement = nil;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    statement = [self copyStatementWithCommand:command error:(pError ? &error : nil)];
    
    if (!statement)
    {
        goto jmp_exit;
    }
    
    resultObject = [statement copyExecuteScalarWithBindValues:bindValues error:(pError ? &error : nil)];
    
    if (!resultObject)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return resultObject;
}

- (id)executeScalarWithCommand:(NSString *)command bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    id resultObject = [self copyExecuteScalarWithCommand:command bindValues:bindValues error:pError];
    return resultObject;
}

- (NSMutableArray *)copyExecuteWithCommand:(NSString *)command bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSError           *error = nil;
    NSMutableArray    *rows= nil;
    RWSQLiteStatement *statement = nil;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    statement = [self copyStatementWithCommand:command error:(pError ? &error : nil)];
    
    if (!statement)
    {
        goto jmp_exit;
    }
    
    rows = [statement copyExecuteWithBindValues:bindValues error:(pError ? &error : nil)];
    
    if (!rows)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return rows;
}

- (NSMutableArray *)executeWithCommand:(NSString *)command bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSMutableArray *rows = [self copyExecuteWithCommand:command bindValues:bindValues error:pError];
    return rows;
}

- (BOOL)executeWithCommand:(NSString *)command bindValues:(NSDictionary *)bindValues enumerateRowsUsingBlock:(void (^)(NSDictionary *values, NSUInteger index, BOOL *stop))enumerateRowsBlock error:(NSError **)pError
{
    NSError           *error = nil;
    RWSQLiteStatement *statement = nil;
    BOOL               success = NO;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    statement = [self copyStatementWithCommand:command error:(pError ? &error : nil)];
    
    if (!statement)
    {
        goto jmp_exit;
    }
    
    success = [statement executeWithBindValues:bindValues enumerateRowsUsingBlock:enumerateRowsBlock error:(pError ? &error : nil)];
    
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

- (BOOL)executeNonQueryWithCommand:(NSString *)command bindObject:(id)bindObject error:(NSError **)pError
{
    NSError           *error = nil;
    RWSQLiteStatement *statement = nil;
    BOOL               success = NO;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    statement = [self copyStatementWithCommand:command error:(pError ? &error : nil)];
    
    if (!statement)
    {
        goto jmp_exit;
    }
    
    success = [statement executeNonQueryWithBindObject:bindObject error:(pError ? &error : nil)];
    
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

- (id)copyExecuteScalarWithCommand:(NSString *)command class:(Class)cls bindObject:(id)bindObject error:(NSError **)pError
{
    NSError           *error = nil;
    id                 resultObject = nil;
    RWSQLiteStatement *statement = nil;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    statement = [self copyStatementWithCommand:command error:(pError ? &error : nil)];
    
    if (!statement)
    {
        goto jmp_exit;
    }
    
    resultObject = [statement copyExecuteScalarWithClass:cls bindObject:bindObject error:(pError ? &error : nil)];
    
    if (!resultObject)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return resultObject;
}

- (id)executeScalarWithCommand:(NSString *)command class:(Class)cls bindObject:(id)bindObject error:(NSError **)pError
{
    id resultObject = [self copyExecuteWithCommand:command class:cls bindObject:bindObject error:pError];
    return resultObject;
}

- (NSMutableArray *)copyExecuteWithCommand:(NSString *)command class:(Class)cls bindObject:(id)bindObject error:(NSError **)pError
{
    NSError           *error = nil;
    NSMutableArray    *rows= nil;
    RWSQLiteStatement *statement = nil;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    statement = [self copyStatementWithCommand:command error:(pError ? &error : nil)];
    
    if (!statement)
    {
        goto jmp_exit;
    }
    
    rows = [statement copyExecuteWithClass:cls bindObject:bindObject error:(pError ? &error : nil)];
    
    if (!rows)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return rows;
}

- (NSMutableArray *)executeWithCommand:(NSString *)command class:(Class)cls bindObject:(id)bindObject error:(NSError **)pError
{
    NSMutableArray *rows = [self copyExecuteWithCommand:command class:cls bindObject:bindObject error:pError];
    return rows;
}

- (BOOL)executeWithCommand:(NSString *)command class:(Class)cls bindObject:(id)bindObject enumerateRowsUsingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))enumerateRowsBlock error:(NSError **)pError
{
    NSError           *error = nil;
    RWSQLiteStatement *statement = nil;
    BOOL               success = NO;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    statement = [self copyStatementWithCommand:command error:(pError ? &error : nil)];
    
    if (!statement)
    {
        goto jmp_exit;
    }
    
    success = [statement executeWithClass:cls bindObject:bindObject enumerateRowsUsingBlock:enumerateRowsBlock error:(pError ? &error : nil)];
    
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

- (id)copyExecuteScalarWithCommand:(NSString *)command class:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSError           *error = nil;
    id                 resultObject = nil;
    RWSQLiteStatement *statement = nil;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    statement = [self copyStatementWithCommand:command error:(pError ? &error : nil)];
    
    if (!statement)
    {
        goto jmp_exit;
    }
    
    resultObject = [statement copyExecuteScalarWithClass:cls bindValues:bindValues error:(pError ? &error : nil)];
    
    if (!resultObject)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return resultObject;
}

- (id)executeScalarWithCommand:(NSString *)command class:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    id resultObject = [self copyExecuteScalarWithCommand:command class:cls bindValues:bindValues error:pError];
    return resultObject;
}

- (NSMutableArray *)copyExecuteWithCommand:(NSString *)command class:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSError           *error = nil;
    NSMutableArray    *rows= nil;
    RWSQLiteStatement *statement = nil;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    statement = [self copyStatementWithCommand:command error:(pError ? &error : nil)];
    
    if (!statement)
    {
        goto jmp_exit;
    }
    
    rows = [statement copyExecuteWithClass:cls bindValues:bindValues error:(pError ? &error : nil)];
    
    if (!rows)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    if (pError)
    {
        *pError = error;
    }
    
    return rows;
}

- (NSMutableArray *)executeWithCommand:(NSString *)command class:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)pError
{
    NSMutableArray *rows = [self copyExecuteWithCommand:command class:cls bindValues:bindValues error:pError];
    return rows;
}

- (BOOL)executeWithCommand:(NSString *)command class:(Class)cls bindValues:(NSDictionary *)bindValues enumerateRowsUsingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))enumerateRowsBlock error:(NSError **)pError
{
    NSError           *error = nil;
    RWSQLiteStatement *statement = nil;
    BOOL               success = NO;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    statement = [self copyStatementWithCommand:command error:(pError ? &error : nil)];
    
    if (!statement)
    {
        goto jmp_exit;
    }
    
    success = [statement executeWithClass:cls bindValues:bindValues enumerateRowsUsingBlock:enumerateRowsBlock error:(pError ? &error : nil)];
    
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

#pragma mark - Opening the Blob

- (RWSQLiteBlob *)copyOpenBlobWithDatabaseName:(NSString *)databaseName tableName:(NSString *)tableName columnName:(NSString *)columnName rowIdentifier:(SInt64)rowIdentifier options:(RWSQLiteBlobOpenOptions)options error:(NSError **)pError
{
    RWSQLiteBlob       *blob = nil;
    char               *cColumnName = NULL;
    char               *cDatabaseName = NULL;
    int                 cOpenFlags = 0;
    char               *cTableName = NULL;
    NSError            *error = nil;
    RWSQLiteResultCode  resultCode = RWSQLiteResultCodeSuccess;
    sqlite3_blob       *sqliteBlob = NULL;
    
    if (!mSqlite3)
    {
        goto jmp_exit;
    }
    
    cDatabaseName = (char *)RWSQLiteCStringCreateWithNSString(databaseName, RWSQLiteStringEncodingUTF8);
    
    if (!cDatabaseName ^ !databaseName)
    {
        goto jmp_exit;
    }
    
    cTableName = (char *)RWSQLiteCStringCreateWithNSString(tableName, RWSQLiteStringEncodingUTF8);
    
    if (!cTableName ^ !tableName)
    {
        goto jmp_exit;
    }
    
    cColumnName = (char *)RWSQLiteCStringCreateWithNSString(columnName, RWSQLiteStringEncodingUTF8);
    
    if (!cColumnName ^ !columnName)
    {
        goto jmp_exit;
    }
    
    cOpenFlags = (int)(options & RWSQLiteBlobOpenOptionMask);
    
    resultCode = (RWSQLiteResultCode)sqlite3_blob_open(mSqlite3, cDatabaseName, cTableName, cColumnName, (sqlite3_int64)rowIdentifier, cOpenFlags, &sqliteBlob);
    
    if (resultCode != RWSQLiteResultCodeSuccess)
    {
        if (pError)
        {
            error = RWSQLiteNSErrorCreateWithSqliteAndResultCode(mSqlite3, resultCode);
        }
        
        goto jmp_exit;
    }
    
    blob = [[RWSQLiteBlob alloc] initWithSqliteBlob:sqliteBlob];
    
    if (blob)
    {
        sqliteBlob = NULL;
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
    
    free(cColumnName);
    cColumnName = NULL;
    
    free(cDatabaseName);
    cDatabaseName = NULL;
    
    free(cTableName);
    cTableName = NULL;
    
    sqlite3_blob_close(sqliteBlob);
    sqliteBlob = NULL;
    
    return blob;
}

- (RWSQLiteBlob *)openBlobWithDatabaseName:(NSString *)databaseName tableName:(NSString *)tableName columnName:(NSString *)columnName rowIdentifier:(SInt64)rowIdentifier options:(RWSQLiteBlobOpenOptions)options error:(NSError **)pError
{
    RWSQLiteBlob *blob = [self copyOpenBlobWithDatabaseName:databaseName tableName:tableName columnName:columnName rowIdentifier:rowIdentifier options:options error:pError];
    return blob;
}

#pragma mark - Conforming the NSObject Protocol

#pragma mark Identifying and Comparing Objects

- (BOOL)isEqual:(id)object
{
    BOOL isEqual = (mSqlite3 && object && [object isKindOfClass:[RWSQLite class]] && (mSqlite3 == ((RWSQLite *)object)->mSqlite3));
    return isEqual;
}

- (NSUInteger)hash
{
    NSUInteger hash = (NSUInteger)mSqlite3;
    return hash;
}

@end
