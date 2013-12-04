//
//  RERFC822.m
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2010.10.09.
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
#import "RERFC822.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation NSString (NSStringRERFC822)

#pragma mark - Methods of RFC 822

- (NSDate *)dateRFC822
{
    NSDate *date = nil;
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    if (locale)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        if (dateFormatter)
        {
            [dateFormatter setLocale:locale];
            
            if (!date)
            {
                [dateFormatter setDateFormat:@"eee, d MMM y H:m:s ZZZ"];
                date = [dateFormatter dateFromString:self];
            }
            
            if (!date)
            {
                [dateFormatter setDateFormat:@"eee, d MMM y H:m ZZZ"];
                date = [dateFormatter dateFromString:self];
            }
            
            if (!date)
            {
                [dateFormatter setDateFormat:@"d MMM y H:m:s ZZZ"];
                date = [dateFormatter dateFromString:self];
            }
            
            if (!date)
            {
                [dateFormatter setDateFormat:@"d MMM y H:m ZZZ"];
                date = [dateFormatter dateFromString:self];
            }
        }
    }
    
    return date;
}

@end

@implementation NSDate (NSDateRERFC822)

#pragma mark - Methods of RFC 822

- (NSString *)stringRFC822
{
    NSString *string = nil;
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    if (locale)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        if (dateFormatter)
        {
            [dateFormatter setLocale:locale];
            [dateFormatter setDateFormat:@"eee, dd MMM yyyy HH:mm:ss ZZZ"];
            
            string = [dateFormatter stringFromDate:self];
        }
    }
    
    return string;
}

@end

@implementation NSDateFormatter (NSDateFormatterRERFC822)

#pragma mark - Methods of RFC 822

+ (NSDate *)dateForStringRFC822:(NSString *)string
{
    NSDate *date = [string dateRFC822];
    return date;
}

+ (NSString *)stringRFC822ForDate:(NSDate *)date
{
    NSString *string = [date stringRFC822];
    return string;
}

@end
