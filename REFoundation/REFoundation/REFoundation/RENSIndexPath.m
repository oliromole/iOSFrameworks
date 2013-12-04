//
//  RENSIndexPath.m
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

// Importing the header.
#import "RENSIndexPath.h"

// Importing the project headers.
#import "RENSObjCRuntime.h"
#import "RENSRange.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

NSIndexPath * NSIndexPathEmpty = nil;

@implementation NSIndexPath (NSIndexPathRENSIndexPath)

#pragma mark - Initializing a Class

+ (void)load
{
    NSIndexPathEmpty = [[NSIndexPath alloc] initWithIndexes:NULL length:0];
}

#pragma mark - Initializing and Creating a NSIndexPath

- (id)initWithLength:(NSUInteger)length, ...
{
    if (length == 0)
    {
        self = [self initWithIndexes:NULL length:0];
    }
    
    // Length > 0.
    else
    {
        NSUInteger indexes[length];
        
        va_list valist;
        va_start(valist, length);
        
        for (int position = 0; position < (NSInteger)length; position++)
        {
            NSUInteger index = va_arg(valist, NSUInteger);
            
            indexes[position] = index;
        }
        
        va_end(valist);
        
        self = [self initWithIndexes:indexes length:length];
    }
    
    return self;
}

+ (id)indexPathWithLength:(NSUInteger)length, ...
{
    NSIndexPath *indexPath = nil;
    
    if (length == 0)
    {
        indexPath = [self indexPathWithIndexes:NULL length:0];
    }
    
    // Length > 0.
    else
    {
        NSUInteger indexes[length];
        
        va_list valist;
        va_start(valist, length);
        
        for (int position = 0; position < (NSInteger)length; position++)
        {
            NSUInteger index = va_arg(valist, NSUInteger);
            
            indexes[position] = index;
        }
        
        va_end(valist);
        
        indexPath = [self indexPathWithIndexes:indexes length:length];
    }
    
    return indexPath;
}

#pragma mark - Combining Strings

- (NSIndexPath *)copyIndexPathByAppendingIndexPath:(NSIndexPath *)indexPath2
{
    if (!indexPath2)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The aIndexPath argument is nil." userInfo:nil];
    }
    
    NSUInteger length1 = self.length;
    NSUInteger length2 = indexPath2.length;
    NSUInteger length = length1 + length2;
    
    NSUInteger indexes[length];
    
    [self getIndexes:indexes];
    [indexPath2 getIndexes:(indexes + length1)];
    
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndexes:indexes length:length];
    
    return indexPath;
}

- (NSIndexPath *)indexPathByAppendingIndexPath:(NSIndexPath *)aIndexPath
{
    NSIndexPath *indexPath = [self copyIndexPathByAppendingIndexPath:aIndexPath];
    return indexPath;
}

- (NSIndexPath *)copyIndexPathByAppendingLength:(NSUInteger)length2, ...
{
    NSIndexPath *indexPath = nil;
    
    if (length2 == 0)
    {
        indexPath = self;
    }
    
    // Length > 0.
    else
    {
        NSUInteger length1 = self.length;
        NSUInteger length = length1 + length2;
        
        NSUInteger indexes[length];
        
        [self getIndexes:indexes];
        
        va_list valist;
        va_start(valist, length2);
        
        for (NSUInteger position2 = 0; position2 < length2; position2++)
        {
            NSUInteger index2 = va_arg(valist, NSUInteger);
            
            indexes[length1 + position2] = index2;
        }
        
        va_end(valist);
        
        indexPath = [[NSIndexPath alloc] initWithIndexes:indexes length:length];
    }
    
    return indexPath;
}

- (NSIndexPath *)indexPathByAppendingLength:(NSUInteger)length2, ...
{
    NSIndexPath *indexPath = nil;
    
    if (length2 == 0)
    {
        indexPath = self;
    }
    
    // Length > 0.
    else
    {
        NSUInteger length1 = self.length;
        NSUInteger length = length1 + length2;
        
        NSUInteger indexes[length];
        
        [self getIndexes:indexes];
        
        va_list valist;
        va_start(valist, length2);
        
        for (NSUInteger position2 = 0; position2 < length2; position2++)
        {
            NSUInteger index2 = va_arg(valist, NSUInteger);
            
            indexes[length1 + position2] = index2;
        }
        
        va_end(valist);
        
        indexPath = [[NSIndexPath alloc] initWithIndexes:indexes length:length];
    }
    
    return indexPath;
}

