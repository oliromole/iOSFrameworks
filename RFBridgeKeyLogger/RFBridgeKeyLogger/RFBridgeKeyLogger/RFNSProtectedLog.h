//
//  RFNSProtectedLog.h
//  RFBridgeKeyLogger
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2014.02.08.
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

/*
 * <local_condition>
 * <local_variables>
 * <local_releases>
 * <function_name>
 * <function_arguments>
 * <function_argument_values>
 * <function_local_variables>
 * <function_local_parameters>
 * <function_local_releases>
 *
 * _____________________
 * Declaration Function
 *
 *  void <function_name>(<function_arguments>);
 *
 * _______________________
 * Implementation Function
 *
 *  void <function_name>(<function_arguments>)
 *  {
 *      <function_local_variables>
 *
 *      RFNSBridgeKeyLogParameter parameters[] =
 *      {
 *          <function_local_parameters>
 *      };
 *
 *      __RFNSProtectedBridgeKeyLogForCommand(parameters);
 *
 *      <function_local_releases>
 *  }
 *
 * _____________
 * Call Function
 *
 *  do
 *  {
 *      if (!(<local_condition>))
 *      {
 *          <local_variables>
 *
 *          <function_name>(<function_argument_values>)
 *
 *          <local_releases>
 *      }
 *  } while (0)
 *
 */

#define RF_NS_PROTECTED_LOGGER_PASTE3(argument1, argument2, argument3) argument1##argument2##argument3 \

#define RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE(argument1, ...) argument1, ##__VA_ARGS__ \

#pragma mark - Parameters

#pragma mark Empty

// Empty Local Variables.
#define __RF_NS_PROTECTED_LOGGER_EMPTY_LOCAL_VARIABLES__(prefix, number) \

// Empty Function Arguments.
#define __RF_NS_PROTECTED_LOGGER_EMPTY_FUNCTION_ARGUMENTS__(prefix, number) \

// Empty Function Argument Values
#define __RF_NS_PROTECTED_LOGGER_EMPTY_FUNCTION_ARGUMENT_VALUES__(prefix, number) \

// Empty Function Local Variables.
#define __RF_NS_PROTECTED_LOGGER_EMPTY_FUNCTION_LOCAL_VARIABLES__(prefix, number) \

// Empty Function Local Parameters.
#define __RF_NS_PROTECTED_LOGGER_EMPTY_FUNCTION_LOCAL_PARAMETERS__(prefix, number) \

// Empty Function Local Releases.
#define __RF_NS_PROTECTED_LOGGER_EMPTY_FUNCTION_LOCAL_RELEASES__(prefix, number) \

// Empty Local Releases.
#define __RF_NS_PROTECTED_LOGGER_EMPTY_LOCAL_RELEASES__(prefix, number) \

#pragma mark Common

// Common Local Variables.
#define __RF_NS_PROTECTED_LOGGER_COMMON_LOCAL_VARIABLES__(prefix, number) \

// Common Function Arguments.
#define __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENTS__(prefix, number)                                                      \
const char     *RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__BASE_FILE__),       \
const char     *RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__DATE__),            \
const char     *RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__FILE__),            \
const char     *RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__FUNCTION__),        \
const long int  RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__INCLUDE_LEVEL__),   \
const long int  RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__LINE__),            \
const char     *RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__PRETTY_FUNCTION__), \
const char     *RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__TIME__),            \
const char     *RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__TIMESTAMP__),       \

// Common Function Argument Values
#define __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENT_VALUES__(prefix, number) \
__BASE_FILE__,                                                                     \
__DATE__,                                                                          \
__FILE__,                                                                          \
__FUNCTION__,                                                                      \
__INCLUDE_LEVEL__,                                                                 \
__LINE__,                                                                          \
__PRETTY_FUNCTION__,                                                               \
__TIME__,                                                                          \
__TIMESTAMP__,                                                                     \

// Common Function Local Variables.
#define __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_VARIABLES__(prefix, number) \

// Common Function Local Parameters.
#define __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                 \
(RFNSBridgeKeyLogParameter)                                                                                                         \
{                                                                                                                                   \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                         \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__BASE_FILE__,                                                     \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                             \
    .value     = &RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__BASE_FILE__),       \
},                                                                                                                                  \
(RFNSBridgeKeyLogParameter)                                                                                                         \
{                                                                                                                                   \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                         \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__DATE__,                                                          \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                             \
    .value     = &RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__DATE__),            \
},                                                                                                                                  \
(RFNSBridgeKeyLogParameter)                                                                                                         \
{                                                                                                                                   \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                         \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__FILE__,                                                          \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                             \
    .value     = &RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__FILE__),            \
},                                                                                                                                  \
(RFNSBridgeKeyLogParameter)                                                                                                         \
{                                                                                                                                   \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                         \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__FUNCTION__,                                                      \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                             \
    .value     = &RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__FUNCTION__),        \
},                                                                                                                                  \
(RFNSBridgeKeyLogParameter)                                                                                                         \
{                                                                                                                                   \
.keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                             \
.keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__INCLUDE_LEVEL__,                                                     \
.valueType = &RFNSBridgeKeyLogParameterTypeLongInteger,                                                                             \
.value     = &RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__INCLUDE_LEVEL__),       \
},                                                                                                                                  \
(RFNSBridgeKeyLogParameter)                                                                                                         \
{                                                                                                                                   \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                         \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__LINE__,                                                          \
    .valueType = &RFNSBridgeKeyLogParameterTypeLongInteger,                                                                         \
    .value     = &RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__LINE__),            \
},                                                                                                                                  \
(RFNSBridgeKeyLogParameter)                                                                                                         \
{                                                                                                                                   \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                         \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__PRETTY_FUNCTION__,                                               \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                             \
    .value     = &RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__PRETTY_FUNCTION__), \
},                                                                                                                                  \
(RFNSBridgeKeyLogParameter)                                                                                                         \
{                                                                                                                                   \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                         \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__TIME__,                                                          \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                             \
    .value     = &RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__TIME__),            \
},                                                                                                                                  \
(RFNSBridgeKeyLogParameter)                                                                                                         \
{                                                                                                                                   \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                                         \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__TIMESTAMP__,                                                     \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                                             \
    .value     = &RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterValuePredefinedMacro__TIMESTAMP__)        \
},                                                                                                                                  \

