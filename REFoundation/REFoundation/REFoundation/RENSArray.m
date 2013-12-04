//
//  RENSArray.m
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

// Importing the header.
#import "RENSArray.h"

// Importing the project headers.
#import "RENSException.h"
#import "RENSIndexPath.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation NSArray (NSArrayRENSArray)

#pragma mark - Initializing and Creating an Array.

- (id)initWithLength:(NSUInteger)length
{
    return [self initWithLength:length object:[NSNull null]];
}

+ (id)arrauWithLength:(NSUInteger)length
{
    return [[self alloc] initWithLength:length];
}

- (id)initWithLength:(NSUInteger)length object:(id)object
{
    __unsafe_unretained id *objects = (__unsafe_unretained id *)malloc(length * sizeof(id));
    
    RENSAssert(objects, @"Low memory.");
    
    for (NSUInteger index = 0; index < length; index++)
    {
        objects[index] = object;
    }
    
    if ((self = [self initWithObjects:objects count:length]))
    {
    }
    
    free(objects);
    objects = NULL;
    
    return self;
}

+ (id)arrauWithLength:(NSUInteger)length object:(id)object
{
    return [[self alloc] initWithLength:length object:object];
}

#pragma mark - Querying an Array

- (NSRange)range
{
    NSRange range;
    range.location = 0;
    range.length = self.count;
    
    return range;
}

- (id)firstObject
{
    id firstObject = nil;
    
    if (self.count > 0)
    {
        firstObject = [self objectAtIndex:0];
    }
    
    return firstObject;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath argument is nil." userInfo:nil];
    }
    
    NSArray    *array = self;
    NSUInteger  length = indexPath.length;
    id          object = nil;
    
    for (NSUInteger position = 0; position < length; position++)
    {
        NSUInteger index = [indexPath indexAtPosition:position];
        
        if (position == (length - 1))
        {
            object = [array objectAtIndex:index];
        }
        
        else
        {
            array = [array objectAtIndex:index];
        }
    }
    
    return object;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))childArrayBlock
{
    if (!indexPath)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath argument is nil." userInfo:nil];
    }
    
    NSArray    *array = self;
    NSUInteger  length = indexPath.length;
    id          object = nil;
    
    for (NSUInteger position = 0; position < length; position++)
    {
        NSUInteger index = [indexPath indexAtPosition:position];
        
        if (position == (length - 1))
        {
            object = [array objectAtIndex:index];
        }
        
        else
        {
            NSIndexPath *subindexPath = [indexPath copySubindexPathToPosition:(position + 1)];
            
            id object2 = [array objectAtIndex:index];
            array = childArrayBlock(object2, subindexPath);
        }
    }
    
    return object;
}

#pragma mark - Finding Objects in an Array

- (NSUInteger)indexOfObject:(id)anObject options:(NSEnumerationOptions)options
{
#pragma unused(options)
    
    NSUInteger indexOfObject = [self indexOfObject:anObject inRange:self.range options:0];
    return indexOfObject;
}

- (NSUInteger)indexOfObject:(id)anObject inRange:(NSRange)range options:(NSEnumerationOptions)options
{
    if (NSMaxRange(range) > self.count)
    {
        @throw [NSException exceptionWithName:NSRangeException reason:@"The range argument is invalid." userInfo:nil];
    }
    
    NSInteger indexOfObject = NSNotFound;
    
    if ((options & NSEnumerationReverse) == NSEnumerationReverse)
    {
        NSInteger index1 = (NSInteger)range.location - 1;
        
        for (NSInteger index2 = (NSInteger)NSMaxRange(range) - 1; index1 < index2; index2--)
        {
            id object = [self objectAtIndex:(NSUInteger)index2];
            
            if ([object isEqual:anObject])
            {
                indexOfObject = index2;
                break;
            }
        }
    }
    
    else
    {
        NSInteger index2 = (NSInteger)NSMaxRange(range);
        
        for (NSInteger index1 = (NSInteger)range.location; index1 < index2; index1++)
        {
            id object = [self objectAtIndex:(NSUInteger)index1];
            
            if ([object isEqual:anObject])
            {
                indexOfObject = index1;
                break;
            }
        }
    }
    
    return (NSUInteger)indexOfObject;
}

- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject options:(NSEnumerationOptions)options
{
    NSUInteger indexOfObject = [self indexOfObjectIdenticalTo:anObject inRange:self.range options:options];
    return indexOfObject;
}

- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range options:(NSEnumerationOptions)options
{
    if (NSMaxRange(range) > self.count)
    {
        @throw [NSException exceptionWithName:NSRangeException reason:@"The range argument is invalid." userInfo:nil];
    }
    
    NSInteger indexOfObject = NSNotFound;
    
    if ((options & NSEnumerationReverse) == NSEnumerationReverse)
    {
        NSInteger index1 = (NSInteger)range.location - 1;
        
        for (NSInteger index2 = (NSInteger)NSMaxRange(range) - 1; index1 < index2; index2--)
        {
            id object = [self objectAtIndex:(NSUInteger)index2];
            
            if (object == anObject)
            {
                indexOfObject = index2;
                break;
            }
        }
    }
    
    else
    {
        NSInteger index2 = (NSInteger)NSMaxRange(range);
        
        for (NSInteger index1 = (NSInteger)range.location; index1 < index2; index1++)
        {
            id object = [self objectAtIndex:(NSUInteger)index1];
            
            if (object == anObject)
            {
                indexOfObject = index1;
                break;
            }
        }
    }
    
    return (NSUInteger)indexOfObject;
}

#pragma mark - Reversing the Array

- (NSArray *)reversedArray
{
    NSInteger count = (NSInteger)self.count;
    NSInteger index = count - 1;
    
    NSMutableArray *mutableReversedArray = [[NSMutableArray alloc] initWithCapacity:(NSUInteger)count];
    
    while (index > -1)
    {
        id object = [self objectAtIndex:(NSUInteger)index];
        [mutableReversedArray addObject:object];
        
        index--;
    }
    
    NSArray *reversedArray = [mutableReversedArray copy];
    
    return reversedArray;
}

#pragma mark - Sending Messages to Elements

- (BOOL)enumerateObjectsWithParentIndexPath:(NSIndexPath *)parentIndexPath usingIndexPathBlock:(void (^)(id object, NSIndexPath *indexPath, BOOL *stop))indexPathBlock
{
    if (!parentIndexPath)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The parentIndexPath argument is nil." userInfo:nil];
    }
    
    Class arrayClass = [NSArray class];
    BOOL  stop = NO;
    
    for (NSUInteger index = 0; !stop && (index < self.count); index++)
    {
        id object = [self objectAtIndex:index];
        
        NSIndexPath *indexPath = [parentIndexPath copyIndexPathByAddingIndex:index];
        
        indexPathBlock(object, indexPath, &stop);
        
        if (!stop && [object isKindOfClass:arrayClass])
        {
            NSArray *childArray = (NSArray *)object;
            
            stop = [childArray enumerateObjectsWithParentIndexPath:indexPath usingIndexPathBlock:indexPathBlock];
        }
    }
    
    return stop;
}

- (void)enumerateObjectsUsingIndexPathBlock:(void (^)(id object, NSIndexPath *indexPath, BOOL *stop))indexPathBlock
{
    NSIndexPath *parentIndexPath = [[NSIndexPath alloc] initWithIndexes:NULL length:0];
    
    [self enumerateObjectsWithParentIndexPath:parentIndexPath usingIndexPathBlock:indexPathBlock];
}

- (BOOL)enumerateObjectsWithParentIndexPath:(NSIndexPath *)parentIndexPath usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))childArrayBlock indexPathBlock:(void (^)(id object, NSIndexPath *indexPath, BOOL *stop))indexPathBlock
{
    if (!parentIndexPath)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The parentIndexPath argument is nil." userInfo:nil];
    }
    
    BOOL  stop = NO;
    
    for (NSUInteger index = 0; !stop && (index < self.count); index++)
    {
        id object = [self objectAtIndex:index];
        
        NSIndexPath *indexPath = [parentIndexPath copyIndexPathByAddingIndex:index];
        
        indexPathBlock(object, indexPath, &stop);
        
        if (!stop)
        {
            NSArray *childArray = childArrayBlock(object, indexPath);
            
            if (childArray)
            {
                stop = [childArray enumerateObjectsWithParentIndexPath:indexPath usingChildArrayBlock:childArrayBlock indexPathBlock:indexPathBlock];
            }
        }
    }
    
    return stop;
}