#pragma mark - Dividing Index Paths

- (NSIndexPath *)copySubindexPathFromPosition:(NSUInteger)fromPosition
{
    if (fromPosition > self.length)
    {
        @throw [NSException exceptionWithName:NSRangeException reason:@"The fromPosition argument is invalid." userInfo:nil];
    }
    
    NSRange range;
    range.location = fromPosition;
    range.length = self.length - fromPosition;
    
    NSIndexPath *subindexPath = [self copySubindexPathWithRange:range];
    
    return subindexPath;
}

- (NSIndexPath *)subindexPathFromPosition:(NSUInteger)fromPosition
{
    NSIndexPath *subindexPath = [self copySubindexPathFromPosition:fromPosition];
    return subindexPath;
}

- (NSIndexPath *)copySubindexPathToPosition:(NSUInteger)toPosition
{
    NSRange range;
    range.location = 0;
    range.length = toPosition;
    
    NSIndexPath *subindexPath = [self copySubindexPathWithRange:range];
    
    return subindexPath;
}

- (NSIndexPath *)subindexPathToPosition:(NSUInteger)toPosition
{
    NSIndexPath *subindexPath = [self copySubindexPathToPosition:toPosition];
    return subindexPath;
}

- (NSIndexPath *)copySubindexPathWithRange:(NSRange)range
{
    if (NSMaxRange(range) > self.length)
    {
        @throw [NSException exceptionWithName:NSRangeException reason:@"The range argument is invalid." userInfo:nil];
    }
    
    NSUInteger length = self.length;
    
    NSUInteger indexes[length];
    
    [self getIndexes:indexes];
    
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndexes:(indexes + range.location) length:range.length];
    
    return indexPath;
}

- (NSIndexPath *)subindexPathWithRange:(NSRange)range
{
    NSIndexPath *subindexPath = [self copySubindexPathWithRange:range];
    return subindexPath;
}

#pragma mark - Finding SubindexPaths

- (NSRange)rangeOfIndexPath:(NSIndexPath *)aIndexPath
{
    NSRange searchRange;
    searchRange.location = 0;
    searchRange.length = self.length;
    
    NSRange range = [self rangeOfIndexPath:aIndexPath options:0 range:searchRange];
    
    return range;
}

- (NSRange)rangeOfIndexPath:(NSIndexPath *)aIndexPath options:(NSIndexPathCompareOptions)mask
{
    NSRange searchRange;
    searchRange.location = 0;
    searchRange.length = self.length;
    
    NSRange range = [self rangeOfIndexPath:aIndexPath options:mask range:searchRange];
    
    return range;
}

- (NSRange)rangeOfIndexPath:(NSIndexPath *)indexPath2 options:(NSIndexPathCompareOptions)mask range:(NSRange)searchRange
{
    if (!indexPath2)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The aIndexPath argument is nil." userInfo:nil];
    }
    
    NSRange range = NSRangeNotFound;
    
    NSUInteger length1 = self.length;
    NSUInteger length2 = indexPath2.length;
    
    NSUInteger maxSearchRange = NSMaxRange(searchRange);
    
    if (maxSearchRange > length1)
    {
        @throw [NSException exceptionWithName:NSRangeException reason:@"The searchRange argument is invalid." userInfo:nil];
    }
    
    if ((length1 > 0) && (length2 > 0) && (maxSearchRange >= length2))
    {
        NSUInteger indexes1[length1];
        NSUInteger indexes2[length2];
        
        [self getIndexes:indexes1];
        [indexPath2 getIndexes:indexes2];
        
        if ((mask & NSIndexPathCompareOptionBackwardsSearch) == NSIndexPathCompareOptionBackwardsSearch)
        {
            // TODO: Implemented me.
            @throw [NSException exceptionWithName:NSGenericException reason:@"NSIndexPathCompareOptionBackwardsSearch does not supported. It is not implemented." userInfo:nil];
        }
        
        else
        {
            for (NSUInteger position1 = searchRange.location; (position1 + length2) <= maxSearchRange; position1++)
            {
                NSUInteger position2 = 0;
                
                for (; position2 < length2; position2++)
                {
                    NSUInteger index1 = indexes1[position1 + position2];
                    NSUInteger index2 = indexes2[position2];
                    
                    if (index1 != index2)
                    {
                        break;
                    }
                }
                
                if (position2 == length2)
                {
                    range.location = position1;
                    range.length = length2;
                    
                    break;
                }
            }
        }
        
    }
    
    return range;
}

