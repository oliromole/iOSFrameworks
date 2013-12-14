//
//  RFNSBridgeKeyLogDefines.h
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

// Importing the system headers.
#import <TargetConditionals.h>

#if !defined(RFNS_BRIDGE_KEY_LOGGER_EXTERN)
#   if defined(__cplusplus)
#       define RFNS_BRIDGE_KEY_LOGGER_EXTERN extern "C"
#   else
#       define RFNS_BRIDGE_KEY_LOGGER_EXTERN extern
#   endif
#endif

#if !defined(RFNS_BRIDGE_KEY_LOGGER_INLINE)
#   if defined(__GNUC__)
#       define RFNS_BRIDGE_KEY_LOGGER_INLINE static __inline__ __attribute__((always_inline))
#   elif defined(__MWERKS__) || defined(__cplusplus)
#       define RFNS_BRIDGE_KEY_LOGGER_INLINE static inline
#   elif defined(_MSC_VER)
#       define RFNS_BRIDGE_KEY_LOGGER_INLINE static __inline
#   elif TARGET_OS_WIN32
#       define RFNS_BRIDGE_KEY_LOGGER_INLINE static __inline__
#   endif
#endif

#if !defined(RFNS_BRIDGE_KEY_LOGGER_STATIC_INLINE)
#   define RFNS_BRIDGE_KEY_LOGGER_STATIC_INLINE static __inline__
#endif

#if !defined(RFNS_BRIDGE_KEY_LOGGER_INLINE)
#   define RFNS_BRIDGE_KEY_LOGGER_INLINE extern __inline__
#endif