// Common Function Local Releases.
#define __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_RELEASES__(prefix, number) \

// Common Local Releases.
#define __RF_NS_PROTECTED_LOGGER_COMMON_LOCAL_RELEASES__(prefix, number) \

#pragma mark C Function

// C Function Local Variables.
#define __RF_NS_PROTECTED_LOGGER_C_FUNCTION_LOCAL_VARIABLES__(prefix, number) \

// C Function Function Arguments.
#define __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENTS__(prefix, number) \

// C Function Function Argument Values
#define __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENT_VALUES__(prefix, number) \

// C Function Function Local Variables.
#define __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_VARIABLES__(prefix, number) \

// C Function Function Local Parameters.
#define __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_PARAMETERS__(prefix, number) \

// C Function Function Local Releases.
#define __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_RELEASES__(prefix, number) \

// C Function Local Releases.
#define __RF_NS_PROTECTED_LOGGER_C_FUNCTION_LOCAL_RELEASES__(prefix, number) \

#pragma mark Condition

// Condition Local Variables.
#define __RF_NS_PROTECTED_LOGGER_CONDITION_LOCAL_VARIABLES__(prefix, number) \

// Condition Function Arguments.
#define __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENTS__(prefix, number)                             \
const char *RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueConditionText), \

// Condition Function Argument Values
#define __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENT_VALUES__(prefix, number, condition) \
#condition,                                                                                      \

// Condition Function Local Variables.
#define __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_VARIABLES__(prefix, number) \

// Condition Function Local Parameters.
#define __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                            \
(RFNSBridgeKeyLogParameter)                                                                                       \
{                                                                                                                 \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                       \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameConditionText,                                                  \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                           \
    .value     = &RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueConditionText), \
},                                                                                                                \

// Condition Function Local Releases.
#define __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_RELEASES__(prefix, number) \

// Condition Local Releases.
#define __RF_NS_PROTECTED_LOGGER_CONDITION_LOCAL_RELEASES__(prefix, number) \

#pragma mark C Message

// C Message Local Variables.
#define __RF_NS_PROTECTED_LOGGER_C_MESSAGE_LOCAL_VARIABLES__(prefix, number) \

// C Message Function Arguments.
#define __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENTS__(prefix, number)                                 \
const char *RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessageFormat), ... \

// C Message Function Argument Values
#define __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENT_VALUES__(prefix, number, format, ...) \
format, ##__VA_ARGS__                                                                              \

// C Message Function Local Variables.
#define __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                 \
char *RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessage) = nil;                 \
                                                                                                                      \
if (RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessageFormat))                   \
{                                                                                                                     \
    va_list RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessageFormatArguments);  \
    va_start(RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessageFormatArguments), \
             RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessageFormat)           \
             );                                                                                                       \
                                                                                                                      \
    vasprintf(&RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessage),              \
              RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessageFormat),         \
              RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessageFormatArguments) \
              );                                                                                                      \
                                                                                                                      \
    va_end(RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessageFormatArguments));  \
}                                                                                                                     \

// C Message Function Local Parameters.
#define __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                      \
(RFNSBridgeKeyLogParameter)                                                                                 \
{                                                                                                           \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                 \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameMessage,                                                  \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                     \
    .value     = &RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessage), \
},                                                                                                          \

// C Message Function Local Releases.
#define __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_RELEASES__(prefix, number)            \
free(RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyValueMessage)); \

// C Message Local Releases.
#define __RF_NS_PROTECTED_LOGGER_C_MESSAGE_LOCAL_RELEASES__(prefix, number) \

#pragma mark Command Abort

// Command Abort Local Variables.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_LOCAL_VARIABLES__(prefix, number) \

// Command Abort Function Arguments.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_FUNCTION_ARGUMENTS__(prefix, number) \

// Command Abort Function Argument Values
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_FUNCTION_ARGUMENT_VALUES__(prefix, number) \

// Command Abort Function Local Variables.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_FUNCTION_LOCAL_VARIABLES__(prefix, number) \

// Command Abort Function Local Parameters.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_FUNCTION_LOCAL_PARAMETERS__(prefix, number) \
(RFNSBridgeKeyLogParameter)                                                                \
{                                                                                          \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameCommandAbort,                            \
    .valueType = NULL,                                                                     \
    .value     = NULL,                                                                     \
},                                                                                         \

// Command Abort Function Local Releases.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_FUNCTION_LOCAL_RELEASES__(prefix, number) \

// Command Abort Local Releases.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_LOCAL_RELEASES__(prefix, number) \

#pragma mark Command Assert

// Command Assert Local Variables.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_LOCAL_VARIABLES__(prefix, number) \

// Command Assert Function Arguments.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_FUNCTION_ARGUMENTS__(prefix, number) \

// Command Assert Function Argument Values
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_FUNCTION_ARGUMENT_VALUES__(prefix, number) \

// Command Assert Function Local Variables.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_FUNCTION_LOCAL_VARIABLES__(prefix, number) \

