//
//  RFNSLog.h
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

// Importing the project headers.
#import "RFNSBridgeKeyLog.h"
#import "RFNSBridgeKeyLogParameter.h"

// Importing the system headers.
#import <Foundation/NSError.h>
#import <Foundation/NSException.h>
#import <Foundation/NSString.h>

// Importing the system headers.
#import <stdio.h>
#import <stdlib.h>

#define __RF_NS_LOGGER_PASTE__(prefix, number, name) prefix##number##name \

// Common Variables.
#define __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                                                                        \
const char     *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__BASE_FILE__)       = __BASE_FILE__;       \
const char     *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__DATE__)            = __DATE__;            \
const char     *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__FILE__)            = __FILE__;            \
const char     *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__FUNCTION__)        = __FUNCTION__;        \
const long int *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__INCLUDE_LEVEL__)   = __INCLUDE_LEVEL__;   \
const long int  __RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__LINE__)            = __LINE__;            \
const char     *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__PRETTY_FUNCTION__) = __PRETTY_FUNCTION__; \
const char     *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__TIME__)            = __TIME__;            \
const char     *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__TIMESTAMP__)       = __TIMESTAMP__;       \

// Common Parameters.
#define __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                                                   \
(RFNSBridgeKeyLogParameter)                                                                                                  \
{                                                                                                                            \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                  \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__BASE_FILE__,                                              \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                      \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__BASE_FILE__),       \
},                                                                                                                           \
(RFNSBridgeKeyLogParameter)                                                                                                  \
{                                                                                                                            \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                  \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__DATE__,                                                   \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                      \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__DATE__),            \
},                                                                                                                           \
(RFNSBridgeKeyLogParameter)                                                                                                  \
{                                                                                                                            \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                  \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__FILE__,                                                   \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                      \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__FILE__),            \
},                                                                                                                           \
(RFNSBridgeKeyLogParameter)                                                                                                  \
{                                                                                                                            \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                  \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__FUNCTION__,                                               \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                      \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__FUNCTION__),        \
},                                                                                                                           \
(RFNSBridgeKeyLogParameter)                                                                                                  \
{                                                                                                                            \
.keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                      \
.keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__INCLUDE_LEVEL__,                                              \
.valueType = &RFNSBridgeKeyLogParameterTypeLongInteger,                                                                      \
.value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__INCLUDE_LEVEL__),       \
},                                                                                                                           \
(RFNSBridgeKeyLogParameter)                                                                                                  \
{                                                                                                                            \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                  \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__LINE__,                                                   \
    .valueType = &RFNSBridgeKeyLogParameterTypeLongInteger,                                                                  \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__LINE__),            \
},                                                                                                                           \
(RFNSBridgeKeyLogParameter)                                                                                                  \
{                                                                                                                            \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                  \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__PRETTY_FUNCTION__,                                        \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                      \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__PRETTY_FUNCTION__), \
},                                                                                                                           \
(RFNSBridgeKeyLogParameter)                                                                                                  \
{                                                                                                                            \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                  \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__TIME__,                                                   \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                      \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__TIME__),            \
},                                                                                                                           \
(RFNSBridgeKeyLogParameter)                                                                                                  \
{                                                                                                                            \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                  \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__TIMESTAMP__,                                              \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                      \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__TIMESTAMP__)        \
},                                                                                                                           \

// Common Releases.
#define __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number) \

// Function Variables.
#define __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number) \

// Function Parameters.
#define __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number) \

// Function Releases.
#define __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number) \

// Method Variables.
#define __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number) \

// Method Parameters.
#define __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)         \
(RFNSBridgeKeyLogParameter)                                        \
{                                                                  \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,        \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameObjectiveCself,  \
    .valueType = &RFNSBridgeKeyLogParameterTypeObjectiveCID,       \
    .value     = &self,                                            \
},                                                                 \
(RFNSBridgeKeyLogParameter)                                        \
{                                                                  \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,        \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameObjectiveC_cmd,  \
    .valueType = &RFNSBridgeKeyLogParameterTypeObjectiveCSelector, \
    .value     = &_cmd,                                            \
}, 

// Method Releases.
#define __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number) \

// Condition Variables.
#define __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                                           \
const char *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterKeyValueConditionText) = #condition; \

// Condition Parameters.
#define __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                                              \
(RFNSBridgeKeyLogParameter)                                                                                \
{                                                                                                          \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameConditionText,                                           \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                    \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterKeyValueConditionText), \
},                                                                                                         \

// Condition Releases.
#define __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number) \

// C Message Variables.
#define __RF_NS_LOGGER_C_MESSAGE_VARIABLES__(prefix, number, format, ...)                                                \
char *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessage) = nil;                           \
                                                                                                                         \
if ((format))                                                                                                            \
{                                                                                                                        \
    asprintf(&__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessage), (format), ##__VA_ARGS__); \
}                                                                                                                        \

// C Message Parameters.
#define __RF_NS_LOGGER_C_MESSAGE_PARAMETERS__(prefix, number)                                        \
(RFNSBridgeKeyLogParameter)                                                                          \
{                                                                                                    \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                          \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameMessage,                                           \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                              \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessage), \
},                                                                                                   \