- (void)enumerateObjectsUsingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))childArrayBlock indexPathBlock:(void (^)(id object, NSIndexPath *indexPath, BOOL *stop))indexPathBlock
{
    NSIndexPath *parentIndexPath = [[NSIndexPath alloc] initWithIndexes:NULL length:0];
    
    [self enumerateObjectsWithParentIndexPath:parentIndexPath usingChildArrayBlock:childArrayBlock indexPathBlock:indexPathBlock];
}

@end

@implementation NSMutableArray (NSMutableArrayRENSMutableArray)

#pragma mark - Adding Objects

- (void)addObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath argument is nil." userInfo:nil];
    }
    
    NSMutableArray *array = self;
    NSUInteger      length = indexPath.length;
    
    for (NSUInteger position = 0; position < length; position++)
    {
        NSUInteger index = [indexPath indexAtPosition:position];
        
        array = [array objectAtIndex:index];
    }
    
    [array addObject:anObject];
}

- (void)addObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))childArrayBlock
{
    if (!indexPath)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath argument is nil." userInfo:nil];
    }
    
    NSMutableArray *array = self;
    NSUInteger      length = indexPath.length;
    
    for (NSUInteger position = 0; position < length; position++)
    {
        NSUInteger index = [indexPath indexAtPosition:position];
        
        id object = [array objectAtIndex:index];
        
        NSIndexPath *subindexPath = [indexPath copySubindexPathToPosition:(position + 1)];
        
        array = childArrayBlock(object, subindexPath);
    }
    
    [array addObject:anObject];
}

- (void)insertObject:(id)object inSortedRange:(NSRange)range options:(NSBinarySearchingOptions)options usingComparator:(NSComparator)comparatorBlock
{
    // Correcting the options.
    options = ((options & (NSBinarySearchingFirstEqual | NSBinarySearchingLastEqual | NSBinarySearchingInsertionIndex)) | NSBinarySearchingInsertionIndex);
    
    // Getting th insertion index.
    NSUInteger insertionIndex = [self indexOfObject:object inSortedRange:range options:options usingComparator:comparatorBlock];
    
    // Inserting the object.
    [self insertObject:object atIndex:insertionIndex];
}

- (void)insertObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath argument is nil." userInfo:nil];
    }
    
    NSMutableArray *array = self;
    NSUInteger      length = indexPath.length;
    
    for (NSUInteger position = 0; position < length; position++)
    {
        NSUInteger index = [indexPath indexAtPosition:position];
        
        if (position == (length - 1))
        {
            [array insertObject:anObject atIndex:index];
        }
        
        else
        {
            array = [array objectAtIndex:index];
        }
    }
}

- (void)insertObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))childArrayBlock
{
    if (!indexPath)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath argument is nil." userInfo:nil];
    }
    
    NSMutableArray *array = self;
    NSUInteger      length = indexPath.length;
    
    for (NSUInteger position = 0; position < length; position++)
    {
        NSUInteger index = [indexPath indexAtPosition:position];
        
        if (position == (length - 1))
        {
            [array insertObject:anObject atIndex:index];
        }
        
        else
        {
            id object = [array objectAtIndex:index];
            
            NSIndexPath *subindexPath = [indexPath copySubindexPathToPosition:(position + 1)];
            
            array = childArrayBlock(object, subindexPath);
        }
    }
}

#pragma mark - Replacing Objects

- (void)replaceObjectAtIndexPath:(NSIndexPath *)indexPath withObject:(id)anObject
{
    if (!indexPath)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath argument is nil." userInfo:nil];
    }
    
    NSMutableArray *array = self;
    NSUInteger      length = indexPath.length;
    
    for (NSUInteger position = 0; position < length; position++)
    {
        NSUInteger index = [indexPath indexAtPosition:position];
        
        if (position == (length - 1))
        {
            [array replaceObjectAtIndex:index withObject:anObject];
        }
        
        else
        {
            array = [array objectAtIndex:index];
        }
    }
}

