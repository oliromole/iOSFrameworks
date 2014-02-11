//
//  RFOSPrivateLog.h
//  RFLibKern
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2014.02.09.
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

// Importing the external headers.
#import <RFBridgeKeyLogger/RFNSProtectedLog.h>

#define RF_OS_PRIVATE_FRAMEWORK_NAME "RFLibKern"

#pragma mark - Parameters

#pragma mark C Framework Name

// C Framework Name Local Variables.
#define __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_LOCAL_VARIABLES__(prefix, number) \

// C Framework Name Function Arguments.
#define __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENTS__(prefix, number) \

// C Framework Name Function Argument Values
#define __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENT_VALUES__(prefix, number) \

// C Framework Name Function Local Variables.
#define __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_VARIABLES__(prefix, number)                                 \
char *RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyNameFrameworkName) = RF_OS_PRIVATE_FRAMEWORK_NAME; \

// C Framework Name Function Local Parameters.
#define __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_PARAMETERS__(prefix, number)             \
(RFNSBridgeKeyLogParameter)                                                                                      \
{                                                                                                                \
    .keyType   = &RFNSBridgeKeyLogParameterTypeVoidPointer,                                                      \
    .keyName   = &RFNSBridgeKeyLogParameterKeyNameFrameworkName,                                                 \
    .valueType = &RFNSBridgeKeyLogParameterTypeCString,                                                          \
    .value     = &RF_NS_PROTECTED_LOGGER_PASTE3(prefix, number, _RFNSBridgeKeyLogParameterKeyNameFrameworkName), \
},                                                                                                               \

// C Framework Name Function Local Releases.
#define __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_RELEASES__(prefix, number) \

// C Framework Name Local Releases.
#define __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_LOCAL_RELEASES__(prefix, number) \

#pragma mark - C Functions

#pragma mark C Abort

// Abort Declaration.
#define __RFOSPrivateCAbortDeclaration(prefix, number, function_name)                         \
RFNSProtectedCAbortDeclaration                                                                \
(                                                                                             \
    prefix,                                                                                   \
    number,                                                                                   \
    function_name,                                                                            \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                            \
    (                                                                                         \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENTS__(prefix, number) \
    )                                                                                         \
)                                                                                             \

// Abort Declaration.
__RFOSPrivateCAbortDeclaration    \
(                                 \
    rf_lib_kern_private_c_abort_, \
    __COUNTER__,                  \
    RFOSLibKernPrivateCAbort      \
)                                 \

// Abort Implementation.
#define __RFOSPrivateCAbortImplementation(prefix, number, function_name)                             \
RFNSProtectedCAbortImplementation                                                                    \
(                                                                                                    \
    prefix,                                                                                          \
    number,                                                                                          \
    function_name,                                                                                   \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENTS__(prefix, number)        \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_VARIABLES__(prefix, number)  \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_PARAMETERS__(prefix, number) \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_RELEASES__(prefix, number)   \
    )                                                                                                \
)                                                                                                    \

// Abort Call.
#define __RFOSPrivateCAbortCall(prefix, number, local_condition, function_name, format, ...)        \
RFNSProtectedCAbortCall                                                                             \
(                                                                                                   \
    prefix,                                                                                         \
    number,                                                                                         \
    local_condition,                                                                                \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_LOCAL_VARIABLES__(prefix, number)          \
    ),                                                                                              \
    function_name,                                                                                  \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENT_VALUES__(prefix, number) \
    ),                                                                                              \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_LOCAL_RELEASES__(prefix, number)           \
    ),                                                                                              \
    format,                                                                                         \
    ##__VA_ARGS__                                                                                   \
)                                                                                                   \

// Abort Call.
#define RFOSPrivateCAbort(condition, format, ...) \
__RFOSPrivateCAbortCall                           \
(                                                 \
    rf_lib_kern_private_c_abort_,                 \
    __COUNTER__,                                  \
    condition,                                    \
    RFOSLibKernPrivateCAbort,                     \
    format,                                       \
    ##__VA_ARGS__                                 \
)                                                 \

#pragma mark C Assert

// Assert Declaration.
#define __RFOSPrivateCAssertDeclaration(prefix, number, function_name)                        \
RFNSProtectedCAssertDeclaration                                                               \
(                                                                                             \
    prefix,                                                                                   \
    number,                                                                                   \
    function_name,                                                                            \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                            \
    (                                                                                         \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENTS__(prefix, number) \
    )                                                                                         \
)                                                                                             \

