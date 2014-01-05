//
//  RFOSSequenceSpinLockFunctions.m
//  RFLibKern
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2014.01.05.
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
#import "RFOSSequenceSpinLockFunctions.h"

// Importing the external headers.
#import <RFBridgeKeyLogger/RFBridgeKeyLogger.h>

// Importing the system headers.
#import <libkern/OSAtomic.h>

void RFOSSequenceSpinLockInitialize(RFOSSequenceSpinLock *pSequenceSpinLock)
{
    // Validating the arguments.
    RFNSCAssert(pSequenceSpinLock, "The sequenceSpinLock argument is NULL.");
    
    // Initializing the sequence spin lock.
    pSequenceSpinLock->counter1 = 0;
    pSequenceSpinLock->counter2 = 2;
}

RFOSSequenceSpinLockLockIdentifier RFOSSequenceSpinLockLock(RFOSSequenceSpinLock *pSequenceSpinLock)
{
    // Validating the arguments.
    RFNSCAssert(pSequenceSpinLock, "The sequenceSpinLock argument is NULL.");
    
    // Getting the lock indentifier.
    RFOSSequenceSpinLockLockIdentifier lockIdentifier = OSAtomicAdd32Barrier(2, &pSequenceSpinLock->counter1);
    
    // Locking the sequence lock.
    while (!OSAtomicCompareAndSwap32Barrier(lockIdentifier, lockIdentifier + 1, &pSequenceSpinLock->counter2))
    {
    }
    
    // Returning the lock indentifier.
    return lockIdentifier;
}

void RFOSSequenceSpinLockUnlock(RFOSSequenceSpinLock *pSequenceSpinLock, RFOSSequenceSpinLockLockIdentifier lockIdentifier)
{
    // Validating the arguments.
    RFNSCAssert(pSequenceSpinLock, "The sequenceSpinLock argument is NULL.");
    
    // Unlocking the sequence lock.
    while (!OSAtomicCompareAndSwap32Barrier(lockIdentifier + 1, lockIdentifier + 2, &pSequenceSpinLock->counter2))
    {
        // Validating the arguments.
        RFNSCAssert(NO, "The lockIdentifier argument is invalid.");
    }
}