// C Message Releases.
#define __RF_NS_LOGGER_C_MESSAGE_RELEASES__(prefix, number)                              \
free(__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessage)); \

// Objective-C Message Variables.
#define __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ...)                                                                                       \
NSString *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessage) = ((format) ? [[NSString alloc] initWithFormat:(format), ##__VA_ARGS__] : nil); \

// Objective-C Message Parameters.
#define __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                              \
(RFNSBridgeKeyLogParameter)                                                                          \
{                                                                                                    \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                          \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameMessage,                                           \
    .valueType = &RFNSBridgeKeyLogParameterTypeObjectiveCNSString,                                   \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessage), \
},                                                                                                   \

// Objective-C Message Releases.
#define __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number) \

// Objective-C Error Variables.
#define __RF_NS_LOGGER_OBJECTIVE_C_ERROR_VARIABLES__(prefix, number, error_)                       \
NSError *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterKeyValueError) = error_; \

// Objective-C Error Parameters.
#define __RF_NS_LOGGER_OBJECTIVE_C_ERROR_PARAMETERS__(prefix, number)                              \
(RFNSBridgeKeyLogParameter)                                                                        \
{                                                                                                  \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                        \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameError,                                           \
    .valueType = &RFNSBridgeKeyLogParameterTypeObjectiveCNSError,                                  \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterKeyValueError), \
},                                                                                                 \

// Objective-C Error Releases.
#define __RF_NS_LOGGER_OBJECTIVE_C_ERROR_RELEASES__(prefix, number) \

// Objective-C Exception Variables.
#define __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_VARIABLES__(prefix, number, exception)                           \
NSException *__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterKeyValueException) = exception; \

// Objective-C Exception Parameters.
#define __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_PARAMETERS__(prefix, number)                              \
(RFNSBridgeKeyLogParameter)                                                                            \
{                                                                                                      \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                            \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameException,                                           \
    .valueType = &RFNSBridgeKeyLogParameterTypeObjectiveCNSException,                                  \
    .value     = &__RF_NS_LOGGER_PASTE__(prefix, number, _RFNSBridgeKeyLogParameterKeyValueException), \
},                                                                                                     \

// Objective-C Exception Releases.
#define __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_RELEASES__(prefix, number) \

// Command Abort Variables.
#define __RF_NS_LOGGER_COMMAND_ABORT_VARIABLES__(prefix, number) \

// Command Abort Parameters.
#define __RF_NS_LOGGER_COMMAND_ABORT_PARAMETERS__(prefix, number) \
(RFNSBridgeKeyLogParameter)                                       \
{                                                                 \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,       \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameCommandAbort,   \
    .valueType = NULL,                                            \
    .value     = NULL,                                            \
},                                                                \

// Command Abort Releases.
#define __RF_NS_LOGGER_COMMAND_ABORT_RELEASES__(prefix, number) \

// Command Assert Variables.
#define __RF_NS_LOGGER_COMMAND_ASSERT_VARIABLES__(prefix, number) \

// Command Assert Parameters.
#define __RF_NS_LOGGER_COMMAND_ASSERT_PARAMETERS__(prefix, number) \
(RFNSBridgeKeyLogParameter)                                        \
{                                                                  \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,        \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameCommandAssert,   \
    .valueType = NULL,                                             \
    .value     = NULL,                                             \
},                                                                 \

// Command Assert Releases.
#define __RF_NS_LOGGER_COMMAND_ASSERT_RELEASES__(prefix, number) \

// Command Breakpoint Variables.
#define __RF_NS_LOGGER_COMMAND_BREAKPOINT_VARIABLES__(prefix, number) \

// Command Breakpoint Parameters.
#define __RF_NS_LOGGER_COMMAND_BREAKPOINT_PARAMETERS__(prefix, number) \
(RFNSBridgeKeyLogParameter)                                            \
{                                                                      \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,            \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameCommandBreakpoint,   \
    .valueType = NULL,                                                 \
    .value     = NULL,                                                 \
},                                                                     \

// Command Breakpoint Releases.
#define __RF_NS_LOGGER_COMMAND_BREAKPOINT_RELEASES__(prefix, number) \

// Command Inform Variables.
#define __RF_NS_LOGGER_COMMAND_INFORM_VARIABLES__(prefix, number) \

// Command Inform Parameters.
#define __RF_NS_LOGGER_COMMAND_INFORM_PARAMETERS__(prefix, number) \
(RFNSBridgeKeyLogParameter)                                        \
{                                                                  \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,        \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameCommandInform,   \
    .valueType = NULL,                                             \
    .value     = NULL,                                             \
},                                                                 \

// Command Inform Releases.
#define __RF_NS_LOGGER_COMMAND_INFORM_RELEASES__(prefix, number) \

// Command Warn Variables.
#define __RF_NS_LOGGER_COMMAND_WARN_VARIABLES__(prefix, number) \

// Command Warn Parameters.
#define __RF_NS_LOGGER_COMMAND_WARN_PARAMETERS__(prefix, number) \
(RFNSBridgeKeyLogParameter)                                      \
{                                                                \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,      \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameCommandWarn,   \
    .valueType = NULL,                                           \
    .value     = NULL,                                           \
},                                                               \