// Assert Declaration.
__RFOSPrivateCAssertDeclaration    \
(                                  \
    rf_lib_kern_private_c_assert_, \
    __COUNTER__,                   \
    RFOSLibKernPrivateCAssert      \
)                                  \

// Assert Implementation.
#define __RFOSPrivateCAssertImplementation(prefix, number, function_name)                            \
RFNSProtectedCAssertImplementation                                                                   \
(                                                                                                    \
    prefix,                                                                                          \
    number,                                                                                          \
    function_name,                                                                                   \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENTS__(prefix, number)        \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_VARIABLES__(prefix, number)  \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_PARAMETERS__(prefix, number) \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_RELEASES__(prefix, number)   \
    )                                                                                                \
)                                                                                                    \

// Assert Call.
#define __RFOSPrivateCAssertCall(prefix, number, local_condition, function_name, format, ...)       \
RFNSProtectedCAssertCall                                                                            \
(                                                                                                   \
    prefix,                                                                                         \
    number,                                                                                         \
    local_condition,                                                                                \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_LOCAL_VARIABLES__(prefix, number)          \
    ),                                                                                              \
    function_name,                                                                                  \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENT_VALUES__(prefix, number) \
    ),                                                                                              \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_LOCAL_RELEASES__(prefix, number)           \
    ),                                                                                              \
    format,                                                                                         \
    ##__VA_ARGS__                                                                                   \
)                                                                                                   \

// Assert Call.
#define RFOSPrivateCAssert(condition, format, ...) \
__RFOSPrivateCAssertCall                           \
(                                                  \
    rf_lib_kern_private_c_assert_,                 \
    __COUNTER__,                                   \
    condition,                                     \
    RFOSLibKernPrivateCAssert,                     \
    format,                                        \
    ##__VA_ARGS__                                  \
)                                                  \

#pragma mark C Breakpoint

// Breakpoint Declaration.
#define __RFOSPrivateCBreakpointDeclaration(prefix, number, function_name)                    \
RFNSProtectedCBreakpointDeclaration                                                           \
(                                                                                             \
    prefix,                                                                                   \
    number,                                                                                   \
    function_name,                                                                            \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                            \
    (                                                                                         \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENTS__(prefix, number) \
    )                                                                                         \
)                                                                                             \

// Breakpoint Declaration.
__RFOSPrivateCBreakpointDeclaration    \
(                                      \
    rf_lib_kern_private_c_breakpoint_, \
    __COUNTER__,                       \
    RFOSLibKernPrivateCBreakpoint      \
)                                      \

// Breakpoint Implementation.
#define __RFOSPrivateCBreakpointImplementation(prefix, number, function_name)                        \
RFNSProtectedCBreakpointImplementation                                                               \
(                                                                                                    \
    prefix,                                                                                          \
    number,                                                                                          \
    function_name,                                                                                   \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENTS__(prefix, number)        \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_VARIABLES__(prefix, number)  \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_PARAMETERS__(prefix, number) \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_RELEASES__(prefix, number)   \
    )                                                                                                \
)                                                                                                    \

// Breakpoint Call.
#define __RFOSPrivateCBreakpointCall(prefix, number, local_condition, function_name, format, ...)   \
RFNSProtectedCBreakpointCall                                                                        \
(                                                                                                   \
    prefix,                                                                                         \
    number,                                                                                         \
    local_condition,                                                                                \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_LOCAL_VARIABLES__(prefix, number)          \
    ),                                                                                              \
    function_name,                                                                                  \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENT_VALUES__(prefix, number) \
    ),                                                                                              \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_LOCAL_RELEASES__(prefix, number)           \
    ),                                                                                              \
    format,                                                                                         \
    ##__VA_ARGS__                                                                                   \
)                                                                                                   \

// Breakpoint Call.
#define RFOSPrivateCBreakpoint(condition, format, ...) \
__RFOSPrivateCBreakpointCall                           \
(                                                      \
    rf_lib_kern_private_c_breakpoint_,                 \
    __COUNTER__,                                       \
    condition,                                         \
    RFOSLibKernPrivateCBreakpoint,                     \
    format,                                            \
    ##__VA_ARGS__                                      \
)                                                      \

#pragma mark C Inform

// Inform Declaration.
#define __RFOSPrivateCInformDeclaration(prefix, number, function_name)                        \
RFNSProtectedCInformDeclaration                                                               \
(                                                                                             \
    prefix,                                                                                   \
    number,                                                                                   \
    function_name,                                                                            \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                            \
    (                                                                                         \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENTS__(prefix, number) \
    )                                                                                         \
)                                                                                             \

