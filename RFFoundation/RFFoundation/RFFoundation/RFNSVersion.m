//
//  RFNSVersion.m
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.05.12.
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
#import "RFNSVersion.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>

@implementation RFNSVersion

#pragma mark - Initializing and Creating a RFNSVersion

- (id)init
{
    if ((self = [super init]))
    {
        // Creating an array of components.
        mComponents = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+ (id)version
{
    return [[self alloc] init];
}

- (id)initWithString:(NSString *)versionString
{
    if ((self = [self init]))
    {
        // Separating the version string to components.
        NSArray *componentStrings = [versionString componentsSeparatedByString:@"."];
        
        // Adding the components
        for (NSString *componentString in componentStrings)
        {
            // Adding the component.
            NSInteger componentInteger = componentString.integerValue;
            [mComponents addObject:@(componentInteger)];
        }
    }
    
    return self;
}

+ (id)versionWithString:(NSString *)versionString
{
    return [[self alloc] initWithString:versionString];
}

- (id)initWithComponents:(id)firstComponent, ...
{
    if ((self = [self init]))
    {
        // Initializing a valist.
        va_list valist;
        va_start(valist, firstComponent);
        
        // Getting the first component.
        id component = firstComponent;
        
        // We have a component.
        while (component)
        {
            // Adding the component.
            [mComponents addObject:component];
            
            // Getting the next component.
            component = va_arg(valist, id);
        }
        
        // Ending the valist.
        va_end(valist);
    }
    
    return self;
}

+ (id)versionWithComponents:(id)firstComponent, ...
{
    // Creating a version.
    RFNSVersion *version = [[self alloc] init];
    
    // We have the version.
    if (version)
    {
        // Initializing a valist.
        va_list valist;
        va_start(valist, firstComponent);
        
        // Getting the first component.
        id component = firstComponent;
        
        // We have a component.
        while (component)
        {
            // Adding the component.
            [version->mComponents addObject:component];
            
            // Getting the next component.
            component = va_arg(valist, id);
        }
        
        // Ending the valist.
        va_end(valist);
    }
    
    // Returning the version.
    return version;
}

- (id)initWithArray:(NSArray *)array
{
    if ((self = [self init]))
    {
        // Setting the components.
        [mComponents setArray:array];
    }
    
    return self;
}

+ (id)versionWithArray:(NSArray *)array
{
    return [[self alloc] initWithArray:array];
}

#pragma mark - Deallocating a RFNSVersion

- (void)dealloc
{
    // Releasing the componetns.
    mComponents = nil;
}

#pragma mark - Accessing the Components.

- (NSArray *)copyAllComponents
{
    // Copying the all components.
    NSMutableArray *allComponents = [mComponents mutableCopy];
    
    // Returning the all components.
    return allComponents;
}

- (NSArray *)allComponents
{
    // Copying the all components.
    NSArray *allComponents = [self copyAllComponents];
    
    // Returning the all components.
    return allComponents;
}

- (NSInteger)numberOfComponents
{
    // Getting the numer of components.
    NSInteger numberOfComponents = (NSInteger)mComponents.count;
    
    // Returning the number of components.
    return numberOfComponents;
}

- (NSNumber *)componentAtIndex:(NSInteger)index
{
    // Decraling some variables.
    NSNumber * component;
    
    // The index is valid.
    if ((index >= 0) && (index < (NSInteger)[mComponents count]))
    {
        // Getting the component.
        component = mComponents[(NSUInteger)index];
    }
    
    // The index is invalid.
    else
    {
        // Setting the default value.
        component = @0;
    }
    
    // Returning the component.
    return component;
}

- (id)objectAtIndexedSubscript:(NSInteger)index
{
    // Decraling some variables.
    NSNumber * component;
    
    // The index is valid.
    if ((index >= 0) && (index < (NSInteger)[mComponents count]))
    {
        // Getting the component.
        component = mComponents[(NSUInteger)index];
    }
    
    // The index is invalid.
    else
    {
        // Setting the default value.
        component = @0;
    }
    
    // Returning the component.
    return component;
}

- (NSNumber *)major
{
    // Getting the major version number.
    NSNumber *major = self[0];
    
    // Returning the major version number.
    return major;
}

- (NSNumber *)minor
{
    // Getting the minor version number.
    NSNumber *minor = self[1];
    
    // Returning the minor version number.
    return minor;
}

- (NSNumber *)build
{
    // Getting the build number.
    NSNumber *build = self[2];
    
    // Returning the build number.
    return build;
}

- (NSNumber *)revision
{
    // Getting the revision number.
    NSNumber *revision = self[3];
    
    // Returning the revision number.
    return revision;
}

#pragma mark - Comparing RFNSVersion Objects

- (NSComparisonResult)compare:(RFNSVersion *)rightVersion
{
    // Setting default values.
    NSComparisonResult comparisonResult = NSOrderedSame;
    
    // We do have the right version.
    if (!rightVersion)
    {
        // Creating the default version.
        rightVersion = [[RFNSVersion alloc] init];
    }
    
    // Getting the number of components.
    NSInteger numberOfLeftComponents = [self numberOfComponents];
    NSInteger numberOfRightComponents = [rightVersion numberOfComponents];
    NSInteger numberOfComponents = MAX(numberOfLeftComponents, numberOfRightComponents);
    
    // Comparing the components.
    for (NSInteger indexOfComponent = 0; (indexOfComponent < numberOfComponents) && (comparisonResult == NSOrderedSame); indexOfComponent++)
    {
        // Getting the left componets and the right component.
        NSNumber *leftComponent = self[indexOfComponent];
        NSNumber *rightComponent = rightVersion[indexOfComponent];
        
        // Comparing the left component and the right component.
        comparisonResult = [leftComponent compare:rightComponent];
    }
    
    // Returning the comparison result;
    return comparisonResult;
}

- (BOOL)isEqualToVersion:(RFNSVersion *)rightVersion
{
    // Setting default values.
    NSComparisonResult comparisonResult = NSOrderedSame;
    
    // We do have the right version.
    if (!rightVersion)
    {
        // Creating the default version.
        rightVersion = [[RFNSVersion alloc] init];
    }
    
    // Getting the number of components.
    NSInteger numberOfLeftComponents = [self numberOfComponents];
    NSInteger numberOfRightComponents = [rightVersion numberOfComponents];
    NSInteger numberOfComponents = MAX(numberOfLeftComponents, numberOfRightComponents);
    
    // Comparing the components.
    for (NSInteger indexOfComponent = 0; (indexOfComponent < numberOfComponents) && (comparisonResult == NSOrderedSame); indexOfComponent++)
    {
        // Getting the left componets and the right component.
        NSNumber *leftComponent = self[indexOfComponent];
        NSNumber *rightComponent = rightVersion[indexOfComponent];
        
        // Comparing the left component and the right component.
        comparisonResult = [leftComponent compare:rightComponent];
    }
    
    // Equaling the version.
    BOOL isEqual = (comparisonResult == NSOrderedSame);
    
    // Returning the result;
    return isEqual;
}

#pragma mark - Conforming the NSObject Protocol

#pragma mark Identifying and Comparing Objects

- (BOOL)isEqual:(id)object
{
    // Setting default values.
    NSComparisonResult comparisonResult = NSOrderedSame;
    
    // The object is a RFNSVersion object.
    if ([object isKindOfClass:[RFNSVersion class]])
    {
        // Getting the right version
        RFNSVersion *rightVersion = (RFNSVersion *)object;
        
        // Getting the number of components.
        NSInteger numberOfLeftComponents = [self numberOfComponents];
        NSInteger numberOfRightComponents = [rightVersion numberOfComponents];
        NSInteger numberOfComponents = MAX(numberOfLeftComponents, numberOfRightComponents);
        
        // Comparing the components.
        for (NSInteger indexOfComponent = 0; (indexOfComponent < numberOfComponents) && (comparisonResult == NSOrderedSame); indexOfComponent++)
        {
            // Getting the left componets and the right component.
            NSNumber *leftComponent = self[indexOfComponent];
            NSNumber *rightComponent = rightVersion[indexOfComponent];
            
            // Comparing the left component and the right component.
            comparisonResult = [leftComponent compare:rightComponent];
        }
    }
    
    // Equaling the version.
    BOOL isEqual = (comparisonResult == NSOrderedSame);
    
    // Returning the result;
    return isEqual;
}

- (NSUInteger)hash
{
    // Setting the default values.
    NSUInteger hash = 0;
    
    // Getting the number of components.
    NSInteger numberOfComponents = [self numberOfComponents];
    
    // Hashing the components.
    for (NSInteger indexOfComponent = 0; indexOfComponent < numberOfComponents; indexOfComponent++)
    {
        // Getting the componet.
        NSNumber *component = self[indexOfComponent];
        
        // The component hash must be 0 when if the componet is 0!
        // 0 is not effect on the value of the version hash.
        // The component is not zero.
        if (![component isEqual:@0])
        {
            // Calculating the hash.
            NSUInteger componentHash = [component hash];
            hash ^= componentHash;
        }
    }
    
    // Returning the hash.
    return hash;
}

#pragma mark Describing Objects

- (NSString *)description
{
    // Creating the empty description.
    NSMutableString *description = [[NSMutableString alloc] init];
    
    // Getting the number of components.
    NSInteger numberOfComponents = [self numberOfComponents];
    
    // Enumarating the components.
    for (NSInteger indexOfComponent = 0; indexOfComponent < numberOfComponents; indexOfComponent++)
    {
        // Getting the componet.
        NSNumber *component = self[indexOfComponent];
        
        // Appending the component to the desctiption.
        [description appendFormat:@"%ld.", (long)component.integerValue];
    }
    
    // Deleting the last characters: ".".
    [description trimRightStrings:@".", nil];
    
    // Returning the description
    return description;
}

@end