// Command Warn Releases.
#define __RF_NS_LOGGER_COMMAND_WARN_RELEASES__(prefix, number) \

// Bridge Key Log for the Abort.
#define __RFNSBridgeKeyLogForAbort(parameters)                                                                                        \
do                                                                                                                                    \
{                                                                                                                                     \
    ((void (* __dead2)(RFNSBridgeKeyLogParameter*, size_t))RFNSBridgeKeyLog)(parameters, (sizeof(parameters) / sizeof(*parameters))); \
}                                                                                                                                     \
while (0)                                                                                                                             \

// Bridge Key Log for the Assertion.
#define __RFNSBridgeKeyLogForAssertion(parameters)                                                 \
do                                                                                                 \
{                                                                                                  \
    RFNSBridgeKeyLog(parameters, (sizeof(parameters) / sizeof(*parameters)));                      \
    /* Deceiving the static analyzer. */                                                           \
    [(NSAssertionHandler *)nil handleFailureInFunction:nil file:nil lineNumber:0 description:nil]; \
}                                                                                                  \
while (0)                                                                                          \

// Bridge Key Log for the Breakpoint.
#define __RFNSBridgeKeyLogForBreakpoint(parameters)                           \
do                                                                            \
{                                                                             \
    RFNSBridgeKeyLog(parameters, (sizeof(parameters) / sizeof(*parameters))); \
}                                                                             \
while (0)                                                                     \

// Bridge Key Log for the Warning.
#define __RFNSBridgeKeyLogForWarning(parameters)                              \
do                                                                            \
{                                                                             \
    RFNSBridgeKeyLog(parameters, (sizeof(parameters) / sizeof(*parameters))); \
}                                                                             \
while (0)                                                                     \

// Bridge Key Log for Information.
#define __RFNSBridgeKeyLogForInformation(parameters)                          \
do                                                                            \
{                                                                             \
    RFNSBridgeKeyLog(parameters, (sizeof(parameters) / sizeof(*parameters))); \
}                                                                             \
while (0)                                                                     \

#pragma mark - Functions for C

#define __RFNSCAbort(prefix, number, condition, format, ...)                              \
do                                                                                        \
{                                                                                         \
    if (!(condition))                                                                     \
    {                                                                                     \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                 \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                               \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                   \
        __RF_NS_LOGGER_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)       \
        __RF_NS_LOGGER_COMMAND_ABORT_VARIABLES__(prefix, number)                          \
                                                                                          \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] = \
        {                                                                                 \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                            \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                          \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                         \
            __RF_NS_LOGGER_C_MESSAGE_PARAMETERS__(prefix, number)                         \
            __RF_NS_LOGGER_COMMAND_ABORT_PARAMETERS__(prefix, number)                     \
        };                                                                                \
                                                                                          \
        __RFNSBridgeKeyLogForAbort(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));  \
                                                                                          \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                  \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                               \
        __RF_NS_LOGGER_C_MESSAGE_RELEASES__(prefix, number)                               \
        __RF_NS_LOGGER_COMMAND_ABORT_RELEASES__(prefix, number)                           \
    }                                                                                     \
}                                                                                         \
while (0)                                                                                 \

#define RFNSCAbort(condition, format, ...) __RFNSCAbort(rf_ns_c_abort_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSCAssert(prefix, number, condition, format, ...)                                \
do                                                                                           \
{                                                                                            \
    if (!(condition))                                                                        \
    {                                                                                        \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                    \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                  \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                      \
        __RF_NS_LOGGER_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)          \
        __RF_NS_LOGGER_COMMAND_ASSERT_VARIABLES__(prefix, number)                            \
                                                                                             \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =    \
        {                                                                                    \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                               \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                            \
            __RF_NS_LOGGER_C_MESSAGE_PARAMETERS__(prefix, number)                            \
            __RF_NS_LOGGER_COMMAND_ASSERT_PARAMETERS__(prefix, number)                       \
        };                                                                                   \
                                                                                             \
        __RFNSBridgeKeyLogForAssertion(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                             \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                  \
        __RF_NS_LOGGER_C_MESSAGE_RELEASES__(prefix, number)                                  \
        __RF_NS_LOGGER_COMMAND_ASSERT_RELEASES__(prefix, number)                             \
    }                                                                                        \
}                                                                                            \
while (0)                                                                                    \

#define RFNSCAssert(condition, format, ...) __RFNSCAssert(rf_ns_c_assert_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSCBreakpoint(prefix, number, condition, format, ...)                             \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)           \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_VARIABLES__(prefix, number)                         \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_C_MESSAGE_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_COMMAND_BREAKPOINT_PARAMETERS__(prefix, number)                    \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForBreakpoint(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_C_MESSAGE_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_RELEASES__(prefix, number)                          \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSCBreakpoint(condition, format, ...) __RFNSCBreakpoint(rf_ns_c_breakpoint_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSCInform(prefix, number, condition, format, ...)                                  \
do                                                                                             \
{                                                                                              \
    if (!(condition))                                                                          \
    {                                                                                          \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                        \
        __RF_NS_LOGGER_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)            \
        __RF_NS_LOGGER_COMMAND_INFORM_VARIABLES__(prefix, number)                              \
                                                                                               \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =      \
        {                                                                                      \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                 \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                               \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_C_MESSAGE_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_COMMAND_INFORM_PARAMETERS__(prefix, number)                         \
        };                                                                                     \
                                                                                               \
        __RFNSBridgeKeyLogForInformation(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                               \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                       \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_C_MESSAGE_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_COMMAND_INFORM_RELEASES__(prefix, number)                               \
    }                                                                                          \
}                                                                                              \
while (0)                                                                                      \

