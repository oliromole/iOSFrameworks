//
//  RFNSObjectWrapper.m
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.06.16.
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
#import "RFNSObjectWrapper.h"

// Importing the project headers.
#import "RFNSRecursionTracer.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>

NSString *NSStringFromRFNSObjectWrapperOptions(RFNSObjectWrapperOptions options)
{
    // Creating the string representation of the options.
    NSMutableString *optionsString = [[NSMutableString alloc] init];
    [optionsString appendString:@"{"];
    
    // We have the RFNSObjectWrapperOptionNone.
    if (options == 0)
    {
        // Appending the string representation of the RFNSObjectWrapperOptionNone.
        [optionsString appendString:@"RFNSObjectWrapperOptionNone, "];
    }
    
    // We do not have the RFNSObjectWrapperOptionNone.
    else
    {
        // We have the RFNSObjectWrapperOptionWeak.
        if ((options & RFNSObjectWrapperOptionReferenceMask) == RFNSObjectWrapperOptionWeakReference)
        {
            // Appending the string representation of the RFNSObjectWrapperOptionWeak.
            [optionsString appendString:@"RFNSObjectWrapperOptionWeak, "];
            
            // Resetting the RFNSObjectWrapperOptionReferenceMask.
            options &= ~RFNSObjectWrapperOptionReferenceMask;
        }
        
        // We have the RFNSObjectWrapperOptionDeepCopy.
        if ((options & RFNSObjectWrapperOptionCopyMask) == RFNSObjectWrapperOptionDeepCopy)
        {
            // Appending the string representation of the RFNSObjectWrapperOptionDeepCopy.
            [optionsString appendString:@"RFNSObjectWrapperOptionDeepCopy, "];
            
            // Resetting the RFNSObjectWrapperOptionCopyMask.
            options &= ~RFNSObjectWrapperOptionCopyMask;
        }
        
        // We have the RFNSObjectWrapperOptionDeepMutableCopy.
        else if ((options & RFNSObjectWrapperOptionCopyMask) == RFNSObjectWrapperOptionDeepMutableCopy)
        {
            // Appending the string representation of the RFNSObjectWrapperOptionDeepMutableCopy.
            [optionsString appendString:@"RFNSObjectWrapperOptionDeepMutableCopy, "];
            
            // Resetting the RFNSObjectWrapperOptionCopyMask.
            options &= ~RFNSObjectWrapperOptionCopyMask;
        }
        
        // We have the RFNSObjectWrapperOptionNoCopy.
        else if ((options & RFNSObjectWrapperOptionCopyMask) == RFNSObjectWrapperOptionNoCopy)
        {
            // Appending the string representation of the RFNSObjectWrapperOptionNoCopy.
            [optionsString appendString:@"RFNSObjectWrapperOptionNoCopy, "];
            
            // Resetting the RFNSObjectWrapperOptionCopyMask.
            options &= ~RFNSObjectWrapperOptionCopyMask;
        }
        
        // We have the options which do not have the string representation.
        if (options != 0)
        {
            // Appending the string representation of the options which do not have the string representation.
            [optionsString appendFormat:@"0x%lx, ", (unsigned long)options];
            
            // Resetting the options which do not have the string representation.
            options = 0;
        }
    }
    
    // Deceiving the static analyzer.
    options = options;
    
    // Appending the end of a string representation.
    [optionsString trimRightStrings:@",", @" ", nil];
    [optionsString appendString:@"}"];
    
    // Returning the string representation of the options.
    return optionsString;
}

