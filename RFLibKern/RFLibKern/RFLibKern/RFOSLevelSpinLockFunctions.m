//
//  RFOSLevelSpinLockFunctions.m
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
#import "RFOSLevelSpinLockFunctions.h"

// Importing the project headers.
#import "RFOSPrivateLog.h"

// Importing the system headers.
#import <libkern/OSAtomic.h>

#define RF_OS_LEVEL_SPIN_LOCK_LEVELS_BITS UINT32_C(32)

uint32_t RFOSLevelSpinLockStaticGetMaximumNumberOfLevels(void)
{
    // Returning the maximum number of levels.
    return RF_OS_LEVEL_SPIN_LOCK_LEVELS_BITS;
}

uint32_t RFOSLevelSpinLockStaticGetMaximumLevelCount(uint32_t numberOfLevels)
{
    // Calculating the maximum level count.
    uint32_t numberOfLevelBits = (numberOfLevels ? (RF_OS_LEVEL_SPIN_LOCK_LEVELS_BITS / numberOfLevels) : UINT32_C(0));
    uint32_t maximumLevelCount = (uint32_t)(UINT32_C(1) << numberOfLevelBits) - UINT32_C(1);
    
    // Returning the maximum level count.
    return maximumLevelCount;
}

void RFOSLevelSpinLockInitialize(RFOSLevelSpinLock *pLevelSpinLock, uint32_t numberOfLevels)
{
    // Validating the arguments.
    RFOSPrivateCAssert(pLevelSpinLock, "The levelSpinLock argument is NULL.");
    RFOSPrivateCAssert(((numberOfLevels >= UINT32_C(1)) && (numberOfLevels <= RFOSLevelSpinLockStaticGetMaximumNumberOfLevels())), "The numberOfLevels (%lu) argument is out of bounds [1, RFOSLevelSpinLockStaticGetMaximumNumberOfLevels()] ([1, %ld]).", (unsigned long)numberOfLevels, (unsigned long)RFOSLevelSpinLockStaticGetMaximumNumberOfLevels());
    
    // Initializing the level spin lock.
    pLevelSpinLock->numberOfLevels = numberOfLevels;
    pLevelSpinLock->waitingCounts = UINT32_C(0);
    pLevelSpinLock->maximumHeldCounts = UINT32_C(1);
    pLevelSpinLock->heldCounts = UINT32_C(0);
    
    uint32_t numberOfLevelBits = RF_OS_LEVEL_SPIN_LOCK_LEVELS_BITS / pLevelSpinLock->numberOfLevels;
    
    for (uint32_t indexOfLevel = UINT32_C(1); indexOfLevel < numberOfLevels; indexOfLevel++)
    {
        pLevelSpinLock->maximumHeldCounts |= (pLevelSpinLock->maximumHeldCounts << numberOfLevelBits);
    }
}

uint32_t RFOSLevelSpinLockGetNumberOfLevels(RFOSLevelSpinLock *pLevelSpinLock)
{
    // Validating the arguments.
    RFOSPrivateCAssert(pLevelSpinLock, "The levelSpinLock argument is NULL.");
    RFOSPrivateCAssert(((pLevelSpinLock->numberOfLevels >= UINT32_C(1)) && (pLevelSpinLock->numberOfLevels <= RFOSLevelSpinLockStaticGetMaximumNumberOfLevels())), "The levelSpinLock->numberOfLevels (%lu) argument is corrupted, because it is out of bounds [1, RFOSLevelSpinLockStaticGetMaximumNumberOfLevels()] ([1, %ld]).", (unsigned long)pLevelSpinLock->numberOfLevels, (unsigned long)RFOSLevelSpinLockStaticGetMaximumNumberOfLevels());
    
    // Getting the number of levels.
    uint32_t numberOfLevels = pLevelSpinLock->numberOfLevels;
    
    // Returning the number of levels.
    return numberOfLevels;
}

