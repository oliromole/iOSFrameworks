//
//  REUILabel.m
//  REUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2011.06.15.
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
#import "REUILabel.h"

// Importing the project headers.
#import "REUIView.h"

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation UILabel (UILabelREUILabel)

#pragma mark - Initializing and Creating a UILabel

+ (id)label
{
    return [self view];
}

+ (id)labelWithFrame:(CGRect)viewFrame
{
    return [self viewWithFrame:viewFrame];
}

#pragma mark - Drawing and Positioning Overrides

- (CGSize)textSize
{
    CGRect bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    bounds.size.width = CGFLOAT_MAX;
    bounds.size.height = CGFLOAT_MAX;
    
    NSInteger numberOfLines = self.numberOfLines;
    
    CGRect textFrame = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return textFrame.size;
}

- (CGSize)textSizeForLimitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    bounds.size.width = CGFLOAT_MAX;
    bounds.size.height = CGFLOAT_MAX;
    
    CGRect textFrame = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return textFrame.size;
}

- (CGSize)textSizeForSize:(CGSize)size
{
    CGRect bounds;
    bounds.origin = CGPointZero;
    bounds.size = size;
    
    NSInteger numberOfLines = self.numberOfLines;
    
    CGRect textFrame = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return textFrame.size;
}

- (CGSize)textSizeForSize:(CGSize)size limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect bounds;
    bounds.origin = CGPointZero;
    bounds.size = size;
    
    CGRect textFrame = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return textFrame.size;
}

- (CGSize)textSizeForForHeight:(CGFloat)height
{
    CGRect bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    bounds.size.width = CGFLOAT_MAX;
    bounds.size.height = height;
    
    NSInteger numberOfLines = self.numberOfLines;
    
    CGRect textFrame = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return textFrame.size;
}

- (CGSize)textSizeForForHeight:(CGFloat)height limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    bounds.size.width = CGFLOAT_MAX;
    bounds.size.height = height;
    
    CGRect textFrame = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return textFrame.size;
}

- (CGSize)textSizeForForWidth:(CGFloat)width
{
    CGRect bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    bounds.size.width = width;
    bounds.size.height = CGFLOAT_MAX;
    
    NSInteger numberOfLines = self.numberOfLines;
    
    CGRect textFrame = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return textFrame.size;
}

- (CGSize)textSizeForForWidth:(CGFloat)width limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    bounds.size.width = width;
    bounds.size.height = CGFLOAT_MAX;
    
    CGRect textFrame = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return textFrame.size;
}

- (CGFloat)textWidthForHeight:(CGFloat)height
{
    CGRect bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    bounds.size.width = CGFLOAT_MAX;
    bounds.size.height = height;
    
    NSInteger numberOfLines = self.numberOfLines;
    
    CGRect textFrame = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return textFrame.size.width;
}

- (CGFloat)textWidthForHeight:(CGFloat)height limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    bounds.size.width = CGFLOAT_MAX;
    bounds.size.height = height;
    
    CGRect textFrame = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return textFrame.size.width;
}

- (CGFloat)textHeightForWidth:(CGFloat)width
{
    CGRect bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    bounds.size.width = width;
    bounds.size.height = CGFLOAT_MAX;
    
    NSInteger numberOfLines = self.numberOfLines;
    
    CGRect textFrame = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return textFrame.size.height;
}

- (CGFloat)textHeightForWidth:(CGFloat)width limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    bounds.size.width = width;
    bounds.size.height = CGFLOAT_MAX;
    
    CGRect textFrame = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return textFrame.size.height;
}

@end
