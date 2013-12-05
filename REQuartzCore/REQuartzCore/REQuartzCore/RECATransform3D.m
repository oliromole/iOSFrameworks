//
//  RECATransform3D.h
//  REQuartzCore
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.06.26.
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
#import "RECATransform3D.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

NSString *NSStringFromCATransform3D(CATransform3D transform3D)
{
    NSString *string = [NSString stringWithFormat:(@"["
                                                   @"%g, %g, %g, %g, "
                                                   @"%g, %g, %g, %g, "
                                                   @"%g, %g, %g, %g, "
                                                   @"%g, %g, %g, %g"
                                                   @"]"),
                        transform3D.m11, transform3D.m12, transform3D.m13, transform3D.m14,
                        transform3D.m21, transform3D.m22, transform3D.m23, transform3D.m24,
                        transform3D.m31, transform3D.m32, transform3D.m33, transform3D.m34,
                        transform3D.m41, transform3D.m42, transform3D.m43, transform3D.m44];
    
    return string;
}

CATransform3D CATransform3DFromNSString(NSString *string)
{
    CATransform3D transform3D = CATransform3DIdentity;
    
    NSMutableString *transform3DString = [string mutableCopy];
    
    if (transform3DString)
    {
        NSRange range = [transform3DString rangeOfString:(@"^"
                                                          @"[^\\[\\{]*"
                                                          @"[\\[\\{]"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^,\\]\\}]+,"
                                                          @"[^\\]\\}]+"
                                                          @"[\\]\\}]?")
                                                 options:NSRegularExpressionSearch range:transform3DString.range];
        
        if (!NSRangeIsNotFound(range))
        {
            [transform3DString replaceOccurrencesOfString:(@"^"
                                                           @"[^\\[\\{]*"
                                                           @"[\\[\\{]")
                                               withString:@""
                                                  options:NSRegularExpressionSearch
                                                    range:transform3DString.range];
            
            NSRange transform3DComponentsStringRange = [transform3DString rangeOfString:(@"^"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^,\\]\\}]+,"
                                                                                         @"[^\\]\\}]+")
                                                                                options:NSRegularExpressionSearch range:transform3DString.range];
            
            NSCAssert(!NSRangeIsNotFound(transform3DComponentsStringRange), @"The method has a logical error.");
            
            NSRange deleteRange;
            deleteRange.location = NSMaxRange(transform3DComponentsStringRange);
            deleteRange.length = transform3DString.length - deleteRange.location;
            
            [transform3DString deleteCharactersInRange:deleteRange];
            
            NSArray *transform3DComponentStrings = [transform3DString componentsSeparatedByString:@","];
            
            NSCAssert((transform3DComponentStrings.count == 16), @"The method has a logical error.");
            
            transform3D.m11 = [transform3DComponentStrings[0] floatValue];
            transform3D.m12 = [transform3DComponentStrings[1] floatValue];
            transform3D.m13 = [transform3DComponentStrings[2] floatValue];
            transform3D.m14 = [transform3DComponentStrings[3] floatValue];
            transform3D.m21 = [transform3DComponentStrings[4] floatValue];
            transform3D.m22 = [transform3DComponentStrings[5] floatValue];
            transform3D.m23 = [transform3DComponentStrings[6] floatValue];
            transform3D.m24 = [transform3DComponentStrings[7] floatValue];
            transform3D.m31 = [transform3DComponentStrings[8] floatValue];
            transform3D.m32 = [transform3DComponentStrings[9] floatValue];
            transform3D.m33 = [transform3DComponentStrings[10] floatValue];
            transform3D.m34 = [transform3DComponentStrings[11] floatValue];
            transform3D.m41 = [transform3DComponentStrings[12] floatValue];
            transform3D.m42 = [transform3DComponentStrings[13] floatValue];
            transform3D.m43 = [transform3DComponentStrings[14] floatValue];
            transform3D.m44 = [transform3DComponentStrings[15] floatValue];
        }
    }
    
    return transform3D;
}