uint32_t RFOSLevelSpinLockGetMaximumLevelCount(RFOSLevelSpinLock *pLevelSpinLock, uint32_t level)
{
    // Validating the arguments.
    RFOSPrivateCAssert(pLevelSpinLock, "The levelSpinLock argument is NULL.");
    RFOSPrivateCAssert(((pLevelSpinLock->numberOfLevels >= UINT32_C(1)) && (pLevelSpinLock->numberOfLevels <= RFOSLevelSpinLockStaticGetMaximumNumberOfLevels())), "The levelSpinLock->numberOfLevels (%lu) argument is corrupted, because it is out of bounds [1, RFOSLevelSpinLockStaticGetMaximumNumberOfLevels()] ([1, %ld]).", (unsigned long)pLevelSpinLock->numberOfLevels, (unsigned long)RFOSLevelSpinLockStaticGetMaximumNumberOfLevels());
    RFOSPrivateCAssert((level < pLevelSpinLock->numberOfLevels), "The level (%lu) argument is out of bounds [0, levelSpinLock->numberOfLevels) ([0, %ld)).", (unsigned long)level, (unsigned long)pLevelSpinLock->numberOfLevels);
    
    // Calculating the additional data.
    
    uint32_t numberOfLevelBits = RF_OS_LEVEL_SPIN_LOCK_LEVELS_BITS / pLevelSpinLock->numberOfLevels;
    uint32_t numberOfHighLevelsBits = numberOfLevelBits * level;
    
    uint32_t levelMask = ((uint32_t)((UINT32_C(1) << numberOfLevelBits) - UINT32_C(1)) << numberOfHighLevelsBits);
    
    // Calculating the maximum level count.
    uint32_t maximumLevelCount = (pLevelSpinLock->maximumHeldCounts & levelMask) >> numberOfHighLevelsBits;
    
    // Returning the maximum level count.
    return maximumLevelCount;
}

void RFOSLevelSpinLockSetMaximumLevelCount(RFOSLevelSpinLock *pLevelSpinLock, uint32_t level, uint32_t maximumCount)
{
    // Validating the arguments.
    RFOSPrivateCAssert(pLevelSpinLock, "The levelSpinLock argument is NULL.");
    RFOSPrivateCAssert(((pLevelSpinLock->numberOfLevels >= UINT32_C(1)) && (pLevelSpinLock->numberOfLevels <= RFOSLevelSpinLockStaticGetMaximumNumberOfLevels())), "The levelSpinLock->numberOfLevels (%lu) argument is corrupted, because it is out of bounds [1, RFOSLevelSpinLockStaticGetMaximumNumberOfLevels()] ([1, %ld]).", (unsigned long)pLevelSpinLock->numberOfLevels, (unsigned long)RFOSLevelSpinLockStaticGetMaximumNumberOfLevels());
    RFOSPrivateCAssert((level < pLevelSpinLock->numberOfLevels), "The level (%lu) argument is out of bounds [0, levelSpinLock->numberOfLevels) ([0, %ld)).", (unsigned long)level, (unsigned long)pLevelSpinLock->numberOfLevels);
    RFOSPrivateCAssert(((maximumCount >= UINT32_C(1)) && (maximumCount <= RFOSLevelSpinLockStaticGetMaximumLevelCount(pLevelSpinLock->numberOfLevels))), "The maximumCount (%lu) argument is out of bounds [1, RFOSLevelSpinLockStaticGetMaximumLevelCount(levelSpinLock->numberOfLevels)] ([1, %ld]).", (unsigned long)maximumCount, (unsigned long)RFOSLevelSpinLockStaticGetMaximumLevelCount(pLevelSpinLock->numberOfLevels));
    
    // Calculating the additional data.
    
    uint32_t numberOfLevelBits = RF_OS_LEVEL_SPIN_LOCK_LEVELS_BITS / pLevelSpinLock->numberOfLevels;
    uint32_t numberOfHighLevelsBits = numberOfLevelBits * level;
    
    uint32_t levelMask = ((uint32_t)((UINT32_C(1) << numberOfLevelBits) - UINT32_C(1)) << numberOfHighLevelsBits);
    uint32_t maximumHeldCount = maximumCount << numberOfHighLevelsBits;
    
    // Setting the maximum count for the level.
    
    uint32_t maximumHeldCounts;
    
    do
    {
        maximumHeldCounts = pLevelSpinLock->maximumHeldCounts;
    } while (!OSAtomicCompareAndSwap32Barrier((int32_t)maximumHeldCounts, (int32_t)((maximumHeldCounts & ~levelMask) | maximumHeldCount), (volatile int32_t *)&pLevelSpinLock->maximumHeldCounts));
}