- (void)enumerateIndexUsingBlock:(void (^)(NSUInteger index, NSUInteger position, BOOL *stop))block
{
    NSRange range;
    range.location = 0;
    range.length = self.length;
    
    [self enumerateIndexInRange:range options:0 usingBlock:block];
}

- (void)enumerateIndexWithOptions:(NSIndexPathEnumerationOptions)options usingBlock:(void (^)(NSUInteger index, NSUInteger position, BOOL *stop))block
{
    NSRange range;
    range.location = 0;
    range.length = self.length;
    
    [self enumerateIndexInRange:range options:options usingBlock:block];
}

- (void)enumerateIndexInRange:(NSRange)range options:(NSIndexPathEnumerationOptions)options usingBlock:(void (^)(NSUInteger index, NSUInteger position, BOOL *stop))block
{
    NSUInteger maxRange = NSMaxRange(range);
    
    NSUInteger length = self.length;
    
    if (maxRange > length)
    {
        @throw [NSException exceptionWithName:NSRangeException reason:@"The range argument is invalid." userInfo:nil];
    }
    
    BOOL stop = NO;
    
    if ((options & NSIndexPathCompareOptionBackwardsSearch) == NSIndexPathCompareOptionBackwardsSearch)
    {
        // TODO: Implemented me.
        @throw [NSException exceptionWithName:NSGenericException reason:@"NSIndexPathCompareOptionBackwardsSearch does not supported. It is not implemented." userInfo:nil];
    }
    
    else
    {
        for (NSUInteger position = range.location; !stop && (position < maxRange); position++)
        {
            NSUInteger index = [self indexAtPosition:position];
            
            block(index, position, &stop);
        }
    }
}

#pragma mark - Replacing Subindex Paths

