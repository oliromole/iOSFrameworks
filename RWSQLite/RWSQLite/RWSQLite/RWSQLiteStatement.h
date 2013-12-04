//
//  RWSQLiteStatement.h
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

// Importing the project headers.
#import "RWSQLiteDataType.h"
#import "RWSQLiteError.h"
#import "RWSQLiteStringEncoding.h"

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>

// Importing the system headers.
#import <sqlite3.h>

@class NSData;
@class NSDictionary;
@class NSError;
@class NSMutableArray;
@class NSMutableDictionary;
@class NSNumber;
@class NSString;

@interface RWSQLiteStatement : NSObject
{
@protected
    
    sqlite3_stmt           *mSqlite3_stmt;
    RWSQLiteStringEncoding  mStringEncoding;
}

// Initializing and Creating a RWSQLiteStatement

+ (id)liteStatement;
- (id)initWithSqliteStatement:(sqlite3_stmt *)sqliteStatement;
+ (id)liteStatementWithSqliteStatement:(sqlite3_stmt *)sqliteStatement;

// Managing the sqlite3_stmt

@property (nonatomic, readonly) sqlite3_stmt *sqlite3_stmt;
- (void)setSqlite3_stmt:(sqlite3_stmt *)sqlite3_stmt;

@property (nonatomic) RWSQLiteStringEncoding stringEncoding;

// Retrieving Statement SQL

- (NSString *)copyCommand;
@property (nonatomic, readonly) NSString *command;

// Determining if an SQL Statement Writes the Database

@property (nonatomic, readonly) BOOL isReadonly;

// Binding Values To Prepared Statements

- (BOOL)bindData:(NSData *)aData atIndex:(NSUInteger)index copied:(BOOL)copied error:(NSError **)error;
- (BOOL)bindData:(NSData *)aData forName:(NSString *)name copied:(BOOL)copied error:(NSError **)error;
- (BOOL)bindDouble:(double)aDouble atIndex:(NSUInteger)index error:(NSError **)error;
- (BOOL)bindDouble:(double)aDouble forName:(NSString *)name error:(NSError **)error;
- (BOOL)bindInt:(int)anInt atIndex:(NSUInteger)index error:(NSError **)error;
- (BOOL)bindInt:(int)anInt forName:(NSString *)name error:(NSError **)error;
- (BOOL)bindInt64:(SInt64)anInt64 atIndex:(NSUInteger)index error:(NSError **)error;
- (BOOL)bindInt64:(SInt64)anInt64 forName:(NSString *)name error:(NSError **)error;
- (BOOL)bindNullAtIndex:(NSUInteger)index error:(NSError **)error;
- (BOOL)bindNullForName:(NSString *)name error:(NSError **)error;
- (BOOL)bindString:(NSString *)aString atIndex:(NSUInteger)index error:(NSError **)error;
- (BOOL)bindString:(NSString *)aString forName:(NSString *)name error:(NSError **)error;
- (BOOL)bindZeroDataAtIndex:(NSUInteger)index length:(NSUInteger)length error:(NSError **)error;
- (BOOL)bindZeroDataForName:(NSString *)name length:(NSUInteger)length error:(NSError **)error;

- (BOOL)bindNumber:(NSNumber *)number atIndex:(NSUInteger)index error:(NSError **)error;
- (BOOL)bindNumber:(NSNumber *)number forName:(NSString *)name error:(NSError **)error;
- (BOOL)bindObject:(id)object atIndex:(NSUInteger)index copied:(BOOL)copied error:(NSError **)error;
- (BOOL)bindObject:(id)object forName:(NSString *)name copied:(BOOL)copied error:(NSError **)error;

- (BOOL)bindValues:(NSDictionary *)values copied:(BOOL)copied error:(NSError **)error;

- (BOOL)bindObject:(id)bindObject copied:(BOOL)copied error:(NSError **)error;

// Getting Data Binding

// Getting a Number of SQL Parameters
- (NSUInteger)bindCount;

// Name of a Host Parameter
- (NSString *)copyBindNameAtIndex:(NSUInteger)atIndex;
- (NSString *)bindNameAtIndex:(NSUInteger)atIndex;

// Getting Index of a Parameter with a Given Name
- (NSUInteger)bindIndexFromName:(NSString *)aName;

