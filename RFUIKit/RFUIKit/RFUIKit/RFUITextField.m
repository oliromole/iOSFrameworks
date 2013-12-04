//
//  RFUITextField.m
//  RFUIKit
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

// Importing the header.
#import "RFUITextField.h"

// Importing the external headers.
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@implementation RFUITextField

#pragma mark - Initializing and Creating a RFUITextField

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        mPlaceholderColor = nil;
        
        mPlaceholderFont = nil;
    }
    
    return self;
}

#pragma mark - Deallocating a RFUITextField

- (void)dealloc
{
    mPlaceholderColor = nil;
    
    mPlaceholderFont = nil;
}

#pragma mark - Accessing the Text Attributes

- (UIColor *)placeholderColor
{
    return mPlaceholderColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    if (mPlaceholderColor != placeholderColor)
    {
        mPlaceholderColor = placeholderColor;
        
        [self setNeedsDisplay];
    }
}

- (UIFont *)placeholderFont
{
    return mPlaceholderFont;
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    if (mPlaceholderFont != placeholderFont)
    {
        mPlaceholderFont = placeholderFont;
        
        [self setNeedsDisplay];
    }
}

#pragma mark - Drawing and Positioning Overrides

- (void)drawPlaceholderInRect:(CGRect)rect
{
    if (mPlaceholderColor || mPlaceholderFont)
    {
        CGRect viewFrame = self.frame;
        
        CGRect drawRect;
        drawRect.origin = CGPointZero;
        drawRect.size = viewFrame.size;
        
        UIFont *font = mPlaceholderFont;
        
        if (!font)
        {
            font = self.font;
        }
        
        if (!font)
        {
            font = [UIFont fontWithName:@"Helvetica" size:17.0f];
        }
        
        NSLineBreakMode lineBreakMode = NSLineBreakByCharWrapping;
        
        NSTextAlignment textAlignment = self.textAlignment;
        
        UIColor *color = mPlaceholderColor;
        
        if (!color)
        {
            color = [UIColor lightGrayColor];
        }
        
        [color setFill];
        
        [self.placeholder drawInRect:drawRect withFont:font lineBreakMode:lineBreakMode alignment:textAlignment];
    }
    
    else
    {
        [super drawPlaceholderInRect:rect];
    }
}

@end
