//
//  RWSQLiteURL.m
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
#import "RWSQLiteURL.h"

// Importing the system headers.
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>

char *RWSQLiteCStringCreateWithCFURL(CFURLRef cfUrlRef);

char *RWSQLiteCStringCreateWithCFURL(CFURLRef cfUrlRef)
{
    char *cString = NULL;
    
    if (cfUrlRef)
    {
        CFURLRef cfAbsoluteURL = CFURLCopyAbsoluteURL(cfUrlRef);
        
        if (cfAbsoluteURL)
        {
            CFStringRef cfString = CFURLGetString(cfAbsoluteURL);
            
            if (cfString)
            {
                CFIndex cfStringLenght = CFStringGetLength(cfString);
                CFIndex cStringStringSize = CFStringGetMaximumSizeForEncoding(cfStringLenght, kCFStringEncodingUTF8) + 1;
                
                cString = (char *)malloc((size_t)cStringStringSize);
                
                if (cString)
                {
                    Boolean success = CFStringGetCString(cfString, cString, cStringStringSize, kCFStringEncodingUTF8);
                    
                    if (!success)
                    {
                        free(cString);
                        cString = NULL;
                    }
                }
                
                // We do not release cfString, because we get pointer.
            }
            
            CFRelease(cfAbsoluteURL);
            cfAbsoluteURL = NULL;
        }
    }
    
    return cString;
}

char *RWSQLiteCStringCreateWithNSURL(NSURL *nsUrl)
{
    char *cString = RWSQLiteCStringCreateWithCFURL((__bridge CFURLRef)nsUrl);
    return cString;
}

CFURLRef RWSQLiteCFURLCreateWithCString(const char *cString);

CFURLRef RWSQLiteCFURLCreateWithCString(const char *cString)
{
    CFURLRef cfUrlRef = nil;
    
    if (cString)
    {
        CFIndex cStringLength = (CFIndex)strlen(cString);
        cfUrlRef = CFURLCreateWithBytes(kCFAllocatorDefault, (const UInt8 *)cString, cStringLength, kCFStringEncodingUTF8, nil);
    }
    
    return cfUrlRef;
}

NSURL *RWSQLiteNSURLCreateWithCString(const char *cString)
{
    NSURL *nsURL = (__bridge_transfer NSURL *)RWSQLiteCFURLCreateWithCString(cString);
    return nsURL;
}
