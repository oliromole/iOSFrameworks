//
//  RENSObject.m
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.07.23.
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
#import "RENSObject.h"

// Importing the project headers.
#import "RENSException.h"

// Importing the system headers.
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>

// Importing the system headers.
#import <pthread.h>

static NSObject * volatile NSObject_NSObjectRENSObject_SingletonSynchronizer = nil;

const char * const NSObject_NSObjectRENSObject_ObjectDictionaryKey = "NSObject_NSObjectRENSObject_ObjectDictionaryKey";
CFTypeID NSObject_NSObjectRENSObject_NSObject_TypeID = 0;

@implementation NSObject (NSObjectRENSObject)

#pragma mark - Initializing a Class

+ (void)load
{
    NSObject_NSObjectRENSObject_SingletonSynchronizer = [[NSObject alloc] init];
    
    NSObject *object = [[NSObject alloc] init];
    NSObject_NSObjectRENSObject_NSObject_TypeID = CFGetTypeID((__bridge CFTypeRef)object);
    
}

#pragma mark - Synchronizing the Singleton

+ (NSObject *)singletonSynchronizer
{
    RENSAssert(NSObject_NSObjectRENSObject_SingletonSynchronizer, @"The %@ class is used incorrectly.", NSStringFromClass([self class]));
    
    return NSObject_NSObjectRENSObject_SingletonSynchronizer;
}

#pragma mark - Obtaining Information About Methods

+ (NSString *)encodeClassMethodForSelector:(SEL)selector
{
    // Setting the default value.
    NSString *nsTypeEncoding = nil;
    
    // We have a selector.
    if (selector)
    {
        // Getting a specified class method.
        Method method = class_getClassMethod(self, selector);
        
        // We have the method.
        if (method)
        {
            // Getting a type encoding of the method.
            const char *cTypeEncoding = method_getTypeEncoding(method);
            
            // We have the type encoding.
            if (cTypeEncoding)
            {
                // Saving the type encoding.
                nsTypeEncoding = [[NSString alloc] initWithUTF8String:cTypeEncoding];
            }
        }
    }
    
    // Returning the type encoding.
    return nsTypeEncoding;
}

+ (NSString *)encodeInstanceMethodForSelector:(SEL)selector
{
    // Setting the default value.
    NSString *nsTypeEncoding = nil;
    
    // We have a selector.
    if (selector)
    {
        // Getting a specified instance method.
        Method method = class_getInstanceMethod(self, selector);
        
        // We have the method.
        if (method)
        {
            // Getting a type encoding of the method.
            const char *cTypeEncoding = method_getTypeEncoding(method);
            
            // We have the type encoding.
            if (cTypeEncoding)
            {
                // Saving the type encoding.
                nsTypeEncoding = [[NSString alloc] initWithUTF8String:cTypeEncoding];
            }
        }
    }
    
    // Returning the type encoding.
    return nsTypeEncoding;
}

- (NSString *)encodeMethodForSelector:(SEL)selector
{
    // Setting the default value.
    NSString *nsTypeEncoding = nil;
    
    // We have a selector.
    if (selector)
    {
        // Getting a specified instance method.
        Method method = class_getInstanceMethod([self class], selector);
        
        // We have the method.
        if (method)
        {
            // Getting a type encoding of the method.
            const char *cTypeEncoding = method_getTypeEncoding(method);
            
            // We have the type encoding.
            if (cTypeEncoding)
            {
                // Saving the type encoding.
                nsTypeEncoding = [[NSString alloc] initWithUTF8String:cTypeEncoding];
            }
        }
    }
    
    // Returning the type encoding.
    return nsTypeEncoding;
}

#pragma mark - Managing Associative References

- (id)associatedObjectForKey:(const void *)key
{
    if (!key)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The key argument is NULL." userInfo:nil];
    }
    
    id associatedObject = objc_getAssociatedObject(self, key);
    
    return associatedObject;
}

- (void)setAssociatedObject:(id)object forKey:(const void *)key policy:(NSObjectAssociationPolicy)policy
{
    if (!key)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The key argument is NULL." userInfo:nil];
    }
    
    objc_setAssociatedObject(self, key, object, (uintptr_t)policy);
}

- (void)removeAllAssociatedObjects
{
    objc_removeAssociatedObjects(self);
}

#pragma mark - Managing the NSObject Information