RFNSObjectWrapperOptions RFNSObjectWrapperOptionsFromNSString(NSString *string)
{
    NSMutableString *optionsString = [string mutableCopy];
    
    RFNSObjectWrapperOptions options = 0;
    
    if (optionsString)
    {
        NSRange range = [optionsString rangeOfString:(@"^"
                                                      @"[^\\[\\{]*"
                                                      @"[\\[\\{]"
                                                      @"([^,\\]\\}]+,)*"
                                                      @"([^,\\]\\}]+)?"
                                                      @"[\\]\\}]?")
                                             options:NSRegularExpressionSearch
                                               range:optionsString.range];
        
        if (!NSRangeIsNotFound(range))
        {
            [optionsString replaceOccurrencesOfString:(@"^"
                                                       @"[^\\[\\{]*"
                                                       @"[\\[\\{]")
                                           withString:@""
                                              options:NSRegularExpressionSearch
                                                range:optionsString.range];
            
            NSRange optionsStringRange = [optionsString rangeOfString:(@"^"
                                                                       @"([^,\\]\\}]+,)*"
                                                                       @"([^,\\]\\}]+)?")
                                                              options:NSRegularExpressionSearch
                                                                range:optionsString.range];
            
            NSCAssert(!NSRangeIsNotFound(optionsStringRange), @"The method has a logical error.");
            
            NSRange deleteRange;
            deleteRange.location = NSMaxRange(optionsStringRange);
            deleteRange.length = optionsString.length - deleteRange.location;
            
            [optionsString deleteCharactersInRange:deleteRange];
            
            NSArray *optionStrings = [optionsString componentsSeparatedByString:@","];
            
            NSCharacterSet *whitespaceAndNewlineCharacterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            
            for (NSString *optionString in optionStrings)
            {
                if (optionString.length > 0)
                {
                    NSMutableString *optionString2 = [optionString mutableCopy];
                    [optionString2 trimCharactersInSet:whitespaceAndNewlineCharacterSet];
                    
                    BOOL needsConvertOptionString = YES;
                    
                    if (needsConvertOptionString)
                    {
                        if ([optionString2 isEqual:@"RFNSObjectWrapperOptionNone"])
                        {
                            needsConvertOptionString = NO;
                            options = RFNSObjectWrapperOptionNone;
                        }
                        
                        else if ([optionString2 isEqual:@"RFNSObjectWrapperOptionWeak"])
                        {
                            needsConvertOptionString = NO;
                            options = (options & ~RFNSObjectWrapperOptionReferenceMask) | RFNSObjectWrapperOptionWeakReference;
                        }
                        
                        else if ([optionString2 isEqual:@"RFNSObjectWrapperOptionDeepCopy"])
                        {
                            needsConvertOptionString = NO;
                            options = (options & ~RFNSObjectWrapperOptionCopyMask) | RFNSObjectWrapperOptionDeepCopy;
                        }
                        
                        else if ([optionString2 isEqual:@"RFNSObjectWrapperOptionDeepMutableCopy"])
                        {
                            needsConvertOptionString = NO;
                            options = (options & ~RFNSObjectWrapperOptionCopyMask) | RFNSObjectWrapperOptionDeepMutableCopy;
                        }
                        
                        else if ([optionString2 isEqual:@"RFNSObjectWrapperOptionNoCopy"])
                        {
                            needsConvertOptionString = NO;
                            options = (options & ~RFNSObjectWrapperOptionCopyMask) | RFNSObjectWrapperOptionNoCopy;
                        }
                    }
                    
                    if (needsConvertOptionString)
                    {
                        NSScanner *scanner = [[NSScanner alloc] initWithString:optionString2];
                        
                        unsigned long long options2 = 0ll;
                        
                        BOOL result = [scanner scanHexLongLong:&options2];
                        
                        if (result)
                        {
                            needsConvertOptionString = NO;
                            options |= (RFNSObjectWrapperOptions)options2;
                        }
                    }
                    
                    if (needsConvertOptionString)
                    {
                        NSScanner *scanner = [[NSScanner alloc] initWithString:optionString2];
                        
                        long long options2 = 0ll;
                        
                        BOOL result = [scanner scanLongLong:&options2];
                        
                        if (result)
                        {
                            needsConvertOptionString = NO;
                            options |= (RFNSObjectWrapperOptions)options2;
                        }
                    }
                    
                    // Deceiving the static analyzer.
                    needsConvertOptionString = needsConvertOptionString;
                }
            }
        }
    }
    
    return options;
}