- (void)replaceObjectAtIndexPath:(NSIndexPath *)indexPath withObject:(id)anObject usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))childArrayBlock
{
    if (!indexPath)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath argument is nil." userInfo:nil];
    }
    
    NSMutableArray *array = self;
    NSUInteger      length = indexPath.length;
    
    for (NSUInteger position = 0; position < length; position++)
    {
        NSUInteger index = [indexPath indexAtPosition:position];
        
        if (position == (length - 1))
        {
            [array replaceObjectAtIndex:index withObject:anObject];
        }
        
        else
        {
            id object = [array objectAtIndex:index];
            
            NSIndexPath *subindexPath = [indexPath copySubindexPathToPosition:(position + 1)];
            
            array = childArrayBlock(object, subindexPath);
        }
    }
}

#pragma mark - Removing Objects

- (void)removeFirstObject
{
    [self removeObjectAtIndex:0];
}

- (void)removeObject:(id)anObject options:(NSEnumerationOptions)options
{
    [self removeObject:anObject inRange:self.range options:options];
}

- (void)removeObject:(id)anObject inRange:(NSRange)range options:(NSEnumerationOptions)options
{
    NSUInteger indexOfObject = [self indexOfObject:anObject inRange:range options:options];
    
    if (indexOfObject != NSNotFound)
    {
        [self removeObjectAtIndex:indexOfObject];
    }
}

- (void)removeObjectIdenticalTo:(id)anObject options:(NSEnumerationOptions)options
{
    [self removeObjectIdenticalTo:anObject inRange:self.range options:options];
}

- (void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range options:(NSEnumerationOptions)options
{
    NSUInteger indexOfObject = [self indexOfObjectIdenticalTo:anObject inRange:range options:options];
    
    if (indexOfObject != NSNotFound)
    {
        [self removeObjectAtIndex:indexOfObject];
    }
}

- (void)removeObject:(id)object inSortedRange:(NSRange)range options:(NSBinarySearchingOptions)options usingComparator:(NSComparator)comparatorBlock
{
    // Correcting the options.
    options = (options & (NSBinarySearchingFirstEqual | NSBinarySearchingLastEqual));
    
    // Getting the index of object.
    NSUInteger indexOfObject = [self indexOfObject:object inSortedRange:range options:options usingComparator:comparatorBlock];
    
    // We found the object.
    if (indexOfObject != NSNotFound)
    {
        // Removing the object.
        [self removeObjectAtIndex:indexOfObject];
    }
}

- (void)removeObject:(id)object inSortedRange:(NSRange)range usingComparator:(NSComparator)comparatorBlock
{
    // Getting the first index of object.
    NSUInteger firstIndexOfObject = [self indexOfObject:object inSortedRange:range options:(NSBinarySearchingFirstEqual) usingComparator:comparatorBlock];
    
    // We found the object.
    if (firstIndexOfObject)
    {
        // Getting the last index of object.
        NSUInteger lastIndexOfObject = [self indexOfObject:object inSortedRange:range options:(NSBinarySearchingLastEqual) usingComparator:comparatorBlock];
        
        // Creating the range.
        NSRange range2;
        range2.location = firstIndexOfObject;
        range2.length = lastIndexOfObject - firstIndexOfObject + 1;
        
        // Removing the objects in the range.
        [self removeObjectsInRange:range2];
    }
}

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath argument is nil." userInfo:nil];
    }
    
    NSMutableArray *array = self;
    NSUInteger      length = indexPath.length;
    
    for (NSUInteger position = 0; position < length; position++)
    {
        NSUInteger index = [indexPath indexAtPosition:position];
        
        if (position == (length - 1))
        {
            [array removeObjectAtIndex:index];
        }
        
        else
        {
            array = [array objectAtIndex:index];
        }
    }
}

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))childArrayBlock
{
    if (!indexPath)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath argument is nil." userInfo:nil];
    }
    
    NSMutableArray *array = self;
    NSUInteger      length = indexPath.length;
    
    for (NSUInteger position = 0; position < length; position++)
    {
        NSUInteger index = [indexPath indexAtPosition:position];
        
        if (position == (length - 1))
        {
            [array removeObjectAtIndex:index];
        }
        
        else
        {
            id object = [array objectAtIndex:index];
            
            NSIndexPath *subindexPath = [indexPath copySubindexPathToPosition:(position + 1)];
            
            array = childArrayBlock(object, subindexPath);
        }
    }
}