bool RFOSLevelSpinLockTry(RFOSLevelSpinLock *pLevelSpinLock, uint32_t level)
{
    // Validating the arguments.
    RFOSPrivateCAssert(pLevelSpinLock, "The levelSpinLock argument is NULL.");
    RFOSPrivateCAssert(((pLevelSpinLock->numberOfLevels >= UINT32_C(1)) && (pLevelSpinLock->numberOfLevels <= RFOSLevelSpinLockStaticGetMaximumNumberOfLevels())), "The levelSpinLock->numberOfLevels (%lu) argument is corrupted, because it is out of bounds [1, RFOSLevelSpinLockStaticGetMaximumNumberOfLevels()] ([1, %ld]).", (unsigned long)pLevelSpinLock->numberOfLevels, (unsigned long)RFOSLevelSpinLockStaticGetMaximumNumberOfLevels());
    RFOSPrivateCAssert((level < pLevelSpinLock->numberOfLevels), "The level (%lu) argument is out of bounds [0, levelSpinLock->numberOfLevels) ([0, %ld)).", (unsigned long)level, (unsigned long)pLevelSpinLock->numberOfLevels);
    
    // Calculating the additional data.
    
    uint32_t numberOfLevelBits = RF_OS_LEVEL_SPIN_LOCK_LEVELS_BITS / pLevelSpinLock->numberOfLevels;
    uint32_t numberOfHighLevelsBits = numberOfLevelBits * level;
    
    uint32_t highLevelsMask = (UINT32_C(1) << numberOfHighLevelsBits) - UINT32_C(1);
    uint32_t levelMask = ((uint32_t)((UINT32_C(1) << numberOfLevelBits) - UINT32_C(1)) << numberOfHighLevelsBits);
    uint32_t levelAmount = UINT32_C(1) << numberOfHighLevelsBits;
    
    // Declaring some variables.
    bool result = true;
    
    // Incrementing the waitingCount for the level.
    
    uint32_t oldWaitingCounts;
    
    do
    {
        if ((((oldWaitingCounts = pLevelSpinLock->waitingCounts)) & levelMask) == levelMask)
        {
            result = false;
            goto jmp_return;
        }
    } while (!OSAtomicCompareAndSwap32Barrier((int32_t)oldWaitingCounts, (int32_t)(oldWaitingCounts + levelAmount), (volatile int32_t *)&pLevelSpinLock->waitingCounts));
    
    // Incrementing the heldCount for the level.
    
    uint32_t oldHeldCounts;
    
    do
    {
        if (pLevelSpinLock->waitingCounts & highLevelsMask)
        {
            result = false;
            goto jmp_decrement_waitingCount;
        }
        
        oldHeldCounts = pLevelSpinLock->heldCounts;
        
        if ((oldHeldCounts & ~levelMask) || ((oldHeldCounts & levelMask) >= (pLevelSpinLock->maximumHeldCounts & levelMask)))
        {
            result = false;
            goto jmp_decrement_waitingCount;
        }
    } while (!OSAtomicCompareAndSwap32Barrier((int32_t)oldHeldCounts, (int32_t)(oldHeldCounts + levelAmount), (volatile int32_t *)&pLevelSpinLock->heldCounts));
    
jmp_decrement_waitingCount:
    
    // Decrementing the waitingCount for the level.
    {
        uint32_t newWaitingCounts = (uint32_t)OSAtomicAdd32Barrier(-((int32_t)levelAmount), (volatile int32_t *)&pLevelSpinLock->waitingCounts);
        RFOSPrivateCAssert(((newWaitingCounts & levelMask) != levelMask), "The levelSpinLock->waitingCounts argument is corrupted.");
    }
    
jmp_return:
    
    // Returning the result.
    return result;
}

