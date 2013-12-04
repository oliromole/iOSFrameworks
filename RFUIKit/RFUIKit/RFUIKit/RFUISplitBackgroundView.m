//
//  RFUISplitBackgroundView.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2011.12.05.
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
#import "RFUISplitBackgroundView.h"

// Importing the external headers.
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@implementation RFUISplitBackgroundView

#pragma mark - Initializing and Creating a RFUISplitBackgroundView

- (id)init
{
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
}

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        mWidth0 = 10.0f;
        mWidth2 = 10.0f;
        
        mHeight0 = 10.0f;
        mHeight2 = 10.0f;
        
        mView00 = nil;
        mView01 = nil;
        mView02 = nil;
        
        mView10 = nil;
        mView11 = nil;
        mView12 = nil;
        
        mView20 = nil;
        mView21 = nil;
        mView22 = nil;
        
        self.userInteractionEnabled = NO;
    }
    
    return self;
}

#pragma mark - Deallocating a RFUISplitBackgroundView

- (void)dealloc
{
    mView00 = nil;
    
    mView01 = nil;
    
    mView02 = nil;
    
    mView10 = nil;
    
    mView11 = nil;
    
    mView12 = nil;
    
    mView20 = nil;
    
    mView21 = nil;
    
    mView22 = nil;
}

#pragma mark - Laying out Subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect viewFrame = self.frame;
    
    CGFloat width0;
    CGFloat width1;
    CGFloat width2;
    
    if ((mWidth0 + mWidth2) <= viewFrame.size.width)
    {
        width0 = mWidth0;
        width1 = viewFrame.size.width - (mWidth0 + mWidth2);
        width2 = mWidth2;
    }
    
    else
    {
        width0 = truncf(mWidth0 * (viewFrame.size.width / (mWidth0 + mWidth2)));
        width1 = 0.0f;
        width2 = viewFrame.size.width - width0;
    }
    
    CGFloat height0;
    CGFloat height1;
    CGFloat height2;
    
    if ((mHeight0 + mHeight2) <= viewFrame.size.height)
    {
        height0 = mHeight0;
        height1 = viewFrame.size.height - (mHeight0 + mHeight2);
        height2 = mHeight2;
    }
    
    else
    {
        height0 = truncf(mHeight0 * (viewFrame.size.height / (mHeight0 + mHeight2)));
        height1 = 0.0f;
        height2 = viewFrame.size.height - height0;
    }
    
    [mView00 setFrameIfNeeded:CGRectMake(0.0f, 0.0f, width0, height0)];
    [mView01 setFrameIfNeeded:CGRectMake(width0, 0.0f, width1, height0)];
    [mView02 setFrameIfNeeded:CGRectMake(width0 + width1, 0.0f, width2, height0)];
    
    [mView10 setFrameIfNeeded:CGRectMake(0.0f, height0, width0, height1)];
    [mView11 setFrameIfNeeded:CGRectMake(width0, height0, width1, height1)];
    [mView12 setFrameIfNeeded:CGRectMake(width0 + width1, height0, width2, height1)];
    
    [mView20 setFrameIfNeeded:CGRectMake(0.0f, height0 + height1, width0, height2)];
    [mView21 setFrameIfNeeded:CGRectMake(width0, height0 + height1, width1, height2)];
    [mView22 setFrameIfNeeded:CGRectMake(width0 + width1, height0 + height1, width2, height2)];
}

#pragma mark - Configuring the RFUISplitBackgroundView

- (CGFloat)height0
{
    return mHeight0;
}

- (void)setHeight0:(CGFloat)height0
{
    if (mHeight0 != height0)
    {
        mHeight0 = height0;
        
        [self setNeedsLayout];
    }
}

- (CGFloat)height2
{
    return mHeight2;
}

- (void)setHeight2:(CGFloat)height2
{
    if (mHeight2 != height2)
    {
        mHeight2 = height2;
        
        [self setNeedsLayout];
    }
}

- (CGFloat)width0
{
    return mWidth0;
}

- (void)setWidth0:(CGFloat)width0
{
    if (mWidth0 != width0)
    {
        mWidth0 = width0;
        
        [self setNeedsLayout];
    }
}

- (CGFloat)width2
{
    return mWidth2;
}

- (void)setWidth2:(CGFloat)width2
{
    if (mWidth2 != width2)
    {
        mWidth2 = width2;
        
        [self setNeedsLayout];
    }
}

#pragma mark - Managing the Content

- (UIView *)view00
{
    if (!mView00)
    {
        CGRect view00Frame;
        view00Frame.origin.x = 0.0f;
        view00Frame.origin.y = 0.0f;
        view00Frame.size.width = mWidth0;
        view00Frame.size.height = mHeight0;
        
        mView00 = [[UIView alloc] initWithFrame:view00Frame];
        
        [self addSubview:mView00];
        
        [self setNeedsLayout];
    }
    
    return mView00;
}

