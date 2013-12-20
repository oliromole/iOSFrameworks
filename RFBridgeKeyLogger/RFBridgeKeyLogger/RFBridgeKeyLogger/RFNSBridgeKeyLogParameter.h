//
//  RFNSBridgeKeyLogParameter.h
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

// Importing the project headers.
#import "RFNSBridgeKeyLogDefines.h"

typedef struct
{
    const void *keyType;
    const void *keyName;
    const void *valueType;
    const void *value;
} RFNSBridgeKeyLogParameter;

// Parameter Types.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterTypeCString;
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterTypeObjectiveCID;
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterTypeObjectiveCNSException;
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterTypeObjectiveCNSError;
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterTypeObjectiveCNSString;
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterTypeObjectiveCSelector;
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterTypeLongInteger;
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterTypeVoidPointer;

// Parameter Key Names for Predefined Macros.
// http://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html
// http://gcc.gnu.org/onlinedocs/cpp/Standard-Predefined-Macros.html
//
// {!0, !0,  0,  0}; - The define is not defined.
// (!0, !0, !0,  0}; - The define is defined without any value.
// (!0, !0, !0, !0}; - The define is defined with the value.
//
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__BASE_FILE__;       // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeCString.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__DATE__;            // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeCString.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__FILE__;            // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeCString.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__FUNCTION__;        // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeCString.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__LINE__;            // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeLongInteger.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__PRETTY_FUNCTION__; // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeCString.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__TIME__;            // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeCString.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__TIMESTAMP__;       // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeCString.

// Parameter Key Names for Commands.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNameCommandAbort;      // RFNSBridgeKeyLogParameterTypeVoidPointer, NULL.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNameCommandAssert;     // RFNSBridgeKeyLogParameterTypeVoidPointer, NULL.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNameCommandBreakpoint; // RFNSBridgeKeyLogParameterTypeVoidPointer, NULL.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNameCommandInform;     // RFNSBridgeKeyLogParameterTypeVoidPointer, NULL.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNameCommandWarn;       // RFNSBridgeKeyLogParameterTypeVoidPointer, NULL.

// Common Parameter Key Names.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNameConditionText; // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeCString.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNameException;     // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeObjectiveCNSException.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNameError;         // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeObjectiveCNSError.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNameMessage;       // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeCString | RFNSBridgeKeyLogParameterTypeObjectiveCNSString.

// Parameter Key Names for Objective-C.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNameObjectiveC_cmd; // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeObjectiveCSelector.
RFNS_BRIDGE_KEY_LOGGER_EXTERN const void * const RFNSBridgeKeyLogParameterKeyNameObjectiveCself; // RFNSBridgeKeyLogParameterTypeVoidPointer, RFNSBridgeKeyLogParameterTypeObjectiveCID.