@implementation RFNSObjectWrapper

#pragma mark - Initializing and Creating a RFNSObjectWrapper

- (id)init
{
    if ((self = [super init]))
    {
        // Setting the default values.
        mEqualSelector = NULL;
        mHashSelector = NULL;
        mOptions = 0;
        mStrongObject = nil;
        mWeakObject = nil;
    }
    
    return self;
}

+ (id)objectWrapper
{
    return [[self alloc] init];
}

- (id)initWithObject:(id)object
{
    if ((self = [self init]))
    {
        // Saving the object.
        self.object = object;
    }
    
    return self;
}

+ (id)objectWrapperWithObject:(id)object
{
    return [[self alloc] initWithObject:object];
}

- (id)initWithObject:(id)object equalSelector:(SEL)equalSelector hashSelector:(SEL)hashSelector
{
    if ((self = [self init]))
    {
        // Saving the object.
        self.object = object;
        
        // Setting the equal selector and the the hash selector.
        [self setEqualSelector:equalSelector hashSelector:hashSelector];
    }
    
    return self;
}

+ (id)objectWrapperWithObject:(id)object equalSelector:(SEL)equalSelector hashSelector:(SEL)hashSelector
{
    return [[self alloc] initWithObject:object equalSelector:equalSelector hashSelector:hashSelector];
}

- (id)initWithOptions:(RFNSObjectWrapperOptions)options
{
    if ((self = [self init]))
    {
        // Setting the options.
        self.options = options;
    }
    
    return self;
}

+ (id)objectWrapperWithOptions:(RFNSObjectWrapperOptions)options
{
    return [[self alloc] initWithOptions:options];
}

- (id)initWithObject:(id)object options:(RFNSObjectWrapperOptions)options
{
    if ((self = [self init]))
    {
        // Setting the options.
        self.options = options;
        
        // Saving the object.
        self.object = object;
    }
    
    return self;
}

+ (id)objectWrapperWithObject:(id)object options:(RFNSObjectWrapperOptions)options
{
    return [[self alloc] initWithObject:object options:options];
}

- (id)initWithObject:(id)object options:(RFNSObjectWrapperOptions)options equalSelector:(SEL)equalSelector hashSelector:(SEL)hashSelector
{
    if ((self = [self init]))
    {
        // Setting the options.
        self.options = options;
        
        // Saving the object.
        self.object = object;
        
        // Setting the equal selector and the hash selector.
        [self setEqualSelector:equalSelector hashSelector:hashSelector];
    }
    
    return self;
}

+ (id)objectWrapperWithObject:(id)object options:(RFNSObjectWrapperOptions)options equalSelector:(SEL)equalSelector hashSelector:(SEL)hashSelector
{
    return [[self alloc] initWithObject:object options:options equalSelector:equalSelector hashSelector:hashSelector];
}

#pragma mark - Deallocating a RFNSObjectWrapper

- (void)dealloc
{
    // Releasing the strong reference to the object.
    mStrongObject = nil;
    
    // Releasing the weak reference to the object.
    mWeakObject = nil;
}

#pragma mark - Managing the Object.

- (id)object
{
    // We use the weak reference to the object.
    if ((mOptions & RFNSObjectWrapperOptionReferenceMask) == RFNSObjectWrapperOptionWeakReference)
    {
        // Returning the object.
        return mWeakObject;
    }
    
    // We use the strong reference to the object.
    else
    {
        // Returning the object.
        return mStrongObject;
    }
}

