//
//  RFNSFileMemoryBuffer.m
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

// Importing the header.
#import "RFNSFileMemoryBuffer.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>
#import <RWUUID/RWUUID.h>

// Importing the system headers.
#import <Foundation/Foundation.h>

#define RFNS_FILE_MEMORY_BUFFER_MAX_MEMORY_SIZE_DEFAULT (512 * 1024)
#define RFNS_FILE_MEMORY_BUFFER_MAX_MEMORY_SIZE_MINIMUM (1 * 1024)
#define RFNS_FILE_MEMORY_MOVE_DATA_FROM_FILE_TO_BUFFER_MEMORY_SIZE (1 * 1024 * 1024)

@implementation RFNSFileMemoryBuffer

#pragma mark - Initializing and Creating a RFNSFileMemoryBuffer

- (id)init
{
    if ((self = [self initWithFilePath:nil maxMemorySize:0]))
    {
    }
    
    return nil;
}

+ (id)fileMemoryBuffer
{
    return [[self alloc] init];
}

- (id)initWithFilePath:(NSString *)filePath maxMemorySize:(NSUInteger)maxMemorySize
{
    if ((self = [super init]))
    {
        mError = nil;
        
        mFileHandle = 0;
        
        if (filePath.length == 0)
        {
            NSString *temporaryDirectory = NSTemporaryDirectory();
            RWUUID *fileUUID = [[RWUUID alloc] initWithGenerateTime];
            
            mFilePath = [temporaryDirectory stringByAppendingPathComponent:[@"FileMemoryBuffer-" stringByAppendingString:[fileUUID uppercaseString]]];
        }
        
        else
        {
            mFilePath = [filePath copy];
        }
        
        mFileURL = nil;
        
        mIsMemoryUsed = YES;
        
        mMaxMemorySize = ((maxMemorySize == 0) ? RFNS_FILE_MEMORY_BUFFER_MAX_MEMORY_SIZE_DEFAULT : maxMemorySize);
        mMaxMemorySize = ((mMaxMemorySize < RFNS_FILE_MEMORY_BUFFER_MAX_MEMORY_SIZE_MINIMUM) ? RFNS_FILE_MEMORY_BUFFER_MAX_MEMORY_SIZE_MINIMUM : mMaxMemorySize);
        
        mBuffer = NULL;
        mBufferCapacity = 0;
        mBufferLength = 0;
    }
    
    return self;
}

+ (id)fileMemoryBufferWithFilePath:(NSString *)filePath maxMemorySize:(NSUInteger)maxMemorySize
{
    return [[self alloc] initWithFilePath:filePath maxMemorySize:maxMemorySize];
}

- (id)initWithFileURL:(NSURL *)fileURL maxMemorySize:(NSUInteger)maxMemorySize
{
    if ((self = [super init]))
    {
        mError = nil;
        
        mFileHandle = 0;
        
        mFilePath = nil;
        
        if (fileURL.isFileURL)
        {
            mFileURL = [fileURL absoluteURL];
        }
        
        else
        {
            NSString *temporaryDirectory = NSTemporaryDirectory();
            RWUUID *fileUUID = [[RWUUID alloc] initWithGenerateTime];
            
            NSString *filePath = [temporaryDirectory stringByAppendingPathComponent:[@"FileMemoryBuffer-" stringByAppendingString:[fileUUID uppercaseString]]];
            mFileURL = [[NSURL alloc] initFileURLWithPath:filePath isDirectory:NO];
        }
        
        mIsMemoryUsed = YES;
        
        mMaxMemorySize = ((maxMemorySize == 0) ? RFNS_FILE_MEMORY_BUFFER_MAX_MEMORY_SIZE_DEFAULT : maxMemorySize);
        mMaxMemorySize = ((mMaxMemorySize < RFNS_FILE_MEMORY_BUFFER_MAX_MEMORY_SIZE_MINIMUM) ? RFNS_FILE_MEMORY_BUFFER_MAX_MEMORY_SIZE_MINIMUM : mMaxMemorySize);
        
        mBuffer = NULL;
        mBufferCapacity = 0;
        mBufferLength = 0;
    }
    
    return self;
}