- (NSIndexPath *)copyIndexPathByReplacingOccurrencesOfIndexPath:(NSIndexPath *)indexPath2 withIndexPath:(NSIndexPath *)indexPath3 options:(NSIndexPathCompareOptions)options range:(NSRange)searchRange
{
    if (!indexPath2)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The target argument is nil." userInfo:nil];
    }
    
    if (!indexPath3)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The replacement argument is nil." userInfo:nil];
    }
    
    NSUInteger maxSearchRange = NSMaxRange(searchRange);
    
    NSUInteger length1 = self.length;
    NSUInteger length2 = indexPath2.length;
    NSUInteger length3 = indexPath3.length;
    
    if (maxSearchRange > length1)
    {
        @throw [NSException exceptionWithName:NSRangeException reason:@"The searchRange argument is invalid." userInfo:nil];
    }
    
    NSIndexPath *indexPath = nil;
    
    if ((length1 > 0) && (length2 > 0) && (maxSearchRange >= length2))
    {
        NSUInteger indexes1[length1];
        NSUInteger indexes2[length2];
        NSUInteger indexes3[length3];
        
        [self getIndexes:indexes1];
        [indexPath2 getIndexes:indexes2];
        [indexPath3 getIndexes:indexes3];
        
        NSUInteger oldPosition1 = 0;
        
        NSRange    ranges1[length1];
        NSUInteger numberOfRanges1 = 0;
        
        NSUInteger length = 0;
        
        if ((options & NSIndexPathCompareOptionBackwardsSearch) == NSIndexPathCompareOptionBackwardsSearch)
        {
            // TODO: Implemented me.
            @throw [NSException exceptionWithName:NSGenericException reason:@"NSIndexPathCompareOptionBackwardsSearch does not supported. It is not implemented." userInfo:nil];
        }
        
        else
        {
            NSUInteger position1 = searchRange.location;
            
            for (; (position1 + length2) <= maxSearchRange; position1++)
            {
                NSUInteger position2 = 0;
                
                for (; position2 < length2; position2++)
                {
                    NSUInteger index1 = indexes1[position1 + position2];
                    NSUInteger index2 = indexes2[position2];
                    
                    if (index1 != index2)
                    {
                        break;
                    }
                }
                
                if (position2 == length2)
                {
                    ranges1[numberOfRanges1].location = oldPosition1;
                    ranges1[numberOfRanges1].length = position1 - oldPosition1;
                    
                    length += ranges1[numberOfRanges1].length + length3;
                    
                    numberOfRanges1++;
                    
                    oldPosition1 = position1 + length2;
                    position1 = position1 + length2 - 1;
                }
            }
            
            ranges1[numberOfRanges1].location = oldPosition1;
            ranges1[numberOfRanges1].length = length1 - oldPosition1;
            
            length += ranges1[numberOfRanges1].length;
            
            numberOfRanges1++;
            
            NSUInteger indexes[length];
            NSUInteger position = 0;
            
            for (NSUInteger indexOfRange1 = 0; indexOfRange1 < numberOfRanges1; indexOfRange1++)
            {
                NSRange range1 = ranges1[indexOfRange1];
                
                memcpy((indexes + position), (indexes1 + range1.location), (sizeof(NSUInteger) * range1.length));
                
                position += range1.length;
                
                if (indexOfRange1 < (numberOfRanges1 - 1))
                {
                    memcpy((indexes + position), indexes3, (sizeof(NSUInteger) * length3));
                    
                    position += length3;
                }
            }
            
            indexPath = [[NSIndexPath alloc] initWithIndexes:indexes length:length];
        }
    }
    
    else
    {
        indexPath = self;
    }
    
    return indexPath;
}

- (NSIndexPath *)indexPathByReplacingOccurrencesOfIndexPath:(NSIndexPath *)target withIndexPath:(NSIndexPath *)replacement options:(NSIndexPathCompareOptions)options range:(NSRange)searchRange
{
    NSIndexPath *indexPath = [self copyIndexPathByReplacingOccurrencesOfIndexPath:target withIndexPath:replacement options:options range:searchRange];
    return indexPath;
}

- (NSIndexPath *)copyIndexPathByReplacingOccurrencesOfIndexPath:(NSIndexPath *)target withIndexPath:(NSIndexPath *)replacement
{
    NSRange searchRange;
    searchRange.location = 0;
    searchRange.length = self.length;
    
    NSIndexPath *indexPath = [self copyIndexPathByReplacingOccurrencesOfIndexPath:target withIndexPath:replacement options:0 range:searchRange];
    
    return indexPath;
}

- (NSIndexPath *)indexPathByReplacingOccurrencesOfIndexPath:(NSIndexPath *)target withIndexPath:(NSIndexPath *)replacement
{
    NSIndexPath *indexPath = [self copyIndexPathByReplacingOccurrencesOfIndexPath:target withIndexPath:replacement];
    return indexPath;
}

- (NSIndexPath *)copyIndexPathByReplacingIndexesInRange:(NSRange)range withIndexPath:(NSIndexPath *)indexPath2
{
    if (!indexPath2)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The replacement argument is invalid." userInfo:nil];
    }
    
    NSUInteger maxRange = NSMaxRange(range);
    
    NSUInteger length1 = self.length;
    NSUInteger length2 = indexPath2.length;
    NSUInteger length = length1 - range.length + length2;
    
    if (maxRange > length1)
    {
        @throw [NSException exceptionWithName:NSRangeException reason:@"The range argument is invalid." userInfo:nil];
    }
    
    NSUInteger indexes1[length1];
    NSUInteger indexes2[length2];
    NSUInteger indexes[length];
    
    [self getIndexes:indexes1];
    [indexPath2 getIndexes:indexes2];
    
    memcpy(indexes, indexes1, sizeof(NSUInteger) * range.location);
    memcpy((indexes + range.location), indexes2, sizeof(NSUInteger) * length2);
    memcpy((indexes + range.location + length2), (indexes1 + maxRange), sizeof(NSUInteger) * (length1 - maxRange));
    
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndexes:indexes length:length];
    
    return indexPath;
}

