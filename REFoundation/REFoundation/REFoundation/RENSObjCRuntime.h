//
//  RENSObjCRuntime.h
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.06.27.
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
#import <RWObjC/RWObjC.h>

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>

#define NS_COMPARE(value1, value2) (((value1) < (value2)) ? (NSOrderedAscending) : (((value1) > (value2)) ? (NSOrderedDescending) : (NSOrderedSame)))
#define NS_CASCADE_COMPARE(value1, value2, value3) (((value1) < (value2)) ? (NSOrderedAscending) : (((value1) > (value2)) ? (NSOrderedDescending) : (value3)))

NS_INLINE NSComparisonResult NSInvertComparisonResult(NSComparisonResult comparisonResult)
{
    NSComparisonResult invertedComparisonResult;
    
    if (comparisonResult < NSOrderedSame)
    {
        invertedComparisonResult = NSOrderedDescending;
    }
    
    else if (comparisonResult > NSOrderedSame)
    {
        invertedComparisonResult = NSOrderedAscending;
    }
    
    else
    {
        invertedComparisonResult = NSOrderedSame;
    }
    
    return invertedComparisonResult;
}

NS_INLINE NSComparisonResult NSComparisonResultFromCComparisonResult(int cComparisonResult)
{
    NSComparisonResult nsComparisonResult;
    
    if (cComparisonResult < 0)
    {
        nsComparisonResult = NSOrderedAscending;
    }
    
    else if (cComparisonResult > 0)
    {
        nsComparisonResult = NSOrderedDescending;
    }
    
    else
    {
        nsComparisonResult = NSOrderedSame;
    }
    
    return nsComparisonResult;
}

#define RENSTestOptions(options, test_options) (((options) & (test_options)) == (test_options))
#define RENSTestOptionsWithMask(options, test_mask, test_options) (((options) & (test_mask)) == (test_options))
#define RENSGetOptions(options) (options)
#define RENSGetOptionsByMask(options, mask) ((options) & (mask))
#define RENSSetOptions(variable_options, set_options) do { variable_options = (variable_options | (set_options)); } while (0)
#define RENSSetOptionsByMask(variable_options, set_mask, set_options) do { variable_options = ((variable_options & ~(set_mask)) | (set_options)); } while (0)
#define RENSResetOptions(variable_options, reset_options) do { variable_options = (variable_options & ~(reset_options)); } while (0)
#define RENSResetOptionsByMask(variable_options, reset_mask) do { variable_options = (variable_options & ~(reset_mask)); } while (0)

NS_INLINE int CComparisonResultFromNSComparisonResult(NSComparisonResult nsComparisonResult)
{
    int cComparisonResult;
    
    if (nsComparisonResult < NSOrderedSame)
    {
        cComparisonResult = -1;
    }
    
    else if (nsComparisonResult > NSOrderedSame)
    {
        cComparisonResult = 1;
    }
    
    else
    {
        cComparisonResult = 0;
    }
    
    return cComparisonResult;
}

#define MAXS(value0, ...) \
({ \
    __typeof__(value0) __maximum_value = value0; \
    __typeof__(value0) __values[] = {__VA_ARGS__}; \
     \
    size_t __number_of_values = sizeof(__values) / sizeof(value0); \
     \
    for (size_t __index_of_value = 0; __index_of_value < __number_of_values; __index_of_value++)\
    { \
        if (__maximum_value < __values[__index_of_value]) \
        { \
            __maximum_value = __values[__index_of_value]; \
        } \
    } \
     \
    __maximum_value;\
})

#define MINS(value0, ...) \
({ \
    __typeof__(value0) __mininum_value = value0; \
    __typeof__(value0) __values[] = {__VA_ARGS__}; \
     \
    size_t __number_of_values = sizeof(__values) / sizeof(value0); \
     \
    for (size_t __index_of_value = 0; __index_of_value < __number_of_values; __index_of_value++)\
    { \
        if (__mininum_value > __values[__index_of_value]) \
        { \
            __mininum_value = __values[__index_of_value]; \
        } \
    } \
     \
    __mininum_value;\
})
