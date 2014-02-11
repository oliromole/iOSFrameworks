//
//  RFNSBridgeKeyLogParameter.m
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
#import "RFNSBridgeKeyLogParameter.h"

// Importing the system headers.
#import <stddef.h>

// Parameter Types.
const void * const RFNSBridgeKeyLogParameterTypeCString = NULL;
const void * const RFNSBridgeKeyLogParameterTypeObjectiveCID = NULL;
const void * const RFNSBridgeKeyLogParameterTypeObjectiveCNSException = NULL;
const void * const RFNSBridgeKeyLogParameterTypeObjectiveCNSError = NULL;
const void * const RFNSBridgeKeyLogParameterTypeObjectiveCNSString = NULL;
const void * const RFNSBridgeKeyLogParameterTypeObjectiveCSelector = NULL;
const void * const RFNSBridgeKeyLogParameterTypeLongInteger = NULL;
const void * const RFNSBridgeKeyLogParameterTypeVoidPointer = NULL;

// Parameter Key Names for Predefined Macros.
const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__BASE_FILE__ = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__DATE__ = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__FILE__ = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__FUNCTION__ = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__INCLUDE_LEVEL__ = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__LINE__ = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__PRETTY_FUNCTION__ = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__TIME__ = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNamePredefinedMacro__TIMESTAMP__ = NULL;

// Parameter Key Names for Commands.
const void * const RFNSBridgeKeyLogParameterKeyNameCommandAbort = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNameCommandAssert = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNameCommandBreakpoint = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNameCommandInform = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNameCommandWarn = NULL;

// Common Parameter Key Names.
const void * const RFNSBridgeKeyLogParameterKeyNameConditionText = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNameException = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNameError = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNameFrameworkName = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNameMessage = NULL;

// Parameter Key Names for Objective-C.
const void * const RFNSBridgeKeyLogParameterKeyNameObjectiveC_cmd = NULL;
const void * const RFNSBridgeKeyLogParameterKeyNameObjectiveCself = NULL;