- (void)setView00:(UIView *)view00
{
    if (mView00 != view00)
    {
        [mView00 removeFromSuperview];
        
        mView00 = view00;
        
        [self addSubview:mView00];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view01
{
    if (!mView01)
    {
        CGRect viewFrame = self.frame;
        
        CGRect view01Frame;
        view01Frame.origin.x = mWidth0;
        view01Frame.origin.y = 0.0f;
        view01Frame.size.width = viewFrame.size.width - mWidth0 - mWidth2;
        view01Frame.size.height = mHeight0;
        
        mView01 = [[UIView alloc] initWithFrame:view01Frame];
        
        [self addSubview:mView01];
        
        [self setNeedsLayout];
    }
    
    return mView01;
}

- (void)setView01:(UIView *)view01
{
    if (mView01 != view01)
    {
        [mView01 removeFromSuperview];
        
        mView01 = view01;
        
        [self addSubview:mView01];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view02
{
    if (!mView02)
    {
        CGRect viewFrame = self.frame;
        
        CGRect view02Frame;
        view02Frame.origin.x = viewFrame.size.width - mWidth2;
        view02Frame.origin.y = 0.0f;
        view02Frame.size.width = mWidth2;
        view02Frame.size.height = mHeight0;
        
        mView02 = [[UIView alloc] initWithFrame:view02Frame];
        
        [self addSubview:mView02];
        
        [self setNeedsLayout];
    }
    
    return mView02;
}

- (void)setView02:(UIView *)view02
{
    if (mView02 != view02)
    {
        [mView02 removeFromSuperview];
        
        mView02 = view02;
        
        [self addSubview:mView02];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view10
{
    if (!mView10)
    {
        CGRect viewFrame = self.frame;
        
        CGRect view10Frame;
        view10Frame.origin.x = 0.0f;
        view10Frame.origin.y = mHeight0;
        view10Frame.size.width = mWidth0;
        view10Frame.size.height = viewFrame.size.height - mHeight0 - mHeight2;
        
        mView10 = [[UIView alloc] initWithFrame:view10Frame];
        
        [self addSubview:mView10];
        
        [self setNeedsLayout];
    }
    
    return mView10;
}

- (void)setView10:(UIView *)view10
{
    if (mView10 != view10)
    {
        [mView10 removeFromSuperview];
        
        mView10 = view10;
        
        [self addSubview:mView10];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view11
{
    if (!mView11)
    {
        CGRect viewFrame = self.frame;
        
        CGRect view11Frame;
        view11Frame.origin.x = mWidth0;
        view11Frame.origin.y = mHeight0;
        view11Frame.size.width = viewFrame.size.width - mWidth0 - mWidth2;
        view11Frame.size.height = viewFrame.size.height - mHeight0 - mHeight2;
        
        mView11 = [[UIView alloc] initWithFrame:view11Frame];
        
        [self addSubview:mView11];
        
        [self setNeedsLayout];
    }
    
    return mView11;
}

- (void)setView11:(UIView *)view11
{
    if (mView11 != view11)
    {
        [mView11 removeFromSuperview];
        
        mView11 = view11;
        
        [self addSubview:mView11];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view12
{
    if (!mView12)
    {
        CGRect viewFrame = self.frame;
        
        CGRect view12Frame;
        view12Frame.origin.x = viewFrame.size.width - mWidth2;
        view12Frame.origin.y = mHeight0;
        view12Frame.size.width = mWidth2;
        view12Frame.size.height = viewFrame.size.height - mHeight0 - mHeight2;
        
        mView12 = [[UIView alloc] initWithFrame:view12Frame];
        
        [self addSubview:mView12];
        
        [self setNeedsLayout];
    }
    
    return mView12;
}

- (void)setView12:(UIView *)view12
{
    if (mView12 != view12)
    {
        [mView12 removeFromSuperview];
        
        mView12 = view12;
        
        [self addSubview:mView12];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view20
{
    if (!mView20)
    {
        CGRect viewFrame = self.frame;
        
        CGRect view20Frame;
        view20Frame.origin.x = 0.0f;
        view20Frame.origin.y = viewFrame.size.height - mHeight2;
        view20Frame.size.width = mWidth0;
        view20Frame.size.height = mHeight2;
        
        mView20 = [[UIView alloc] initWithFrame:view20Frame];
        
        [self addSubview:mView20];
        
        [self setNeedsLayout];
    }
    
    return mView20;
}

- (void)setView20:(UIView *)view20
{
    if (mView20 != view20)
    {
        [mView20 removeFromSuperview];
        
        mView20 = view20;
        
        [self addSubview:mView20];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view21
{
    if (!mView21)
    {
        CGRect viewFrame = self.frame;
        
        CGRect view21Frame;
        view21Frame.origin.x = mWidth0;
        view21Frame.origin.y = viewFrame.size.height - mHeight2;
        view21Frame.size.width = viewFrame.size.width - mWidth0 - mWidth2;
        view21Frame.size.height = mHeight2;
        
        mView21 = [[UIView alloc] initWithFrame:view21Frame];
        
        [self addSubview:mView21];
        
        [self setNeedsLayout];
    }
    
    return mView21;
}

- (void)setView21:(UIView *)view21
{
    if (mView21 != view21)
    {
        [mView21 removeFromSuperview];
        
        mView21 = view21;
        
        [self addSubview:mView21];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view22
{
    if (!mView22)
    {
        CGRect viewFrame = self.frame;
        
        CGRect view22Frame;
        view22Frame.origin.x = viewFrame.size.width - mWidth2;
        view22Frame.origin.y = viewFrame.size.height - mHeight2;
        view22Frame.size.width = mWidth2;
        view22Frame.size.height = mHeight2;
        
        mView22 = [[UIView alloc] initWithFrame:view22Frame];
        
        [self addSubview:mView22];
        
        [self setNeedsLayout];
    }
    
    return mView22;
}

- (void)setView22:(UIView *)view22
{
    if (mView22 != view22)
    {
        [mView22 removeFromSuperview];
        
        mView22 = view22;
        
        [self addSubview:mView22];
        
        [self setNeedsLayout];
    }
}

@end