#define RFNSCInform(condition, format, ...) __RFNSCInform(rf_ns_c_inform_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSCWarn(prefix, number, condition, format, ...)                                \
do                                                                                         \
{                                                                                          \
    if (!(condition))                                                                      \
    {                                                                                      \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                  \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                    \
        __RF_NS_LOGGER_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)        \
        __RF_NS_LOGGER_COMMAND_WARN_VARIABLES__(prefix, number)                            \
                                                                                           \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =  \
        {                                                                                  \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                           \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                          \
            __RF_NS_LOGGER_C_MESSAGE_PARAMETERS__(prefix, number)                          \
            __RF_NS_LOGGER_COMMAND_WARN_PARAMETERS__(prefix, number)                       \
        };                                                                                 \
                                                                                           \
        __RFNSBridgeKeyLogForWarning(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                           \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                 \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                \
        __RF_NS_LOGGER_C_MESSAGE_RELEASES__(prefix, number)                                \
        __RF_NS_LOGGER_COMMAND_WARN_RELEASES__(prefix, number)                             \
    }                                                                                      \
}                                                                                          \
while (0)                                                                                  \

#define RFNSCWarn(condition, format, ...) __RFNSCWarn(rf_ns_c_warn_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#pragma mark - Functions for Objective-C

#define __RFNSObjectiveCCAbort(prefix, number, condition, format, ...)                        \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_ABORT_VARIABLES__(prefix, number)                              \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_ABORT_PARAMETERS__(prefix, number)                         \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForAbort(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));      \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_ABORT_RELEASES__(prefix, number)                               \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCCAbort(condition, format, ...) __RFNSObjectiveCCAbort(rf_ns_objective_c_c_abort_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCAssert(prefix, number, condition, format, ...)                       \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_ASSERT_VARIABLES__(prefix, number)                             \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_ASSERT_PARAMETERS__(prefix, number)                        \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForAssertion(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));  \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_ASSERT_RELEASES__(prefix, number)                              \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCCAssert(condition, format, ...) __RFNSObjectiveCCAssert(rf_ns_objective_c_c_assert_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCBreakpoint(prefix, number, condition, format, ...)                   \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_VARIABLES__(prefix, number)                         \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_BREAKPOINT_PARAMETERS__(prefix, number)                    \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForBreakpoint(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_RELEASES__(prefix, number)                          \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCCBreakpoint(condition, format, ...) __RFNSObjectiveCCBreakpoint(rf_ns_objective_c_c_breakpoint_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCInform(prefix, number, condition, format, ...)                        \
do                                                                                             \
{                                                                                              \
    if (!(condition))                                                                          \
    {                                                                                          \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                        \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)  \
        __RF_NS_LOGGER_COMMAND_INFORM_VARIABLES__(prefix, number)                              \
                                                                                               \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =      \
        {                                                                                      \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                 \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                               \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                    \
            __RF_NS_LOGGER_COMMAND_INFORM_PARAMETERS__(prefix, number)                         \
        };                                                                                     \
                                                                                               \
        __RFNSBridgeKeyLogForInformation(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                               \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                       \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                          \
        __RF_NS_LOGGER_COMMAND_INFORM_RELEASES__(prefix, number)                               \
    }                                                                                          \
}                                                                                              \
while (0)                                                                                      \

#define RFNSObjectiveCCInform(condition, format, ...) __RFNSObjectiveCCInform(rf_ns_objective_c_c_inform_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCWarn(prefix, number, condition, format, ...)                         \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_WARN_VARIABLES__(prefix, number)                               \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_WARN_PARAMETERS__(prefix, number)                          \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForWarning(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));    \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_WARN_RELEASES__(prefix, number)                                \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCCWarn(condition, format, ...) __RFNSObjectiveCCWarn(rf_ns_objective_c_c_warn_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCAbort(prefix, number, condition, format, ...)                         \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_ABORT_VARIABLES__(prefix, number)                              \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_ABORT_PARAMETERS__(prefix, number)                         \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForAbort(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));      \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_ABORT_RELEASES__(prefix, number)                               \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCAbort(condition, format, ...) __RFNSObjectiveCAbort(rf_ns_objective_c_abort_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCAssert(prefix, number, condition, format, ...)                        \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_ASSERT_VARIABLES__(prefix, number)                             \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_ASSERT_PARAMETERS__(prefix, number)                        \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForAssertion(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));  \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_ASSERT_RELEASES__(prefix, number)                              \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCAssert(condition, format, ...) __RFNSObjectiveCAssert(rf_ns_objective_c_assert_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCBreakpoint(prefix, number, condition, format, ...)                    \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_VARIABLES__(prefix, number)                         \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_BREAKPOINT_PARAMETERS__(prefix, number)                    \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForBreakpoint(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_RELEASES__(prefix, number)                          \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCBreakpoint(condition, format, ...) __RFNSObjectiveCBreakpoint(rf_ns_objective_c_breakpoint_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCInform(prefix, number, condition, format, ...)                         \
do                                                                                             \
{                                                                                              \
    if (!(condition))                                                                          \
    {                                                                                          \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                      \
        __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                        \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)  \
        __RF_NS_LOGGER_COMMAND_INFORM_VARIABLES__(prefix, number)                              \
                                                                                               \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =      \
        {                                                                                      \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                 \
            __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)                                 \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                    \
            __RF_NS_LOGGER_COMMAND_INFORM_PARAMETERS__(prefix, number)                         \
        };                                                                                     \
                                                                                               \
        __RFNSBridgeKeyLogForInformation(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                               \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                       \
        __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number)                                       \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                          \
        __RF_NS_LOGGER_COMMAND_INFORM_RELEASES__(prefix, number)                               \
    }                                                                                          \
}                                                                                              \
while (0)                                                                                      \