// Resetting All Bindings on a Prepared Statement

- (BOOL)clearBindingsError:(NSError **)error;

// Getting Result Data

// Getting Number of Columns in a Result Set
- (NSUInteger)columnCount;

// Getting Column Names in a Result Set
- (NSString *)copyColumnNameAtIndex:(NSUInteger)atIndex error:(NSError **)error;
- (NSString *)columnNameAtIndex:(NSUInteger)atIndex error:(NSError **)error;

// Getting Declared Datatype of a Query Result
- (NSString *)copyColumnDecltypeNameAtIndex:(NSUInteger)atIndex;
- (NSString *)columnDecltypeTableNameAtIndex:(NSUInteger)atIndex;

// Evaluating An SQL Statement

- (RWSQLiteResultCode)stepError:(NSError **)error;

// Getting Number of Columns in a Result Set in the Current Row
- (NSUInteger)dataCount;

// Getting Result Values from a Query
- (NSData *)copyDataAtIndex:(NSUInteger)index error:(NSError **)error;
- (NSData *)dataAtIndex:(NSUInteger)index error:(NSError **)error;
- (double)doubleAtIndex:(NSUInteger)index error:(NSError **)error;
- (int)intAtIndex:(NSUInteger)index error:(NSError **)error;
- (SInt64)int64AtIndex:(NSUInteger)index error:(NSError **)error;
- (NSString *)copyStringAtIndex:(NSUInteger)index error:(NSError **)error;
- (NSString *)stringAtIndex:(NSUInteger)index error:(NSError **)error;
- (RWSQLiteDataType)dataTypeAtIndex:(NSUInteger)index error:(NSError **)error;

- (NSNumber *)copyNumberAtIndex:(NSUInteger)index error:(NSError **)error;
- (NSNumber *)numberAtIndex:(NSUInteger)index error:(NSError **)error;
- (id)copyObjectAtIndex:(NSUInteger)index error:(NSError **)error;
- (id)objectAtIndex:(NSUInteger)index error:(NSError **)error;

- (NSMutableDictionary *)copyValuesError:(NSError **)error;
- (NSMutableDictionary *)valuesError:(NSError **)error;

- (id)copyObjectClass:(Class)cls error:(NSError **)error;
- (id)objectClass:(Class)cls error:(NSError **)error;

// Destroying a Prepared Statement Object
- (BOOL)finalizeStatementError:(NSError **)error;

// Resetting a Prepared Statement Object
- (BOOL)resetError:(NSError **)error;

// Executing the SQL Statement
- (BOOL)executeNonQueryWithBindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (id)copyExecuteScalarWithBindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (id)executeScalarWithBindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (NSMutableArray *)copyExecuteWithBindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (NSMutableArray *)executeWithBindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (BOOL)executeWithBindValues:(NSDictionary *)bindValues enumerateRowsUsingBlock:(void (^)(NSDictionary *values, NSUInteger index, BOOL *stop))block error:(NSError **)error;

- (BOOL)executeNonQueryWithBindObject:(id)bindObject error:(NSError **)error;
- (id)copyExecuteScalarWithClass:(Class)cls bindObject:(id)bindObject error:(NSError **)error;
- (id)executeScalarWithClass:(Class)cls bindObject:(id)bindObject error:(NSError **)error;
- (NSMutableArray *)copyExecuteWithClass:(Class)cls bindObject:(id)bindObject error:(NSError **)error;
- (NSMutableArray *)executeWithClass:(Class)cls bindObject:(id)bindObject error:(NSError **)error;
- (BOOL)executeWithClass:(Class)cls bindObject:(id)bindObject enumerateRowsUsingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))block error:(NSError **)error;

- (id)copyExecuteScalarWithClass:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (id)executeScalarWithClass:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (NSMutableArray *)copyExecuteWithClass:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (NSMutableArray *)executeWithClass:(Class)cls bindValues:(NSDictionary *)bindValues error:(NSError **)error;
- (BOOL)executeWithClass:(Class)cls bindValues:(NSDictionary *)bindValues enumerateRowsUsingBlock:(void (^)(id object, NSUInteger index, BOOL *stop))block error:(NSError **)error;

@end