// Command Assert Function Local Parameters.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_FUNCTION_LOCAL_PARAMETERS__(prefix, number) \
(RFNSBridgeKeyLogParameter)                                                                 \
{                                                                                           \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                 \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameCommandAssert,                            \
    .valueType = NULL,                                                                      \
    .value     = NULL,                                                                      \
},                                                                                          \

// Command Assert Function Local Releases.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_FUNCTION_LOCAL_RELEASES__(prefix, number) \

// Command Assert Local Releases.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_LOCAL_RELEASES__(prefix, number) \

#pragma mark Command Breakpoint

// Command Breakpoint Local Variables.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_LOCAL_VARIABLES__(prefix, number) \

// Command Breakpoint Function Arguments.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_FUNCTION_ARGUMENTS__(prefix, number) \

// Command Breakpoint Function Argument Values
#define __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_FUNCTION_ARGUMENT_VALUES__(prefix, number) \

// Command Breakpoint Function Local Variables.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_FUNCTION_LOCAL_VARIABLES__(prefix, number) \

// Command Breakpoint Function Local Parameters.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_FUNCTION_LOCAL_PARAMETERS__(prefix, number) \
(RFNSBridgeKeyLogParameter)                                                                     \
{                                                                                               \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                     \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameCommandBreakpoint,                            \
    .valueType = NULL,                                                                          \
    .value     = NULL,                                                                          \
},                                                                                              \

// Command Breakpoint Function Local Releases.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_FUNCTION_LOCAL_RELEASES__(prefix, number) \

// Command Breakpoint Local Releases.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_LOCAL_RELEASES__(prefix, number) \

#pragma mark Command Inform

// Command Inform Local Variables.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_LOCAL_VARIABLES__(prefix, number) \

// Command Inform Function Arguments.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_FUNCTION_ARGUMENTS__(prefix, number) \

// Command Inform Function Argument Values
#define __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_FUNCTION_ARGUMENT_VALUES__(prefix, number) \

// Command Inform Function Local Variables.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_FUNCTION_LOCAL_VARIABLES__(prefix, number) \

// Command Inform Function Local Parameters.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_FUNCTION_LOCAL_PARAMETERS__(prefix, number) \
(RFNSBridgeKeyLogParameter)                                                                 \
{                                                                                           \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                 \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameCommandInform,                            \
    .valueType = NULL,                                                                      \
    .value     = NULL,                                                                      \
},                                                                                          \

// Command Inform Function Local Releases.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_FUNCTION_LOCAL_RELEASES__(prefix, number) \

// Command Inform Local Releases.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_LOCAL_RELEASES__(prefix, number) \

#pragma mark Command Warn

// Command Warn Local Variables.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_LOCAL_VARIABLES__(prefix, number) \

// Command Warn Function Arguments.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_FUNCTION_ARGUMENTS__(prefix, number) \

// Command Warn Function Argument Values
#define __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_FUNCTION_ARGUMENT_VALUES__(prefix, number) \

// Command Warn Function Local Variables.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_FUNCTION_LOCAL_VARIABLES__(prefix, number) \

// Command Warn Function Local Parameters.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_FUNCTION_LOCAL_PARAMETERS__(prefix, number) \
(RFNSBridgeKeyLogParameter)                                                               \
{                                                                                         \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                               \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameCommandWarn,                            \
    .valueType = NULL,                                                                    \
    .value     = NULL,                                                                    \
},                                                                                        \

// Command Warn Function Local Releases.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_FUNCTION_LOCAL_RELEASES__(prefix, number) \

// Command Warn Local Releases.
#define __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_LOCAL_RELEASES__(prefix, number) \

#pragma mark - Functions

#pragma mark Abort

// Bridge Key Log for the Abort.
#define __RFNSProtectedBridgeKeyLogForAbort(parameters)                                                                               \
do                                                                                                                                    \
{                                                                                                                                     \
    ((void (* __dead2)(RFNSBridgeKeyLogParameter*, size_t))RFNSBridgeKeyLog)(parameters, (sizeof(parameters) / sizeof(*parameters))); \
}                                                                                                                                     \
while (0)                                                                                                                             \

// Abort Declaration.
#define __RFNSProtectedAbortDeclaration(prefix, number, function_name, function_arguments) \
void function_name(function_arguments);                                                    \

// Abort Implementation.
#define __RFNSProtectedAbortImplementation(prefix, number, function_name, function_arguments, function_local_variables, function_local_parameters, function_local_releases) \
void function_name(function_arguments)                                                                                                                                      \
{                                                                                                                                                                           \
    function_local_variables                                                                                                                                                \
                                                                                                                                                                            \
    RFNSBridgeKeyLogParameter RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _parameters)[] =                                                                                \
    {                                                                                                                                                                       \
        function_local_parameters                                                                                                                                           \
    };                                                                                                                                                                      \
                                                                                                                                                                            \
    __RFNSProtectedBridgeKeyLogForAbort(RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _parameters));                                                                        \
                                                                                                                                                                            \
    function_local_releases                                                                                                                                                 \
}                                                                                                                                                                           \

// Abort Call.
#define __RFNSProtectedAbortCall(prefix, number, local_condition, local_variables, function_name, function_argument_values, local_releases) \
do                                                                                                                                          \
{                                                                                                                                           \
    if (!(local_condition))                                                                                                                 \
    {                                                                                                                                       \
        local_variables                                                                                                                     \
                                                                                                                                            \
        function_name(function_argument_values);                                                                                            \
                                                                                                                                            \
        local_releases                                                                                                                      \
    }                                                                                                                                       \
}                                                                                                                                           \
while (0)                                                                                                                                   \

