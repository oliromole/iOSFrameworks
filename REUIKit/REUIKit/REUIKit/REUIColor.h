//
//  REUIColor.h
//  REUIKit
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

// Importing the system headers.
#import <CoreGraphics/CGBase.h>
#import <UIKit/UIColor.h>
#import <UIKit/UIKitDefines.h>

@class NSString;
@class UIColor;

UIKIT_EXTERN NSString *NSStringFromUIColor(UIColor *color);
UIKIT_EXTERN UIColor *UIColorFromNSString(NSString *string);

UIKIT_EXTERN NSString *NSStringFromUIColor255(UIColor *color);
UIKIT_EXTERN UIColor *UIColorFromNSString255(NSString *string);

@interface UIColor (UIColorREUIColor)

// Initializing and Creating a UIColor Object from Component Values

- (UIColor *)initWithWhite255:(CGFloat)white alpha255:(CGFloat)alpha;
+ (UIColor *)colorWithWhite255:(CGFloat)white alpha255:(CGFloat)alpha;

- (UIColor *)initWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue alpha255:(CGFloat)alpha;
+ (UIColor *)colorWithRed255:(CGFloat)red green255:(CGFloat)green blue255:(CGFloat)blue alpha255:(CGFloat)alpha;

- (UIColor *)initWithPatternImageNamed:(NSString *)name;
+ (UIColor *)colorWithPatternImageNamed:(NSString *)name;

// Getting Color Components

/*
 Return the (unpremultiplied) red, green or blue components of the color.
 */
- (CGFloat)red;
- (CGFloat)red255;
- (CGFloat)green;
- (CGFloat)green255;
- (CGFloat)blue;
- (CGFloat)blue255;

/*
 Return the alpha value of the color.
 */
- (CGFloat)alpha;
- (CGFloat)alpha255;

- (void)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;
- (void)red255:(CGFloat *)red255 green255:(CGFloat *)green255 blue255:(CGFloat *)blue255 alpha255:(CGFloat *)alpha255;

@end
