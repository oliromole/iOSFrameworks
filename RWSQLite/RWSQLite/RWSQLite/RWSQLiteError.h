//
//  RWSQLiteError.h
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

// Importing the system headers.
#import <Foundation/NSError.h>
#import <Foundation/NSObjCRuntime.h>

// Importing the system headers.
#import <sqlite3.h>

@class NSString;

FOUNDATION_EXTERN NSString * const RWSQLiteResultCodeErrorDomain;

FOUNDATION_EXTERN NSString * const RWSQLiteExtendedResultCodeErrorKey; // NSNumber of NSInteger.

typedef NS_ENUM(NSInteger, RWSQLiteResultCode)
{
    RWSQLiteResultCodeSuccess = SQLITE_OK,            //   0   /* Successful result */
    
    RWSQLiteResultCodeError = SQLITE_ERROR,           //   1   /* SQL error or missing database */
    RWSQLiteResultCodeInternal = SQLITE_INTERNAL,     //   2   /* Internal logic error in SQLite */
    RWSQLiteResultCodePermission = SQLITE_PERM,       //   3   /* Access permission denied */
    RWSQLiteResultCodeAbort = SQLITE_ABORT,           //   4   /* Callback routine requested an abort */
    RWSQLiteResultCodeBusy = SQLITE_BUSY,             //   5   /* The database file is locked */
    RWSQLiteResultCodeLocked = SQLITE_LOCKED,         //   6   /* A table in the database is locked */
    RWSQLiteResultCodeNoMemory = SQLITE_NOMEM,        //   7   /* A malloc() failed */
    RWSQLiteResultCodeReadonly = SQLITE_READONLY,     //   8   /* Attempt to write a readonly database */
    RWSQLiteResultCodeInterrup = SQLITE_INTERRUPT,    //   9   /* Operation terminated by sqlite3_interrupt()*/
    RWSQLiteResultCodeIOError = SQLITE_IOERR,         //  10   /* Some kind of disk I/O error occurred */
    RWSQLiteResultCodeCorrup = SQLITE_CORRUPT,        //  11   /* The database disk image is malformed */
    RWSQLiteResultCodeNotFoun = SQLITE_NOTFOUND,      //  12   /* Unknown opcode in sqlite3_file_control() */
    RWSQLiteResultCodeFull = SQLITE_FULL,             //  13   /* Insertion failed because database is full */
    RWSQLiteResultCodeCanNotOpen = SQLITE_CANTOPEN,   //  14   /* Unable to open the database file */
    RWSQLiteResultCodeProtocol = SQLITE_PROTOCOL,     //  15   /* Database lock protocol error */
    RWSQLiteResultCodeEmpty = SQLITE_EMPTY,           //  16   /* Database is empty */
    RWSQLiteResultCodeSchema = SQLITE_SCHEMA,         //  17   /* The database schema changed */
    RWSQLiteResultCodeTooBig = SQLITE_TOOBIG,         //  18   /* String or BLOB exceeds size limit */
    RWSQLiteResultCodeConstraint = SQLITE_CONSTRAINT, //  19   /* Abort due to constraint violation */
    RWSQLiteResultCodeMismatch = SQLITE_MISMATCH,     //  20   /* Data type mismatch */
    RWSQLiteResultCodeMisuse = SQLITE_MISUSE,         //  21   /* Library used incorrectly */
    RWSQLiteResultCodeNoLFS = SQLITE_NOLFS,           //  22   /* Uses OS features not supported on host */
    RWSQLiteResultCodeAuthorization = SQLITE_AUTH,    //  23   /* Authorization denied */
    RWSQLiteResultCodeFormat = SQLITE_FORMAT,         //  24   /* Auxiliary database format error */
    RWSQLiteResultCodeRange = SQLITE_RANGE,           //  25   /* 2nd parameter to sqlite3_bind out of range */
    RWSQLiteResultCodeNotDatabase = SQLITE_NOTADB,    //  26   /* File opened that is not a database file */
    RWSQLiteResultCodeRow = SQLITE_ROW,               // 100  /* sqlite3_step() has another row ready */
    RWSQLiteResultCodeDone = SQLITE_DONE,             // 101  /* sqlite3_step() has finished executing */
    
    RWSQLiteExtendedResultCodeIOErrorRead                     = SQLITE_IOERR_READ,              // (SQLITE_IOERR | (1<<8))
    RWSQLiteExtendedResultCodeIOErrorShortRead                = SQLITE_IOERR_SHORT_READ,        // (SQLITE_IOERR | (2<<8))
    RWSQLiteExtendedResultCodeIOErrorWrite                    = SQLITE_IOERR_WRITE,             // (SQLITE_IOERR | (3<<8))
    RWSQLiteExtendedResultCodeIOErrorFileSynchronize          = SQLITE_IOERR_FSYNC,             // (SQLITE_IOERR | (4<<8))
    RWSQLiteExtendedResultCodeIOErrorDirectoryFileSynchronize = SQLITE_IOERR_DIR_FSYNC,         // (SQLITE_IOERR | (5<<8))
    RWSQLiteExtendedResultCodeIOErrorTruncate                 = SQLITE_IOERR_TRUNCATE,          // (SQLITE_IOERR | (6<<8))
    RWSQLiteExtendedResultCodeIOErrorFileStat                 = SQLITE_IOERR_FSTAT,             // (SQLITE_IOERR | (7<<8))
    RWSQLiteExtendedResultCodeIOErrorUnlock                   = SQLITE_IOERR_UNLOCK,            // (SQLITE_IOERR | (8<<8))
    RWSQLiteExtendedResultCodeIOErrorReadLock                 = SQLITE_IOERR_RDLOCK,            // (SQLITE_IOERR | (9<<8))
    RWSQLiteExtendedResultCodeIOErrorDelete                   = SQLITE_IOERR_DELETE,            // (SQLITE_IOERR | (10<<8))
    RWSQLiteExtendedResultCodeIOErrorBlocked                  = SQLITE_IOERR_BLOCKED,           // (SQLITE_IOERR | (11<<8))
    RWSQLiteExtendedResultCodeIOErrorNoMemory                 = SQLITE_IOERR_NOMEM,             // (SQLITE_IOERR | (12<<8))
    RWSQLiteExtendedResultCodeIOErrorAccess                   = SQLITE_IOERR_ACCESS,            // (SQLITE_IOERR | (13<<8))
    RWSQLiteExtendedResultCodeIOErrorCheckReservedLock        = SQLITE_IOERR_CHECKRESERVEDLOCK, // (SQLITE_IOERR | (14<<8))
    RWSQLiteExtendedResultCodeIOErrorLock                     = SQLITE_IOERR_LOCK,              // (SQLITE_IOERR | (15<<8))
    RWSQLiteExtendedResultCodeIOErrorClose                    = SQLITE_IOERR_CLOSE,             // (SQLITE_IOERR | (16<<8))
    RWSQLiteExtendedResultCodeIOErrorDirectoryClose           = SQLITE_IOERR_DIR_CLOSE,         // (SQLITE_IOERR | (17<<8))
    RWSQLiteExtendedResultCodeIOErrorSharedMemoryOpen         = SQLITE_IOERR_SHMOPEN,           // (SQLITE_IOERR | (18<<8))
    RWSQLiteExtendedResultCodeIOErrorSharedMemorySize         = SQLITE_IOERR_SHMSIZE,           // (SQLITE_IOERR | (19<<8))
    RWSQLiteExtendedResultCodeIOErrorSharedMemoryLock         = SQLITE_IOERR_SHMLOCK,           // (SQLITE_IOERR | (20<<8))
    RWSQLiteExtendedResultCodeIOErrorSharedMemoryMap          = SQLITE_IOERR_SHMMAP,            // (SQLITE_IOERR | (21<<8))
    RWSQLiteExtendedResultCodeIOErrorSeek                     = SQLITE_IOERR_SEEK,              // (SQLITE_IOERR | (22<<8))
    RWSQLiteExtendedResultCodeSharedCach                      = SQLITE_LOCKED_SHAREDCACHE,      // (SQLITE_LOCKED |  (1<<8))
    RWSQLiteExtendedResultCodeBusyRecovery                    = SQLITE_BUSY_RECOVERY,           // (SQLITE_BUSY   |  (1<<8))
    RWSQLiteExtendedResultCodeCanNotOpenNoTemporaryDirectory  = SQLITE_CANTOPEN_NOTEMPDIR,      // (SQLITE_CANTOPEN | (1<<8))
    RWSQLiteExtendedResultCodeCorruptVirtualTable             = SQLITE_CORRUPT_VTAB,            // (SQLITE_CORRUPT | (1<<8))
    RWSQLiteExtendedResultCodeReadOnlyRecovery                = SQLITE_READONLY_RECOVERY,       // (SQLITE_READONLY | (1<<8))
    RWSQLiteExtendedResultCodeReadOnlyCanNotLock              = SQLITE_READONLY_CANTLOCK        // (SQLITE_READONLY | (2<<8))
};