#pragma mark Assert

// Bridge Key Log for the Assert.
#define __RFNSProtectedBridgeKeyLogForAssert(parameters)                                           \
do                                                                                                 \
{                                                                                                  \
    RFNSBridgeKeyLog(parameters, (sizeof(parameters) / sizeof(*parameters)));                      \
    /* Deceiving the static analyzer. */                                                           \
    [(NSAssertionHandler *)nil handleFailureInFunction:nil file:nil lineNumber:0 description:nil]; \
}                                                                                                  \
while (0)                                                                                          \

// Assert Declaration.
#define __RFNSProtectedAssertDeclaration(prefix, number, function_name, function_arguments) \
void function_name(function_arguments);                                                     \

// Assert Implementation.
#define __RFNSProtectedAssertImplementation(prefix, number, function_name, function_arguments, function_local_variables, function_local_parameters, function_local_releases) \
void function_name(function_arguments)                                                                                                                                       \
{                                                                                                                                                                            \
    function_local_variables                                                                                                                                                 \
                                                                                                                                                                             \
    RFNSBridgeKeyLogParameter RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _parameters)[] =                                                                                 \
    {                                                                                                                                                                        \
        function_local_parameters                                                                                                                                            \
    };                                                                                                                                                                       \
                                                                                                                                                                             \
    __RFNSProtectedBridgeKeyLogForAssert(RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _parameters));                                                                        \
                                                                                                                                                                             \
    function_local_releases                                                                                                                                                  \
}                                                                                                                                                                            \

// Assert Call.
#define __RFNSProtectedAssertCall(prefix, number, local_condition, local_variables, function_name, function_argument_values, local_releases) \
do                                                                                                                                           \
{                                                                                                                                            \
    if (!(local_condition))                                                                                                                  \
    {                                                                                                                                        \
        local_variables                                                                                                                      \
                                                                                                                                             \
        function_name(function_argument_values);                                                                                             \
                                                                                                                                             \
        local_releases                                                                                                                       \
    }                                                                                                                                        \
}                                                                                                                                            \
while (0)                                                                                                                                    \

#pragma mark Breakpoint

// Bridge Key Log for the Breakpoint.
#define __RFNSProtectedBridgeKeyLogForBreakpoint(parameters)                  \
do                                                                            \
{                                                                             \
    RFNSBridgeKeyLog(parameters, (sizeof(parameters) / sizeof(*parameters))); \
}                                                                             \
while (0)                                                                     \

// Breakpoint Declaration.
#define __RFNSProtectedBreakpointDeclaration(prefix, number, function_name, function_arguments) \
void function_name(function_arguments);                                                         \

// Breakpoint Implementation.
#define __RFNSProtectedBreakpointImplementation(prefix, number, function_name, function_arguments, function_local_variables, function_local_parameters, function_local_releases) \
void function_name(function_arguments)                                                                                                                                           \
{                                                                                                                                                                                \
    function_local_variables                                                                                                                                                     \
                                                                                                                                                                                 \
    RFNSBridgeKeyLogParameter RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _parameters)[] =                                                                                     \
    {                                                                                                                                                                            \
        function_local_parameters                                                                                                                                                \
    };                                                                                                                                                                           \
                                                                                                                                                                                 \
    __RFNSProtectedBridgeKeyLogForBreakpoint(RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _parameters));                                                                        \
                                                                                                                                                                                 \
    function_local_releases                                                                                                                                                      \
}                                                                                                                                                                                \

// Breakpoint Call.
#define __RFNSProtectedBreakpointCall(prefix, number, local_condition, local_variables, function_name, function_argument_values, local_releases) \
do                                                                                                                                               \
{                                                                                                                                                \
    if (!(local_condition))                                                                                                                      \
    {                                                                                                                                            \
        local_variables                                                                                                                          \
                                                                                                                                                 \
        function_name(function_argument_values);                                                                                                 \
                                                                                                                                                 \
        local_releases                                                                                                                           \
    }                                                                                                                                            \
}                                                                                                                                                \
while (0)                                                                                                                                        \

#pragma mark Inform

// Bridge Key Log for the Inform.
#define __RFNSProtectedBridgeKeyLogForInform(parameters)                      \
do                                                                            \
{                                                                             \
    RFNSBridgeKeyLog(parameters, (sizeof(parameters) / sizeof(*parameters))); \
}                                                                             \
while (0)                                                                     \

// Inform Declaration
#define __RFNSProtectedInformDeclaration(prefix, number, function_name, function_arguments) \
void function_name(function_arguments);                                                     \

// Inform Implementation
#define __RFNSProtectedInformImplementation(prefix, number, function_name, function_arguments, function_local_variables, function_local_parameters, function_local_releases) \
void function_name(function_arguments)                                                                                                                                       \
{                                                                                                                                                                            \
    function_local_variables                                                                                                                                                 \
                                                                                                                                                                             \
    RFNSBridgeKeyLogParameter RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _parameters)[] =                                                                                 \
    {                                                                                                                                                                        \
        function_local_parameters                                                                                                                                            \
    };                                                                                                                                                                       \
                                                                                                                                                                             \
    __RFNSProtectedBridgeKeyLogForInform(RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _parameters));                                                                        \
                                                                                                                                                                             \
    function_local_releases                                                                                                                                                  \
}                                                                                                                                                                            \

// Inform Call
#define __RFNSProtectedInformCall(prefix, number, local_condition, local_variables, function_name, function_argument_values, local_releases) \
do                                                                                                                                           \
{                                                                                                                                            \
    if (!(local_condition))                                                                                                                  \
    {                                                                                                                                        \
        local_variables                                                                                                                      \
                                                                                                                                             \
        function_name(function_argument_values);                                                                                             \
                                                                                                                                             \
        local_releases                                                                                                                       \
    }                                                                                                                                        \
}                                                                                                                                            \
while (0)                                                                                                                                    \

