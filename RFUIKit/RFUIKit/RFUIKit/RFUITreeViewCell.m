//
//  RFUITreeViewCell.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.08.01.
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
#import "RFUITreeViewCell.h"

// Importing the project headers.
#import "RFUITreeView.h"

// Importing the external headers.
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUITreeViewCell

#pragma mark - Initializing and Creating a RFUITreeViewCell

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        mBackgroundView = nil;
        
        mContentView = nil;
        
        mIndentationLevel = 0;
        
        mIndentationWidth = 10.0f;
        
        mReuseIdentifier = nil;
        
        mTreeView = nil;
    }
    
    return self;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)]))
    {
        mReuseIdentifier = [reuseIdentifier copy];
    }
    
    return self;
}

+ (id)treeViewCellWithReuseIdentifier:(NSString *)reuseIdentifier
{
    return [[self alloc] initWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - Deallocating a RFUITreeViewCell

- (void)dealloc
{
    mBackgroundView = nil;
    
    mContentView = nil;
    
    mReuseIdentifier = nil;
    
    mTreeView = nil;
}

#pragma mark - Laying out Subview

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect viewFrame = self.frame;
    
    CGRect backgroundViewFrame;
    CGRect contentViewFrame;
    
    backgroundViewFrame.origin = CGPointZero;
    backgroundViewFrame.size = viewFrame.size;
    
    contentViewFrame.origin = CGPointZero;
    contentViewFrame.size = viewFrame.size;
    
    if (mBackgroundView)
    {
        [mBackgroundView setFrameIfNeeded:backgroundViewFrame];
    }
    
    if (mContentView)
    {
        [mContentView setFrameIfNeeded:contentViewFrame];
    }
}

#pragma mark - Managing the RFUITreeView

@synthesize treeView = mTreeView;

#pragma mark - Accessing Views of the Cell Object

- (UIView *)backgroundView
{
    if (!mBackgroundView)
    {
        CGRect viewFrame = self.frame;
        
        CGRect backgroundViewFrame;
        
        backgroundViewFrame.origin = CGPointZero;
        backgroundViewFrame.size = viewFrame.size;
        
        mBackgroundView = [[UIView alloc] initWithFrame:backgroundViewFrame];
        mBackgroundView.userInteractionEnabled = NO;
        
        if (mBackgroundView)
        {
            [self insertSubview:mBackgroundView atIndex:0];
        }
    }
    
    return mBackgroundView;
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (mBackgroundView != backgroundView)
    {
        if (mBackgroundView)
        {
            [mBackgroundView removeFromSuperview];
        }
        
        mBackgroundView = backgroundView;
        
        if (mBackgroundView)
        {
            [self insertSubview:mBackgroundView atIndex:0];
        }
    }
}

- (UIView *)contentView
{
    if (!mContentView)
    {
        CGRect viewFrame = self.frame;
        
        CGRect contentViewFrame;
        
        contentViewFrame.origin = CGPointZero;
        contentViewFrame.size = viewFrame.size;
        
        mContentView = [[UIView alloc] initWithFrame:contentViewFrame];
        
        if (mContentView)
        {
            [self addSubview:mContentView];
        }
    }
    
    return mContentView;
}

- (void)setContentView:(UIView *)contentView
{
    if (mContentView != contentView)
    {
        if (mContentView)
        {
            [mContentView removeFromSuperview];
        }
        
        mContentView = contentView;
        
        if (mContentView)
        {
            [self addSubview:mContentView];
        }
    }
}

#pragma mark - Reusing Cells

@synthesize reuseIdentifier = mReuseIdentifier;

- (void)prepareForReuse
{
    mIndentationLevel = 0;
}

#pragma mark - Managing Content Indentation

@synthesize indentationLevel = mIndentationLevel;

@synthesize indentationWidth = mIndentationWidth;

@end