void RFOSLevelSpinLockLock(RFOSLevelSpinLock *pLevelSpinLock, uint32_t level)
{
    // Validating the arguments.
    RFOSPrivateCAssert(pLevelSpinLock, "The levelSpinLock argument is NULL.");
    RFOSPrivateCAssert(((pLevelSpinLock->numberOfLevels >= UINT32_C(1)) && (pLevelSpinLock->numberOfLevels <= RFOSLevelSpinLockStaticGetMaximumNumberOfLevels())), "The levelSpinLock->numberOfLevels (%lu) argument is corrupted, because it is out of bounds [1, RFOSLevelSpinLockStaticGetMaximumNumberOfLevels()] ([1, %ld]).", (unsigned long)pLevelSpinLock->numberOfLevels, (unsigned long)RFOSLevelSpinLockStaticGetMaximumNumberOfLevels());
    RFOSPrivateCAssert((level < pLevelSpinLock->numberOfLevels), "The level (%lu) argument is out of bounds [0, levelSpinLock->numberOfLevels) ([0, %ld)).", (unsigned long)level, (unsigned long)pLevelSpinLock->numberOfLevels);
    
    // Calculating the additional data.
    
    uint32_t numberOfLevelBits = RF_OS_LEVEL_SPIN_LOCK_LEVELS_BITS / pLevelSpinLock->numberOfLevels;
    uint32_t numberOfHighLevelsBits = numberOfLevelBits * level;
    
    uint32_t highLevelsMask = (UINT32_C(1) << numberOfHighLevelsBits) - UINT32_C(1);
    uint32_t levelMask = ((uint32_t)((UINT32_C(1) << numberOfLevelBits) - UINT32_C(1)) << numberOfHighLevelsBits);
    uint32_t levelAmount = UINT32_C(1) << numberOfHighLevelsBits;
    
    // Incrementing the waitingCount for the level.
    
    uint32_t oldWaitingCounts;
    
    do
    {
        do
        {
        } while ((((oldWaitingCounts = pLevelSpinLock->waitingCounts)) & levelMask) == levelMask);
    } while (!OSAtomicCompareAndSwap32Barrier((int32_t)oldWaitingCounts, (int32_t)(oldWaitingCounts + levelAmount), (volatile int32_t *)&pLevelSpinLock->waitingCounts));
    
    // Incrementing the heldCount for the level.
    
    uint32_t oldHeldCounts;
    
    do
    {
        do
        {
        } while (pLevelSpinLock->waitingCounts & highLevelsMask);
        do
        {
            oldHeldCounts = pLevelSpinLock->heldCounts;
        } while ((oldHeldCounts & ~levelMask) || ((oldHeldCounts & levelMask) >= (pLevelSpinLock->maximumHeldCounts & levelMask)));
    } while (!OSAtomicCompareAndSwap32Barrier((int32_t)oldHeldCounts, (int32_t)(oldHeldCounts + levelAmount), (volatile int32_t *)&pLevelSpinLock->heldCounts));
    
    // Decrementing the waitingCount for the level.
    
    uint32_t newWaitingCounts = (uint32_t)OSAtomicAdd32Barrier(-((int32_t)levelAmount), (volatile int32_t *)&pLevelSpinLock->waitingCounts);
    RFOSPrivateCAssert(((newWaitingCounts & levelMask) != levelMask), "The levelSpinLock->waitingCounts argument is corrupted.");
}

void RFOSLevelSpinLockUnlock(RFOSLevelSpinLock *pLevelSpinLock, uint32_t level)
{
    // Validating the arguments.
    RFOSPrivateCAssert(pLevelSpinLock, "The levelSpinLock argument is NULL.");
    RFOSPrivateCAssert(((pLevelSpinLock->numberOfLevels >= UINT32_C(1)) && (pLevelSpinLock->numberOfLevels <= RFOSLevelSpinLockStaticGetMaximumNumberOfLevels())), "The levelSpinLock->numberOfLevels (%lu) argument is corrupted, because it is out of bounds [1, RFOSLevelSpinLockStaticGetMaximumNumberOfLevels()] ([1, %ld]).", (unsigned long)pLevelSpinLock->numberOfLevels, (unsigned long)RFOSLevelSpinLockStaticGetMaximumNumberOfLevels());
    RFOSPrivateCAssert((level < pLevelSpinLock->numberOfLevels), "The level (%lu) argument is out of bounds [0, levelSpinLock->numberOfLevels) ([0, %ld)).", (unsigned long)level, (unsigned long)pLevelSpinLock->numberOfLevels);
    
    // Calculating the additional data.
    
    uint32_t numberOfLevelBits = RF_OS_LEVEL_SPIN_LOCK_LEVELS_BITS / pLevelSpinLock->numberOfLevels;
    uint32_t numberOfHighLevelsBits = numberOfLevelBits * level;
    
    uint32_t levelMask = ((uint32_t)((UINT32_C(1) << numberOfLevelBits) - UINT32_C(1)) << numberOfHighLevelsBits);
    uint32_t levelAmount = UINT32_C(1) << numberOfHighLevelsBits;
    
    // Decrementing the heldCount for the level.
    
    uint32_t newHeldCounts = (uint32_t)OSAtomicAdd32Barrier(-((int32_t)levelAmount), (volatile int32_t *)&pLevelSpinLock->heldCounts);
    RFOSPrivateCAssert(((newHeldCounts & ~levelMask) == UINT32_C(0)), "The levelSpinLock->oldHeldCounts argument is corrupted. The number of call unlock functions is greater than the number of call lock functions.");
    RFOSPrivateCAssert(((newHeldCounts & levelMask) != levelMask), "The levelSpinLock->heldCounts argument is corrupted. The number of call unlock functions is greater than the number of call lock functions.");
}