- (void)setObject:(id)object
{
    // We use the weak reference to the object.
    if ((mOptions & RFNSObjectWrapperOptionReferenceMask) == RFNSObjectWrapperOptionWeakReference)
    {
        // Saving the object.
        mWeakObject = object;
    }
    
    // We user the strong reference to the object.
    else
    {
        // Saving the object.
        mStrongObject = object;
    }
}

- (void)setObject:(id)object options:(RFNSObjectWrapperOptions)options
{
    // Setting the options.
    self.options = options;
    
    // Saving the object.
    self.object = object;
}

- (RFNSObjectWrapperOptions)options
{
    // Returning the options.
    return mOptions;
}

- (void)setOptions:(RFNSObjectWrapperOptions)options
{
    // The old options and the new options are different.
    if (mOptions != options)
    {
        // Saving the old options.
        RFNSObjectWrapperOptions oldOptions = mOptions;
        
        // Saving the new options.
        mOptions = options;
        
        // Saving the new options.
        RFNSObjectWrapperOptions newOptions = mOptions;
        
        // We have changed the reference type.
        if ((oldOptions & RFNSObjectWrapperOptionReferenceMask) != (newOptions & RFNSObjectWrapperOptionReferenceMask))
        {
            // The new reference type is weak.
            if ((newOptions & RFNSObjectWrapperOptionReferenceMask) == RFNSObjectWrapperOptionWeakReference)
            {
                // Changing the reference to the object.
                mWeakObject = mStrongObject;
                mStrongObject = nil;
            }
            
            // The new reference type is strong.
            else
            {
                // Changing the reference to the object.
                mStrongObject = mWeakObject;
                mWeakObject = nil;
            }
        }
    }
}

- (void)setOptionStrongReference
{
    // The option reference is not strong reference.
    if ((mOptions & RFNSObjectWrapperOptionReferenceMask) != 0)
    {
        // Calculating options with strong reference.
        RFNSObjectWrapperOptions options = mOptions & ~(RFNSObjectWrapperOptionReferenceMask);
        
        // Setting new options.
        [self setOptions:options];
    }
}

- (void)setOptionWeakReference
{
    // The option reference is not weak reference.
    if ((mOptions & RFNSObjectWrapperOptionReferenceMask) != RFNSObjectWrapperOptionWeakReference)
    {
        // Calculating options with weak reference.
        RFNSObjectWrapperOptions options = (mOptions & ~(RFNSObjectWrapperOptionReferenceMask)) | RFNSObjectWrapperOptionWeakReference;
        
        // Setting new options.
        [self setOptions:options];
    }
}

- (void)setOptionCopy
{
    // The option copy is not copy.
    if ((mOptions & RFNSObjectWrapperOptionCopyMask) != 0)
    {
        // Calculating options with copy.
        RFNSObjectWrapperOptions options = mOptions & ~(RFNSObjectWrapperOptionCopyMask);
        
        // Setting new options.
        [self setOptions:options];
    }
}

- (void)setOptionDeepCopy
{
    // The option copy is not deep copy.
    if ((mOptions & RFNSObjectWrapperOptionCopyMask) != RFNSObjectWrapperOptionDeepCopy)
    {
        // Calculating options with deep copy.
        RFNSObjectWrapperOptions options = (mOptions & ~(RFNSObjectWrapperOptionCopyMask)) | RFNSObjectWrapperOptionDeepCopy;
        
        // Setting new options.
        [self setOptions:options];
    }
}
- (void)setOptionDeepMutableCopy
{
    // The option copy is not deep mutable copy.
    if ((mOptions & RFNSObjectWrapperOptionCopyMask) != RFNSObjectWrapperOptionDeepMutableCopy)
    {
        // Calculating options with deep mutable copy.
        RFNSObjectWrapperOptions options = (mOptions & ~(RFNSObjectWrapperOptionCopyMask)) | RFNSObjectWrapperOptionDeepMutableCopy;
        
        // Setting new options.
        [self setOptions:options];
    }
}

