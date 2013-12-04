//
//  RENSString.h
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.06.27.
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
#import "RENSObject.h"

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSRange.h>
#import <Foundation/NSString.h>

@class NSCharacterSet;
@class NSSet;
@class NSString;

@interface NSString (NSStringRENSString)

// Getting a String’s Range

/*
 Return the NSRange structure giving the location is 0 and the length is the the number of Unicode characters currently in the receiver.
 */
- (NSRange)range;

// Getting a Substring

- (NSString *)copySubstringFromIndex:(NSUInteger)from;
- (NSString *)copySubstringToIndex:(NSUInteger)to;
- (NSString *)copySubstringWithRange:(NSRange)range;

// Modifying a String

- (NSString *)copyStringByDeletingPrefix:(NSString *)prefix;
- (NSString *)stringByDeletingPrefix:(NSString *)prefix;
- (NSString *)copyStringByDeletingSuffix:(NSString *)suffix;
- (NSString *)stringByDeletingSuffix:(NSString *)suffix;

// Trimming a String

- (NSString *)copyStringByTrimming;
- (NSString *)stringByTrimming;
- (NSString *)copyStringByTrimmingLeft;
- (NSString *)stringByTrimmingLeft;
- (NSString *)copyStringByTrimmingRight;
- (NSString *)stringByTrimmingRight;

- (NSString *)copyStringByTrimmingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)copyStringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)copyStringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

- (NSString *)copyStringByTrimmingStrings:(NSString *)string0, ... NS_REQUIRES_NIL_TERMINATION;
- (NSString *)stringByTrimmingStrings:(NSString *)string0, ... NS_REQUIRES_NIL_TERMINATION;
- (NSString *)copyStringByTrimmingLeftStrings:(NSString *)string0, ... NS_REQUIRES_NIL_TERMINATION;
- (NSString *)stringByTrimmingLeftStrings:(NSString *)string0, ... NS_REQUIRES_NIL_TERMINATION;
- (NSString *)copyStringByTrimmingRightStrings:(NSString *)string0, ... NS_REQUIRES_NIL_TERMINATION;
- (NSString *)stringByTrimmingRightStrings:(NSString *)string0, ... NS_REQUIRES_NIL_TERMINATION;

- (NSString *)copyStringByTrimmingStringsInSet:(NSSet *)stringSet;
- (NSString *)stringByTrimmingStringsInSet:(NSSet *)stringSet;
- (NSString *)copyStringByTrimmingLeftStringsInSet:(NSSet *)stringSet;
- (NSString *)stringByTrimmingLeftStringsInSet:(NSSet *)stringSet;
- (NSString *)copyStringByTrimmingRightStringsInSet:(NSSet *)stringSet;
- (NSString *)stringByTrimmingRightStringsInSet:(NSSet *)stringSet;

// Identifying and Comparing Strings

+ (NSComparisonResult)compareLeftString:(NSString *)leftString rightString:(NSString *)rightString;
+ (NSComparisonResult)compareLeftString:(NSString *)leftString rightString:(NSString *)rightString options:(NSStringCompareOptions)mask;

+ (NSComparisonResult)caseIdenticalCompareLeftString:(NSString *)leftString rightString:(NSString *)rightString;
+ (NSComparisonResult)caseInsensitiveCompareLeftString:(NSString *)leftString rightString:(NSString *)rightString;

+ (NSComparisonResult)localizedCompareLeftString:(NSString *)leftString rightString:(NSString *)rightString;
+ (NSComparisonResult)localizedCaseInsensitiveCompareLeftString:(NSString *)leftString rightString:(NSString *)rightString;

/*
 Returns the result identical comparing characters.
 
 aString:
 The string with which to compare the receiver.
 This value must not be nil. If this value is nil, the behavior is undefined and may change in future versions of Mac OS X.
 */
- (NSComparisonResult)caseIdenticalCompare:(NSString *)string;

- (BOOL)hasPrefix:(NSString *)aString range:(NSRange)range;
- (BOOL)hasSuffix:(NSString *)aString range:(NSRange)range;

// Getting C Strings

// NULL return if conversion not possible due to encoding errors.
- (void)getCString:(char **)pCString encoding:(NSStringEncoding)encoding;
- (void)getUTF8String:(char **)pCString;

// Working with Encodings

- (NSData *)dataUsingUTF8StringEncoding;

@end

@interface NSMutableString (NSMutableStringRENSMutableString)

// Modifying a String

- (void)deleteAllCharacters;
- (void)deleteLastCharacter;

- (void)deletePrefix:(NSString *)prefix;
- (void)deleteSuffix:(NSString *)suffix;

// Replacing Substrings

- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement;

// Trimming a String

- (void)trim;
- (void)trimLeft;
- (void)trimRight;

- (void)trimCharactersInSet:(NSCharacterSet *)characterSet;
- (void)trimLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (void)trimRightCharactersInSet:(NSCharacterSet *)characterSet;

- (void)trimStrings:(NSString *)string0, ... NS_REQUIRES_NIL_TERMINATION;
- (void)trimLeftStrings:(NSString *)string0, ... NS_REQUIRES_NIL_TERMINATION;
- (void)trimRightStrings:(NSString *)string0, ... NS_REQUIRES_NIL_TERMINATION;

- (void)trimStringsInSet:(NSSet *)stringSet;
- (void)trimLeftStringsInSet:(NSSet *)stringSet;
- (void)trimRightStringsInSet:(NSSet *)stringSet;

// Inserting a Indent

- (void)insertIndent:(NSString *)indent separatedByString:(NSString *)separator;
- (void)insertLeftIndent:(NSString *)indent separatedByString:(NSString *)separator;
- (void)insertRightIndent:(NSString *)indent separatedByString:(NSString *)separator;

@end

#define NSStringCast(string) NSObjectCast(string, NSString)
#define NSMutableStringCast(string) NSObjectCast(string, NSMutableString)
#define NSMutableStringCastOrCopy(string) NSMutableObjectCastOrCopy(string, NSMutableString)

FOUNDATION_EXTERN void *RECStringCreateWithNSString(NSString *nsString, NSStringEncoding encoding, BOOL fast, void *(*mallocFuntion)(size_t), void (*freeFunction)(void *));
FOUNDATION_EXTERN NSString *RENSStringCreateWithCString(const void *cString, int numberOfBytes, NSStringEncoding encoding);
FOUNDATION_EXTERN NSMutableString *RENSMutableStringCreateWithCString(const void *cString, int numberOfBytes, NSStringEncoding encoding);
