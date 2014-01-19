//
//  RWSQLiteFileOpenOptions.h
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
#import <Foundation/NSObjCRuntime.h>

// Importing the system headers.
#import <sqlite3.h>

typedef NS_OPTIONS(NSInteger, RWSQLiteFileOpenOptions)
{
    RWSQLiteFileOpenOptionReadonly          = SQLITE_OPEN_READONLY,         // 0x00000001  /* Ok for sqlite3_open_v2() */
    RWSQLiteFileOpenOptionReadWrite         = SQLITE_OPEN_READWRITE,        // 0x00000002  /* Ok for sqlite3_open_v2() */
    RWSQLiteFileOpenOptionCreate            = SQLITE_OPEN_CREATE,           // 0x00000004  /* Ok for sqlite3_open_v2() */
    RWSQLiteFileOpenOptionDeleteOnClose     = SQLITE_OPEN_DELETEONCLOSE,    // 0x00000008  /* VFS only */
    RWSQLiteFileOpenOptionExclusive         = SQLITE_OPEN_EXCLUSIVE,        // 0x00000010  /* VFS only */
    RWSQLiteFileOpenOptionAutoProxy         = SQLITE_OPEN_AUTOPROXY,        // 0x00000020  /* VFS only */
    RWSQLiteFileOpenOptionURI               = SQLITE_OPEN_URI,              // 0x00000040  /* Ok for sqlite3_open_v2() */
    RWSQLiteFileOpenOptionMainDatabase      = SQLITE_OPEN_MAIN_DB,          // 0x00000100  /* VFS only */
    RWSQLiteFileOpenOptionTemporaryDatabase = SQLITE_OPEN_TEMP_DB,          // 0x00000200  /* VFS only */
    RWSQLiteFileOpenOptionTransientDatabase = SQLITE_OPEN_TRANSIENT_DB,     // 0x00000400  /* VFS only */
    RWSQLiteFileOpenOptionMainJournal       = SQLITE_OPEN_MAIN_JOURNAL,     // 0x00000800  /* VFS only */
    RWSQLiteFileOpenOptionJournal           = SQLITE_OPEN_TEMP_JOURNAL,     // 0x00001000  /* VFS only */
    RWSQLiteFileOpenOptionSubJournal        = SQLITE_OPEN_SUBJOURNAL,       // 0x00002000  /* VFS only */
    RWSQLiteFileOpenOptionMasterJournal     = SQLITE_OPEN_MASTER_JOURNAL,   // 0x00004000  /* VFS only */
    RWSQLiteFileOpenOptionNoMutex           = SQLITE_OPEN_NOMUTEX,          // 0x00008000  /* Ok for sqlite3_open_v2() */
    RWSQLiteFileOpenOptionFullMutex         = SQLITE_OPEN_FULLMUTEX,        // 0x00010000  /* Ok for sqlite3_open_v2() */
    RWSQLiteFileOpenOptionSharedCache       = SQLITE_OPEN_SHAREDCACHE,      // 0x00020000  /* Ok for sqlite3_open_v2() */
    RWSQLiteFileOpenOptionPrivateCache      = SQLITE_OPEN_PRIVATECACHE,     // 0x00040000  /* Ok for sqlite3_open_v2() */
    RWSQLiteFileOpenOptionWAL               = SQLITE_OPEN_WAL,              // 0x00080000  /* VFS only */
    RWSQLiteFileOpenOptionFileProtectionComplete                             = SQLITE_OPEN_FILEPROTECTION_COMPLETE,                             // 0x00100000
    RWSQLiteFileOpenOptionFileProtectionCompleteUnlessOpen                   = SQLITE_OPEN_FILEPROTECTION_COMPLETEUNLESSOPEN,                   // 0x00200000
    RWSQLiteFileOpenOptionFileProtectionCompleteUntilFirstUserAuthentication = SQLITE_OPEN_FILEPROTECTION_COMPLETEUNTILFIRSTUSERAUTHENTICATION, // 0x00300000
    RWSQLiteFileOpenOptionFileProtectionNone                                 = SQLITE_OPEN_FILEPROTECTION_NONE,                                 // 0x00400000
    RWSQLiteFileOpenOptionFileProtectionMask                                 = SQLITE_OPEN_FILEPROTECTION_MASK                                  // 0x00700000
};
