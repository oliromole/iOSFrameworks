//
//  RWSQLiteData.m
//  RWSQLite
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.06.24.
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
#import "RWSQLiteData.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

void *RWSQLiteCDataCreateWithNSData(NSData *nsData)
{
    void *bytes = NULL;
    
    if (nsData)
    {
        NSUInteger nsDataLength = nsData.length;
        
        bytes = malloc((unsigned long)nsDataLength);
        
        if (bytes)
        {
            NSRange nsRange;
            nsRange.location = 0;
            nsRange.length = nsDataLength;
            
            [nsData getBytes:bytes range:nsRange];
        }
    }
    
    return bytes;
}

NSData *RWSQLiteNSDataCreateWithCData(const void *cBytes, int numberOfBytes)
{
    NSData *nsData = NULL;
    
    if (cBytes)
    {
        nsData = [[NSData alloc] initWithBytes:cBytes length:(NSUInteger)numberOfBytes];
    }
    
    return nsData;
}

NSMutableData *RWSQLiteNSMutableDataCreateWithCData(const void *cBytes, int numberOfBytes)
{
    NSMutableData *nsData = NULL;
    
    if (cBytes)
    {
        nsData = [[NSMutableData alloc] initWithBytes:cBytes length:(NSUInteger)numberOfBytes];
    }
    
    return nsData;
}

int RWSQLiteNSDataGetNumberOfBytes(NSData *nsData)
{
    int numberOfBytes = 0;
    
    if (nsData)
    {
        numberOfBytes = (int)nsData.length;
    }
    
    return numberOfBytes;
}
