//
//  RENSPropertyList.m
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.08.12.
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
#import "RENSPropertyList.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation NSPropertyListSerialization (NSPropertyListSerializationRENSPropertyListSerialization)

#pragma mark - Serializing a Property List

+ (NSData *)dataWithPropertyList:(id)plist error:(out NSError **)pError
{
    NSData *data = [self dataWithPropertyList:plist format:NSPropertyListBinaryFormat_v1_0 options:0 error:pError];
    return data;
}

+ (NSData *)dataWithPropertyList:(id)plist
{
    NSData *data = [self dataWithPropertyList:plist format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
    return data;
}

+ (NSInteger)writePropertyList:(id)plist toStream:(NSOutputStream *)stream error:(out NSError **)pError
{
    NSInteger bytesWritten = [self writePropertyList:plist toStream:stream format:NSPropertyListBinaryFormat_v1_0 options:0 error:pError];
    return bytesWritten;
}

+ (NSInteger)writePropertyList:(id)plist toStream:(NSOutputStream *)stream
{
    NSInteger bytesWritten = [self writePropertyList:plist toStream:stream format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
    return bytesWritten;
}

#pragma mark - Deserializing a Property List

+ (id)propertyListWithData:(NSData *)data error:(out NSError **)pError
{
    id propertyListObject = [self propertyListWithData:data options:NSPropertyListImmutable format:NULL error:pError];
    return propertyListObject;
}

+ (id)propertyListWithData:(NSData *)data
{
    id propertyListObject = [self propertyListWithData:data options:NSPropertyListImmutable format:NULL error:nil];
    return propertyListObject;
}

+ (id)propertyListWithStream:(NSInputStream *)stream error:(out NSError **)pError
{
    id propertyListObject = [self propertyListWithStream:stream options:NSPropertyListImmutable format:NULL error:pError];
    return propertyListObject;
}

+ (id)propertyListWithStream:(NSInputStream *)stream
{
    id propertyListObject = [self propertyListWithStream:stream options:NSPropertyListImmutable format:NULL error:nil];
    return propertyListObject;
}

@end