#define RFNSObjectiveCInform(condition, format, ...) __RFNSObjectiveCInform(rf_ns_objective_c_inform_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCWarn(prefix, number, condition, format, ...)                          \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_WARN_VARIABLES__(prefix, number)                               \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_WARN_PARAMETERS__(prefix, number)                          \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForWarning(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));    \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_WARN_RELEASES__(prefix, number)                                \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCWarn(condition, format, ...) __RFNSObjectiveCWarn(rf_ns_objective_c_warn_, __COUNTER__, condition, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCAbortWithError(prefix, number, condition, error_, format, ...)       \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_VARIABLES__(prefix, number, error_)                  \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_ABORT_VARIABLES__(prefix, number)                              \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_ERROR_PARAMETERS__(prefix, number)                     \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_ABORT_PARAMETERS__(prefix, number)                         \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForAbort(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));      \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_RELEASES__(prefix, number)                           \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_ABORT_RELEASES__(prefix, number)                               \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCCAbortWithError(condition, error_, format, ...) __RFNSObjectiveCCAbortWithError(rf_ns_objective_c_c_abort_, __COUNTER__, condition, error_, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCAssertWithError(prefix, number, condition, error_, format, ...)      \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_VARIABLES__(prefix, number, error_)                  \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_ASSERT_VARIABLES__(prefix, number)                             \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_ERROR_PARAMETERS__(prefix, number)                     \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_ASSERT_PARAMETERS__(prefix, number)                        \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForAssertion(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));  \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_RELEASES__(prefix, number)                           \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_ASSERT_RELEASES__(prefix, number)                              \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCCAssertWithError(condition, error_, format, ...) __RFNSObjectiveCCAssertWithError(rf_ns_objective_c_c_assert_, __COUNTER__, condition, error_, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCBreakpointWithError(prefix, number, condition, error_, format, ...)  \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_VARIABLES__(prefix, number, error_)                  \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_VARIABLES__(prefix, number)                         \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_ERROR_PARAMETERS__(prefix, number)                     \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_BREAKPOINT_PARAMETERS__(prefix, number)                    \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForBreakpoint(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_RELEASES__(prefix, number)                           \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_RELEASES__(prefix, number)                          \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCCBreakpointWithError(condition, error_, format, ...) __RFNSObjectiveCCBreakpointWithError(rf_ns_objective_c_c_breakpoint_, __COUNTER__, condition, error_, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCInformWithError(prefix, number, condition, error_, format, ...)       \
do                                                                                             \
{                                                                                              \
    if (!(condition))                                                                          \
    {                                                                                          \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                        \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_VARIABLES__(prefix, number, error_)                   \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)  \
        __RF_NS_LOGGER_COMMAND_INFORM_VARIABLES__(prefix, number)                              \
                                                                                               \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =      \
        {                                                                                      \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                 \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                               \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_OBJECTIVE_C_ERROR_PARAMETERS__(prefix, number)                      \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                    \
            __RF_NS_LOGGER_COMMAND_INFORM_PARAMETERS__(prefix, number)                         \
        };                                                                                     \
                                                                                               \
        __RFNSBridgeKeyLogForInformation(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                               \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                       \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_RELEASES__(prefix, number)                            \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                          \
        __RF_NS_LOGGER_COMMAND_INFORM_RELEASES__(prefix, number)                               \
    }                                                                                          \
}                                                                                              \
while (0)                                                                                      \