- (void)setOptionNoCopy
{
    // The option copy is not no copy.
    if ((mOptions & RFNSObjectWrapperOptionCopyMask) != RFNSObjectWrapperOptionNoCopy)
    {
        // Calculating options with no copy.
        RFNSObjectWrapperOptions options = (mOptions & ~(RFNSObjectWrapperOptionCopyMask)) | RFNSObjectWrapperOptionNoCopy;
        
        // Setting new options.
        [self setOptions:options];
    }
}

- (SEL)equalSelector
{
    // Returning the equal selector.
    return mEqualSelector;
}

- (SEL)hashSelector
{
    // Returning the hash selector.
    return mHashSelector;
}

- (void)setEqualSelector:(SEL)equalSelector hashSelector:(SEL)hashSelector
{
    // Validing the arguments.
    if (!equalSelector ^ !hashSelector)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"The equalSelector argument and the hashSelector argument pair are invalid. The equalSelector argument: %@. The hashSelector argument %@", NSStringFromSelector(equalSelector), NSStringFromSelector(hashSelector)] userInfo:nil];
    }
    
    // Saving the new selectors.
    mEqualSelector = equalSelector;
    mHashSelector = hashSelector;
}

#pragma mark - Conforming the NSCopying Protocol

- (id)copyWithZone:(NSZone *)zone
{
    // Creating the new object wrapper.
    RFNSObjectWrapper *objectWrapper = [[[self class] allocWithZone:zone] init];
    
    // Copying the values.
    objectWrapper->mEqualSelector = self->mEqualSelector;
    objectWrapper->mHashSelector = self->mHashSelector;
    objectWrapper->mOptions = self->mOptions;
    
    // We must make a copy object.
    if ((mOptions & RFNSObjectWrapperOptionCopyMask) == RFNSObjectWrapperOptionDeepCopy)
    {
        // Making the copy object.
        
        objectWrapper->mStrongObject = [self->mStrongObject copy];
        
        id strongObject = self->mWeakObject;
        strongObject = [strongObject  copy];
        objectWrapper->mWeakObject = strongObject;
    }
    
    // We must make a mutable copy object.
    else if ((mOptions & RFNSObjectWrapperOptionCopyMask) == RFNSObjectWrapperOptionDeepMutableCopy)
    {
        // Making the mutable copy object.
        
        objectWrapper->mStrongObject = [self->mStrongObject mutableCopy];
        
        id strongObject = self->mWeakObject;
        strongObject = [strongObject  mutableCopy];
        objectWrapper->mWeakObject = strongObject;
    }
    
    // We must not make any copy.
    else if ((mOptions & RFNSObjectWrapperOptionCopyMask) == RFNSObjectWrapperOptionNoCopy)
    {
        // Setting the default values.
        objectWrapper->mStrongObject = nil;
        objectWrapper->mWeakObject = nil;
    }
    
    // ((mOptions & RFNSObjectWrapperOptionCopyMask) == 0)
    // We must copy the reference to the object.
    else
    {
        // Copying the references to the object.
        objectWrapper->mStrongObject = self->mStrongObject;
        objectWrapper->mWeakObject = self->mWeakObject;
    }
    
    // Returning the copied annonce response.
    return objectWrapper;
}

#pragma mark - Conforming the NSObject Protocol

#pragma mark Identifying and Comparing Objects