#pragma mark Warn

// Bridge Key Log for the Warn.
#define __RFNSProtectedBridgeKeyLogForWarn(parameters)                        \
do                                                                            \
{                                                                             \
    RFNSBridgeKeyLog(parameters, (sizeof(parameters) / sizeof(*parameters))); \
}                                                                             \
while (0)                                                                     \

// Warn Declaration.
#define __RFNSProtectedWarnDeclaration(prefix, number, function_name, function_arguments) \
void function_name(function_arguments);                                                   \

// Warn Implementation.
#define __RFNSProtectedWarnImplementation(prefix, number, function_name, function_arguments, function_local_variables, function_local_parameters, function_local_releases) \
void function_name(function_arguments)                                                                                                                                     \
{                                                                                                                                                                          \
    function_local_variables                                                                                                                                               \
                                                                                                                                                                           \
    RFNSBridgeKeyLogParameter RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _parameters)[] =                                                                               \
    {                                                                                                                                                                      \
        function_local_parameters                                                                                                                                          \
    };                                                                                                                                                                     \
                                                                                                                                                                           \
    __RFNSProtectedBridgeKeyLogForWarn(RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _parameters));                                                                        \
                                                                                                                                                                           \
    function_local_releases                                                                                                                                                \
}                                                                                                                                                                          \

// Warn Call.
#define __RFNSProtectedWarnCall(prefix, number, local_condition, local_variables, function_name, function_argument_values, local_releases) \
do                                                                                                                                         \
{                                                                                                                                          \
    if (!(local_condition))                                                                                                                \
    {                                                                                                                                      \
        local_variables                                                                                                                    \
                                                                                                                                           \
        function_name(function_argument_values);                                                                                           \
                                                                                                                                           \
        local_releases                                                                                                                     \
    }                                                                                                                                      \
}                                                                                                                                          \
while (0)                                                                                                                                  \

#pragma mark - Functions for C

#pragma mark C Abort

// Abort Declaration.
#define RFNSProtectedCAbortDeclaration(prefix, number, function_name, function_arguments) \
__RFNSProtectedAbortDeclaration                                                           \
(                                                                                         \
    prefix,                                                                               \
    number,                                                                               \
    function_name,                                                                        \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                        \
    (                                                                                     \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENTS__(prefix, number)              \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENTS__(prefix, number)          \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENTS__(prefix, number)           \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_FUNCTION_ARGUMENTS__(prefix, number)       \
        function_arguments                                                                \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENTS__(prefix, number)           \
    )                                                                                     \
)                                                                                         \

// Abort Implementation.
#define RFNSProtectedCAbortImplementation(prefix, number, function_name, function_arguments, function_local_variables, function_local_parameters, function_local_releases) \
__RFNSProtectedAbortImplementation                                                                                                                                         \
(                                                                                                                                                                          \
    prefix,                                                                                                                                                                \
    number,                                                                                                                                                                \
    function_name,                                                                                                                                                         \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                         \
    (                                                                                                                                                                      \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENTS__(prefix, number)                                                                                               \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENTS__(prefix, number)                                                                                           \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENTS__(prefix, number)                                                                                            \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_FUNCTION_ARGUMENTS__(prefix, number)                                                                                        \
        function_arguments                                                                                                                                                 \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENTS__(prefix, number)                                                                                            \
    ),                                                                                                                                                                     \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                         \
    (                                                                                                                                                                      \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                         \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                     \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                      \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                      \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                  \
        function_local_variables                                                                                                                                           \
    ),                                                                                                                                                                     \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                         \
    (                                                                                                                                                                      \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                        \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                    \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                     \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                     \
        function_local_parameters                                                                                                                                          \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                 \
    ),                                                                                                                                                                     \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                         \
    (                                                                                                                                                                      \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                          \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                      \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                       \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                       \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                   \
        function_local_releases                                                                                                                                            \
    )                                                                                                                                                                      \
)                                                                                                                                                                          \

