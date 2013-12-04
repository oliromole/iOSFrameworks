//
//  RFUIScrollLabel.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.08.05.
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
#import "RFUIScrollLabel.h"

// Importing the external headers.
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUIScrollLabel

#pragma mark - Initializing and Creating a RFUIScrollLabel

+ (id)scrollLabel
{
    return [self view];
}

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        mLabel = nil;
        mLabelInset = UIEdgeInsetsZero;
        
        mUserInteractionAutomatic = NO;
        
        self.alwaysBounceHorizontal = NO;
        self.alwaysBounceVertical = YES;
        self.bounces = YES;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

+ (id)scrollLabelWithFrame:(CGRect)viewFrame
{
    return [self scrollViewWithFrame:viewFrame];
}

#pragma mark - Deallocating a RFUIScrollLabel

- (void)dealloc
{
    mLabel = nil;
}

#pragma mark - Laying out Subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect viewFrame = self.frame;
    
    CGSize contentSize = CGSizeZero;
    
    if (mLabel)
    {
        BOOL alwaysBounceHorizontal = self.alwaysBounceHorizontal;
        BOOL alwaysBounceVertical = self.alwaysBounceVertical;
        
        CGSize labelContentSize;
        labelContentSize.width = (alwaysBounceHorizontal ? CGFLOAT_MAX : viewFrame.size.width);
        labelContentSize.height = (alwaysBounceVertical ? CGFLOAT_MAX : viewFrame.size.height);
        labelContentSize = UIEdgeInsetsInsetSize(labelContentSize, mLabelInset);
        
        CGSize labeTextSize;
        labeTextSize = [mLabel textSizeForSize:labelContentSize];
        
        CGRect labeFrame;
        labeFrame.origin.x = mLabelInset.left;
        labeFrame.origin.y = mLabelInset.top;
        labeFrame.size.width = MAX(labeTextSize.width, (viewFrame.size.width - mLabelInset.left - mLabelInset.right));
        labeFrame.size.height = MAX(labeTextSize.height, (viewFrame.size.height - mLabelInset.top - mLabelInset.bottom));
        
        contentSize.width = labeFrame.size.width + mLabelInset.left + mLabelInset.right;
        contentSize.height = labeFrame.size.height + mLabelInset.top + mLabelInset.bottom;
        
        [mLabel setFrameIfNeeded:labeFrame];
    }
    
    [self setContentSizeIfNeeded:contentSize];
    
    if (mUserInteractionAutomatic)
    {
        CGSize visibleContentSize = viewFrame.size;
        
        if ((contentSize.width > visibleContentSize.width) ||
            (contentSize.height > visibleContentSize.height))
        {
            self.userInteractionEnabled = YES;
        }
        
        else
        {
            self.userInteractionEnabled = NO;
        }
    }
}

#pragma mark - Managing the UIScrollView Object

- (UILabel *)label
{
    if (!mLabel)
    {
        CGRect viewFrame = self.frame;
        
        CGRect labelFrame;
        labelFrame.origin = CGPointZero;
        labelFrame.size = viewFrame.size;
        
        mLabel = [[UILabel alloc] initWithFrame:labelFrame];
        mLabel.numberOfLines = 0;
        
        [self addSubview:mLabel];
        [self setNeedsLayout];
    }
    
    return mLabel;
}

- (void)setLabel:(UILabel *)label
{
    if (mLabel != label)
    {
        if (mLabel)
        {
            [mLabel removeFromSuperview];
        }
        
        mLabel = label;
        
        if (mLabel)
        {
            [self addSubview:mLabel];
        }
        
        [self setNeedsLayout];
    }
}

- (UIEdgeInsets)labelInset
{
    return mLabelInset;
}

- (void)setLabelInset:(UIEdgeInsets)labelInset
{
    if (!UIEdgeInsetsEqualToEdgeInsets(mLabelInset, labelInset))
    {
        mLabelInset = labelInset;
        
        [self setNeedsLayout];
    }
}

- (void)setLabelInsetIfNeeded:(UIEdgeInsets)newLabelInset
{
    UIEdgeInsets oldLabelInset = self.labelInset;
    
    if (!UIEdgeInsetsEqualToEdgeInsets(oldLabelInset, newLabelInset))
    {
        self.labelInset = newLabelInset;
    }
}

#pragma mark - Configuring the Event-Related Behavior

- (BOOL)userInteractionAutomatic
{
    return mUserInteractionAutomatic;
}

- (void)setUserInteractionAutomatic:(BOOL)userInteractionAutomatic
{
    if (mUserInteractionAutomatic != userInteractionAutomatic)
    {
        mUserInteractionAutomatic = userInteractionAutomatic;
        
        [self setNeedsLayout];
    }
}

@end
