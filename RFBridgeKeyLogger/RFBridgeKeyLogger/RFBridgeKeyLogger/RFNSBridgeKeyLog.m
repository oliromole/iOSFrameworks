//
//  RFNSBridgeKeyLog.m
//  RFBridgeKeyLogger
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.12.06.
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
#import "RFNSBridgeKeyLog.h"

// Importing the system headers.
#import <libkern/OSAtomic.h>
#import <memory.h>
#import <stdio.h>
#import <stdlib.h>
#import <pthread.h>
#import <time.h>

void RFNSDefaultBridgeKeyLog(RFNSBridgeKeyLogParameter *parameters, size_t length);

static RFNSBridgeKeyLogHandler * volatile RFNSBridgeKeyLog_Handler = RFNSDefaultBridgeKeyLog;

static volatile int32_t RFNSDefaultBridgeKeyLog_NumberOfLogs = 0;

void RFNSDefaultBridgeKeyLog(RFNSBridgeKeyLogParameter *parameters, size_t numberOfParameters)
{
    int32_t numberOfLog = OSAtomicAdd32Barrier(1, &RFNSDefaultBridgeKeyLog_NumberOfLogs);
    
    size_t  capacityOfTexts = 100;
    size_t  numberOfTexts = 0;
    char   *texts[capacityOfTexts];
    
    if (numberOfTexts < capacityOfTexts)
    {
        time_t     currentTime = time(NULL);
        struct tm *pCurrentTimeComponents = localtime(&currentTime);
        
        if (pCurrentTimeComponents)
        {
            asprintf(&texts[numberOfTexts], "%04d.%02d.%02d %02d:%02d:%02d %d Bridge Key Log:\n",
                     1900 + pCurrentTimeComponents->tm_year,
                     1 + pCurrentTimeComponents->tm_mon,
                     pCurrentTimeComponents->tm_mday,
                     pCurrentTimeComponents->tm_hour,
                     pCurrentTimeComponents->tm_min,
                     pCurrentTimeComponents->tm_sec,
                     (int)numberOfLog
                     );
            numberOfTexts++;
        }
    }
    
    if (numberOfTexts < capacityOfTexts)
    {
        clock_t currentClocks = clock();
        asprintf(&texts[numberOfTexts], "    Clocks: %g\n", (((double)currentClocks)/CLOCKS_PER_SEC));
        numberOfTexts++;
    }
    
    if (numberOfTexts < capacityOfTexts)
    {
        char threadName[1024];
        
        pthread_t currentPthread = pthread_self();
        int result = pthread_getname_np(currentPthread, threadName, (sizeof(threadName) / sizeof(*threadName)));
        
        if (result == 0)
        {
            asprintf(&texts[numberOfTexts], "    Thread Name: %s\n", threadName);
            numberOfTexts++;
        }
    }
    
    for (size_t indexOfParameter = 0; indexOfParameter < numberOfParameters; indexOfParameter++)
    {
        if (numberOfTexts >= capacityOfTexts)
        {
            break;
        }
        
        RFNSBridgeKeyLogParameter parameter = parameters[indexOfParameter];
        
        if (parameter.keyType &&
            parameter.keyName)
        {
            if (parameter.valueType &&
                parameter.value)
            {
                if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                    (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__BASE_FILE__) &&
                    (parameter.valueType == &RFNSBridgeKeyLogParameterTypeCString))
                {
                    asprintf(&texts[numberOfTexts], "    __BASE_FILE__: %s\n", *((const char * const *)parameter.value));
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__DATE__) &&
                         (parameter.valueType == &RFNSBridgeKeyLogParameterTypeCString))
                {
                    asprintf(&texts[numberOfTexts], "    __DATE__: %s\n", *((const char * const *)parameter.value));
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__FILE__) &&
                         (parameter.valueType == &RFNSBridgeKeyLogParameterTypeCString))
                {
                    asprintf(&texts[numberOfTexts], "    __FILE__: %s\n", *((const char * const *)parameter.value));
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__FUNCTION__) &&
                         (parameter.valueType == &RFNSBridgeKeyLogParameterTypeCString))
                {
                    asprintf(&texts[numberOfTexts], "    __FUNCTION__: %s\n", *((const char * const *)parameter.value));
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__INCLUDE_LEVEL__) &&
                         (parameter.valueType == &RFNSBridgeKeyLogParameterTypeLongInteger))
                {
                    asprintf(&texts[numberOfTexts], "    __INCLUDE_LEVEL__: %ld\n", *((const long *)parameter.value));
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__LINE__) &&
                         (parameter.valueType == &RFNSBridgeKeyLogParameterTypeLongInteger))
                {
                    asprintf(&texts[numberOfTexts], "    __LINE__: %ld\n", *((const long *)parameter.value));
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__PRETTY_FUNCTION__) &&
                         (parameter.valueType == &RFNSBridgeKeyLogParameterTypeCString))
                {
                    asprintf(&texts[numberOfTexts], "    __PRETTY_FUNCTION__: %s\n", *((const char * const *)parameter.value));
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__TIME__) &&
                         (parameter.valueType == &RFNSBridgeKeyLogParameterTypeCString))
                {
                    asprintf(&texts[numberOfTexts], "    __TIME__: %s\n", *((const char * const *)parameter.value));
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__TIMESTAMP__) &&
                         (parameter.valueType == &RFNSBridgeKeyLogParameterTypeCString))
                {
                    asprintf(&texts[numberOfTexts], "    __TIMESTAMP__: %s\n", *((const char * const *)parameter.value));
                    numberOfTexts++;
                }
                
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNameConditionText) &&
                         (parameter.valueType == &RFNSBridgeKeyLogParameterTypeCString))
                {
                    asprintf(&texts[numberOfTexts], "    Condition Text: %s\n", *((const char * const *)parameter.value));
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNameFrameworkName) &&
                         (parameter.valueType == &RFNSBridgeKeyLogParameterTypeCString))
                {
                    asprintf(&texts[numberOfTexts], "    Framework Name: %s\n", *((const char * const *)parameter.value));
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNameMessage) &&
                         (parameter.valueType == &RFNSBridgeKeyLogParameterTypeCString))
                {
                    asprintf(&texts[numberOfTexts], "    Message: %s\n", *((const char * const *)parameter.value));
                    numberOfTexts++;
                }
            }
            else if (!parameter.valueType &&
                     !parameter.value)
            {
                if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                    (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNameCommandAbort))
                {
                    asprintf(&texts[numberOfTexts], "    Abort\n");
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNameCommandAssert))
                {
                    asprintf(&texts[numberOfTexts], "    Assert\n");
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNameCommandBreakpoint))
                {
                    asprintf(&texts[numberOfTexts], "    Breakpoint\n");
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNameCommandInform))
                {
                    asprintf(&texts[numberOfTexts], "    Inform\n");
                    numberOfTexts++;
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNameCommandWarn))
                {
                    asprintf(&texts[numberOfTexts], "    Warn\n");
                    numberOfTexts++;
                }
            }
        }
    }
    
    size_t capacityOfFullText = 0;
    size_t lengthOfFullText = 0;
    
    for (size_t indexOfText = 0; indexOfText < numberOfTexts; indexOfText++)
    {
        capacityOfFullText += strlen(texts[indexOfText]);
    }
    
    char *fullText = malloc(sizeof(*fullText) * (capacityOfFullText + 1));
    
    if (!fullText)
    {
        printf("Low memory.");
        abort();
    }
    
    for (size_t indexOfText = 0; indexOfText < numberOfTexts; indexOfText++)
    {
        char *text = texts[indexOfText];
        size_t lengthOfText = strlen(text);
        
        memcpy(&fullText[lengthOfFullText], text, sizeof(*text) * lengthOfText);
        
        lengthOfFullText += lengthOfText;
    }
    
    fullText[lengthOfFullText] = '\0';
    
    printf("%s", fullText);
    
    for (size_t indexOfText = 0; indexOfText < numberOfTexts; indexOfText++)
    {
        free(texts[indexOfText]);
        texts[indexOfText] = NULL;
    }
    
    free(fullText);
    fullText = NULL;
    
    for (size_t indexOfParameter = 0; indexOfParameter < numberOfParameters; indexOfParameter++)
    {
        RFNSBridgeKeyLogParameter parameter = parameters[indexOfParameter];
        
        if (parameter.keyType &&
            parameter.keyName)
        {
            if (!parameter.valueType &&
                !parameter.value)
            {
                if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                    (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNameCommandAbort))
                {
                    abort();
                }
                else if ((parameter.keyType == &RFNSBridgeKeyLogParameterTypeVoidPointer) &&
                         (parameter.keyName == &RFNSBridgeKeyLogParameterKeyNameCommandAssert))
                {
                    abort();
                }
            }
        }
    }
}

