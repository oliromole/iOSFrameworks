//
//  RWSQLiteMutex.m
//  RWSQLite
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.07.18.
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
#import "RWSQLiteMutex.h"

// Importing the project headers.
#import "RWSQLiteError.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RWSQLiteMutex

#pragma mark - Initializing and Creating a RWSQLiteStatement

- (id)init
{
    self = [super init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    mNeedsFree = NO;
    mSqlite3_mutex = nil;
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)liteMutex
{
    return [[self alloc] init];
}

- (id)initWithMutexType:(RWSQLiteMutexType)mutexType
{
    BOOL           needsFree = NO;
    sqlite3_mutex *sqliteMutex = NULL;
    
    if (!RWSQLiteMutexTypeIsValid(mutexType))
    {
        goto jmp_error;
    }
    
    sqliteMutex = sqlite3_mutex_alloc((int)mutexType);
    
    if (!sqliteMutex)
    {
        goto jmp_error;
    }
    
    needsFree = !RWSQLiteMutexTypeIsStatic(mutexType);
    
    self = [self initWithSqliteMutex:sqliteMutex needsFree:needsFree];
    
    if (self)
    {
        sqliteMutex = NULL;
    }
    
    else
    {
        goto jmp_error;
    }
    
    sqlite3_mutex_free(sqliteMutex);
    sqliteMutex = NULL;
    
    return self;
    
jmp_error:
    
    sqlite3_mutex_free(sqliteMutex);
    sqliteMutex = NULL;
    
    self = nil;
    
    return self;
}

+ (id)liteMutexWithMutexType:(RWSQLiteMutexType)mutexType
{
    return [[self alloc] initWithMutexType:mutexType];
}

- (id)initWithSqliteMutex:(sqlite3_mutex *)sqliteMutex
{
    return [self initWithSqliteMutex:sqliteMutex needsFree:YES];
}

+ (id)liteMutexWithSqliteMutex:(sqlite3_mutex *)sqliteMutex
{
    return [[self alloc] initWithSqliteMutex:sqliteMutex];
}

- (id)initWithSqliteMutex:(sqlite3_mutex *)sqliteMutex needsFree:(BOOL)needsFree
{
    self = [self init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    [self setSqlite3_mutex:sqliteMutex needsFree:needsFree];
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)liteMutexWithSqliteMutex:(sqlite3_mutex *)sqliteMutex needsFree:(BOOL)needsFree
{
    return [[self alloc] initWithSqliteMutex:sqliteMutex needsFree:needsFree];
}

#pragma mark - Deallocating a RWSQLiteMutex

- (void)dealloc
{
    if (mNeedsFree)
    {
        sqlite3_mutex_free(mSqlite3_mutex);
        mSqlite3_mutex = NULL;
    }
}

#pragma mark - Managing the sqlite3_stmt

@synthesize needsFree = mNeedsFree;

- (sqlite3_mutex *)sqlite3_mutex
{
    return mSqlite3_mutex;
}

- (void)setSqlite3_mutex:(sqlite3_mutex *)sqlite3_mutex
{
    [self setSqlite3_mutex:sqlite3_mutex needsFree:YES];
}

- (void)setSqlite3_mutex:(sqlite3_mutex *)sqlite3_mutex needsFree:(BOOL)needsFree
{
    if (mSqlite3_mutex != sqlite3_mutex)
    {
        mNeedsFree = needsFree;
        mSqlite3_mutex = sqlite3_mutex;
    }
}

#pragma mark - Entering and Trying and Leaving the Mutex

- (void)enter
{
    if (mSqlite3_mutex)
    {
        sqlite3_mutex_enter(mSqlite3_mutex);
    }
}

- (BOOL)try
{
    BOOL entered = NO;
    
    if (mSqlite3_mutex)
    {
        RWSQLiteResultCode resultCodeOrExtendedResultCode = (RWSQLiteResultCode)sqlite3_mutex_try(mSqlite3_mutex);
        RWSQLiteResultCode resultCode = RWSQLiteExtendedResultCodeGetResultCode(resultCodeOrExtendedResultCode);
        
        entered = (resultCode == RWSQLiteResultCodeSuccess);
    }
    
    return entered;
}

- (void)leave
{
    if (mSqlite3_mutex)
    {
        sqlite3_mutex_leave(mSqlite3_mutex);
    }
}

#pragma mark - Conforming the NSObject Protocol

#pragma mark Identifying and Comparing Objects

- (BOOL)isEqual:(id)object
{
    BOOL isEqual = (mSqlite3_mutex && object && [object isKindOfClass:[RWSQLiteMutex class]] && (mSqlite3_mutex == ((RWSQLiteMutex *)object)->mSqlite3_mutex));
    return isEqual;
}

- (NSUInteger)hash
{
    NSUInteger hash = (NSUInteger)mSqlite3_mutex;
    return hash;
}

@end