// Abort Call.
#define RFNSProtectedCAbortCall(prefix, number, local_condition, local_variables, function_name, function_argument_values, local_releases, format, ...) \
__RFNSProtectedAbortCall                                                                                                                                \
(                                                                                                                                                       \
    prefix,                                                                                                                                             \
    number,                                                                                                                                             \
    local_condition,                                                                                                                                    \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                      \
    (                                                                                                                                                   \
        __RF_NS_PROTECTED_LOGGER_COMMON_LOCAL_VARIABLES__(prefix, number)                                                                               \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                           \
        __RF_NS_PROTECTED_LOGGER_CONDITION_LOCAL_VARIABLES__(prefix, number)                                                                            \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_LOCAL_VARIABLES__(prefix, number)                                                                            \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_LOCAL_VARIABLES__(prefix, number)                                                                        \
        local_variables                                                                                                                                 \
    ),                                                                                                                                                  \
    function_name,                                                                                                                                      \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                      \
    (                                                                                                                                                   \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                                      \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                                  \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENT_VALUES__(prefix, number, local_condition)                                                  \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                               \
        function_argument_values                                                                                                                        \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENT_VALUES__(prefix, number, format, ##__VA_ARGS__)                                            \
    ),                                                                                                                                                  \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                      \
    (                                                                                                                                                   \
        __RF_NS_PROTECTED_LOGGER_COMMON_LOCAL_RELEASES__(prefix, number)                                                                                \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                            \
        __RF_NS_PROTECTED_LOGGER_CONDITION_LOCAL_RELEASES__(prefix, number)                                                                             \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_LOCAL_RELEASES__(prefix, number)                                                                             \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ABORT_LOCAL_RELEASES__(prefix, number)                                                                         \
        local_releases                                                                                                                                  \
    )                                                                                                                                                   \
)                                                                                                                                                       \

#pragma mark C Assert

// Assert Declaration.
#define RFNSProtectedCAssertDeclaration(prefix, number, function_name, function_arguments) \
__RFNSProtectedAssertDeclaration                                                           \
(                                                                                          \
    prefix,                                                                                \
    number,                                                                                \
    function_name,                                                                         \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                         \
    (                                                                                      \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENTS__(prefix, number)               \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENTS__(prefix, number)           \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENTS__(prefix, number)            \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_FUNCTION_ARGUMENTS__(prefix, number)       \
        function_arguments                                                                 \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENTS__(prefix, number)            \
    )                                                                                      \
)                                                                                          \

// Assert Implementation.
#define RFNSProtectedCAssertImplementation(prefix, number, function_name, function_arguments, function_local_variables, function_local_parameters, function_local_releases) \
__RFNSProtectedAssertImplementation                                                                                                                                         \
(                                                                                                                                                                           \
    prefix,                                                                                                                                                                 \
    number,                                                                                                                                                                 \
    function_name,                                                                                                                                                          \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                          \
    (                                                                                                                                                                       \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENTS__(prefix, number)                                                                                                \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENTS__(prefix, number)                                                                                            \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENTS__(prefix, number)                                                                                             \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_FUNCTION_ARGUMENTS__(prefix, number)                                                                                        \
        function_arguments                                                                                                                                                  \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENTS__(prefix, number)                                                                                             \
    ),                                                                                                                                                                      \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                          \
    (                                                                                                                                                                       \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                          \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                      \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                       \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                       \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                  \
        function_local_variables                                                                                                                                            \
    ),                                                                                                                                                                      \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                          \
    (                                                                                                                                                                       \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                         \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                     \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                      \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                      \
        function_local_parameters                                                                                                                                           \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                 \
    ),                                                                                                                                                                      \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                          \
    (                                                                                                                                                                       \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                           \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                       \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                        \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                        \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                   \
        function_local_releases                                                                                                                                             \
    )                                                                                                                                                                       \
)                                                                                                                                                                           \

// Assert Call.
#define RFNSProtectedCAssertCall(prefix, number, local_condition, local_variables, function_name, function_argument_values, local_releases, format, ...) \
__RFNSProtectedAssertCall                                                                                                                                \
(                                                                                                                                                        \
    prefix,                                                                                                                                              \
    number,                                                                                                                                              \
    local_condition,                                                                                                                                     \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                       \
    (                                                                                                                                                    \
        __RF_NS_PROTECTED_LOGGER_COMMON_LOCAL_VARIABLES__(prefix, number)                                                                                \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                            \
        __RF_NS_PROTECTED_LOGGER_CONDITION_LOCAL_VARIABLES__(prefix, number)                                                                             \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_LOCAL_VARIABLES__(prefix, number)                                                                             \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_LOCAL_VARIABLES__(prefix, number)                                                                        \
        local_variables                                                                                                                                  \
    ),                                                                                                                                                   \
    function_name,                                                                                                                                       \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                       \
    (                                                                                                                                                    \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                                       \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                                   \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENT_VALUES__(prefix, number, local_condition)                                                   \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                               \
        function_argument_values                                                                                                                         \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENT_VALUES__(prefix, number, format, ##__VA_ARGS__)                                             \
    ),                                                                                                                                                   \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                       \
    (                                                                                                                                                    \
        __RF_NS_PROTECTED_LOGGER_COMMON_LOCAL_RELEASES__(prefix, number)                                                                                 \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                             \
        __RF_NS_PROTECTED_LOGGER_CONDITION_LOCAL_RELEASES__(prefix, number)                                                                              \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_LOCAL_RELEASES__(prefix, number)                                                                              \
        __RF_NS_PROTECTED_LOGGER_COMMAND_ASSERT_LOCAL_RELEASES__(prefix, number)                                                                         \
        local_releases                                                                                                                                   \
    )                                                                                                                                                    \
)                                                                                                                                                        \

#pragma mark C Breakpoint

// Breakpoint Declaration.
#define RFNSProtectedCBreakpointDeclaration(prefix, number, function_name, function_arguments) \
__RFNSProtectedBreakpointDeclaration                                                           \
(                                                                                              \
    prefix,                                                                                    \
    number,                                                                                    \
    function_name,                                                                             \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                             \
    (                                                                                          \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENTS__(prefix, number)                   \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENTS__(prefix, number)               \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENTS__(prefix, number)                \
        __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_FUNCTION_ARGUMENTS__(prefix, number)       \
        function_arguments                                                                     \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENTS__(prefix, number)                \
    )                                                                                          \
)                                                                                              \

// Breakpoint Implementation.
#define RFNSProtectedCBreakpointImplementation(prefix, number, function_name, function_arguments, function_local_variables, function_local_parameters, function_local_releases) \
__RFNSProtectedBreakpointImplementation                                                                                                                                         \
(                                                                                                                                                                               \
    prefix,                                                                                                                                                                     \
    number,                                                                                                                                                                     \
    function_name,                                                                                                                                                              \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                              \
    (                                                                                                                                                                           \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENTS__(prefix, number)                                                                                                    \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENTS__(prefix, number)                                                                                                \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENTS__(prefix, number)                                                                                                 \
        __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_FUNCTION_ARGUMENTS__(prefix, number)                                                                                        \
        function_arguments                                                                                                                                                      \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENTS__(prefix, number)                                                                                                 \
    ),                                                                                                                                                                          \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                              \
    (                                                                                                                                                                           \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                              \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                          \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                           \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                           \
        __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                  \
        function_local_variables                                                                                                                                                \
    ),                                                                                                                                                                          \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                              \
    (                                                                                                                                                                           \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                             \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                         \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                          \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                          \
        function_local_parameters                                                                                                                                               \
        __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                 \
    ),                                                                                                                                                                          \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                              \
    (                                                                                                                                                                           \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                               \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                           \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                            \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                            \
        __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                   \
        function_local_releases                                                                                                                                                 \
    )                                                                                                                                                                           \
)                                                                                                                                                                               \

// Breakpoint Call.
#define RFNSProtectedCBreakpointCall(prefix, number, local_condition, local_variables, function_name, function_argument_values, local_releases, format, ...) \
__RFNSProtectedBreakpointCall                                                                                                                                \
(                                                                                                                                                            \
    prefix,                                                                                                                                                  \
    number,                                                                                                                                                  \
    local_condition,                                                                                                                                         \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                           \
    (                                                                                                                                                        \
        __RF_NS_PROTECTED_LOGGER_COMMON_LOCAL_VARIABLES__(prefix, number)                                                                                    \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                \
        __RF_NS_PROTECTED_LOGGER_CONDITION_LOCAL_VARIABLES__(prefix, number)                                                                                 \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_LOCAL_VARIABLES__(prefix, number)                                                                                 \
        __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_LOCAL_VARIABLES__(prefix, number)                                                                        \
        local_variables                                                                                                                                      \
    ),                                                                                                                                                       \
    function_name,                                                                                                                                           \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                           \
    (                                                                                                                                                        \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                                           \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                                       \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENT_VALUES__(prefix, number, local_condition)                                                       \
        __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                               \
        function_argument_values                                                                                                                             \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENT_VALUES__(prefix, number, format, ##__VA_ARGS__)                                                 \
    ),                                                                                                                                                       \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                           \
    (                                                                                                                                                        \
        __RF_NS_PROTECTED_LOGGER_COMMON_LOCAL_RELEASES__(prefix, number)                                                                                     \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                 \
        __RF_NS_PROTECTED_LOGGER_CONDITION_LOCAL_RELEASES__(prefix, number)                                                                                  \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_LOCAL_RELEASES__(prefix, number)                                                                                  \
        __RF_NS_PROTECTED_LOGGER_COMMAND_BREAKPOINT_LOCAL_RELEASES__(prefix, number)                                                                         \
        local_releases                                                                                                                                       \
    )                                                                                                                                                        \
)                                                                                                                                                            \

#pragma mark C Inform

// Breakpoint Declaration.
#define RFNSProtectedCInformDeclaration(prefix, number, function_name, function_arguments) \
__RFNSProtectedInformDeclaration                                                           \
(                                                                                          \
    prefix,                                                                                \
    number,                                                                                \
    function_name,                                                                         \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                         \
    (                                                                                      \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENTS__(prefix, number)               \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENTS__(prefix, number)           \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENTS__(prefix, number)            \
        __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_FUNCTION_ARGUMENTS__(prefix, number)       \
        function_arguments                                                                 \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENTS__(prefix, number)            \
    )                                                                                      \
)                                                                                          \

#define RFNSProtectedCInformImplementation(prefix, number, function_name, function_arguments, function_local_variables, function_local_parameters, function_local_releases) \
__RFNSProtectedInformImplementation                                                                                                                                         \
(                                                                                                                                                                           \
    prefix,                                                                                                                                                                 \
    number,                                                                                                                                                                 \
    function_name,                                                                                                                                                          \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                          \
    (                                                                                                                                                                       \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENTS__(prefix, number)                                                                                                \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENTS__(prefix, number)                                                                                            \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENTS__(prefix, number)                                                                                             \
        __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_FUNCTION_ARGUMENTS__(prefix, number)                                                                                        \
        function_arguments                                                                                                                                                  \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENTS__(prefix, number)                                                                                             \
    ),                                                                                                                                                                      \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                          \
    (                                                                                                                                                                       \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                          \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                      \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                       \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                       \
        __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                  \
        function_local_variables                                                                                                                                            \
    ),                                                                                                                                                                      \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                          \
    (                                                                                                                                                                       \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                         \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                     \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                      \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                      \
        function_local_parameters                                                                                                                                           \
        __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                 \
    ),                                                                                                                                                                      \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                          \
    (                                                                                                                                                                       \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                           \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                       \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                        \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                        \
        __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                   \
        function_local_releases                                                                                                                                             \
    )                                                                                                                                                                       \
)                                                                                                                                                                           \

// Breakpoint Call.
#define RFNSProtectedCInformCall(prefix, number, local_condition, local_variables, function_name, function_argument_values, local_releases, format, ...) \
__RFNSProtectedInformCall                                                                                                                                \
(                                                                                                                                                        \
    prefix,                                                                                                                                              \
    number,                                                                                                                                              \
    local_condition,                                                                                                                                     \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                       \
    (                                                                                                                                                    \
        __RF_NS_PROTECTED_LOGGER_COMMON_LOCAL_VARIABLES__(prefix, number)                                                                                \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                            \
        __RF_NS_PROTECTED_LOGGER_CONDITION_LOCAL_VARIABLES__(prefix, number)                                                                             \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_LOCAL_VARIABLES__(prefix, number)                                                                             \
        __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_LOCAL_VARIABLES__(prefix, number)                                                                        \
        local_variables                                                                                                                                  \
    ),                                                                                                                                                   \
    function_name,                                                                                                                                       \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                       \
    (                                                                                                                                                    \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                                       \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                                   \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENT_VALUES__(prefix, number, local_condition)                                                   \
        __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                               \
        function_argument_values                                                                                                                         \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENT_VALUES__(prefix, number, format, ##__VA_ARGS__)                                             \
    ),                                                                                                                                                   \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                       \
    (                                                                                                                                                    \
        __RF_NS_PROTECTED_LOGGER_COMMON_LOCAL_RELEASES__(prefix, number)                                                                                 \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                             \
        __RF_NS_PROTECTED_LOGGER_CONDITION_LOCAL_RELEASES__(prefix, number)                                                                              \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_LOCAL_RELEASES__(prefix, number)                                                                              \
        __RF_NS_PROTECTED_LOGGER_COMMAND_INFORM_LOCAL_RELEASES__(prefix, number)                                                                         \
        local_releases                                                                                                                                   \
    )                                                                                                                                                    \
)                                                                                                                                                        \

#pragma mark C Warn

// Warn Declaration.
#define RFNSProtectedCWarnDeclaration(prefix, number, function_name, function_arguments) \
__RFNSProtectedWarnDeclaration                                                           \
(                                                                                        \
    prefix,                                                                              \
    number,                                                                              \
    function_name,                                                                       \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                       \
    (                                                                                    \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENTS__(prefix, number)             \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENTS__(prefix, number)         \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENTS__(prefix, number)          \
        __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_FUNCTION_ARGUMENTS__(prefix, number)       \
        function_arguments                                                               \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENTS__(prefix, number)          \
    )                                                                                    \
)                                                                                        \

// Warn Implementation.
#define RFNSProtectedCWarnImplementation(prefix, number, function_name, function_arguments, function_local_variables, function_local_parameters, function_local_releases) \
__RFNSProtectedWarnImplementation                                                                                                                                         \
(                                                                                                                                                                         \
    prefix,                                                                                                                                                               \
    number,                                                                                                                                                               \
    function_name,                                                                                                                                                        \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                        \
    (                                                                                                                                                                     \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENTS__(prefix, number)                                                                                              \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENTS__(prefix, number)                                                                                          \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENTS__(prefix, number)                                                                                           \
        __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_FUNCTION_ARGUMENTS__(prefix, number)                                                                                        \
        function_arguments                                                                                                                                                \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENTS__(prefix, number)                                                                                           \
    ),                                                                                                                                                                    \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                        \
    (                                                                                                                                                                     \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                        \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                    \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                     \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                     \
        __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                                  \
        function_local_variables                                                                                                                                          \
    ),                                                                                                                                                                    \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                        \
    (                                                                                                                                                                     \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                       \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                   \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                    \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                    \
        function_local_parameters                                                                                                                                         \
        __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_FUNCTION_LOCAL_PARAMETERS__(prefix, number)                                                                                 \
    ),                                                                                                                                                                    \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                                        \
    (                                                                                                                                                                     \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                         \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                     \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                      \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                      \
        __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                                   \
        function_local_releases                                                                                                                                           \
    )                                                                                                                                                                     \
)                                                                                                                                                                         \

// Warn Call.
#define RFNSProtectedCWarnCall(prefix, number, local_condition, local_variables, function_name, function_argument_values, local_releases, format, ...) \
__RFNSProtectedWarnCall                                                                                                                                \
(                                                                                                                                                      \
    prefix,                                                                                                                                            \
    number,                                                                                                                                            \
    local_condition,                                                                                                                                   \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                     \
    (                                                                                                                                                  \
        __RF_NS_PROTECTED_LOGGER_COMMON_LOCAL_VARIABLES__(prefix, number)                                                                              \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                                                          \
        __RF_NS_PROTECTED_LOGGER_CONDITION_LOCAL_VARIABLES__(prefix, number)                                                                           \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_LOCAL_VARIABLES__(prefix, number)                                                                           \
        __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_LOCAL_VARIABLES__(prefix, number)                                                                        \
        local_variables                                                                                                                                \
    ),                                                                                                                                                 \
    function_name,                                                                                                                                     \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                     \
    (                                                                                                                                                  \
        __RF_NS_PROTECTED_LOGGER_COMMON_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                                     \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                                 \
        __RF_NS_PROTECTED_LOGGER_CONDITION_FUNCTION_ARGUMENT_VALUES__(prefix, number, local_condition)                                                 \
        __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_FUNCTION_ARGUMENT_VALUES__(prefix, number)                                                               \
        function_argument_values                                                                                                                       \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_FUNCTION_ARGUMENT_VALUES__(prefix, number, format, ##__VA_ARGS__)                                           \
    ),                                                                                                                                                 \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                                                                     \
    (                                                                                                                                                  \
        __RF_NS_PROTECTED_LOGGER_COMMON_LOCAL_RELEASES__(prefix, number)                                                                               \
        __RF_NS_PROTECTED_LOGGER_C_FUNCTION_LOCAL_RELEASES__(prefix, number)                                                                           \
        __RF_NS_PROTECTED_LOGGER_CONDITION_LOCAL_RELEASES__(prefix, number)                                                                            \
        __RF_NS_PROTECTED_LOGGER_C_MESSAGE_LOCAL_RELEASES__(prefix, number)                                                                            \
        __RF_NS_PROTECTED_LOGGER_COMMAND_WARN_LOCAL_RELEASES__(prefix, number)                                                                         \
        local_releases                                                                                                                                 \
    )                                                                                                                                                  \
)                                                                                                                                                      \
