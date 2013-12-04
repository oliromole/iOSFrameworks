//
//  RWSQLite-1.h
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

// Importing the project headers.
#import "RWSQLiteFileOpenOperations.h"
#import "RWSQLiteLibraryThreadsafeMode.h"
#import "RWSQLiteStringEncoding.h"

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>

// Importing the system headers.
#import <sqlite3.h>

@class NSDictionary;
@class NSError;
@class NSMutableArray;
@class NSString;
@class NSURL;

@class RWSQLiteMutex;
@class RWSQLiteStatement;

@interface RWSQLite : NSObject
{
@protected
    
    sqlite3                *mSqlite3;
    RWSQLiteStringEncoding  mStringEncoding;
}

// Initaliazing and Creating a RWSQLite

+ (id)lite;
- (id)initWithSqlite3:(sqlite3 *)sqlite3;
+ (id)liteWithSqlite3:(sqlite3 *)sqlite3;
- (id)initWithContentsOfFile:(NSString *)path fileOpenOperations:(RWSQLiteFileOpenOperations)fileOpenOperations virtualFileSystem:(NSString *)virtualFileSystem error:(NSError **)error;
+ (id)liteWithContentsOfFile:(NSString *)path fileOpenOperations:(RWSQLiteFileOpenOperations)fileOpenOperations virtualFileSystem:(NSString *)virtualFileSystem error:(NSError **)error;
- (id)initWithContentsOfURL:(NSURL *)url fileOpenOperations:(RWSQLiteFileOpenOperations)fileOpenOperations virtualFileSystem:(NSString *)virtualFileSystem error:(NSError **)error;
+ (id)liteWithContentsOfURL:(NSURL *)url fileOpenOperations:(RWSQLiteFileOpenOperations)fileOpenOperations virtualFileSystem:(NSString *)virtualFileSystem error:(NSError **)error;

// Configuring The SQLite Library

+ (RWSQLiteLibraryThreadsafeMode)threadsafeMode;
+ (BOOL)setThreadsafeMode:(RWSQLiteLibraryThreadsafeMode)threadsafeMode;

// Managing the sqlite3

@property (nonatomic, readonly) sqlite3 *sqlite3;
- (void)setSqlite3:(sqlite3 *)sqlite3;

@property (nonatomic) RWSQLiteStringEncoding stringEncoding;

// Configuring the SQLite Object

- (BOOL)setBusyTimeout:(NSInteger)milliseconds error:(NSError **)error;

- (BOOL)recursiveTriggerError:(NSError **)error;
- (BOOL)setRecursiveTrigger:(BOOL)recursiveTrigger error:(NSError **)error;

// Configuring the Limits

- (NSInteger)limitLengthError:(NSError **)error;
- (NSInteger)setLimitLength:(NSInteger)limitLength error:(NSError **)error;

- (NSInteger)limitSQLLengthError:(NSError **)error;
- (NSInteger)setLimitSQLLength:(NSInteger)limitSQLLength error:(NSError **)error;

- (NSInteger)limitColumnError:(NSError **)error;
- (NSInteger)setLimitColumn:(NSInteger)limitColumn error:(NSError **)error;

- (NSInteger)limitExpressionDepthError:(NSError **)error;
- (NSInteger)setLimitExpressionDepth:(NSInteger)limitExpressionDepth error:(NSError **)error;

- (NSInteger)limitCompoundSelectError:(NSError **)error;
- (NSInteger)setLimitCompoundSelect:(NSInteger)limitCompoundSelect error:(NSError **)error;

- (NSInteger)limitVDBEOPError:(NSError **)error;
- (NSInteger)setLimitVDBEOP:(NSInteger)limitVDBEOP error:(NSError **)error;

- (NSInteger)limitFunctionArgumentsError:(NSError **)error;
- (NSInteger)setLimitFunctionArguments:(NSInteger)limitFunctionArguments error:(NSError **)error;

- (NSInteger)limitAttachedError:(NSError **)error;
- (NSInteger)setLimitAttached:(NSInteger)limitAttached error:(NSError **)error;

- (NSInteger)limitLikePatternLengthError:(NSError **)error;
- (NSInteger)setLimitLikePatternLength:(NSInteger)limitLikePatternLength error:(NSError **)error;

