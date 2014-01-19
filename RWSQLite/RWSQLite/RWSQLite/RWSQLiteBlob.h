//
//  RWSQLiteBlob.h
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

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>

// Importing the system headers.
#import <sqlite3.h>

@class NSError;
@class NSData;
@class NSMutableData;

@class RWSQLite;

@interface RWSQLiteBlob : NSObject
{
@protected
    
    sqlite3_blob *mSqlite3_blob;
}

// Initializing and Creating a RWSQLiteBlob

+ (id)liteBlob;
- (id)initWithSqliteBlob:(sqlite3_blob *)sqliteBlob;
+ (id)liteBlobWithSqliteBlob:(sqlite3_blob *)sqliteBlob;

// Managing the sqlite3_blob

@property (nonatomic, readonly) sqlite3_blob *sqlite3_blob;
- (void)setSqlite3_blob:(sqlite3_blob *)sqlite3_blob;

// Reopening the Blob Object

- (BOOL)reopenWithRowIdentifier:(SInt64)rowIdentifier error:(NSError **)error;

// Closing the Blob Object

- (BOOL)closeError:(NSError **)error;

// Testing Data

- (NSUInteger)lengthError:(NSError **)error;

// Reading the Data

- (NSMutableData *)copyReadDataLenght:(NSUInteger)length offset:(NSUInteger)offset error:(NSError **)error;
- (NSMutableData *)readDataLenght:(NSUInteger)length offset:(NSUInteger)offset error:(NSError **)error;

// Writing the Data

- (BOOL)writeData:(NSData *)data offset:(NSUInteger)offset error:(NSError **)error;

@end
