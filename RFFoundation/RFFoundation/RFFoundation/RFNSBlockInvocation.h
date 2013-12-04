//
//  RFNSBlockInvocation.h
//  RFFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.07.06.
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
#import <Foundation/NSDate.h>
#import <Foundation/NSInvocation.h>
#import <Foundation/NSNotificationQueue.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSObject.h>

@class NSArray;
@class NSMutableArray;
@class NSThread;

@class RFNSBlockInvocation;

@interface RFNSBlockInvocation : NSInvocation
{
@protected
    
    NSInteger       mAllowAddBlockCounter;
    NSMutableArray *mBlocks;
}

// Initializing and Creating a RFNSBlockInvocation

+ (RFNSBlockInvocation *)blockInvocation;
+ (RFNSBlockInvocation *)blockInvocationWithBlock:(void (^)(void))block;

// Managing the RFNSBlockInvocation Object

- (NSMutableArray *)copyExecutionBlocks;
- (NSMutableArray *)executionBlocks;
- (void)addExecutionBlock:(void (^)(void))block;
- (void)setExecutionBlocks:(NSMutableArray *)executionBlocks;

@end

@interface NSObject (NSObjectRFNSBlockInvocation)

// Sending Messages

- (void)performBlock:(void (^)(void))block;
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay inModes:(NSArray *)modes;
- (void)performBlock:(void (^)(void))block order:(NSUInteger)order;
- (void)performBlock:(void (^)(void))block order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performBlock:(void (^)(void))block postingStyle:(NSPostingStyle)postingStyle;

// Sending Messages in Background

- (void)performBlockInBackground:(void (^)(void))block;

// Sending Messages on a Thread

- (void)performBlock:(void (^)(void))block onThread:(NSThread *)thread order:(NSUInteger)order;
- (void)performBlock:(void (^)(void))block onThread:(NSThread *)thread order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performBlock:(void (^)(void))block onThread:(NSThread *)thread postingStyle:(NSPostingStyle)postingStyle;
- (void)performBlock:(void (^)(void))block onThread:(NSThread *)thread waitUntilDone:(BOOL)wait;
- (void)performBlock:(void (^)(void))block onThread:(NSThread *)thread waitUntilDone:(BOOL)wait modes:(NSArray *)modes;

// Sending Messages on the Main Thread

- (void)performBlockOnMainThread:(void (^)(void))block order:(NSUInteger)order;
- (void)performBlockOnMainThread:(void (^)(void))block order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performBlockOnMainThread:(void (^)(void))block postingStyle:(NSPostingStyle)postingStyle;
- (void)performBlockOnMainThread:(void (^)(void))block waitUntilDone:(BOOL)wait;
- (void)performBlockOnMainThread:(void (^)(void))block waitUntilDone:(BOOL)wait modes:(NSArray *)modes;

// Sending Messages on the Second Thread

- (void)performBlockOnSecondThread:(void (^)(void))block order:(NSUInteger)order;
- (void)performBlockOnSecondThread:(void (^)(void))block order:(NSUInteger)order modes:(NSArray *)modes;
- (void)performBlockOnSecondThread:(void (^)(void))block postingStyle:(NSPostingStyle)postingStyle;
- (void)performBlockOnSecondThread:(void (^)(void))block waitUntilDone:(BOOL)wait;
- (void)performBlockOnSecondThread:(void (^)(void))block waitUntilDone:(BOOL)wait modes:(NSArray *)modes;

@end