void RFNSBridgeKeyLog(RFNSBridgeKeyLogParameter *parameters, size_t length)
{
    // Getting the bridge key log handler.
    RFNSBridgeKeyLogHandler *bridgeKeyLogHandler = RFNSBridgeKeyLog_Handler;
    
    // We have the bridge key log hendler.
    if (bridgeKeyLogHandler)
    {
        // Making the log.
        bridgeKeyLogHandler(parameters, length);
    }
}

RFNSBridgeKeyLogHandler *RFNSGetDefaultBridgeKeyLogHandler()
{
    // Getting the default bridge key log handler.
    return RFNSDefaultBridgeKeyLog;
}

RFNSBridgeKeyLogHandler *RFNSGetBridgeKeyLogHandler()
{
    // Getting the current bridge key log handler.
    return RFNSBridgeKeyLog_Handler;
}

RFNSBridgeKeyLogHandler *RFNSSetBridgeKeyLogHandler(RFNSBridgeKeyLogHandler *newBridgeKeyLogHandler)
{
    // Getting the old bridge key log handler.
    RFNSBridgeKeyLogHandler *oldBridgeKeyLogHandler = RFNSBridgeKeyLog_Handler;
    
    // Setting the new bridge key log handler.
    RFNSBridgeKeyLog_Handler = newBridgeKeyLogHandler;
    
    // Returning the old bridge key log handler.
    return oldBridgeKeyLogHandler;
}