- (NSMutableDictionary *)objectDictionary
{
    NSMutableDictionary *objectDictionary = nil;
    
    CFTypeID objectTypeID = CFGetTypeID((__bridge CFTypeRef)self);
    
    if (objectTypeID != NSObject_NSObjectRENSObject_NSObject_TypeID)
    {
        NSLog(@"WARNING: The %@ class is Core Foundation class. The %@ method returns nil for Core Foundation classes.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    }
    
    else
    {
        objectDictionary = objc_getAssociatedObject(self, NSObject_NSObjectRENSObject_ObjectDictionaryKey);
        
        if (!objectDictionary)
        {
            objectDictionary = [[NSMutableDictionary alloc] init];
            
            objc_setAssociatedObject(self, NSObject_NSObjectRENSObject_ObjectDictionaryKey, objectDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    return objectDictionary;
}

#pragma mark - Identifying and Comparing the Reference of Objects

- (NSComparisonResult)compareReference:(id)object
{
    NSComparisonResult comparisonResult;
    
    if (self < object)
    {
        comparisonResult = NSOrderedAscending;
    }
    
    else if (self > object)
    {
        comparisonResult = NSOrderedDescending;
    }
    
    else
    {
        comparisonResult = NSOrderedSame;
    }
    
    return comparisonResult;
}

- (BOOL)isReferenceEqual:(id)object
{
    BOOL isReferenceEqual  = (self == object);
    return isReferenceEqual;
}

- (NSUInteger)referenceHash
{
    NSUInteger referenceHash = (NSUInteger)self;
    return referenceHash;
}

+ (NSComparisonResult)compareLeftObjectReference:(id)leftObject rightObjectReference:(id)rightObject
{
    NSComparisonResult comparisonResult;
    
    if (leftObject < rightObject)
    {
        comparisonResult = NSOrderedAscending;
    }
    
    else if (leftObject > rightObject)
    {
        comparisonResult = NSOrderedDescending;
    }
    
    else
    {
        comparisonResult = NSOrderedSame;
    }
    
    return comparisonResult;
}

+ (BOOL)isEqualLeftObjectReference:(id)leftObject rightObjectReference:(id)rightObject
{
    // Comparing the left object reference with the right object reference.
    BOOL isEqual = (leftObject == rightObject);
    
    // Returning the result of compared object references.
    return isEqual;
}

#pragma mark - Identifying and Comparing the Objects

+ (NSComparisonResult)compareLeftObject:(id)leftObject rightObject:(id)rightObject
{
    // Declaring some varibale.
    NSComparisonResult comparisonResult;
    
    // We have the left object and the right object.
    if (leftObject && rightObject)
    {
        // Comparing the left object with the right object.
        comparisonResult = [leftObject compare:rightObject];
    }
    
    // We have not the left object.
    else if (!leftObject && rightObject)
    {
        // The left object is smaller than the right object.
        comparisonResult = NSOrderedAscending;
    }
    
    // We have not right object.
    else if (leftObject && !rightObject)
    {
        // The left object is greater than the right object.
        comparisonResult = NSOrderedDescending;
    }
    
    // !leftObject && !rightObject.
    // We have not the left object and the right object.
    else
    {
        // The left object and the right object are equal.
        comparisonResult = NSOrderedSame;
    }
    
    // Returning the result of compared objects.
    return comparisonResult;
}

+ (NSComparisonResult)compareLeftObject:(id)leftObject rightObject:(id)rightObject compareSelector:(SEL)compareSelector
{
    // Declaring some varibale.
    NSComparisonResult comparisonResult;
    
    // We have the left object and the right object.
    if (leftObject && rightObject)
    {
        // We have the specified compare selector.
        if (compareSelector)
        {
            // Getting the compare implementation.
            NSComparisonResult (*compareImplementation)(id, SEL, id) = (NSComparisonResult (*)(id, SEL, id))[leftObject methodForSelector:compareSelector];
            
            // We have not the compare implementation.
            if (!compareImplementation)
            {
                @throw [NSException exceptionWithName:NSGenericException reason:[NSString stringWithFormat:@"The leftObject arguement is not implemented the method -[%@ %@].", NSStringFromClass([leftObject class]), NSStringFromSelector(compareSelector)] userInfo:nil];
            }
            
            // Comparing the left object with the right object.
            comparisonResult = compareImplementation(leftObject, compareSelector, rightObject);
        }
        
        // We have not the compare selector.
        else
        {
            // Comparing the left object with the right object.
            comparisonResult = [leftObject compare:rightObject];
        }
    }
    
    // We have not the left object.
    else if (!leftObject && rightObject)
    {
        // The left object is smaller than the right object.
        comparisonResult = NSOrderedAscending;
    }
    
    // We have not right object.
    else if (leftObject && !rightObject)
    {
        // The left object is greater than the right object.
        comparisonResult = NSOrderedDescending;
    }
    
    // !leftObject && !rightObject.
    // We have not the left object and the right object.
    else
    {
        // The left object and the right object are equal.
        comparisonResult = NSOrderedSame;
    }
    
    // Returning the result of compared objects.
    return comparisonResult;
}

+ (BOOL)isEqualLeftObject:(id)leftObject rightObject:(id)rightObject
{
    BOOL isEqual = (!leftObject == !rightObject);
    
    if (isEqual && leftObject && rightObject)
    {
        isEqual = [leftObject isEqual:rightObject];
    }
    
    return isEqual;
}

#pragma mark - Sending Messages

- (id)performSelector:(SEL)selector withObject:(id)object0 withObject:(id)object1 withObject:(id)object2
{
    IMP implementation = [self methodForSelector:selector];
    
    if (!implementation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: unrecognized selector sent to instance %p", NSStringFromClass(self.class), NSStringFromSelector(selector), self] userInfo:nil];
    }
    
    id returnValue = implementation(self, selector, object0, object1, object2);
    return returnValue;
}

- (id)performSelector:(SEL)selector withObject:(id)object0 withObject:(id)object1 withObject:(id)object2 withObject:(id)object3
{
    IMP implementation = [self methodForSelector:selector];
    
    if (!implementation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: unrecognized selector sent to instance %p", NSStringFromClass(self.class), NSStringFromSelector(selector), self] userInfo:nil];
    }
    
    id returnValue = implementation(self, selector, object0, object1, object2, object3);
    return returnValue;
}

- (id)performSelector:(SEL)selector withObject:(id)object0 withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4
{
    IMP implementation = [self methodForSelector:selector];
    
    if (!implementation)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"-[%@ %@]: unrecognized selector sent to instance %p", NSStringFromClass(self.class), NSStringFromSelector(selector), self] userInfo:nil];
    }
    
    id returnValue = implementation(self, selector, object0, object1, object2, object3, object4);
    return returnValue;
}

@end
