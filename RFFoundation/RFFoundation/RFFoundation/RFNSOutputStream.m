//
//  RFNSOutputStream.m
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.07.06.
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
#import "RFNSOutputStream.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

NSString * const RFNSStreamDataWrittenToMemoryStreamKey = @"RFNSStreamDataWrittenToMemoryStreamKey";
NSString * const RFNSStreamDataWrittenToMutableDataStreamKey = @"RFNSStreamDataWrittenToMutableDataStreamKey";

@implementation RFNSOutputStream

#pragma mark - Initializing and Creating a RFNSOutputStream

- (id)initToMemory
{
    self = [super init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    mDestinationType = RFNSOutputStreamDestinationTypeMemory;
    
    mMutableData = [[NSMutableData alloc] init];
    
    if (!mMutableData)
    {
        goto jmp_error;
    }
    
    mStreamError = nil;
    
    mStreamStatus = NSStreamStatusNotOpen;
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)outputStreamToMemory
{
    return [[self alloc] initToMemory];
}

- (id)initToMutableData:(NSMutableData *)data
{
    self = [super init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    mDestinationType = RFNSOutputStreamDestinationTypeMutableData;
    
    mMutableData = data;
    
    if (!mMutableData)
    {
        goto jmp_error;
    }
    
    mStreamError = nil;
    
    mStreamStatus = NSStreamStatusNotOpen;
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)outputStreamToMutableData:(NSMutableData *)data
{
    return [[self alloc] initToMutableData:data];
}

- (id)initToVacuum
{
    self = [super init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    mDestinationType = RFNSOutputStreamDestinationTypeVacuum;
    
    mMutableData = nil;
    
    mStreamError = nil;
    
    mStreamStatus = NSStreamStatusNotOpen;
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)outputStreamToVacuum
{
    return [[self alloc] initToVacuum];
}

#pragma mark - Deallocating a RFNSOutputStream

- (void)dealloc
{
    mMutableData = nil;
    
    mStreamError = nil;
}

#pragma mark - Configuring Streams

- (id)propertyForKey:(NSString *)key
{
    id value = nil;
    
    if ([key isEqual:RFNSStreamDataWrittenToMemoryStreamKey])
    {
        if (mDestinationType == RFNSOutputStreamDestinationTypeMemory)
        {
            value = mMutableData;
        }
    }
    
    else if ([key isEqual:RFNSStreamDataWrittenToMutableDataStreamKey])
    {
        if (mDestinationType == RFNSOutputStreamDestinationTypeMutableData)
        {
            value = mMutableData;
        }
    }
    
    else
    {
        value = [super propertyForKey:key];
    }
    
    return  value;
}

- (BOOL)setProperty:(id)property forKey:(NSString *)key
{
    BOOL success = NO;
    
    if ([key isEqual:RFNSStreamDataWrittenToMemoryStreamKey])
    {
        success = NO;
    }
    
    else if ([key isEqual:RFNSStreamDataWrittenToMutableDataStreamKey])
    {
        success = NO;
    }
    
    else
    {
        success = [super setProperty:property forKey:key];
    }
    
    return success;
}

#pragma mark - Using Streams

- (void)open
{
    if (mDestinationType == RFNSOutputStreamDestinationTypeMemory)
    {
        if (mStreamStatus == NSStreamStatusNotOpen)
        {
            mStreamStatus = NSStreamStatusOpen;
        }
    }
    
    else if (mDestinationType == RFNSOutputStreamDestinationTypeMutableData)
    {
        if (mStreamStatus == NSStreamStatusNotOpen)
        {
            mStreamStatus = NSStreamStatusOpen;
        }
    }
    
    else if (mDestinationType == RFNSOutputStreamDestinationTypeVacuum)
    {
        if (mStreamStatus == NSStreamStatusNotOpen)
        {
            mStreamStatus = NSStreamStatusOpen;
        }
    }
    
    else
    {
        [super open];
    }
}

- (void)close
{
    if (mDestinationType == RFNSOutputStreamDestinationTypeMemory)
    {
        if (mStreamStatus == NSStreamStatusOpen)
        {
            mStreamStatus = NSStreamStatusClosed;
        }
    }
    
    else if (mDestinationType == RFNSOutputStreamDestinationTypeMutableData)
    {
        if (mStreamStatus == NSStreamStatusOpen)
        {
            mStreamStatus = NSStreamStatusClosed;
        }
    }
    
    else if (mDestinationType == RFNSOutputStreamDestinationTypeVacuum)
    {
        if (mStreamStatus == NSStreamStatusOpen)
        {
            mStreamStatus = NSStreamStatusClosed;
        }
    }
    
    else
    {
        [super close];
    }
}

- (NSInteger)write:(const uint8_t *)buffer maxLength:(NSUInteger)length
{
    NSInteger bytesWritten = -1;
    
    if (mDestinationType == RFNSOutputStreamDestinationTypeMemory)
    {
        if (mStreamStatus == NSStreamStatusOpen)
        {
            [mMutableData appendBytes:(const void *)buffer length:length];
            
            bytesWritten = (NSInteger)length;
        }
        
        else
        {
            bytesWritten = -1;
        }
    }
    
    else if (mDestinationType == RFNSOutputStreamDestinationTypeMutableData)
    {
        if (mStreamStatus == NSStreamStatusOpen)
        {
            [mMutableData appendBytes:(const void *)buffer length:length];
            
            bytesWritten = (NSInteger)length;
        }
        
        else
        {
            bytesWritten = -1;
        }
    }
    
    else if (mDestinationType == RFNSOutputStreamDestinationTypeVacuum)
    {
        if (mStreamStatus == NSStreamStatusOpen)
        {
            bytesWritten = (NSInteger)length;
        }
        
        else
        {
            bytesWritten = -1;
        }
    }
    
    else
    {
        bytesWritten = [super write:buffer maxLength:length];
    }
    
    return bytesWritten;
}

- (BOOL)hasSpaceAvailable
{
    BOOL hasSpaceAvailable = NO;
    
    if (mDestinationType == RFNSOutputStreamDestinationTypeMemory)
    {
        hasSpaceAvailable = YES;
    }
    
    else if (mDestinationType == RFNSOutputStreamDestinationTypeMutableData)
    {
        hasSpaceAvailable = YES;
    }
    
    else if (mDestinationType == RFNSOutputStreamDestinationTypeVacuum)
    {
        hasSpaceAvailable = YES;
    }
    
    else
    {
        hasSpaceAvailable = super.hasSpaceAvailable;
    }
    
    return hasSpaceAvailable;
}

#pragma mark - Managing Run Loops

- (void)scheduleInRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode
{
    if ((mDestinationType == RFNSOutputStreamDestinationTypeMemory) ||
        (mDestinationType == RFNSOutputStreamDestinationTypeMutableData) ||
        (mDestinationType == RFNSOutputStreamDestinationTypeVacuum))
    {
        // TODO: Needs implemente scheduleInRunLoop:forMode: method.
    }
    
    else
    {
        [super scheduleInRunLoop:aRunLoop forMode:mode];
    }
}

- (void)removeFromRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode
{
    if ((mDestinationType == RFNSOutputStreamDestinationTypeMemory) ||
        (mDestinationType == RFNSOutputStreamDestinationTypeMutableData) ||
        (mDestinationType == RFNSOutputStreamDestinationTypeVacuum))
    {
        // TODO: Needs implemente removeFromRunLoop:forMode: method.
    }
    
    else
    {
        [super removeFromRunLoop:aRunLoop forMode:mode];
    }
}

#pragma mark - Getting Stream Information

- (NSStreamStatus)streamStatus
{
    NSStreamStatus streamStatus = NSStreamStatusNotOpen;
    
    if ((mDestinationType == RFNSOutputStreamDestinationTypeMemory) ||
        (mDestinationType == RFNSOutputStreamDestinationTypeMutableData) ||
        (mDestinationType == RFNSOutputStreamDestinationTypeVacuum))
    {
        streamStatus = mStreamStatus;
    }
    
    else
    {
        streamStatus = super.streamStatus;
    }
    
    return streamStatus;
}

- (NSError *)streamError
{
    NSError *streamError = nil;
    
    if ((mDestinationType == RFNSOutputStreamDestinationTypeMemory) ||
        (mDestinationType == RFNSOutputStreamDestinationTypeMutableData) ||
        (mDestinationType == RFNSOutputStreamDestinationTypeVacuum))
    {
        streamError = mStreamError;
    }
    
    else
    {
        streamError = super.streamError;
    }
    
    return streamError;
}

@end
