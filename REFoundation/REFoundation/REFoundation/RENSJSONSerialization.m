//
//  RENSJSONSerialization.m
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.08.28.
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
#import "RENSJSONSerialization.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation NSJSONSerialization (NSJSONSerializationRENSJSONSerialization)

#pragma mark - Creating a JSON Object

+ (id)JSONObjectWithJSON:(NSString *)json options:(NSJSONReadingOptions)options error:(NSError **)pError
{
    if (!json)
    {
        @throw [NSException exceptionWithName:NSInvalidArchiveOperationException reason:@"The json argument is nil." userInfo:nil];
    }
    
    // Setting the default value.
    id jsonObject = nil;
    
    // Creating the JSON data from the JSON.
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    // We have the JSON data.
    if (jsonData)
    {
        // Creating the JSON object from the JSON data.
        jsonObject = [self JSONObjectWithData:jsonData options:options error:pError];
    }
    
    // Returning the JSON object.
    return jsonObject;
}

+ (id)JSONObjectWithPath:(NSString *)path options:(NSJSONReadingOptions)options error:(NSError **)pError
{
    // Setting the default values.
    NSError *error = nil;
    id       jsonObject = nil;
    
    // Creating the JSON input stream.
    NSInputStream *jsonInputStream = [[NSInputStream alloc] initWithFileAtPath:path];
    
    // We have created the JSON input stream.
    if (jsonInputStream)
    {
        // Opening the JSON input stream.
        [jsonInputStream open];
        
        // Getting the stream status of the JSON input stream.
        NSStreamStatus jsonInputStreamStreamStatus = jsonInputStream.streamStatus;
        
        // We have an error.
        if (jsonInputStreamStreamStatus == NSStreamStatusError)
        {
            // The user wants to get the error.
            if (pError)
            {
                // Getting the stream error.
                error = jsonInputStream.streamError;
            }
        }
        
        // We have opened the JSON input stream.
        else if (jsonInputStreamStreamStatus == NSStreamStatusOpen)
        {
            // Creating the JSON Object from the JSON input stream.
            jsonObject = [NSJSONSerialization JSONObjectWithStream:jsonInputStream options:options error:(pError ? &error : nil)];
        }
    }
    
    // The user wants to get the error.
    if (pError)
    {
        // Saving the error.
        *pError = error;
    }
    
    // Returning the created JSON object.
    return jsonObject;
}

+ (id)JSONObjectWithURL:(NSURL *)url options:(NSJSONReadingOptions)options error:(NSError **)pError
{
    // Setting the default values.
    NSError *error = nil;
    id       jsonObject = nil;
    
    // Creating the JSON input stream.
    NSInputStream *jsonInputStream = [[NSInputStream alloc] initWithURL:url];
    
    // We have created the JSON input stream.
    if (jsonInputStream)
    {
        // Opening the JSON input stream.
        [jsonInputStream open];
        
        // Getting the stream status of the JSON input stream.
        NSStreamStatus jsonInputStreamStreamStatus = jsonInputStream.streamStatus;
        
        // We have an error.
        if (jsonInputStreamStreamStatus == NSStreamStatusError)
        {
            // The user wants to get the error.
            if (pError)
            {
                // Getting the stream error.
                error = jsonInputStream.streamError;
            }
        }
        
        // We have opened the JSON input stream.
        else if (jsonInputStreamStreamStatus == NSStreamStatusOpen)
        {
            // Creating the JSON Object from the JSON input stream.
            jsonObject = [NSJSONSerialization JSONObjectWithStream:jsonInputStream options:options error:(pError ? &error : nil)];
        }
    }
    
    // The user wants to get the error.
    if (pError)
    {
        // Saving the error.
        *pError = error;
    }
    
    // Returning the created JSON object.
    return jsonObject;
}

+ (NSString *)JSONWithJSONObject:(id)object options:(NSJSONWritingOptions)options error:(NSError **)pError
{
    // Setting the default value.
    NSString *json = nil;
    
    // Creating the JSON data with JSON object.
    NSData *jsonData = [self dataWithJSONObject:object options:options error:pError];
    
    // We have the JSON data.
    if (jsonData)
    {
        // We have the mutable JSON data.
        if ([jsonData isKindOfClass:[NSMutableData class]])
        {
            // Creating the mutable JSON.
            json = [[NSMutableString alloc] initWithBytes:(const void *)jsonData.bytes length:jsonData.length encoding:NSUTF8StringEncoding];
        }
        
        // We have the JSON data.
        else
        {
            // Creating the JSON.
            json = [[NSString alloc] initWithBytes:(const void *)jsonData.bytes length:jsonData.length encoding:NSUTF8StringEncoding];
        }
    }
    
    // Returning the JSON.
    return json;
}

@end
