//
//  REUIButton.m
//  REUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.12.25.
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
#import "REUIButton.h"

// Importing the system headers.
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation UIButton (UIButtonREUIButton)

#pragma mark - Configuring the Button Title

#pragma mark Attributed Title

- (NSAttributedString *)disabledAttributedTitle
{
    NSAttributedString *disabledAttributedTitle = [self attributedTitleForState:UIControlStateDisabled];
    return disabledAttributedTitle;
}

- (void)setDisabledAttributedTitle:(NSAttributedString *)disabledAttributedTitle
{
    [self setAttributedTitle:disabledAttributedTitle forState:UIControlStateDisabled];
}

- (NSAttributedString *)highlightedAttributedTitle
{
    NSAttributedString *highlightedAttributedTitle = [self attributedTitleForState:UIControlStateHighlighted];
    return highlightedAttributedTitle;
}

- (void)setHighlightedAttributedTitle:(NSAttributedString *)highlightedAttributedTitle
{
    [self setAttributedTitle:highlightedAttributedTitle forState:UIControlStateHighlighted];
}

- (NSAttributedString *)normalAttributedTitle
{
    NSAttributedString *normalAttributedTitle = [self attributedTitleForState:UIControlStateNormal];
    return normalAttributedTitle;
}

- (void)setNormalAttributedTitle:(NSAttributedString *)normalAttributedTitle
{
    [self setAttributedTitle:normalAttributedTitle forState:UIControlStateNormal];
}

- (NSAttributedString *)selectedAttributedTitle
{
    NSAttributedString *selectedAttributedTitle = [self attributedTitleForState:UIControlStateSelected];
    return selectedAttributedTitle;
}

- (void)setSelectedAttributedTitle:(NSAttributedString *)selectedAttributedTitle
{
    [self setAttributedTitle:selectedAttributedTitle forState:UIControlStateSelected];
}

#pragma mark Title

- (NSString *)disabledTitle
{
    NSString *disabledTitle = [self titleForState:UIControlStateDisabled];
    return disabledTitle;
}

- (void)setDisabledTitle:(NSString *)disabledTitle
{
    [self setTitle:disabledTitle forState:UIControlStateDisabled];
}

- (NSString *)highlightedTitle
{
    NSString *highlightedTitle = [self titleForState:UIControlStateHighlighted];
    return highlightedTitle;
}