- (NSInteger)limitVariableNumberError:(NSError **)error;
- (NSInteger)setLimitVariableNumber:(NSInteger)limitVariableNumber error:(NSError **)error;

- (NSInteger)limitTriggerDepthError:(NSError **)error;
- (NSInteger)setLimitTriggerDepth:(NSInteger)limitTriggerDepth error:(NSError **)error;

// Closing A Database Connection

- (BOOL)closeError:(NSError **)error;

// Getting the Last Error

- (NSError *)copyLastError;
@property (nonatomic, readonly) NSError *lastError;

// Getting the Last Insert Rowid

@property (nonatomic, readonly) SInt64 lastInsertRowIdentifier;

// Getting the Number of Rows Changed

@property (nonatomic, readonly) NSInteger numberOfChangedRows;

// Getting the Total of Rows Changed

@property (nonatomic, readonly) NSInteger totalOfChangedRows;

// Interrupting A Long-Running Query

- (void)interrupt;

// Creating the Statement

- (RWSQLiteStatement *)copyStatementWithCommand:(NSString *)command error:(NSError **)error;
- (RWSQLiteStatement *)statementWithCommand:(NSString *)command error:(NSError **)error;

// Retrieving the Mutex for the Database Connection
- (RWSQLiteMutex *)copyMutex;
@property (nonatomic, readonly) RWSQLiteMutex *mutex;

// Beginning, Committing, Rollbacking the Transaction.

- (BOOL)beginTransactionError:(NSError **)error;
- (BOOL)beginDeferredTransactionError:(NSError **)error;
- (BOOL)beginImmediateTransactionError:(NSError **)error;
- (BOOL)beginExclusiveTransactionError:(NSError **)error;

- (BOOL)commitTransactionError:(NSError **)error;
- (BOOL)endTransactionError:(NSError **)error;

- (BOOL)rollbackTransactionError:(NSError **)error;
- (BOOL)rollbackTransactionToSavepoint:(NSString *)savepoint error:(NSError **)error;

- (BOOL)savepoint:(NSString *)savepoint error:(NSError **)error;

- (BOOL)releaseSavepoint:(NSString *)savepoint error:(NSError **)error;

// Executing the SQL Command

- (BOOL)executeNonQueryWithCommand:(NSString *)command bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (id)copyExecuteScalarWithCommand:(NSString *)command bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (id)executeScalarWithCommand:(NSString *)command bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (NSMutableArray *)copyExecuteWithCommand:(NSString *)command bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (NSMutableArray *)executeWithCommand:(NSString *)command bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (BOOL)executeWithCommand:(NSString *)command bindValues:(NSDictionary *)bindValues enumerateRowsUsingBlock:(void (^)(NSDictionary *values, NSUInteger index, BOOL *stop))block error:(NSError **)error;

- (BOOL)executeNonQueryWithCommand:(NSString *)command bindObject:(id)bindObject error:(NSError **)error;
- (id)copyExecuteScalarWithCommand:(NSString *)command class:(Class)cls bindObject:(id)bindObject error:(NSError **)error;
- (id)executeScalarWithCommand:(NSString *)command class:(Class)cls bindObject:(id)bindObject error:(NSError **)error;
- (NSMutableArray *)copyExecuteWithCommand:(NSString *)command class:(Class)cls bindObject:(id)bindObject error:(NSError **)error;
- (NSMutableArray *)executeWithCommand:(NSString *)command class:(Class)cls bindObject:(id)bindObject error:(NSError **)error;
- (BOOL)executeWithCommand:(NSString *)command class:(Class)cls bindObject:(id)bindObject enumerateRowsUsingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))block error:(NSError **)error;

- (id)copyExecuteScalarWithCommand:(NSString *)command class:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (id)executeScalarWithCommand:(NSString *)command class:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (NSMutableArray *)copyExecuteWithCommand:(NSString *)command class:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (NSMutableArray *)executeWithCommand:(NSString *)command class:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (BOOL)executeWithCommand:(NSString *)command class:(Class)cls bindValues:(NSDictionary *)bindValues enumerateRowsUsingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))block error:(NSError **)error;

@end
