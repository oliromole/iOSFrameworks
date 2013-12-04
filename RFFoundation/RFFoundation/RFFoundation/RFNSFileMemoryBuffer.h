//
//  RFNSFileMemoryBuffer.h
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.01.12.
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
#import "RFNSFoundationError.h"

// Importing the system headers.
#import <Foundation/NSObject.h>

@class NSError;
@class NSString;
@class NSURL;

// Error codes
enum
{
    RFNSFileMemoryBufferErrorCodeUnknown  = RFNSFoundationErrorCodeFileMemoryBufferComponent | (0 << 8),
    RFNSFileMemoryBufferErrorLowMemory    = RFNSFoundationErrorCodeFileMemoryBufferComponent | (1 << 8),
    RFNSFileMemoryBufferErrorOpenFile     = RFNSFoundationErrorCodeFileMemoryBufferComponent | (2 << 8),
    RFNSFileMemoryBufferErrorReadFile     = RFNSFoundationErrorCodeFileMemoryBufferComponent | (3 << 8),
    RFNSFileMemoryBufferErrorWriteFile    = RFNSFoundationErrorCodeFileMemoryBufferComponent | (4 << 8),
    RFNSFileMemoryBufferErrorSeekFile     = RFNSFoundationErrorCodeFileMemoryBufferComponent | (5 << 8),
    RFNSFileMemoryBufferErrorTruncateFile = RFNSFoundationErrorCodeFileMemoryBufferComponent | (6 << 8),
};

/*
 * maxMemorySize is defaul 512 KBytes.
 * maxMemorySize is minimum 1 KByte.
 *
 * See also:
 *
 * https://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/man2/open.2.html
 * https://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/man3/perror.3.html
 * http://pubs.opengroup.org/onlinepubs/009695399/basedefs/unistd.h.html
 * http://www.cplusplus.com/reference/cerrno/errno/
 */
@interface RFNSFileMemoryBuffer : NSObject
{
@protected
    
    NSError    *mError;
    int         mFileHandle;
    NSString   *mFilePath;
    NSURL      *mFileURL;
    BOOL        mIsMemoryUsed;
    NSUInteger  mMaxMemorySize;
    uint8_t    *mBuffer;
    NSUInteger  mBufferCapacity;
    NSUInteger  mBufferLength;
}

// Initializing and Creating a RFNSFileMemoryBuffer

+ (id)fileMemoryBuffer;

- (id)initWithFilePath:(NSString *)filePath maxMemorySize:(NSUInteger)maxMemorySize;
+ (id)fileMemoryBufferWithFilePath:(NSString *)filePath maxMemorySize:(NSUInteger)maxMemorySize;

- (id)initWithFileURL:(NSURL *)fileURL maxMemorySize:(NSUInteger)maxMemorySize;
+ (id)fileMemoryBufferWithFileURL:(NSURL *)fileURL maxMemorySize:(NSUInteger)maxMemorySize;

// Accessing the RFNSFileMemoryBuffer Object

@property (nonatomic, readonly) NSError           *error;
@property (nonatomic, readonly) NSString          *filePath;
@property (nonatomic, readonly) NSURL             *fileURL;
@property (nonatomic, readonly) BOOL               hasError;
@property (nonatomic, readonly) BOOL               isMemoryUsed;
@property (nonatomic, readonly) unsigned long long length; // The property returns -1ll if we have an error.
@property (nonatomic, readonly) NSUInteger         maxMemorySize;

// Truncating the Length

// The method returns -1ll if we have an error.
- (long long)truncateToLength:(unsigned long long)length;

// Reading Data

// The method returns -1 if we have an error.
- (NSInteger)readBuffer:(void *)buffer offset:(unsigned long long)offset maxLength:(NSUInteger)maxLength;

// Writing Data

// The method returns -1 if we have an error.
- (NSInteger)writeBuffer:(const void *)buffer offset:(unsigned long long)offset length:(NSUInteger)length;

@end