- (NSIndexPath *)indexPathByReplacingIndexesInRange:(NSRange)range withIndexPath:(NSIndexPath *)replacement
{
    NSIndexPath *indexPath = [self copyIndexPathByReplacingIndexesInRange:range withIndexPath:replacement];
    return indexPath;
}

#pragma mark - Comparing Index Paths

- (NSComparisonResult)caseInvertedCompare:(NSIndexPath *)rightIndexPath
{
    // Comparing the left index path with the right index path.
    NSComparisonResult comparisonResult = [self compare:rightIndexPath];
    
    // Inverting the result of the compared index paths.
    NSComparisonResult invertedComparisonResult = NSInvertComparisonResult(comparisonResult);
    
    // Returning the inverted result of the compared index paths.
    return invertedComparisonResult;
}

- (BOOL)hasPrefix:(NSIndexPath *)indexPath2
{
    if (!indexPath2)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The aIndexPath argument is nil." userInfo:nil];
    }
    
    NSUInteger length1 = self.length;
    NSUInteger length2 = indexPath2.length;
    
    BOOL hasPrefix = NO;
    
    if ((length2 > 0) && (length1 >= length2))
    {
        NSUInteger indexes1[length1];
        NSUInteger indexes2[length2];
        
        [self getIndexes:indexes1];
        [indexPath2 getIndexes:indexes2];
        
        NSUInteger position = 0;
        
        for (; position < length2; position++)
        {
            NSUInteger index1 = indexes1[position];
            NSUInteger index2 = indexes2[position];
            
            if (index1 != index2)
            {
                break;
            }
        }
        
        hasPrefix = (position == length2);
    }
    
    return hasPrefix;
}

- (BOOL)hasSuffix:(NSIndexPath *)indexPath2
{
    if (!indexPath2)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The aIndexPath argument is nil." userInfo:nil];
    }
    
    NSUInteger length1 = self.length;
    NSUInteger length2 = indexPath2.length;
    
    BOOL hasPrefix = NO;
    
    if ((length2 > 0) && (length1 >= length2))
    {
        NSUInteger indexes1[length1];
        NSUInteger indexes2[length2];
        
        [self getIndexes:indexes1];
        [indexPath2 getIndexes:indexes2];
        
        NSUInteger position = 0;
        
        for (; position < length2; position++)
        {
            NSUInteger index1 = indexes1[length1 - position - 1];
            NSUInteger index2 = indexes2[length2 - position - 1];
            
            if (index1 != index2)
            {
                break;
            }
        }
        
        hasPrefix = (position == length2);
    }
    
    return hasPrefix;
}

#pragma mark - Querying Index Paths

- (NSIndexPath *)copyIndexPathByAddingIndex:(NSUInteger)index
{
    NSUInteger length = self.length;
    
    NSUInteger indexes[length + 1];
    indexes[length] = index;
    
    [self getIndexes:indexes];
    
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndexes:indexes length:(length + 1)];
    
    return indexPath;
}

- (NSIndexPath *)copyIndexPathByRemovingLastIndex
{
    NSIndexPath *indexPath = nil;
    
    NSUInteger length = self.length;
    
    if (length <= 1)
    {
        indexPath = [[NSIndexPath alloc] initWithIndexes:NULL length:0];
    }
    
    else
    {
        NSUInteger indexes[length];
        
        [self getIndexes:indexes];
        
        indexPath = [[NSIndexPath alloc] initWithIndexes:indexes length:(length - 1)];
    }
    
    return indexPath;
}

@end
