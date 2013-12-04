//
//  RFNSVersion.h
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

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>

@class NSArray;
@class NSMutableArray;
@class NSNumber;
@class NSString;

@class RFNSVersion;

@interface RFNSVersion : NSObject
{
@protected
    
    NSMutableArray *mComponents;
}

// Initializing and Creating a RFNSVersion

+ (id)version;

- (id)initWithString:(NSString *)string;
+ (id)versionWithString:(NSString *)string;

- (id)initWithComponents:(id)firstComponent, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)versionWithComponents:(id)firstComponent, ... NS_REQUIRES_NIL_TERMINATION;

- (id)initWithArray:(NSArray *)array;
+ (id)versionWithArray:(NSArray *)array;

// Accessing the Components.

- (NSArray *)copyAllComponents; // Returns a NSArray of NSNumber of NSInteger.
- (NSArray *)allComponents;

- (NSInteger)numberOfComponents;
- (NSNumber *)componentAtIndex:(NSInteger)index; // Returns a NSNumber of NSInteger. The method returns default value if the index is invalid. The default value is 0.
- (id)objectAtIndexedSubscript:(NSInteger)index; // Returns a NSNumber of NSInteger. The method returns default value if the index is invalid. The default value is 0.

@property (nonatomic, readonly) NSNumber *major;    // The major version number is a component at 0 position.
@property (nonatomic, readonly) NSNumber *minor;    // The minor version number is a component at 1 position.
@property (nonatomic, readonly) NSNumber *build;    // The build number is a component at 2 position.
@property (nonatomic, readonly) NSNumber *revision; // The revision number is a component at 3 position.

// Comparing RFNSVersion Objects

- (NSComparisonResult)compare:(RFNSVersion *)rightVersion;

- (BOOL)isEqualToVersion:(RFNSVersion *)rightVersion;

@end
