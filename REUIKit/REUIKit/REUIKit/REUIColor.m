//
//  REUIColor.m
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

// Importing the header.
#import "REUIColor.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NSString *NSStringFromUIColor(UIColor *color)
{
    // Getting the color components.
    CGFloat alpha = color.alpha;
    CGFloat blue = color.blue;
    CGFloat green = color.green;
    CGFloat red = color.red;
    
    // Creating a string which represents the color.
    NSString *string = [[NSString alloc] initWithFormat:@"{%g, %g, %g, %g}", red, green, blue, alpha];
    
    // Returning the string.
    return string;
}

UIColor *UIColorFromNSString(NSString *string)
{
    CGFloat alpha = 0.0f;
    CGFloat blue = 0.0f;
    CGFloat green = 0.0f;
    CGFloat red = 0.0f;
    
    NSMutableString *colorString = [string mutableCopy];
    
    if (colorString)
    {
        NSRange range = [colorString rangeOfString:(@"^"
                                                    @"[^\\[\\{]*"
                                                    @"[\\[\\{]"
                                                    @"[^,\\]\\}]+,"
                                                    @"[^,\\]\\}]+,"
                                                    @"[^,\\]\\}]+,"
                                                    @"[^\\]\\}]+"
                                                    @"[\\]\\}]?")
                                           options:NSRegularExpressionSearch
                                             range:colorString.range];
        
        if (!NSRangeIsNotFound(range))
        {
            [colorString replaceOccurrencesOfString:(@"^"
                                                     @"[^\\[\\{]*"
                                                     @"[\\[\\{]")
                                         withString:@""
                                            options:NSRegularExpressionSearch
                                              range:colorString.range];
            
            NSRange colorComponentsStringRange = [colorString rangeOfString:(@"^"
                                                                             @"[^,\\]\\}]+,"
                                                                             @"[^,\\]\\}]+,"
                                                                             @"[^,\\]\\}]+,"
                                                                             @"[^\\]\\}]+")
                                                                    options:NSRegularExpressionSearch
                                                                      range:colorString.range];
            
            NSCAssert(!NSRangeIsNotFound(colorComponentsStringRange), @"The method has a logical error.");
            
            NSRange deleteRange;
            deleteRange.location = NSMaxRange(colorComponentsStringRange);
            deleteRange.length = colorString.length - deleteRange.location;
            
            [colorString deleteCharactersInRange:deleteRange];
            
            NSArray *colorComponentStrings = [colorString componentsSeparatedByString:@","];
            
            NSCAssert((colorComponentStrings.count == 4), @"The method has a logical error.");
            
            red = [[colorComponentStrings objectAtIndex:0] floatValue];
            green = [[colorComponentStrings objectAtIndex:1] floatValue];
            blue = [[colorComponentStrings objectAtIndex:2] floatValue];
            alpha = [[colorComponentStrings objectAtIndex:3] floatValue];
        }
    }
    
    UIColor *color = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
    
    return color;
}

NSString *NSStringFromUIColor255(UIColor *color)
{
    // Getting the color components.
    CGFloat alpha255 = color.alpha255;
    CGFloat blue255 = color.blue255;
    CGFloat green255 = color.green255;
    CGFloat red255 = color.red255;
    
    // Creating a string which represents the color.
    NSString *string = [[NSString alloc] initWithFormat:@"{%.0g, %.0g, %.0g, %.0g}", red255, green255, blue255, alpha255];
    
    // Returning the string.
    return string;
}

UIColor *UIColorFromNSString255(NSString *string)
{
    CGFloat alpha255 = 0.0f;
    CGFloat blue255 = 0.0f;
    CGFloat green255 = 0.0f;
    CGFloat red255 = 0.0f;
    
    NSMutableString *colorString = [string mutableCopy];
    
    if (colorString)
    {
        NSRange range = [colorString rangeOfString:(@"^"
                                                    @"[^\\[\\{]*"
                                                    @"[\\[\\{]"
                                                    @"[^,\\]\\}]+,"
                                                    @"[^,\\]\\}]+,"
                                                    @"[^,\\]\\}]+,"
                                                    @"[^\\]\\}]+"
                                                    @"[\\]\\}]?")
                                           options:NSRegularExpressionSearch
                                             range:colorString.range];
        
        if (!NSRangeIsNotFound(range))
        {
            [colorString replaceOccurrencesOfString:(@"^"
                                                     @"[^\\[\\{]*"
                                                     @"[\\[\\{]")
                                         withString:@""
                                            options:NSRegularExpressionSearch
                                              range:colorString.range];
            
            NSRange colorComponentsStringRange = [colorString rangeOfString:(@"^"
                                                                             @"[^,\\]\\}]+,"
                                                                             @"[^,\\]\\}]+,"
                                                                             @"[^,\\]\\}]+,"
                                                                             @"[^\\]\\}]+")
                                                                    options:NSRegularExpressionSearch
                                                                      range:colorString.range];
            
            NSCAssert(!NSRangeIsNotFound(colorComponentsStringRange), @"The method has a logical error.");
            
            NSRange deleteRange;
            deleteRange.location = NSMaxRange(colorComponentsStringRange);
            deleteRange.length = colorString.length - deleteRange.location;
            
            [colorString deleteCharactersInRange:deleteRange];
            
            NSArray *colorComponentStrings = [colorString componentsSeparatedByString:@","];
            
            NSCAssert((colorComponentStrings.count == 4), @"The method has a logical error.");
            
            red255 = [[colorComponentStrings objectAtIndex:0] floatValue];
            green255 = [[colorComponentStrings objectAtIndex:1] floatValue];
            blue255 = [[colorComponentStrings objectAtIndex:2] floatValue];
            alpha255 = [[colorComponentStrings objectAtIndex:3] floatValue];
        }
    }
    
    UIColor *color = [[UIColor alloc] initWithRed255:red255 green255:green255 blue255:blue255 alpha255:alpha255];
    
    return color;
}

