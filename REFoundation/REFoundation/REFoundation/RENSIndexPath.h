//
//  RENSIndexPath.h
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.07.22.
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
#import <Foundation/NSIndexPath.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSRange.h>

@class NSIndexPath;

typedef NS_OPTIONS(NSUInteger, NSIndexPathCompareOptions)
{
    NSIndexPathCompareOptionBackwardsSearch = 1 << 0  // Search from end of source index path.
};

typedef NS_OPTIONS(NSUInteger, NSIndexPathEnumerationOptions)
{
    NSIndexPathEnumerationOptionReverse = 1 << 0      // Causes enumeration to occur from the end of the specified range to the start.
};

@interface NSIndexPath (NSIndexPathRENSIndexPath)

// Initializing and Creating a NSIndexPath

- (id)initWithLength:(NSUInteger)length, ...;
+ (id)indexPathWithLength:(NSUInteger)length, ...;

// Combining Strings

- (NSIndexPath *)copyIndexPathByAppendingIndexPath:(NSIndexPath *)aIndexPath;
- (NSIndexPath *)indexPathByAppendingIndexPath:(NSIndexPath *)aIndexPath;
- (NSIndexPath *)copyIndexPathByAppendingLength:(NSUInteger)length, ...;
- (NSIndexPath *)indexPathByAppendingLength:(NSUInteger)length, ...;

// Dividing Index Paths

- (NSIndexPath *)copySubindexPathFromPosition:(NSUInteger)from;
- (NSIndexPath *)subindexPathFromPosition:(NSUInteger)from;
- (NSIndexPath *)copySubindexPathToPosition:(NSUInteger)to;
- (NSIndexPath *)subindexPathToPosition:(NSUInteger)to;
- (NSIndexPath *)copySubindexPathWithRange:(NSRange)range;
- (NSIndexPath *)subindexPathWithRange:(NSRange)range;

// Finding Index and SubindexPaths

- (NSRange)rangeOfIndexPath:(NSIndexPath *)aIndexPath;
- (NSRange)rangeOfIndexPath:(NSIndexPath *)aIndexPath options:(NSIndexPathCompareOptions)mask;
- (NSRange)rangeOfIndexPath:(NSIndexPath *)aIndexPath options:(NSIndexPathCompareOptions)mask range:(NSRange)searchRange;

- (void)enumerateIndexUsingBlock:(void (^)(NSUInteger index, NSUInteger position, BOOL *stop))block;
- (void)enumerateIndexWithOptions:(NSIndexPathEnumerationOptions)options usingBlock:(void (^)(NSUInteger index, NSUInteger position, BOOL *stop))block;
- (void)enumerateIndexInRange:(NSRange)range options:(NSIndexPathEnumerationOptions)options usingBlock:(void (^)(NSUInteger index, NSUInteger position, BOOL *stop))block;

// Replacing Subindex Paths

- (NSIndexPath *)copyIndexPathByReplacingOccurrencesOfIndexPath:(NSIndexPath *)target withIndexPath:(NSIndexPath *)replacement options:(NSIndexPathCompareOptions)options range:(NSRange)searchRange;
- (NSIndexPath *)indexPathByReplacingOccurrencesOfIndexPath:(NSIndexPath *)target withIndexPath:(NSIndexPath *)replacement options:(NSIndexPathCompareOptions)options range:(NSRange)searchRange;
- (NSIndexPath *)copyIndexPathByReplacingOccurrencesOfIndexPath:(NSIndexPath *)target withIndexPath:(NSIndexPath *)replacement;
- (NSIndexPath *)indexPathByReplacingOccurrencesOfIndexPath:(NSIndexPath *)target withIndexPath:(NSIndexPath *)replacement;
- (NSIndexPath *)copyIndexPathByReplacingIndexesInRange:(NSRange)range withIndexPath:(NSIndexPath *)replacement;
- (NSIndexPath *)indexPathByReplacingIndexesInRange:(NSRange)range withIndexPath:(NSIndexPath *)replacement;

// Comparing Index Paths

- (NSComparisonResult)caseInvertedCompare:(NSIndexPath *)rightIndexPath;

- (BOOL)hasPrefix:(NSIndexPath *)aIndexPath;
- (BOOL)hasSuffix:(NSIndexPath *)aIndexPath;

// Querying Index Paths

- (NSIndexPath *)copyIndexPathByAddingIndex:(NSUInteger)index;
- (NSIndexPath *)copyIndexPathByRemovingLastIndex;

@end

FOUNDATION_EXTERN NSIndexPath * NSIndexPathEmpty;
