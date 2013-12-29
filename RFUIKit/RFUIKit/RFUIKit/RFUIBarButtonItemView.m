//
//  RFUIBarButtonItemView.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.05.11.
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
#import "RFUIBarButtonItemView.h"

// Importing the external headers.
#import <RECoreGraphics/RECoreGraphics.h>
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUIBarButtonItemView

#pragma mark - Initializing and Creating a RFUIBarButtonItemView

- (id)init
{
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
}

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        // Setting the default values
        mContentEdgeInsets = UIEdgeInsetsZero;
        mContentHeightMode = RFUIBarButtonItemViewContentHeightModeAuto;
        mContentSize = viewFrame.size;
        mContentWidthMode = RFUIBarButtonItemViewContentWidthModeLeft;
        
        // Creating a content view.
        mContentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, mContentSize.width, mContentSize.height)];
        // mContentView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5f];
        
        //self.backgroundColor = [UIColor redColor];
        
        // Building the view hierarchy.
        [self addSubview:mContentView];
    }
    
    return self;
}

#pragma mark - Deallocating a RFUIBarButtonItemView

- (void)dealloc
{
    // Releasing the content view.
    mContentView = nil;
}

#pragma mark - Laying out Subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Getting the view frame.
    CGRect viewFrame = self.frame;
    
    // Declaring some variables;
    CGRect contentViewFrame;
    
    // Calculating the frame for the content view.
    contentViewFrame.origin = CGPointZero;
    contentViewFrame.size = viewFrame.size;
    contentViewFrame = UIEdgeInsetsInsetRect(contentViewFrame, mContentEdgeInsets);
    
    // Applying the calculated frames.
    [mContentView setFrameIfNeeded:contentViewFrame];
}

#pragma mark - Managing the Content View

- (void)updateViewFrame
{
    // Getting the old view frame.
    CGRect oldViewFrame = self.frame;
    
    // Declaring some variables.
    CGRect newViewFrame;
    
    // Calculating the new view width.
    newViewFrame.size.width = mContentSize.width + (mContentEdgeInsets.left + mContentEdgeInsets.right);
    
    // Calculating the new view x.
    switch (mContentWidthMode)
    {
        default:
        case RFUIBarButtonItemViewContentWidthModeLeft:
        {
            newViewFrame.origin.x = oldViewFrame.origin.x;
            
            break;
        }
            
        case RFUIBarButtonItemViewContentWidthModeCenter:
        {
            long int oldViewWidth = cg_lround(oldViewFrame.size.width);
            oldViewWidth += (oldViewWidth % 2l);
            
            long int newViewWidth = cg_lround(newViewFrame.size.width);
            newViewWidth += (newViewWidth % 2l);
            
            newViewFrame.origin.x = oldViewFrame.origin.x += ((oldViewWidth / 2l) - (newViewWidth / 2l));
            
            break;
        }
            
        case RFUIBarButtonItemViewContentWidthModeRight:
        {
            newViewFrame.origin.x = oldViewFrame.origin.x + oldViewFrame.size.width - mContentSize.width;
            
            break;
        }
    }
    
    // Setting the default navigation bar frame.
    CGRect navigationBarFrame;
    navigationBarFrame.origin.x = 0.0f;
    navigationBarFrame.origin.y = 0.0f;
    navigationBarFrame.size.width = 320.0f;
    navigationBarFrame.size.height = 44.0f;
    
    // Caching the class references.
    Class navigationBarClass = [UINavigationBar class];
    
    // Searching the parent navigation bar to get an actual navigation bar frame.
    
    UIView *superview = self.superview;
    
    while (superview)
    {
        if ([superview isKindOfClass:navigationBarClass])
        {
            navigationBarFrame = superview.frame;
            
            break;
        }
        
        else
        {
            superview = superview.superview;
        }
    }
    
    // Calculating the new view height.
    switch (mContentHeightMode)
    {
        default:
        case RFUIBarButtonItemViewContentHeightModeAuto:
        {
            newViewFrame.size.height = navigationBarFrame.size.height + (mContentEdgeInsets.top + mContentEdgeInsets.bottom);
            
            break;
        }
            
        case RFUIBarButtonItemViewContentHeightModeManual:
        {
            newViewFrame.size.height = mContentSize.height + (mContentEdgeInsets.top + mContentEdgeInsets.bottom);
            
            break;
        }
    }
    
    // Caluclating the new view y.
    
    if (newViewFrame.size.height <= navigationBarFrame.size.height)
    {
        newViewFrame.origin.y = cg_trunc((navigationBarFrame.size.height - newViewFrame.size.height) / 2.0f);
    }
    
    else
    {
        newViewFrame.origin.y = newViewFrame.size.height - navigationBarFrame.size.height;
    }
    
    // Applying the new view frame.
    
    if (!CGRectEqualToRect(oldViewFrame, newViewFrame))
    {
        self.frame = newViewFrame;
    }
    
    // Setting to need to layout to apply the new content size.
    [self setNeedsLayout];
}

- (UIEdgeInsets)contentEdgeInsets
{
    // Returning the content edge insets.
    return mContentEdgeInsets;
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
{
    // The old value and the new value are different.
    if (!UIEdgeInsetsEqualToEdgeInsets(mContentEdgeInsets, contentEdgeInsets))
    {
        // Saving the new content edge insets.
        mContentEdgeInsets = contentEdgeInsets;
        
        [self setNeedsLayout];
    }
}

- (RFUIBarButtonItemViewContentHeightMode)contentHeightMode
{
    // Returnig the content height mode
    return mContentHeightMode;
}

- (void)setContentHeightMode:(RFUIBarButtonItemViewContentHeightMode)contentHeightMode
{
    // The old content height mode and the new content height mode are different.
    if (mContentHeightMode != contentHeightMode)
    {
        // Saving the new content height mode.
        mContentHeightMode = contentHeightMode;
        
        // Updating the view frame.
        [self updateViewFrame];
    }
}

- (CGSize)contentSize
{
    // Getting the content view frame.
    CGRect contentViewFrame = mContentView.frame;
    
    // Returning the content size;
    return contentViewFrame.size;
}

- (void)setContentSize:(CGSize)contentSize
{
    //The old content size and the new content are different.
    if (!CGSizeEqualToSize(mContentSize, contentSize))
    {
        // Saving the new content size.
        mContentSize = contentSize;
        
        // Updating the view frame.
        [self updateViewFrame];
    }
}

@synthesize contentView = mContentView;

- (RFUIBarButtonItemViewContentWidthMode)contentWidthMode
{
    // Returning the content width mode.
    return mContentWidthMode;
}

- (void)setContentWidthMode:(RFUIBarButtonItemViewContentWidthMode)contentWidthMode
{
    // The old content width mode and the new content width mode are different.
    if (mContentWidthMode != contentWidthMode)
    {
        // Save new content width mode.
        mContentWidthMode = contentWidthMode;
        
        // Updating the view frame.
        [self updateViewFrame];
    }
}

@end

const UIEdgeInsets RFUIBarButtonItemViewContentEdgeInsetsZero = {0.0f, 0.0f, 0.0f, 0.0f};
const UIEdgeInsets RFUIBarButtonItemViewContentEdgeInsetsLeft_iPad = {0.0f, -7.0f, 0.0f, -4.0f};
const UIEdgeInsets RFUIBarButtonItemViewContentEdgeInsetsCenter_iPad = {0.0f, -4.0f, 0.0f, -4.0f};
const UIEdgeInsets RFUIBarButtonItemViewContentEdgeInsetsRight_iPad = {0.0f, -4.0f, 0.0f, -7.0f};
