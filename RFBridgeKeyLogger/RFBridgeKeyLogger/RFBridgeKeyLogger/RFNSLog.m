//
//  RFNSLog.m
//  RFBridgeKeyLogger
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2014.01.01.
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
#import "RFNSLog.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

void RFNSLoggerTestCDefines(void);
void RFNSLoggerTestCDefines()
{
    // C.
    
    RFNSCAbort((arc4random() % 2), "Test: %s", "RFNSCAbort");
    RFNSCAssert((arc4random() % 2), "Test: %s", "RFNSCAssert");
    RFNSCBreakpoint((arc4random() % 2), "Test: %s", "RFNSCBreakpoint");
    RFNSCInform((arc4random() % 2), "Test: %s", "RFNSCInform");
    RFNSCWarn((arc4random() % 2), "Test: %s", "RFNSCWarn");
    
    // Objective-C.
    
    RFNSObjectiveCCAbort((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCCAbort");
    RFNSObjectiveCCAssert((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCCAssert");
    RFNSObjectiveCCBreakpoint((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCCBreakpoint");
    RFNSObjectiveCCInform((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCCInform");
    RFNSObjectiveCCWarn((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCCWarn");
    
    NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
    
    RFNSObjectiveCCAbortWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCCAbortWithError");
    RFNSObjectiveCCAssertWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCCAssertWithError");
    RFNSObjectiveCCBreakpointWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCCBreakpointWithError");
    RFNSObjectiveCCInformWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCCInformWithError");
    RFNSObjectiveCCWarnWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCCWarnWithError");
    
    NSException *exception = [NSException exceptionWithName:@"" reason:@"" userInfo:nil];
    
    RFNSObjectiveCCAbortWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCCAbortWithException");
    RFNSObjectiveCCAssertWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCCAssertWithException");
    RFNSObjectiveCCBreakpointWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCCBreakpointWithException");
    RFNSObjectiveCCInformWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCCInformWithException");
    RFNSObjectiveCCWarnWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCCWarnWithException");
}

@interface RFNSLoggerTestDefines : NSObject
{
}

@end

@implementation RFNSLoggerTestDefines

- (void)testDefines
{
    // C.
    
    RFNSCAbort((arc4random() % 2), "Test: %s", "RFNSCAbort");
    RFNSCAssert((arc4random() % 2), "Test: %s", "RFNSCAssert");
    RFNSCBreakpoint((arc4random() % 2), "Test: %s", "RFNSCBreakpoint");
    RFNSCInform((arc4random() % 2), "Test: %s", "RFNSCInform");
    RFNSCWarn((arc4random() % 2), "Test: %s", "RFNSCWarn");
    
    // Objective-C.
    
    RFNSObjectiveCCAbort((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCCAbort");
    RFNSObjectiveCCAssert((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCCAssert");
    RFNSObjectiveCCBreakpoint((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCCBreakpoint");
    RFNSObjectiveCCInform((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCCInform");
    RFNSObjectiveCCWarn((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCCWarn");
    
    RFNSObjectiveCAbort((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCAbort");
    RFNSObjectiveCAssert((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCAssert");
    RFNSObjectiveCBreakpoint((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCBreakpoint");
    RFNSObjectiveCInform((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCInform");
    RFNSObjectiveCWarn((arc4random() % 2), @"Test: %@", @"RFNSObjectiveCWarn");
    
    NSError *error = [[NSError alloc] initWithDomain:@"" code:0 userInfo:nil];
    
    RFNSObjectiveCCAbortWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCCAbortWithError");
    RFNSObjectiveCCAssertWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCCAssertWithError");
    RFNSObjectiveCCBreakpointWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCCBreakpointWithError");
    RFNSObjectiveCCInformWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCCInformWithError");
    RFNSObjectiveCCWarnWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCCWarnWithError");
    
    RFNSObjectiveCAbortWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCAbortWithError");
    RFNSObjectiveCAssertWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCAssertWithError");
    RFNSObjectiveCBreakpointWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCBreakpointWithError");
    RFNSObjectiveCInformWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCInformWithError");
    RFNSObjectiveCWarnWithError((arc4random() % 2), error, @"Test: %@", @"RFNSObjectiveCWarnWithError");
    
    NSException *exception = [NSException exceptionWithName:@"" reason:@"" userInfo:nil];
    
    RFNSObjectiveCCAbortWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCCAbortWithException");
    RFNSObjectiveCCAssertWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCCAssertWithException");
    RFNSObjectiveCCBreakpointWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCCBreakpointWithException");
    RFNSObjectiveCCInformWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCCInformWithException");
    RFNSObjectiveCCWarnWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCCWarnWithException");
    
    RFNSObjectiveCAbortWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCAbortWithException");
    RFNSObjectiveCAssertWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCAssertWithException");
    RFNSObjectiveCBreakpointWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCBreakpointWithException");
    RFNSObjectiveCInformWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCInformWithException");
    RFNSObjectiveCWarnWithException((arc4random() % 2), exception, @"Test: %@", @"RFNSObjectiveCWarnWithException");
}

@end