+ (id)fileMemoryBufferWithFileURL:(NSURL *)fileURL maxMemorySize:(NSUInteger)maxMemorySize
{
    return [[self alloc] initWithFileURL:fileURL maxMemorySize:maxMemorySize];
}

#pragma mark - Deallocating a RFNSFileMemoryBuffer

- (void)dealloc
{
    mError = nil;
    
    if (mFileHandle)
    {
        int result = close(mFileHandle);
        
        if (result < 0)
        {
            int cError = errno;
            char *cErrorMessage = strerror(cError);
            
            NSString *errorMessage = (cErrorMessage ? [NSString stringWithCString:cErrorMessage encoding:NSUTF8StringEncoding] : nil);
            errorMessage = errorMessage ?: @"";
            
            RENSAssert(NO, @"The -[%@ %@] method can not close the %ld file handle. errno = %ld. %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), (long)mFileHandle, (long)cErrorMessage, errorMessage);
        }
        
        // result >= 0
        else
        {
            mFileHandle = 0;
            
            const char *cFilePath = NULL;
            
            if (mFilePath)
            {
                cFilePath = mFilePath.UTF8String;
            }
            
            else if (mFileURL)
            {
                cFilePath = mFileURL.path.UTF8String;
            }
            
            result = unlink(cFilePath);
            
            if (result < 0)
            {
                int cError = errno;
                char *cErrorMessage = strerror(cError);
                
                NSString *errorMessage = (cErrorMessage ? [NSString stringWithCString:cErrorMessage encoding:NSUTF8StringEncoding] : nil);
                errorMessage = errorMessage ?: @"";
                
                RENSAssert(NO, @"The -[%@ %@] method can not unlink the file. errno = %ld. %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), (long)cErrorMessage, errorMessage);
            }
        }
    }
    
    mFilePath = nil;
    
    mFileURL = nil;
    
    free(mBuffer);
    mBuffer = NULL;
}

#pragma mark - Accessing the RFNSFileMemoryBuffer Object

@synthesize error = mError;
@synthesize filePath = mFilePath;
@synthesize fileURL = mFileURL;

- (BOOL)hasError
{
    BOOL hasError = (mError != nil);
    return hasError;
}

@synthesize isMemoryUsed = mIsMemoryUsed;

- (unsigned long long)length
{
    mError = nil;
    
    long long result = 0ll;
    
    if (mIsMemoryUsed)
    {
        result = mBufferLength;
    }
    
    else
    {
        off_t newOffset = lseek(mFileHandle, 0ll, SEEK_END);
        
        if (newOffset < 0ll)
        {
            int   cError = errno;
            char *cErrorMessage = strerror(cError);
            
            NSString *errorMessage = nil;
            
            if (cErrorMessage)
            {
                errorMessage = [[NSString alloc] initWithCString:cErrorMessage encoding:NSUTF8StringEncoding];
            }
            
            NSMutableString *localizedDescription = [[NSMutableString alloc] init];
            [localizedDescription appendString:@"Can not set the offset of the file."];
            [localizedDescription appendFormat:@" errno = %ld.", (long)cError];
            
            if (errorMessage.length > 0)
            {
                [localizedDescription appendFormat:@" %@", errorMessage];
                
                if (![localizedDescription hasSuffix:@"."])
                {
                    [localizedDescription appendString:@"."];
                }
            }
            
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
            userInfo[NSLocalizedDescriptionKey] = localizedDescription;
            
            mError = [[NSError alloc] initWithDomain:RFNSFoundationErrorDomain code:RFNSFileMemoryBufferErrorSeekFile userInfo:userInfo];
            
            result = -1ll;
        }
        
        // newOffset >= 0ll
        else
        {
            result = newOffset;
        }
    }
    
    return (unsigned long long)result;
}

@synthesize maxMemorySize = mMaxMemorySize;

#pragma mark - Truncating the Length

- (long long)truncateToLength:(unsigned long long)length
{
    mError = nil;
    
    long long result = 0ll;
    
    if (mIsMemoryUsed)
    {
        if (length <= mMaxMemorySize)
        {
            if (length <= mBufferCapacity)
            {
                mBufferLength = (NSUInteger)length;
                
                memset((mBuffer + mBufferLength), 0, (mBufferCapacity - mBufferLength));
                
                result = mBufferLength;
            }
            
            // length > mBufferCapacity
            else
            {
                NSUInteger newBufferCapacity = (NSUInteger)length;
                
                uint8_t *newBuffer = (uint8_t *)realloc(mBuffer, newBufferCapacity);
                
                if (!newBuffer)
                {
                    NSMutableString *localizedDescription = [[NSMutableString alloc] init];
                    [localizedDescription appendString:@"Low memory."];
                    
                    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                    userInfo[NSLocalizedDescriptionKey] = localizedDescription;
                    
                    mError = [[NSError alloc] initWithDomain:RFNSFoundationErrorDomain code:RFNSFileMemoryBufferErrorLowMemory userInfo:userInfo];
                    
                    result = -1ll;
                }
                
                else
                {
                    memset((newBuffer + mBufferLength), 0, (newBufferCapacity - mBufferLength));
                    
                    mBuffer = newBuffer;
                    mBufferCapacity = newBufferCapacity;
                    mBufferLength = (NSUInteger)length;
                    
                    result = mBufferLength;
                }
            }
        }
        
        else
        {
            const char *cFilePath = NULL;
            
            if (mFilePath)
            {
                cFilePath = mFilePath.UTF8String;
            }
            
            else if (mFileURL)
            {
                cFilePath = mFileURL.path.UTF8String;
            }
            
            int fileHandle = open(cFilePath,
                                  (O_RDWR | O_CREAT),
                                  (S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
                                  );
            
            if (fileHandle < 0)
            {
                int   cError = errno;
                char *cErrorMessage = strerror(cError);
                
                NSString *errorMessage = nil;
                
                if (cErrorMessage)
                {
                    errorMessage = [[NSString alloc] initWithCString:cErrorMessage encoding:NSUTF8StringEncoding];
                }
                
                NSMutableString *localizedDescription = [[NSMutableString alloc] init];
                [localizedDescription appendString:@"Can not open the file."];
                [localizedDescription appendFormat:@" errno = %ld.", (long)cError];
                
                if (errorMessage.length > 0)
                {
                    [localizedDescription appendFormat:@" %@", errorMessage];
                    
                    if (![localizedDescription hasSuffix:@"."])
                    {
                        [localizedDescription appendString:@"."];
                    }
                }
                
                NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                userInfo[NSLocalizedDescriptionKey] = localizedDescription;
                
                mError = [[NSError alloc] initWithDomain:RFNSFoundationErrorDomain code:RFNSFileMemoryBufferErrorOpenFile userInfo:userInfo];
                
                result = -1ll;
            }
            
            else
            {
                mIsMemoryUsed = NO;
                mFileHandle = fileHandle;
                
                result = 0ll;
                
                while (result < mBufferLength)
                {
                    ssize_t writtenBytes = write(mFileHandle, (mBuffer + result), (size_t)(mBufferLength - result));
                    
                    if (writtenBytes < 0)
                    {
                        int cError = errno;
                        
                        int result2 = close(mFileHandle);
                        
                        if (result2 < 0)
                        {
                            int cError2 = errno;
                            char *cErrorMessage = strerror(cError2);
                            
                            NSString *errorMessage = (cErrorMessage ? [NSString stringWithCString:cErrorMessage encoding:NSUTF8StringEncoding] : nil);
                            errorMessage = errorMessage ?: @"";
                            
                            RENSAssert(NO, @"The -[%@ %@] method can not close the %ld file handle. errno = %ld. %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), (long)mFileHandle, (long)cErrorMessage, errorMessage);
                            
                            mIsMemoryUsed = YES;
                            
                            result = -1ll;
                        }
                        
                        // result2 >= 0
                        else
                        {
                            mFileHandle = 0;
                            
                            const char *cFilePath2 = NULL;
                            
                            if (mFilePath)
                            {
                                cFilePath2 = mFilePath.UTF8String;
                            }
                            
                            else if (mFileURL)
                            {
                                cFilePath2 = mFileURL.path.UTF8String;
                            }
                            
                            int result3 = unlink(cFilePath2);
                            
                            if (result3 < 0)
                            {
                                int cError3 = errno;
                                char *cErrorMessage = strerror(cError3);
                                
                                NSString *errorMessage = (cErrorMessage ? [NSString stringWithCString:cErrorMessage encoding:NSUTF8StringEncoding] : nil);
                                errorMessage = errorMessage ?: @"";
                                
                                RENSAssert(NO, @"The -[%@ %@] method can not unling the file. errno = %ld. %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), (long)cErrorMessage, errorMessage);
                                
                                mIsMemoryUsed = YES;
                                
                                result = -1ll;
                            }
                            
                            // result3 >= 0
                            else
                            {
                                char *cErrorMessage = strerror(cError);
                                
                                NSString *errorMessage = nil;
                                
                                if (cErrorMessage)
                                {
                                    errorMessage = [[NSString alloc] initWithCString:cErrorMessage encoding:NSUTF8StringEncoding];
                                }
                                
                                NSMutableString *localizedDescription = [[NSMutableString alloc] init];
                                [localizedDescription appendString:@"Can not write the data into the file."];
                                [localizedDescription appendFormat:@" errno = %ld.", (long)cError];
                                
                                if (errorMessage.length > 0)
                                {
                                    [localizedDescription appendFormat:@" %@", errorMessage];
                                    
                                    if (![localizedDescription hasSuffix:@"."])
                                    {
                                        [localizedDescription appendString:@"."];
                                    }
                                }
                                
                                NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                                userInfo[NSLocalizedDescriptionKey] = localizedDescription;
                                
                                mError = [[NSError alloc] initWithDomain:RFNSFoundationErrorDomain code:RFNSFileMemoryBufferErrorWriteFile userInfo:userInfo];
                                
                                mIsMemoryUsed = YES;
                                
                                result = -1ll;
                            }
                        }
                        
                        break;
                    }
                    
                    // writtenBytes >= 0
                    else
                    {
                        result += writtenBytes;
                    }
                }
                
                if (!mIsMemoryUsed)
                {
                    free(mBuffer);
                    mBuffer = NULL;
                    
                    mBufferCapacity = 0;
                    
                    mBufferLength = 0;
                }
            }
        }
    }
    
    if ((result >= 0ll) && !mIsMemoryUsed)
    {
        result = 0ll;
        result = result; // Deception analyzer.
        
        int result2 = ftruncate(mFileHandle, (off_t)length);
        
        if (result2 < 0)
        {
            int   cError2 = errno;
            char *cErrorMessage = strerror(cError2);
            
            NSString *errorMessage = nil;
            
            if (cErrorMessage)
            {
                errorMessage = [[NSString alloc] initWithCString:cErrorMessage encoding:NSUTF8StringEncoding];
            }
            
            NSMutableString *localizedDescription = [[NSMutableString alloc] init];
            [localizedDescription appendString:@"Can not truncate the file."];
            [localizedDescription appendFormat:@" errno = %ld.", (long)cError2];
            
            if (errorMessage.length > 0)
            {
                [localizedDescription appendFormat:@" %@", errorMessage];
                
                if (![localizedDescription hasSuffix:@"."])
                {
                    [localizedDescription appendString:@"."];
                }
            }
            
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
            userInfo[NSLocalizedDescriptionKey] = localizedDescription;
            
            mError = [[NSError alloc] initWithDomain:RFNSFoundationErrorDomain code:RFNSFileMemoryBufferErrorTruncateFile userInfo:userInfo];
            
            result = -1ll;
        }
        
        else if ((length < (mMaxMemorySize / 3)) &&
                 (length < RFNS_FILE_MEMORY_MOVE_DATA_FROM_FILE_TO_BUFFER_MEMORY_SIZE))
        {
            off_t newOffset = lseek(mFileHandle, 0ll, SEEK_SET);
            
            if (newOffset < 0ll)
            {
                result = (long long)length;
            }
            
            // newOffset >= 0ll
            else
            {
                NSUInteger newBufferCapacity = (NSUInteger)length;
                
                uint8_t *newBuffer = (uint8_t *)realloc(mBuffer, newBufferCapacity);
                
                if (!newBuffer)
                {
                    result = (long long)length;
                }
                
                else
                {
                    mIsMemoryUsed = YES;
                    
                    memset(newBuffer, 0, newBufferCapacity);
                    
                    mBuffer = newBuffer;
                    mBufferCapacity = newBufferCapacity;
                    mBufferLength = 0;
                    
                    result = 0ll;
                    
                    NSUInteger maxLength = (NSUInteger)length;
                    
                    while (result < maxLength)
                    {
                        ssize_t readBytes = read(mFileHandle, (mBuffer + mBufferLength), (maxLength - mBufferLength));
                        
                        if (readBytes > 0)
                        {
                            mBufferLength += (NSUInteger)readBytes;
                            result += readBytes;
                        }
                        
                        else if (readBytes == 0)
                        {
                            break;
                        }
                        
                        else
                        {
                            free(mBuffer);
                            mBuffer = NULL;
                            
                            mBufferCapacity = 0;
                            
                            mBufferLength = 0;
                            
                            mIsMemoryUsed = NO;
                            
                            result = (long long)length;
                            
                            break;
                        }
                    }
                    
                    if (mIsMemoryUsed)
                    {
                        mBufferLength = (NSUInteger)length;
                        
                        int result3 = close(mFileHandle);
                        
                        if (result3 < 0)
                        {
                            int cError3 = errno;
                            char *cErrorMessage = strerror(cError3);
                            
                            NSString *errorMessage = (cErrorMessage ? [NSString stringWithCString:cErrorMessage encoding:NSUTF8StringEncoding] : nil);
                            errorMessage = errorMessage ?: @"";
                            
                            RENSAssert(NO, @"The -[%@ %@] method can not close the %ld file handle. errno = %ld. %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), (long)mFileHandle, (long)cErrorMessage, errorMessage);
                        }
                        
                        // result3 >= 0
                        else
                        {
                            mFileHandle = 0;
                            
                            const char *cFilePath = NULL;
                            
                            if (mFilePath)
                            {
                                cFilePath = mFilePath.UTF8String;
                            }
                            
                            else if (mFileURL)
                            {
                                cFilePath = mFileURL.path.UTF8String;
                            }
                            
                            int result4 = unlink(cFilePath);
                            
                            if (result4 < 0)
                            {
                                int cError4 = errno;
                                char *cErrorMessage = strerror(cError4);
                                
                                NSString *errorMessage = (cErrorMessage ? [NSString stringWithCString:cErrorMessage encoding:NSUTF8StringEncoding] : nil);
                                errorMessage = errorMessage ?: @"";
                                
                                RENSAssert(NO, @"The -[%@ %@] method can not unlink the file. errno = %ld. %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), (long)cErrorMessage, errorMessage);
                            }
                        }
                    }
                }
            }
        }
        
        else
        {
            result = (long long)length;
        }
    }
    
    return result;
}

#pragma mark - Reading Data

- (NSInteger)readBuffer:(void *)buffer offset:(unsigned long long)offset maxLength:(NSUInteger)maxLength
{
    RENSAssert(buffer, @"The buffer argument is nil.");
    
    mError = nil;
    
    if (maxLength == 0)
    {
        return 0;
    }
    
    NSInteger result = 0;
    
    if (mIsMemoryUsed)
    {
        if (offset < mBufferLength)
        {
            if ((offset + maxLength) > mBufferLength)
            {
                maxLength = (NSUInteger)(mBufferLength - offset);
            }
            
            memcpy(buffer, (mBuffer + offset), maxLength);
            result = (NSInteger)maxLength;
        }
        
        else
        {
            result = 0;
        }
    }
    
    if ((result >= 0) && !mIsMemoryUsed)
    {
        off_t newOffset = lseek(mFileHandle, (off_t)offset, SEEK_SET);
        
        // We have an error.
        if (newOffset < 0ll)
        {
            int   cError = errno;
            char *cErrorMessage = strerror(cError);
            
            NSString *errorMessage = nil;
            
            if (cErrorMessage)
            {
                errorMessage = [[NSString alloc] initWithCString:cErrorMessage encoding:NSUTF8StringEncoding];
            }
            
            NSMutableString *localizedDescription = [[NSMutableString alloc] init];
            [localizedDescription appendString:@"Can not set the offset of the file."];
            [localizedDescription appendFormat:@" errno = %ld.", (long)cError];
            
            if (errorMessage.length > 0)
            {
                [localizedDescription appendFormat:@" %@", errorMessage];
                
                if (![localizedDescription hasSuffix:@"."])
                {
                    [localizedDescription appendString:@"."];
                }
            }
            
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
            userInfo[NSLocalizedDescriptionKey] = localizedDescription;
            
            mError = [[NSError alloc] initWithDomain:RFNSFoundationErrorDomain code:RFNSFileMemoryBufferErrorSeekFile userInfo:userInfo];
            
            result = -1;
        }
        
        else
        {
            result = 0;
            
            while (result < (NSInteger)maxLength)
            {
                ssize_t readBytes = read(mFileHandle, (((uint8_t *)buffer) + result), (maxLength - (NSUInteger)result));
                
                if (readBytes > 0)
                {
                    result += readBytes;
                }
                
                else if (readBytes == 0)
                {
                    break;
                }
                
                else if (result > 0)
                {
                    break;
                }
                
                else
                {
                    int   cError = errno;
                    char *cErrorMessage = strerror(cError);
                    
                    NSString *errorMessage = nil;
                    
                    if (cErrorMessage)
                    {
                        errorMessage = [[NSString alloc] initWithCString:cErrorMessage encoding:NSUTF8StringEncoding];
                    }
                    
                    NSMutableString *localizedDescription = [[NSMutableString alloc] init];
                    [localizedDescription appendString:@"Can not read the data from the file."];
                    [localizedDescription appendFormat:@" errno = %ld.", (long)cError];
                    
                    if (errorMessage.length > 0)
                    {
                        [localizedDescription appendFormat:@" %@", errorMessage];
                        
                        if (![localizedDescription hasSuffix:@"."])
                        {
                            [localizedDescription appendString:@"."];
                        }
                    }
                    
                    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                    userInfo[NSLocalizedDescriptionKey] = localizedDescription;
                    
                    mError = [[NSError alloc] initWithDomain:RFNSFoundationErrorDomain code:RFNSFileMemoryBufferErrorReadFile userInfo:userInfo];
                    
                    result = -1;
                    
                    break;
                }
            }
        }
    }
    
    return result;
}

#pragma mark - Writing Data

- (NSInteger)writeBuffer:(const void *)buffer offset:(unsigned long long)offset length:(NSUInteger)length
{
    RENSAssert(buffer, @"The buffer argument is nil.");
    
    mError = nil;
    
    if (length == 0)
    {
        return 0;
    }
    
    NSInteger result = 0;
    
    if (mIsMemoryUsed)
    {
        if ((offset + length) <= mMaxMemorySize)
        {
            if ((offset + length) <= mBufferCapacity)
            {
                memcpy((mBuffer + offset), buffer, length);
                
                mBufferLength = (NSUInteger)(offset + length);
                
                result = (NSInteger)length;
            }
            
            // (offset + length) > mBufferCapacity
            else
            {
                NSUInteger newBufferCapacity = (NSUInteger)(offset + (5 * length));
                newBufferCapacity = (newBufferCapacity <= mMaxMemorySize ? newBufferCapacity : mMaxMemorySize);
                
                uint8_t *newBuffer = (uint8_t *)realloc(mBuffer, newBufferCapacity);
                
                if (!newBuffer)
                {
                    NSMutableString *localizedDescription = [[NSMutableString alloc] init];
                    [localizedDescription appendString:@"Low memory."];
                    
                    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                    userInfo[NSLocalizedDescriptionKey] = localizedDescription;
                    
                    mError = [[NSError alloc] initWithDomain:RFNSFoundationErrorDomain code:RFNSFileMemoryBufferErrorLowMemory userInfo:userInfo];
                    
                    result = -1;
                }
                
                else
                {
                    memset((newBuffer + mBufferLength), 0, (newBufferCapacity - mBufferLength));
                    memcpy((newBuffer + offset), buffer, length);
                    
                    mBuffer = newBuffer;
                    mBufferCapacity = newBufferCapacity;
                    mBufferLength = (NSUInteger)(offset + length);
                    
                    result = (NSInteger)length;
                }
            }
        }
        
        else
        {
            const char *cFilePath = NULL;
            
            if (mFilePath)
            {
                cFilePath = mFilePath.UTF8String;
            }
            
            else if (mFileURL)
            {
                cFilePath = mFileURL.path.UTF8String;
            }
            
            int fileHandle = open(cFilePath,
                                  (O_RDWR | O_CREAT),
                                  (S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
                                  );
            
            if (fileHandle < 0)
            {
                int   cError = errno;
                char *cErrorMessage = strerror(cError);
                
                NSString *errorMessage = nil;
                
                if (cErrorMessage)
                {
                    errorMessage = [[NSString alloc] initWithCString:cErrorMessage encoding:NSUTF8StringEncoding];
                }
                
                NSMutableString *localizedDescription = [[NSMutableString alloc] init];
                [localizedDescription appendString:@"Can not open the file."];
                [localizedDescription appendFormat:@" errno = %ld.", (long)cError];
                
                if (errorMessage.length > 0)
                {
                    [localizedDescription appendFormat:@" %@", errorMessage];
                    
                    if (![localizedDescription hasSuffix:@"."])
                    {
                        [localizedDescription appendString:@"."];
                    }
                }
                
                NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                userInfo[NSLocalizedDescriptionKey] = localizedDescription;
                
                mError = [[NSError alloc] initWithDomain:RFNSFoundationErrorDomain code:RFNSFileMemoryBufferErrorOpenFile userInfo:userInfo];
                
                result = -1;
            }
            
            else
            {
                mIsMemoryUsed = NO;
                mFileHandle = fileHandle;
                
                int totalWrittenBytes = 0;
                
                while (totalWrittenBytes < (int)mBufferLength)
                {
                    ssize_t writtenBytes = write(mFileHandle, (mBuffer + totalWrittenBytes), (mBufferLength - (unsigned int)totalWrittenBytes));
                    
                    if (writtenBytes >= 0)
                    {
                        totalWrittenBytes += writtenBytes;
                    }
                    
                    // writtenBytes < 0
                    else
                    {
                        int   cError = errno;
                        char *cErrorMessage = strerror(cError);
                        
                        NSString *errorMessage = nil;
                        
                        if (cErrorMessage)
                        {
                            errorMessage = [[NSString alloc] initWithCString:cErrorMessage encoding:NSUTF8StringEncoding];
                        }
                        
                        NSMutableString *localizedDescription = [[NSMutableString alloc] init];
                        [localizedDescription appendString:@"Can not write the data from the internal buffer to the file."];
                        [localizedDescription appendFormat:@" errno = %ld.", (long)cError];
                        
                        if (errorMessage.length > 0)
                        {
                            [localizedDescription appendFormat:@" %@", errorMessage];
                            
                            if (![localizedDescription hasSuffix:@"."])
                            {
                                [localizedDescription appendString:@"."];
                            }
                        }
                        
                        RENSAssert(NO, @"%@", localizedDescription);
                        
                        result = -1;
                        
                        break;
                    }
                }
                
                free(mBuffer);
                mBuffer = NULL;
                
                mBufferCapacity = 0;
                
                mBufferLength = 0;
            }
        }
    }
    
    if ((result >= 0) && !mIsMemoryUsed)
    {
        off_t newOffset = lseek(mFileHandle, (off_t)offset, SEEK_SET);
        
        // We have an error.
        if (newOffset < 0ll)
        {
            int   cError = errno;
            char *cErrorMessage = strerror(cError);
            
            NSString *errorMessage = nil;
            
            if (cErrorMessage)
            {
                errorMessage = [[NSString alloc] initWithCString:cErrorMessage encoding:NSUTF8StringEncoding];
            }
            
            NSMutableString *localizedDescription = [[NSMutableString alloc] init];
            [localizedDescription appendString:@"Can not set the offset of the file."];
            [localizedDescription appendFormat:@" errno = %ld.", (long)cError];
            
            if (errorMessage.length > 0)
            {
                [localizedDescription appendFormat:@" %@", errorMessage];
                
                if (![localizedDescription hasSuffix:@"."])
                {
                    [localizedDescription appendString:@"."];
                }
            }
            
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
            userInfo[NSLocalizedDescriptionKey] = localizedDescription;
            
            mError = [[NSError alloc] initWithDomain:RFNSFoundationErrorDomain code:RFNSFileMemoryBufferErrorSeekFile userInfo:userInfo];
            
            result = -1;
        }
        
        else
        {
            result = 0;
            
            while (result < (NSInteger)length)
            {
                ssize_t writtenBytes = write(mFileHandle, (((uint8_t *)buffer) + result), (length - (NSUInteger)result));
                
                if (writtenBytes >= 0)
                {
                    result += writtenBytes;
                }
                
                else if (result > 0)
                {
                    break;
                }
                
                else
                {
                    int   cError = errno;
                    char *cErrorMessage = strerror(cError);
                    
                    NSString *errorMessage = nil;
                    
                    if (cErrorMessage)
                    {
                        errorMessage = [[NSString alloc] initWithCString:cErrorMessage encoding:NSUTF8StringEncoding];
                    }
                    
                    NSMutableString *localizedDescription = [[NSMutableString alloc] init];
                    [localizedDescription appendString:@"Can not write the data into the file."];
                    [localizedDescription appendFormat:@" errno = %ld.", (long)cError];
                    
                    if (errorMessage.length > 0)
                    {
                        [localizedDescription appendFormat:@" %@", errorMessage];
                        
                        if (![localizedDescription hasSuffix:@"."])
                        {
                            [localizedDescription appendString:@"."];
                        }
                    }
                    
                    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                    userInfo[NSLocalizedDescriptionKey] = localizedDescription;
                    
                    mError = [[NSError alloc] initWithDomain:RFNSFoundationErrorDomain code:RFNSFileMemoryBufferErrorWriteFile userInfo:userInfo];
                    
                    result = -1;
                    
                    break;
                }
            }
        }
    }
    
    return result;
}

#pragma mark - Conforming the NSObject Protocol

- (NSString *)description
{
    NSString *description = nil;
    
    if (mIsMemoryUsed)
    {
        NSMutableData *data = [NSMutableData dataWithBytesNoCopy:mBuffer length:mBufferLength freeWhenDone:NO];
        int zeroByte = 0;
        [data appendBytes:&zeroByte length:1];
        
        description = [NSString stringWithCString:(const char *)data.bytes encoding:NSUTF8StringEncoding];
    }
    
    description = (description ?: @"");
    
    return description;
}

@end
