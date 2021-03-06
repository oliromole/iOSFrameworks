//
//  RFOSLevelSpinLockFunctions.h
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

// Importing the project headers.
#import "RFOSLevelSpinLock.h"

// Importing the system headers.
#import <stdbool.h>
#import <stdint.h>

uint32_t RFOSLevelSpinLockStaticGetMaximumNumberOfLevels(void);
uint32_t RFOSLevelSpinLockStaticGetMaximumLevelCount(uint32_t numberOfLevels);

void RFOSLevelSpinLockInitialize(RFOSLevelSpinLock *levelSpinLock, uint32_t numberOfLevels);

uint32_t RFOSLevelSpinLockGetNumberOfLevels(RFOSLevelSpinLock *levelSpinLock);

uint32_t RFOSLevelSpinLockGetMaximumLevelCount(RFOSLevelSpinLock *levelSpinLock, uint32_t level);
void RFOSLevelSpinLockSetMaximumLevelCount(RFOSLevelSpinLock *levelSpinLock, uint32_t level, uint32_t maximumCount);

bool RFOSLevelSpinLockTry(RFOSLevelSpinLock *levelSpinLock, uint32_t level);
void RFOSLevelSpinLockLock(RFOSLevelSpinLock *levelSpinLock, uint32_t level);
void RFOSLevelSpinLockUnlock(RFOSLevelSpinLock *levelSpinLock, uint32_t level);