#pragma mark - Rearranging Content

- (void)moveObjectAtIndex:(NSUInteger)index1 withIndex:(NSUInteger)index2
{
    if (index1 != index2)
    {
        id object = [self objectAtIndex:index2];
        
        [self removeObjectAtIndex:index2];
        
        [self insertObject:object atIndex:index1];
    }
}

- (void)reverse
{
    NSInteger index1 = 0;
    NSInteger index2 = (NSInteger)self.count - 1;
    
    while (index1 < index2)
    {
        [self exchangeObjectAtIndex:(NSUInteger)index1 withObjectAtIndex:(NSUInteger)index2];
        
        index1++;
        index2--;
    }
}

- (void)moveObjectAtIndexPath:(NSIndexPath *)indexPath1 withIndexPath:(NSIndexPath *)indexPath2
{
    if (!indexPath1)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath1 argument is nil." userInfo:nil];
    }
    
    if (indexPath1.length == 0)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath1.length value is 0." userInfo:nil];
    }
    
    if (!indexPath2)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath2 argument is nil." userInfo:nil];
    }
    
    if (indexPath2.length == 0)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath2.length value is 0." userInfo:nil];
    }
    
    NSMutableArray *array1 = self;
    NSUInteger      index1 = 0;
    NSUInteger      length1 = indexPath1.length;
    
    for (NSUInteger position1 = 0; position1 < length1; position1++)
    {
        index1 = [indexPath1 indexAtPosition:position1];
        
        if (position1 < (length1 - 1))
        {
            array1 = [array1 objectAtIndex:index1];
        }
    }
    
    NSMutableArray *array2 = self;
    NSUInteger      index2 = 0;
    NSUInteger      length2 = indexPath2.length;
    
    for (NSUInteger position2 = 0; position2 < length2; position2++)
    {
        index2 = [indexPath2 indexAtPosition:position2];
        
        if (position2 < (length2 - 1))
        {
            array2 = [array2 objectAtIndex:index2];
        }
    }
    
    id object = [array2 objectAtIndex:index2];
    
    [array2 removeObjectAtIndex:index2];
    
    [array1 insertObject:object atIndex:index1];
}

- (void)moveObjectAtIndexPath:(NSIndexPath *)indexPath1 withIndexPath:(NSIndexPath *)indexPath2  usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))childArrayBlock
{
    if (!indexPath1)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath1 argument is nil." userInfo:nil];
    }
    
    if (indexPath1.length == 0)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath1.length value is 0." userInfo:nil];
    }
    
    if (!indexPath2)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath2 argument is nil." userInfo:nil];
    }
    
    if (indexPath2.length == 0)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath2.length value is 0." userInfo:nil];
    }
    
    NSMutableArray *array1 = self;
    NSUInteger      index1 = 0;
    NSUInteger      length1 = indexPath1.length;
    
    for (NSUInteger position1 = 0; position1 < length1; position1++)
    {
        index1 = [indexPath1 indexAtPosition:position1];
        
        if (position1 < (length1 - 1))
        {
            id object1 = [array1 objectAtIndex:index1];
            
            NSIndexPath *subindexPath1 = [indexPath1 copySubindexPathToPosition:(position1 + 1)];
            
            array1 = childArrayBlock(object1, subindexPath1);
        }
    }
    
    NSMutableArray *array2 = self;
    NSUInteger      index2 = 0;
    NSUInteger      length2 = indexPath2.length;
    
    for (NSUInteger position2 = 0; position2 < length2; position2++)
    {
        index2 = [indexPath2 indexAtPosition:position2];
        
        if (position2 < (length2 - 1))
        {
            id object2 = [array2 objectAtIndex:index2];
            
            NSIndexPath *subindexPath2 = [indexPath2 copySubindexPathToPosition:(position2 + 1)];
            
            array2 = childArrayBlock(object2, subindexPath2);
        }
    }
    
    id object = [array2 objectAtIndex:index2];
    
    [array2 removeObjectAtIndex:index2];
    
    [array1 insertObject:object atIndex:index1];
}