// Inform Declaration.
__RFOSPrivateCInformDeclaration    \
(                                  \
    rf_lib_kern_private_c_inform_, \
    __COUNTER__,                   \
    RFOSLibKernPrivateCInform      \
 )                                 \

// Inform Implementation.
#define __RFOSPrivateCInformImplementation(prefix, number, function_name)                            \
RFNSProtectedCInformImplementation                                                                   \
(                                                                                                    \
    prefix,                                                                                          \
    number,                                                                                          \
    function_name,                                                                                   \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENTS__(prefix, number)        \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_VARIABLES__(prefix, number)  \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_PARAMETERS__(prefix, number) \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_RELEASES__(prefix, number)   \
    )                                                                                                \
)                                                                                                    \

// Inform Call.
#define __RFOSPrivateCInformCall(prefix, number, local_condition, function_name, format, ...)       \
RFNSProtectedCInformCall                                                                            \
(                                                                                                   \
    prefix,                                                                                         \
    number,                                                                                         \
    local_condition,                                                                                \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_LOCAL_VARIABLES__(prefix, number)          \
    ),                                                                                              \
    function_name,                                                                                  \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENT_VALUES__(prefix, number) \
    ),                                                                                              \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_LOCAL_RELEASES__(prefix, number)           \
    ),                                                                                              \
    format,                                                                                         \
    ##__VA_ARGS__                                                                                   \
)                                                                                                   \

// Inform Call.
#define RFOSPrivateCInform(condition, format, ...) \
__RFOSPrivateCInformCall                           \
(                                                  \
    rf_lib_kern_private_c_inform_,                 \
    __COUNTER__,                                   \
    condition,                                     \
    RFOSLibKernPrivateCInform,                     \
    format,                                        \
    ##__VA_ARGS__                                  \
)                                                  \

#pragma mark C Warn

// Warn Declaration.
#define __RFOSPrivateCWarnDeclaration(prefix, number, function_name)                          \
RFNSProtectedCWarnDeclaration                                                                 \
(                                                                                             \
    prefix,                                                                                   \
    number,                                                                                   \
    function_name,                                                                            \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                            \
    (                                                                                         \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENTS__(prefix, number) \
    )                                                                                         \
)                                                                                             \

// Warn Declaration.
__RFOSPrivateCWarnDeclaration    \
(                                \
    rf_lib_kern_private_c_warn_, \
    __COUNTER__,                 \
    RFOSLibKernPrivateCWarn      \
 )                               \

// Warn Implementation.
#define __RFOSPrivateCWarnImplementation(prefix, number, function_name)                              \
RFNSProtectedCWarnImplementation                                                                     \
(                                                                                                    \
    prefix,                                                                                          \
    number,                                                                                          \
    function_name,                                                                                   \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENTS__(prefix, number)        \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_VARIABLES__(prefix, number)  \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_PARAMETERS__(prefix, number) \
    ),                                                                                               \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                   \
    (                                                                                                \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_LOCAL_RELEASES__(prefix, number)   \
    )                                                                                                \
)                                                                                                    \

// Warn Call.
#define __RFOSPrivateCWarnCall(prefix, number, local_condition, function_name, format, ...)         \
RFNSProtectedCWarnCall                                                                              \
(                                                                                                   \
    prefix,                                                                                         \
    number,                                                                                         \
    local_condition,                                                                                \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_LOCAL_VARIABLES__(prefix, number)          \
    ),                                                                                              \
    function_name,                                                                                  \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_FUNCTION_ARGUMENT_VALUES__(prefix, number) \
    ),                                                                                              \
    RF_NS_PROTECTED_LOGGER_INSERT_ARGUMENTS_AS_ONE                                                  \
    (                                                                                               \
        __RF_OS_LIB_KERN_PRIVATE_LOGGER_C_FRAMEWORK_NAME_LOCAL_RELEASES__(prefix, number)           \
    ),                                                                                              \
    format,                                                                                         \
    ##__VA_ARGS__                                                                                   \
)                                                                                                   \

// Warn Call.
#define RFOSPrivateCWarn(condition, format, ...) \
__RFOSPrivateCWarnCall                           \
(                                                \
    rf_lib_kern_private_c_warn_,                 \
    __COUNTER__,                                 \
    condition,                                   \
    RFOSLibKernPrivateCWarn,                     \
    format,                                      \
    ##__VA_ARGS__                                \
)                                                \