#define RWSQLiteExtendedResultCodeGetResultCode(extendedResultCode) ((RWSQLiteResultCode)(extendedResultCode & (0x000000FF)))
#define RWSQLiteResultCodeIsExtendedResultCode(resultCodeOrExtendedResultCode) ((resultCodeOrExtendedResultCode) != ((resultCodeOrExtendedResultCode) & (0x000000FF)))

FOUNDATION_EXTERN NSError *RWSQLiteNSErrorCreate(RWSQLiteResultCode resultCode, RWSQLiteResultCode extendedResultCode, NSString *errorMessage);
FOUNDATION_EXTERN NSError *RWSQLiteNSErrorCreateWithSqlite(sqlite3 *sqlite);
FOUNDATION_EXTERN NSError *RWSQLiteNSErrorCreateWithSqliteAndResultCode(sqlite3 *sqlite, RWSQLiteResultCode resultCodeOrExtendedResultCode);

FOUNDATION_EXTERN NSString * const RWSQLiteErrorDomain;
FOUNDATION_EXTERN NSError * RWSQLiteNoMemoryError;

FOUNDATION_EXTERN NSString * const RWSQLiteCommandErrorKey;

typedef enum RWSQLiteErrorCode
{
    RWSQLiteErrorCodeSuccess                = 0,
    RWSQLiteErrorCodeSQLiteResultCode       = 1,
    RWSQLiteErrorCodeNoMemory               = 2,
    RWSQLiteErrorCodeMissingSqlite          = 3,
    RWSQLiteErrorCodeMissingSqliteMutex     = 4,
    RWSQLiteErrorCodeMissingSqliteStatement = 5,
} RWSQLiteErrorCode;

@interface NSError (NSErrorRWSQLiteError)

@end
