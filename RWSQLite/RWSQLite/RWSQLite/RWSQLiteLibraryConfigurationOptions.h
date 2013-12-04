//
//  RWSQLiteLibraryConfigurationOptions.h
//  RWSQLite
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.08.22.
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

typedef enum RWSQLiteLibraryConfigurationOptions
{
    RWSQLiteLibraryConfigurationOptionSingleThread = SQLITE_CONFIG_SINGLETHREAD, //  1  /* nil */
    RWSQLiteLibraryConfigurationOptionMultiThread  = SQLITE_CONFIG_MULTITHREAD,  //  2  /* nil */
    RWSQLiteLibraryConfigurationOptionSerialized   = SQLITE_CONFIG_SERIALIZED,   //  3  /* nil */
    RWSQLiteLibraryConfigurationOptionMalloc       = SQLITE_CONFIG_MALLOC,       //  4  /* sqlite3_mem_methods* */
    RWSQLiteLibraryConfigurationOptionGetMalloc    = SQLITE_CONFIG_GETMALLOC,    //  5  /* sqlite3_mem_methods* */
    RWSQLiteLibraryConfigurationOptionScratch      = SQLITE_CONFIG_SCRATCH,      //  6  /* void*, int sz, int N */
    RWSQLiteLibraryConfigurationOptionPageCache    = SQLITE_CONFIG_PAGECACHE,    //  7  /* void*, int sz, int N */
    RWSQLiteLibraryConfigurationOptionHeap         = SQLITE_CONFIG_HEAP,         //  8  /* void*, int nByte, int min */
    RWSQLiteLibraryConfigurationOptionMemoryStatus = SQLITE_CONFIG_MEMSTATUS,    //  9  /* boolean */
    RWSQLiteLibraryConfigurationOptionMutex        = SQLITE_CONFIG_MUTEX,        // 10  /* sqlite3_mutex_methods* */
    RWSQLiteLibraryConfigurationOptionGetMutex     = SQLITE_CONFIG_GETMUTEX,     // 11  /* sqlite3_mutex_methods* */
    //  RWSQLiteLibraryConfigurationOptionChunkAlloc   = SQLITE_CONFIG_CHUNKALLOC,   // 12  /* previously SQLITE_CONFIG_CHUNKALLOC which is now unused. */
    RWSQLiteLibraryConfigurationOptionLookaside    = SQLITE_CONFIG_LOOKASIDE,    // 13  /* int int */
    RWSQLiteLibraryConfigurationOptionPCache       = SQLITE_CONFIG_PCACHE,       // 14  /* sqlite3_pcache_methods* */
    RWSQLiteLibraryConfigurationOptionGetPCache    = SQLITE_CONFIG_GETPCACHE,    // 15  /* sqlite3_pcache_methods* */
    RWSQLiteLibraryConfigurationOptionLog          = SQLITE_CONFIG_LOG,          // 16  /* xFunc, void* */
    RWSQLiteLibraryConfigurationOptionURI          = SQLITE_CONFIG_URI,          // 17  /* int */
} RWSQLiteLibraryConfigurationOptions;
