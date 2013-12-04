//
//  RENSObject.h
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

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>

// Importing the system headers.
#import <objc/runtime.h>

@class NSMutableDictionary;
@class NSObject;
@class NSString;

typedef NS_ENUM(uintptr_t, NSObjectAssociationPolicy)
{
    NSObjectAssociationPolicyAssign = OBJC_ASSOCIATION_ASSIGN,                    // 0
    NSObjectAssociationPolicyRetainNonatomic = OBJC_ASSOCIATION_RETAIN_NONATOMIC, // 1
    NSObjectAssociationPolicyCopyNonatomic = OBJC_ASSOCIATION_COPY_NONATOMIC,     // 3
    NSObjectAssociationPolicyRetain = OBJC_ASSOCIATION_RETAIN,                    // 01401
    NSObjectAssociationPolicyCopy = OBJC_ASSOCIATION_COPY,                        // 01403
    
    NSObjectAssociationPolicyWeak = NSObjectAssociationPolicyAssign,                     // 0
    NSObjectAssociationPolicyStrongNonatomic = NSObjectAssociationPolicyRetainNonatomic, // 1
    NSObjectAssociationPolicyStrong = NSObjectAssociationPolicyRetain                    // 01401
};

@interface NSObject (NSObjectRENSObject)

// Synchronizing the Singleton

+ (NSObject *)singletonSynchronizer;

// Obtaining Information About Methods

+ (NSString *)encodeClassMethodForSelector:(SEL)selector;
+ (NSString *)encodeInstanceMethodForSelector:(SEL)selector;
- (NSString *)encodeMethodForSelector:(SEL)selector;

// Managing Associative References

- (id)associatedObjectForKey:(const void *)key;
- (void)setAssociatedObject:(id)object forKey:(const void *)key policy:(NSObjectAssociationPolicy)policy;
- (void)removeAllAssociatedObjects;

// Managing the NSObject Information

@property (nonatomic, readonly) NSMutableDictionary *objectDictionary; // Default is nil. The first time the method is accessed, the NSMutableDictionary is created. This method returns nil for Core Foundation classes.

// Identifying and Comparing the Reference of Objects

- (NSComparisonResult)compareReference:(id)object;

- (BOOL)isReferenceEqual:(id)object;
- (NSUInteger)referenceHash;

+ (NSComparisonResult)compareLeftObjectReference:(id)leftObject rightObjectReference:(id)rightObject;

+ (BOOL)isEqualLeftObjectReference:(id)leftObject rightObjectReference:(id)rightObject;

// Identifying and Comparing the Objects

+ (NSComparisonResult)compareLeftObject:(id)leftObject rightObject:(id)rightObject;
+ (NSComparisonResult)compareLeftObject:(id)leftObject rightObject:(id)rightObject compareSelector:(SEL)compareSelector;

+ (BOOL)isEqualLeftObject:(id)leftObject rightObject:(id)rightObject;

// Sending Messages

- (id)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3;
- (id)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4;
- (id)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5;

@end

//
// The defines are only used for diagnostics and testing. The defines use private functions.
//
// See also:
// http://clang.llvm.org/docs/AutomaticReferenceCounting.html
//
#if __has_feature(objc_arc) && DEBUG
#   define RENS_OBJ_RETAIN(obj) do { FOUNDATION_EXTERN id objc_retain(id value); RENSAssert(objc_retain, @"We do not have the \"id objc_retain(id value)\" function."); if (objc_retain) { objc_retain((obj)); } } while (0)
#   define RENS_OBJ_RELEASE(obj) do { FOUNDATION_EXTERN void objc_release(id value); RENSAssert(objc_release, @"We do not have the \"void objc_release(id value)\" function."); if (objc_release) { objc_release((obj)); } } while (0)
#   define RENS_OBJ_AUTORELEASE(obj) do { FOUNDATION_EXTERN id objc_autorelease(id value); RENSAssert(objc_autorelease, @"We do not have the \"id objc_autorelease(id value)\" function."); if (objc_autorelease) { objc_autorelease((obj)); } } while (0)
#   define RENS_OBJ_ROOT_RETAIN_COUNT(obj) ({ FOUNDATION_EXTERN int _objc_rootRetainCount(id value); RENSAssert(_objc_rootRetainCount, @"We do not have the \"int objc_rootRetainCount(id value)\" function."); NSUInteger retainCount = 0; if (_objc_rootRetainCount) { retainCount = (NSUInteger)_objc_rootRetainCount((obj)); } retainCount; })
#endif

//
// The defines are only used for diagnostics and testing. The defines use public functions.
//
// See also:
// http://clang.llvm.org/docs/AutomaticReferenceCounting.html
//
#if __has_feature(objc_arc) && DEBUG
#   define RENS_OBJECT_RETAIN(obj) do { (void)(__bridge_retained CFTypeRef)(obj); } while (0)
#   define RENS_OBJECT_RELEASE(obj) do { (void)(__bridge_transfer id)(__bridge CFTypeRef)(obj); } while (0)
#   define RENS_OBJECT_AUTORELEASE(obj) do { id __autoreleasing obj2 = (obj); (void)(__bridge CFTypeRef)obj2; (void)(__bridge_transfer id)(__bridge CFTypeRef)(obj); } while (0)
#   define RENS_OBJECT_RETAIN_COUNT(obj) ({ (NSUInteger)CFGetRetainCount((__bridge CFTypeRef)(obj)); })
#endif

#define NSObjectCast(object, className) ({ __typeof__(object) __object = (object); [__object isKindOfClass:[className class]] ? ((className *)(__object)) : nil; })
#define NSMutableObjectCastOrCopy(object, className) ({ __typeof__(object) __object = (object); [__object isKindOfClass:[className class]] ? ((className *)(__object)) : [(__object) mutableCopy]; })
