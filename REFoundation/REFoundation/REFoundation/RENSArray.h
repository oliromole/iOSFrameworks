//
//  RENSArray.h
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
#import <Foundation/NSArray.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSRange.h>

@class NSIndexPath;

@interface NSArray (NSArrayRENSArray)

// Initializing and Creating an Array.

- (id)initWithLength:(NSUInteger)length;
+ (id)arrauWithLength:(NSUInteger)length;

- (id)initWithLength:(NSUInteger)length object:(id)object;
+ (id)arrauWithLength:(NSUInteger)length object:(id)object;

// Querying an Array

// Returns the NSRange structure giving the location is 0 and the length is the number of objects currently in the array.
- (NSRange)range;

// Returns the object in the array with the lowest index value. If the array is empty, returns nil.
- (id)firstObject;

// Returns the object located at index path.
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))block;

// Finding Objects in an Array

- (NSUInteger)indexOfObject:(id)anObject options:(NSEnumerationOptions)options;
- (NSUInteger)indexOfObject:(id)anObject inRange:(NSRange)range options:(NSEnumerationOptions)options;
- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject options:(NSEnumerationOptions)options;
- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range options:(NSEnumerationOptions)options;

// Reversing the Array

- (NSArray *)reversedArray;

// Sending Messages to Elements

- (void)enumerateObjectsUsingIndexPathBlock:(void (^)(id object, NSIndexPath *indexPath, BOOL *stop))block;
- (void)enumerateObjectsUsingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))block indexPathBlock:(void (^)(id object, NSIndexPath *indexPath, BOOL *stop))block;

@end

@interface NSMutableArray (NSMutableArrayRENSMutableArray)

// Adding Objects

- (void)addObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath;
- (void)addObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))block;

- (void)insertObject:(id)object inSortedRange:(NSRange)range options:(NSBinarySearchingOptions)options usingComparator:(NSComparator)comparatorBlock;

- (void)insertObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath;
- (void)insertObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))block;

// Replacing Objects

- (void)replaceObjectAtIndexPath:(NSIndexPath *)indexPath withObject:(id)anObject;
- (void)replaceObjectAtIndexPath:(NSIndexPath *)indexPath withObject:(id)anObject usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))block;

// Removing Objects

// Removes the object with the lowest-valued index in the array.
// removeFirstObject raises an NSRangeException if there are no objects in the array.
- (void)removeFirstObject;

- (void)removeObject:(id)anObject options:(NSEnumerationOptions)options;
- (void)removeObject:(id)anObject inRange:(NSRange)range options:(NSEnumerationOptions)options;
- (void)removeObjectIdenticalTo:(id)anObject options:(NSEnumerationOptions)options;
- (void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range options:(NSEnumerationOptions)options;

- (void)removeObject:(id)object inSortedRange:(NSRange)range options:(NSBinarySearchingOptions)options usingComparator:(NSComparator)comparatorBlock;
- (void)removeObject:(id)object inSortedRange:(NSRange)range usingComparator:(NSComparator)comparatorBlock;

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))block;

// Rearranging Content

- (void)moveObjectAtIndex:(NSUInteger)index1 withIndex:(NSUInteger)index2;

- (void)reverse;

- (void)moveObjectAtIndexPath:(NSIndexPath *)indexPath1 withIndexPath:(NSIndexPath *)indexPath2;
- (void)moveObjectAtIndexPath:(NSIndexPath *)indexPath1 withIndexPath:(NSIndexPath *)indexPath2 usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))block;

- (void)exchangeObjectAtIndexPath:(NSIndexPath *)indexPath1 withObjectAtIndexPath:(NSIndexPath *)indexPath2;
- (void)exchangeObjectAtIndexPath:(NSIndexPath *)indexPath1 withObjectAtIndexPath:(NSIndexPath *)indexPath2 usingChildArrayBlock:(id (^)(id object, NSIndexPath *indexPath))block;

@end

#define NSArrayCast(array) NSObjectCast(array, NSArray)
#define NSMutableArrayCast(array) NSObjectCast(array, NSMutableArray)
#define NSMutableArrayCastOrCopy(array) NSMutableObjectCastOrCopy(array, NSMutableArray)