@implementation UIColor (UIColorREUIColor)

#pragma mark - Initializing and Creating a UIColor Object from Component Values

- (UIColor *)initWithWhite255:(CGFloat)white255 alpha255:(CGFloat)alpha255
{
    CGFloat white = white255 / 255.0f;
    CGFloat alpha = alpha255 / 255.0f;
    
    if ((self = [self initWithWhite:white alpha:alpha]))
    {
    }
    
    return self;
}

+ (UIColor *)colorWithWhite255:(CGFloat)white255 alpha255:(CGFloat)alpha255
{
    return [[self alloc] initWithWhite255:white255 alpha255:alpha255];
}

- (UIColor *)initWithRed255:(CGFloat)red255 green255:(CGFloat)green255 blue255:(CGFloat)blue255 alpha255:(CGFloat)alpha255
{
    CGFloat red = red255 / 255.0f;
    CGFloat green = green255 / 255.0f;
    CGFloat blue = blue255 / 255.0f;
    CGFloat alpha = alpha255 / 255.0f;
    
    if ((self = [self initWithRed:red green:green blue:blue alpha:alpha]))
    {
    }
    
    return self;
}

+ (UIColor *)colorWithRed255:(CGFloat)red255 green255:(CGFloat)green255 blue255:(CGFloat)blue255 alpha255:(CGFloat)alpha255
{
    return [[self alloc] initWithRed255:red255 green255:green255 blue255:blue255 alpha255:alpha255];
}

- (UIColor *)initWithPatternImageNamed:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    if (!image)
    {
        goto jmp_error;
    }
    
    self = [self initWithPatternImage:image];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (UIColor *)colorWithPatternImageNamed:(NSString *)name
{
    return [[self alloc] initWithPatternImageNamed:name];
}

#pragma mark - Getting Color Components

- (CGFloat)red
{
    CGFloat red = 0.0f;
    
    CGColorRef cgColor = self.CGColor;
    
    if (cgColor)
    {
        size_t numberOfComponents = CGColorGetNumberOfComponents(cgColor);
        
        if (numberOfComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents(cgColor);
            
            if (components)
            {
                red = components[0];
            }
        }
        
        else
        {
            Class ciColorClass = NSClassFromString(@"CIColor");
            
            if (ciColorClass)
            {
                id ciColor = [[ciColorClass alloc] initWithCGColor:cgColor];
                
                if (ciColor)
                {
                    red = [ciColor red];
                }
            }
        }
    }
    
    else
    {
        @try
        {
            CIColor *ciColor = self.CIColor;
            
            if (ciColor)
            {
                red = ciColor.red;
            }
        }
        
        @catch (NSException *exception)
        {
        }
    }
    
    return red;
}

- (CGFloat)red255
{
    CGFloat red255 = self.red * 255.0f;
    
    return red255;
}

- (CGFloat)green
{
    CGFloat green = 0.0f;
    
    CGColorRef cgColor = self.CGColor;
    
    if (cgColor)
    {
        size_t numberOfComponents = CGColorGetNumberOfComponents(cgColor);
        
        if (numberOfComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents(cgColor);
            
            if (components)
            {
                green = components[1];
            }
        }
        
        else
        {
            Class ciColorClass = NSClassFromString(@"CIColor");
            
            if (ciColorClass)
            {
                id ciColor = [[ciColorClass alloc] initWithCGColor:cgColor];
                
                if (ciColor)
                {
                    green = [ciColor green];
                }
            }
        }
    }
    
    else
    {
        @try
        {
            id ciColor = self.CIColor;
            
            if (ciColor)
            {
                green = [ciColor green];
            }
        }
        
        @catch (NSException *exception)
        {
        }
    }
    
    return green;
}