- (void)setHighlightedTitle:(NSString *)highlightedTitle
{
    [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
}

- (NSString *)normalTitle
{
    NSString *normalTitle = [self titleForState:UIControlStateNormal];
    return normalTitle;
}

- (void)setNormalTitle:(NSString *)normalTitle
{
    [self setTitle:normalTitle forState:UIControlStateNormal];
}

- (NSString *)selectedTitle
{
    NSString *selectedTitle = [self titleForState:UIControlStateSelected];
    return selectedTitle;
}

- (void)setSelectedTitle:(NSString *)selectedTitle
{
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

#pragma mark Title Color

- (UIColor *)disabledTitleColor
{
    UIColor *disabledTitleColor = [self titleColorForState:UIControlStateDisabled];
    return disabledTitleColor;
}

- (void)setDisabledTitleColor:(UIColor *)disabledTitleColor
{
    [self setTitleColor:disabledTitleColor forState:UIControlStateDisabled];
}

- (UIColor *)highlightedTitleColor
{
    UIColor *highlightedTitleColor = [self titleColorForState:UIControlStateHighlighted];
    return highlightedTitleColor;
}

- (void)setHighlightedTitleColor:(UIColor *)highlightedTitleColor
{
    [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIColor *)normalTitleColor
{
    UIColor *normalTitleColor = [self titleColorForState:UIControlStateNormal];
    return normalTitleColor;
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor
{
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
}

- (UIColor *)selectedTitleColor
{
    UIColor *selectedTitleColor = [self titleColorForState:UIControlStateSelected];
    return selectedTitleColor;
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}

#pragma mark Title Shadow Color

- (UIColor *)disabledTitleShadowColor
{
    UIColor *disabledTitleShadowColor = [self titleShadowColorForState:UIControlStateDisabled];
    return disabledTitleShadowColor;
}

- (void)setDisabledTitleShadowColor:(UIColor *)disabledTitleShadowColor
{
    [self setTitleShadowColor:disabledTitleShadowColor forState:UIControlStateDisabled];
}

- (UIColor *)highlightedTitleShadowColor
{
    UIColor *highlightedTitleShadowColor = [self titleShadowColorForState:UIControlStateHighlighted];
    return highlightedTitleShadowColor;
}

- (void)setHighlightedTitleShadowColor:(UIColor *)highlightedTitleShadowColor
{
    [self setTitleShadowColor:highlightedTitleShadowColor forState:UIControlStateHighlighted];
}

- (UIColor *)normalTitleShadowColor
{
    UIColor *normalTitleShadowColor = [self titleShadowColorForState:UIControlStateNormal];
    return normalTitleShadowColor;
}

- (void)setNormalTitleShadowColor:(UIColor *)normalTitleShadowColor
{
    [self setTitleShadowColor:normalTitleShadowColor forState:UIControlStateNormal];
}

- (UIColor *)selectedTitleShadowColor
{
    UIColor *selectedTitleShadowColor = [self titleShadowColorForState:UIControlStateSelected];
    return selectedTitleShadowColor;
}

- (void)setSelectedTitleShadowColor:(UIColor *)selectedTitleShadowColor
{
    [self setTitleShadowColor:selectedTitleShadowColor forState:UIControlStateSelected];
}

#pragma mark - Configuring Button Presentation

#pragma mark Background Image

- (UIImage *)disabledBackgroundImage
{
    UIImage *disabledBackgroundImage = [self backgroundImageForState:UIControlStateDisabled];
    return disabledBackgroundImage;
}

- (void)setDisabledBackgroundImage:(UIImage *)disabledBackgroundImage
{
    [self setBackgroundImage:disabledBackgroundImage forState:UIControlStateDisabled];
}

- (UIImage *)highlightedBackgroundImage
{
    UIImage *highlightedBackgroundImage = [self backgroundImageForState:UIControlStateHighlighted];
    return highlightedBackgroundImage;
}

- (void)setHighlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
{
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
}

- (UIImage *)normalBackgroundImage
{
    UIImage *normalBackgroundImage = [self backgroundImageForState:UIControlStateNormal];
    return normalBackgroundImage;
}

- (void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage
{
    [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
}

- (UIImage *)selectedBackgroundImage
{
    UIImage *selectedBackgroundImage = [self backgroundImageForState:UIControlStateSelected];
    return selectedBackgroundImage;
}

- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage
{
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
}

#pragma mark Image

- (UIImage *)disabledImage
{
    UIImage *disabledImage = [self imageForState:UIControlStateDisabled];
    return disabledImage;
}

- (void)setDisabledImage:(UIImage *)disabledImage
{
    [self setImage:disabledImage forState:UIControlStateDisabled];
}

- (UIImage *)highlightedImage
{
    UIImage *highlightedImage = [self imageForState:UIControlStateHighlighted];
    return highlightedImage;
}

- (void)setHighlightedImage:(UIImage *)highlightedImage
{
    [self setImage:highlightedImage forState:UIControlStateHighlighted];
}

- (UIImage *)normalImage
{
    UIImage *normalImage = [self imageForState:UIControlStateNormal];
    return normalImage;
}

- (void)setNormalImage:(UIImage *)normalImage
{
    [self setImage:normalImage forState:UIControlStateNormal];
}

- (UIImage *)selectedImage
{
    UIImage *selectedImage = [self imageForState:UIControlStateSelected];
    return selectedImage;
}

- (void)setSelectedImage:(UIImage *)selectedImage
{
    [self setImage:selectedImage forState:UIControlStateSelected];
}

@end