- (BOOL)isEqual:(id)object
{
    // Setting the default value.
    BOOL isEqual = NO;
    
    // The objec is the RFNSObjectWrapper object.
    if ([object isKindOfClass:[RFNSObjectWrapper class]])
    {
        // Casting the object ot the RFNSObjectWrapper object.
        RFNSObjectWrapper *rightObjectWrapper = (RFNSObjectWrapper *)object;
        
        // Getting the object.
        id leftObject = self.object;
        id rightObject = rightObjectWrapper.object;
        
        // We have the left object.
        if (leftObject)
        {
            // We have the specified equal selector.
            if (mEqualSelector)
            {
                // Getting the equal implementation.
                BOOL (*equalImplementation)(id, SEL, id) = (BOOL (*)(id, SEL, id))[leftObject methodForSelector:mEqualSelector];
                
                // We have not the equal implementation.
                if (!equalImplementation)
                {
                    @throw [NSException exceptionWithName:NSGenericException reason:[NSString stringWithFormat:@"The leftObject arguement is not implemented the method -[%@ %@].", NSStringFromClass([leftObject class]), NSStringFromSelector(mEqualSelector)] userInfo:nil];
                }
                
                // Comparing the left object with the right object.
                isEqual = equalImplementation(leftObject, mEqualSelector, rightObject);
            }
            
            // We do not have the specified equal selector.
            // We must use the default equal selector.
            else
            {
                // Comparing the left object with the right object.
                isEqual = [leftObject isEqual:rightObject];
            }
        }
    }
    
    // Returning the result of compared objects.
    return isEqual;
}

- (NSUInteger)hash
{
    // Setting the default values.
    NSUInteger hash = 0;
    
    // Getting the object.
    id object = self.object;
    
    // We have the object.
    if (object)
    {
        // We have the specified hash selector.
        if (mHashSelector)
        {
            // Getting the hash implementation.
            NSUInteger (*hashImplementation)(id, SEL) = (NSUInteger (*)(id, SEL))[object methodForSelector:mHashSelector];
            
            // We have not the hash implementation.
            if (!hashImplementation)
            {
                @throw [NSException exceptionWithName:NSGenericException reason:[NSString stringWithFormat:@"The leftObject arguement is not implemented the method -[%@ %@].", NSStringFromClass([object class]), NSStringFromSelector(mHashSelector)] userInfo:nil];
            }
            
            // Hashing the object.
            hash = hashImplementation(object, mHashSelector);
        }
        
        // We do not have the specified hash selector.
        // We must use the default hash selector.
        else
        {
            // Hashing the object.
            hash = [object hash];
        }
    }
    
    // Returning the hash of the object.
    return hash;
}

#pragma mark Describing Objects

- (NSString *)description
{
    // Creating the desctiption.
    NSMutableString *description = [[NSMutableString alloc] init];
    RENSAssert(description, @"The method has a logical error.");
    
    // Beginning to trace the recursion.
    BOOL hasRecursion = RFNSDescriptionRecursionTracerBegin();
    
    // We have the recursion.
    if (hasRecursion)
    {
        // Appending the description for the recursive call.
        [description appendFormat:@"<%@ %p> (recursive call)", NSStringFromClass(self.class), self];
    }
    
    // We do not have the recursion.
    else
    {
        // Saving the weak object as the strong reference.
        id weakObjectAsStrong = mWeakObject;
        
        // Appending the description of the object.
        [description appendFormat:@"<%@ %p> {\n", NSStringFromClass(self.class), self];
        [description appendFormat:@"    mEqualSelector = %@;\n", [NSStringFromSelector(mEqualSelector) stringByReplacingOccurrencesOfString:@"\n" withString:@"\n    "]];
        [description appendFormat:@"    mHashSelector = %@;\n", [NSStringFromSelector(mHashSelector) stringByReplacingOccurrencesOfString:@"\n" withString:@"\n    "]];
        [description appendFormat:@"    mOptions = %@;\n", [NSStringFromRFNSObjectWrapperOptions(mOptions) stringByReplacingOccurrencesOfString:@"\n" withString:@"\n    "]];
        [description appendFormat:@"    mStrongObject = %@;\n", [[mStrongObject description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\n    "]];
        [description appendFormat:@"    mWeakObject = %@;\n", [[weakObjectAsStrong description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\n    "]];
        [description appendFormat:@"}"];
    }
    
    // Ending to trace the recursion.
    RFNSDescriptionRecursionTracerEnd();
    
    // Returning the desctiption.
    return description;
}

@end