- (CGFloat)green255
{
    CGFloat green255 = self.green * 255.0f;
    
    return green255;
}

- (CGFloat)blue
{
    CGFloat blue = 0.0f;
    
    CGColorRef cgColor = self.CGColor;
    
    if (cgColor)
    {
        size_t numberOfComponents = CGColorGetNumberOfComponents(cgColor);
        
        if (numberOfComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents(cgColor);
            
            if (components)
            {
                blue = components[2];
            }
        }
        
        else
        {
            Class ciColorClass = NSClassFromString(@"CIColor");
            
            if (ciColorClass)
            {
                id ciColor = [[ciColorClass alloc] initWithCGColor:cgColor];
                
                if (ciColor)
                {
                    blue = [ciColor blue];
                }
            }
        }
        
    }
    
    else
    {
        @try
        {
            id ciColor = self.CIColor;
            
            if (ciColor)
            {
                blue = [ciColor blue];
            }
        }
        
        @catch (NSException *exception)
        {
        }
    }
    
    return blue;
}

- (CGFloat)blue255
{
    CGFloat blue255 = self.blue * 255.0f;
    
    return blue255;
}

- (CGFloat)alpha
{
    CGFloat alpha = 1.0f;
    
    CGColorRef cgColor = self.CGColor;
    
    if (cgColor)
    {
        size_t numberOfComponents = CGColorGetNumberOfComponents(cgColor);
        
        if (numberOfComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents(cgColor);
            
            if (components)
            {
                alpha = components[3];
            }
        }
        
        else
        {
            Class ciColorClass = NSClassFromString(@"CIColor");
            
            if (ciColorClass)
            {
                id ciColor = [[ciColorClass alloc] initWithCGColor:cgColor];
                
                if (ciColor)
                {
                    alpha = [ciColor alpha];
                }
            }
        }
        
    }
    
    else
    {
        @try
        {
            id ciColor = self.CIColor;
            
            if (ciColor)
            {
                alpha = [ciColor alpha];
            }
        }
        
        @catch (NSException *exception)
        {
        }
    }
    
    return alpha;
}

- (CGFloat)alpha255
{
    CGFloat alpha255 = self.alpha * 255.0f;
    
    return alpha255;
}

- (void)red:(CGFloat *)pRed green:(CGFloat *)pGreen blue:(CGFloat *)pBlue alpha:(CGFloat *)pAlpha
{
    CGFloat alpha = 1.0f;
    CGFloat blue = 0.0f;
    CGFloat green = 0.0f;
    CGFloat red = 0.0f;
    
    CGColorRef cgColor = self.CGColor;
    
    if (cgColor)
    {
        size_t numberOfComponents = CGColorGetNumberOfComponents(cgColor);
        
        if (numberOfComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents(cgColor);
            
            if (components)
            {
                alpha = components[3];
                blue = components[2];
                green = components[1];
                red = components[0];
            }
        }
        
        else
        {
            Class ciColorClass = NSClassFromString(@"CIColor");
            
            if (ciColorClass)
            {
                id ciColor = [[ciColorClass alloc] initWithCGColor:cgColor];
                
                if (ciColor)
                {
                    alpha = [ciColor alpha];
                    blue = [ciColor blue];
                    green = [ciColor green];
                    red = [ciColor red];
                }
            }
        }
        
    }
    
    else
    {
        @try
        {
            id ciColor = self.CIColor;
            
            if (ciColor)
            {
                alpha = [ciColor alpha];
                blue = [ciColor blue];
                green = [ciColor green];
                red = [ciColor red];
            }
        }
        
        @catch (NSException *exception)
        {
        }
    }
    
    if (pAlpha)
    {
        *pAlpha = alpha;
    }
    
    if (pBlue)
    {
        *pBlue = blue;
    }
    
    if (pGreen)
    {
        *pGreen = green;
    }
    
    if (pRed)
    {
        *pRed = red;
    }
}

- (void)red255:(CGFloat *)pRed255 green255:(CGFloat *)pGreen255 blue255:(CGFloat *)pBlue255 alpha255:(CGFloat *)pAlpha255
{
    CGFloat alpha = 1.0f;
    CGFloat blue = 0.0f;
    CGFloat green = 0.0f;
    CGFloat red = 0.0f;
    
    [self red:&red green:&green blue:&blue alpha:&alpha];
    
    if (pAlpha255)
    {
        *pAlpha255 = alpha * 255.0f;
    }
    
    if (pBlue255)
    {
        *pBlue255 = blue * 255.0f;
    }
    
    if (pGreen255)
    {
        *pGreen255 = green * 255.0f;
    }
    
    if (pRed255)
    {
        *pRed255 = red * 255.0f;
    }
}

@end