#define RFNSObjectiveCCInformWithError(condition, error_, format, ...) __RFNSObjectiveCCInformWithError(rf_ns_objective_c_c_inform_, __COUNTER__, condition, error_, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCWarnWithError(prefix, number, condition, error_, format, ...)        \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_VARIABLES__(prefix, number, error_)                  \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_WARN_VARIABLES__(prefix, number)                               \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_ERROR_PARAMETERS__(prefix, number)                     \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_WARN_PARAMETERS__(prefix, number)                          \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForWarning(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));    \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_RELEASES__(prefix, number)                           \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_WARN_RELEASES__(prefix, number)                                \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCCWarnWithError(condition, error_, format, ...) __RFNSObjectiveCCWarnWithError(rf_ns_objective_c_c_warn_, __COUNTER__, condition, error_, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCAbortWithError(prefix, number, condition, error_, format, ...)        \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_VARIABLES__(prefix, number, error_)                  \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_ABORT_VARIABLES__(prefix, number)                              \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_ERROR_PARAMETERS__(prefix, number)                     \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_ABORT_PARAMETERS__(prefix, number)                         \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForAbort(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));      \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_RELEASES__(prefix, number)                           \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_ABORT_RELEASES__(prefix, number)                               \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCAbortWithError(condition, error_, format, ...) __RFNSObjectiveCAbortWithError(rf_ns_objective_c_abort_, __COUNTER__, condition, error_, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCAssertWithError(prefix, number, condition, error_, format, ...)       \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_VARIABLES__(prefix, number, error_)                  \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_ASSERT_VARIABLES__(prefix, number)                             \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_ERROR_PARAMETERS__(prefix, number)                     \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_ASSERT_PARAMETERS__(prefix, number)                        \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForAssertion(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));  \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_RELEASES__(prefix, number)                           \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_ASSERT_RELEASES__(prefix, number)                              \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCAssertWithError(condition, error_, format, ...) __RFNSObjectiveCAssertWithError(rf_ns_objective_c_assert_, __COUNTER__, condition, error_, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCBreakpointWithError(prefix, number, condition, error_, format, ...)   \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_VARIABLES__(prefix, number, error_)                  \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_VARIABLES__(prefix, number)                         \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_ERROR_PARAMETERS__(prefix, number)                     \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_BREAKPOINT_PARAMETERS__(prefix, number)                    \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForBreakpoint(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_RELEASES__(prefix, number)                           \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_RELEASES__(prefix, number)                          \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCBreakpointWithError(condition, error_, format, ...) __RFNSObjectiveCBreakpointWithError(rf_ns_objective_c_breakpoint_, __COUNTER__, condition, error_, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCInformWithError(prefix, number, condition, error_, format, ...)        \
do                                                                                             \
{                                                                                              \
    if (!(condition))                                                                          \
    {                                                                                          \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                      \
        __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                        \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_VARIABLES__(prefix, number, error_)                   \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)  \
        __RF_NS_LOGGER_COMMAND_INFORM_VARIABLES__(prefix, number)                              \
                                                                                               \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =      \
        {                                                                                      \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                 \
            __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)                                 \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_OBJECTIVE_C_ERROR_PARAMETERS__(prefix, number)                      \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                    \
            __RF_NS_LOGGER_COMMAND_INFORM_PARAMETERS__(prefix, number)                         \
        };                                                                                     \
                                                                                               \
        __RFNSBridgeKeyLogForInformation(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                               \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                       \
        __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number)                                       \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_RELEASES__(prefix, number)                            \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                          \
        __RF_NS_LOGGER_COMMAND_INFORM_RELEASES__(prefix, number)                               \
    }                                                                                          \
}                                                                                              \
while (0)                                                                                      \

#define RFNSObjectiveCInformWithError(condition, error_, format, ...) __RFNSObjectiveCInformWithError(rf_ns_objective_c_inform_, __COUNTER__, condition, error_, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCWarnWithError(prefix, number, condition, error_, format, ...)         \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_VARIABLES__(prefix, number, error_)                  \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_WARN_VARIABLES__(prefix, number)                               \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_ERROR_PARAMETERS__(prefix, number)                     \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_WARN_PARAMETERS__(prefix, number)                          \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForWarning(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));    \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_ERROR_RELEASES__(prefix, number)                           \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_WARN_RELEASES__(prefix, number)                                \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCWarnWithError(condition, error_, format, ...) __RFNSObjectiveCWarnWithError(rf_ns_objective_c_warn_, __COUNTER__, condition, error_, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCAbortWithException(prefix, number, condition, exception, format, ...) \
do                                                                                             \
{                                                                                              \
    if (!(condition))                                                                          \
    {                                                                                          \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                        \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_VARIABLES__(prefix, number, exception)            \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)  \
        __RF_NS_LOGGER_COMMAND_ABORT_VARIABLES__(prefix, number)                               \
                                                                                               \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =      \
        {                                                                                      \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                 \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                               \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_PARAMETERS__(prefix, number)                  \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                    \
            __RF_NS_LOGGER_COMMAND_ABORT_PARAMETERS__(prefix, number)                          \
        };                                                                                     \
                                                                                               \
        __RFNSBridgeKeyLogForAbort(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));       \
                                                                                               \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                       \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_RELEASES__(prefix, number)                        \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                          \
        __RF_NS_LOGGER_COMMAND_ABORT_RELEASES__(prefix, number)                                \
    }                                                                                          \
}                                                                                              \
while (0)                                                                                      \

#define RFNSObjectiveCCAbortWithException(condition, exception, format, ...) __RFNSObjectiveCCAbortWithException(rf_ns_objective_c_c_abort_, __COUNTER__, condition, exception, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCAssertWithException(prefix, number, condition, exception, format, ...) \
do                                                                                              \
{                                                                                               \
    if (!(condition))                                                                           \
    {                                                                                           \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                       \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                         \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_VARIABLES__(prefix, number, exception)             \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)   \
        __RF_NS_LOGGER_COMMAND_ASSERT_VARIABLES__(prefix, number)                               \
                                                                                                \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =       \
        {                                                                                       \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                  \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                               \
            __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                     \
            __RF_NS_LOGGER_COMMAND_ASSERT_PARAMETERS__(prefix, number)                          \
        };                                                                                      \
                                                                                                \
        __RFNSBridgeKeyLogForAssertion(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));    \
                                                                                                \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                        \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                     \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                           \
        __RF_NS_LOGGER_COMMAND_ASSERT_RELEASES__(prefix, number)                                \
    }                                                                                           \
}                                                                                               \
while (0)                                                                                       \