- (void)exchangeObjectAtIndexPath:(NSIndexPath *)indexPath1 withObjectAtIndexPath:(NSIndexPath *)indexPath2
{
    if (!indexPath1)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath1 argument is nil." userInfo:nil];
    }
    
    if (indexPath1.length == 0)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath1.length value is 0." userInfo:nil];
    }
    
    if (!indexPath2)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath2 argument is nil." userInfo:nil];
    }
    
    if (indexPath2.length == 0)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath2.length value is 0." userInfo:nil];
    }
    
    NSMutableArray *array1 = self;
    NSUInteger      index1 = 0;
    NSUInteger      length1 = indexPath1.length;
    
    for (NSUInteger position1 = 0; position1 < length1; position1++)
    {
        index1 = [indexPath1 indexAtPosition:position1];
        
        if (position1 < (length1 - 1))
        {
            array1 = [array1 objectAtIndex:index1];
        }
    }
    
    NSMutableArray *array2 = self;
    NSUInteger      index2 = 0;
    NSUInteger      length2 = indexPath2.length;
    
    for (NSUInteger position2 = 0; position2 < length2; position2++)
    {
        index2 = [indexPath2 indexAtPosition:position2];
        
        if (position2 < (length2 - 1))
        {
            array2 = [array2 objectAtIndex:index2];
        }
    }
    
    id object1 = [array1 objectAtIndex:index1];
    id object2 = [array2 objectAtIndex:index2];
    
    [array1 replaceObjectAtIndex:index1 withObject:object2];
    [array2 replaceObjectAtIndex:index2 withObject:object1];
}

- (void)exchangeObjectAtIndexPath:(NSIndexPath *)indexPath1 withObjectAtIndexPath:(NSIndexPath *)indexPath2 usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))childArrayBlock
{
    if (!indexPath1)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath1 argument is nil." userInfo:nil];
    }
    
    if (indexPath1.length == 0)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath1.length value is 0." userInfo:nil];
    }
    
    if (!indexPath2)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath2 argument is nil." userInfo:nil];
    }
    
    if (indexPath2.length == 0)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The indexPath2.length value is 0." userInfo:nil];
    }
    
    NSMutableArray *array1 = self;
    NSUInteger      index1 = 0;
    NSUInteger      length1 = indexPath1.length;
    
    for (NSUInteger position1 = 0; position1 < length1; position1++)
    {
        index1 = [indexPath1 indexAtPosition:position1];
        
        if (position1 < (length1 - 1))
        {
            id object1 = [array1 objectAtIndex:index1];
            
            NSIndexPath *subindexPath1 = [indexPath1 copySubindexPathToPosition:(position1 + 1)];
            
            array1 = childArrayBlock(object1, subindexPath1);
        }
    }
    
    NSMutableArray *array2 = self;
    NSUInteger      index2 = 0;
    NSUInteger      length2 = indexPath2.length;
    
    for (NSUInteger position2 = 0; position2 < length2; position2++)
    {
        index2 = [indexPath2 indexAtPosition:position2];
        
        if (position2 < (length2 - 1))
        {
            id object2 = [array2 objectAtIndex:index2];
            
            NSIndexPath *subindexPath2 = [indexPath2 copySubindexPathToPosition:(position2 + 1)];
            
            array2 = childArrayBlock(object2, subindexPath2);
        }
    }
    
    id object1 = [array1 objectAtIndex:index1];
    id object2 = [array2 objectAtIndex:index2];
    
    [array1 replaceObjectAtIndex:index1 withObject:object2];
    [array2 replaceObjectAtIndex:index2 withObject:object1];
}

@end