#define RFNSObjectiveCCAssertWithException(condition, exception, format, ...) __RFNSObjectiveCCAssertWithException(rf_ns_objective_c_c_assert_, __COUNTER__, condition, exception, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCBreakpointWithException(prefix, number, condition, exception, format, ...) \
do                                                                                                  \
{                                                                                                   \
    if (!(condition))                                                                               \
    {                                                                                               \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                           \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                         \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                             \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_VARIABLES__(prefix, number, exception)                 \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)       \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_VARIABLES__(prefix, number)                               \
                                                                                                    \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =           \
        {                                                                                           \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                      \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                                    \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                                   \
            __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_PARAMETERS__(prefix, number)                       \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                         \
            __RF_NS_LOGGER_COMMAND_BREAKPOINT_PARAMETERS__(prefix, number)                          \
        };                                                                                          \
                                                                                                    \
        __RFNSBridgeKeyLogForBreakpoint(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));       \
                                                                                                    \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                            \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                          \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                         \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_RELEASES__(prefix, number)                             \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                               \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_RELEASES__(prefix, number)                                \
    }                                                                                               \
}                                                                                                   \
while (0)                                                                                           \

#define RFNSObjectiveCCBreakpointWithException(condition, exception, format, ...) __RFNSObjectiveCCBreakpointWithException(rf_ns_objective_c_c_breakpoint_, __COUNTER__, condition, exception, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCInformWithException(prefix, number, condition, exception, format, ...) \
do                                                                                              \
{                                                                                               \
    if (!(condition))                                                                           \
    {                                                                                           \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                       \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                         \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_VARIABLES__(prefix, number, exception)             \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)   \
        __RF_NS_LOGGER_COMMAND_INFORM_VARIABLES__(prefix, number)                               \
                                                                                                \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =       \
        {                                                                                       \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                  \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                               \
            __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                     \
            __RF_NS_LOGGER_COMMAND_INFORM_PARAMETERS__(prefix, number)                          \
        };                                                                                      \
                                                                                                \
        __RFNSBridgeKeyLogForInformation(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));  \
                                                                                                \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                        \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                     \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                           \
        __RF_NS_LOGGER_COMMAND_INFORM_RELEASES__(prefix, number)                                \
    }                                                                                           \
}                                                                                               \
while (0)                                                                                       \

#define RFNSObjectiveCCInformWithException(condition, exception, format, ...) __RFNSObjectiveCCInformWithException(rf_ns_objective_c_c_inform_, __COUNTER__, condition, exception, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCCWarnWithException(prefix, number, condition, exception, format, ...) \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_VARIABLES__(prefix, number, exception)           \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_WARN_VARIABLES__(prefix, number)                               \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_PARAMETERS__(prefix, number)                 \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_WARN_PARAMETERS__(prefix, number)                          \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForWarning(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));    \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_RELEASES__(prefix, number)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_WARN_RELEASES__(prefix, number)                                \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCCWarnWithException(condition, exception, format, ...) __RFNSObjectiveCCWarnWithException(rf_ns_objective_c_c_warn_, __COUNTER__, condition, exception, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCAbortWithException(prefix, number, condition, exception, format, ...) \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_FUNCTION_VARIABLES__(prefix, number)                                   \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_VARIABLES__(prefix, number, exception)           \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_ABORT_VARIABLES__(prefix, number)                              \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_FUNCTION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_PARAMETERS__(prefix, number)                 \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_ABORT_PARAMETERS__(prefix, number)                         \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForAbort(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));      \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_FUNCTION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_RELEASES__(prefix, number)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_ABORT_RELEASES__(prefix, number)                               \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCAbortWithException(condition, exception, format, ...) __RFNSObjectiveCAbortWithException(rf_ns_objective_c_abort_, __COUNTER__, condition, exception, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCAssertWithException(prefix, number, condition, exception, format, ...) \
do                                                                                             \
{                                                                                              \
    if (!(condition))                                                                          \
    {                                                                                          \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                      \
        __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                        \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_VARIABLES__(prefix, number, exception)            \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)  \
        __RF_NS_LOGGER_COMMAND_ASSERT_VARIABLES__(prefix, number)                              \
                                                                                               \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =      \
        {                                                                                      \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                 \
            __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)                                 \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_PARAMETERS__(prefix, number)                  \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                    \
            __RF_NS_LOGGER_COMMAND_ASSERT_PARAMETERS__(prefix, number)                         \
        };                                                                                     \
                                                                                               \
        __RFNSBridgeKeyLogForAssertion(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));   \
                                                                                               \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                       \
        __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number)                                       \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_RELEASES__(prefix, number)                        \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                          \
        __RF_NS_LOGGER_COMMAND_ASSERT_RELEASES__(prefix, number)                               \
    }                                                                                          \
}                                                                                              \
while (0)                                                                                      \

#define RFNSObjectiveCAssertWithException(condition, exception, format, ...) __RFNSObjectiveCAssertWithException(rf_ns_objective_c_assert_, __COUNTER__, condition, exception, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCBreakpointWithException(prefix, number, condition, exception, format, ...) \
do                                                                                                 \
{                                                                                                  \
    if (!(condition))                                                                              \
    {                                                                                              \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                          \
        __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number)                                          \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                            \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_VARIABLES__(prefix, number, exception)                \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)      \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_VARIABLES__(prefix, number)                              \
                                                                                                   \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =          \
        {                                                                                          \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                     \
            __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)                                     \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                                  \
            __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_PARAMETERS__(prefix, number)                      \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                        \
            __RF_NS_LOGGER_COMMAND_BREAKPOINT_PARAMETERS__(prefix, number)                         \
        };                                                                                         \
                                                                                                   \
        __RFNSBridgeKeyLogForBreakpoint(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));      \
                                                                                                   \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                           \
        __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number)                                           \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                        \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_RELEASES__(prefix, number)                            \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                              \
        __RF_NS_LOGGER_COMMAND_BREAKPOINT_RELEASES__(prefix, number)                               \
    }                                                                                              \
}                                                                                                  \
while (0)                                                                                          \

#define RFNSObjectiveCBreakpointWithException(condition, exception, format, ...) __RFNSObjectiveCBreakpointWithException(rf_ns_objective_c_breakpoint_, __COUNTER__, condition, exception, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCInformWithException(prefix, number, condition, exception, format, ...) \
do                                                                                             \
{                                                                                              \
    if (!(condition))                                                                          \
    {                                                                                          \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                      \
        __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                        \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_VARIABLES__(prefix, number, exception)            \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__)  \
        __RF_NS_LOGGER_COMMAND_INFORM_VARIABLES__(prefix, number)                              \
                                                                                               \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =      \
        {                                                                                      \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                 \
            __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)                                 \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                              \
            __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_PARAMETERS__(prefix, number)                  \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                    \
            __RF_NS_LOGGER_COMMAND_INFORM_PARAMETERS__(prefix, number)                         \
        };                                                                                     \
                                                                                               \
        __RFNSBridgeKeyLogForInformation(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters)); \
                                                                                               \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                       \
        __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number)                                       \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                    \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_RELEASES__(prefix, number)                        \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                          \
        __RF_NS_LOGGER_COMMAND_INFORM_RELEASES__(prefix, number)                               \
    }                                                                                          \
}                                                                                              \
while (0)                                                                                      \

#define RFNSObjectiveCInformWithException(condition, exception, format, ...) __RFNSObjectiveCInformWithException(rf_ns_objective_c_inform_, __COUNTER__, condition, exception, format, ##__VA_ARGS__) \

#define __RFNSObjectiveCWarnWithException(prefix, number, condition, exception, format, ...)  \
do                                                                                            \
{                                                                                             \
    if (!(condition))                                                                         \
    {                                                                                         \
        __RF_NS_LOGGER_COMMON_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_METHOD_VARIABLES__(prefix, number)                                     \
        __RF_NS_LOGGER_CONDITION_VARIABLES__(prefix, number, condition)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_VARIABLES__(prefix, number, exception)           \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_VARIABLES__(prefix, number, format, ##__VA_ARGS__) \
        __RF_NS_LOGGER_COMMAND_WARN_VARIABLES__(prefix, number)                               \
                                                                                              \
        RFNSBridgeKeyLogParameter __RF_NS_LOGGER_PASTE__(prefix, number, _parameters)[] =     \
        {                                                                                     \
            __RF_NS_LOGGER_COMMON_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_METHOD_PARAMETERS__(prefix, number)                                \
            __RF_NS_LOGGER_CONDITION_PARAMETERS__(prefix, number)                             \
            __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_PARAMETERS__(prefix, number)                 \
            __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_PARAMETERS__(prefix, number)                   \
            __RF_NS_LOGGER_COMMAND_WARN_PARAMETERS__(prefix, number)                          \
        };                                                                                    \
                                                                                              \
        __RFNSBridgeKeyLogForWarning(__RF_NS_LOGGER_PASTE__(prefix, number, _parameters));    \
                                                                                              \
        __RF_NS_LOGGER_COMMON_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_METHOD_RELEASES__(prefix, number)                                      \
        __RF_NS_LOGGER_CONDITION_RELEASES__(prefix, number)                                   \
        __RF_NS_LOGGER_OBJECTIVE_C_EXCEPTION_RELEASES__(prefix, number)                       \
        __RF_NS_LOGGER_OBJECTIVE_C_MESSAGE_RELEASES__(prefix, number)                         \
        __RF_NS_LOGGER_COMMAND_WARN_RELEASES__(prefix, number)                                \
    }                                                                                         \
}                                                                                             \
while (0)                                                                                     \

#define RFNSObjectiveCWarnWithException(condition, exception, format, ...) __RFNSObjectiveCWarnWithException(rf_ns_objective_c_warn_, __COUNTER__, condition, exception, format, ##__VA_ARGS__) \
