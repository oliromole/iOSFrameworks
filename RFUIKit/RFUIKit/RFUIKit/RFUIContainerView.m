//
//  RFUIContainerView.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.05.07.
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
#import "RFUIContainerView.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUIContainerView

#pragma mark - Initializing and Creating a RFUIContainerView

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        // Setting the default value.
        mContentEdgeInsets = UIEdgeInsetsZero;
        mContentView = nil;
        mContentViewOptions = 0;
    }
    
    return self;
}

#pragma mark - Deallocating a RFUIContainerView

- (void)dealloc
{
    // Releasing the content view.
    mContentView = nil;
}

#pragma mark - Laying out Subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Getting the view bounds.
    CGRect viewBounds = self.bounds;
    
    // Declaring some variables.
    CGRect contentViewFrame;
    
    // Calculating the content view frame.
    contentViewFrame.origin = CGPointZero;
    contentViewFrame.size = viewBounds.size;
    contentViewFrame = UIEdgeInsetsInsetRect(contentViewFrame, mContentEdgeInsets);
    
    // Getting subviews.
    NSArray *subviews = [self.subviews copy];
    
    // Applying the calculated content view frame to the all subviews.
    for (UIView *contentView in subviews)
    {
        // Applying the calculated content view frame.
        [contentView setFrameIfNeeded:contentViewFrame];
    }
}

#pragma mark - Accessing the Content View

- (UIEdgeInsets)contentEdgeInsets
{
    // Returning the content edge insets.
    return mContentEdgeInsets;
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
{
    // The old content edge insets and the new content edge insets are different.
    if (!UIEdgeInsetsEqualToEdgeInsets(mContentEdgeInsets, contentEdgeInsets))
    {
        // Saving the new content edge insets.
        mContentEdgeInsets = contentEdgeInsets;
        
        // Setting to need to layout.
        [self setNeedsLayout];
    }
}

- (UIView *)contentView
{
    // Setting the defalut values.
    UIView *contentView = nil;
    
    // The content view is first subview.
    if ((mContentViewOptions & RFUIContainerViewContentViewIsFirstSubview) == RFUIContainerViewContentViewIsFirstSubview)
    {
        // Getting the first subview.
        contentView = self.subviews.firstObject;
    }
    
    // The content view is last subview.
    else if ((mContentViewOptions & RFUIContainerViewContentViewIsLastSubview) == RFUIContainerViewContentViewIsLastSubview)
    {
        // Getting the last subview.
        contentView = self.subviews.lastObject;
    }
    
    // The content view is the specific view.
    else
    {
        // Saving the specific view.
        contentView = mContentView;
    }
    
    // Need to create a content view.
    if (!contentView &&
        ((mContentViewOptions & RFUIContainerViewContentViewCreateAutomatic) == RFUIContainerViewContentViewCreateAutomatic))
    {
        // Getting the view bounds.
        CGRect viewBounds = self.bounds;
        
        // Calculating the frame for the content view.
        CGRect contentViewFrame;
        contentViewFrame.origin = CGPointZero;
        contentViewFrame.size = viewBounds.size;
        contentViewFrame = UIEdgeInsetsInsetRect(contentViewFrame, mContentEdgeInsets);
        
        // Creating a content view.
        contentView = [[UIView alloc] initWithFrame:contentViewFrame];
        
        // Building the view hierarchy.
        [self addSubview:contentView];
        
        // Saving the created content view.
        mContentView = contentView;
    }
    
    // Returning the content view.
    return contentView;
}

- (void)setContentView:(UIView *)newContentView
{
    // Setting the default value.
    UIView *oldContentView = nil;
    
    // We have the content view.
    if (self.hasContentView)
    {
        // Getting the content view.
        oldContentView = self.contentView;
    }
    
    // The old content view and new content view are different.
    if (oldContentView != newContentView)
    {
        // The content view is first subview.
        if ((mContentViewOptions & RFUIContainerViewContentViewIsFirstSubview) == RFUIContainerViewContentViewIsFirstSubview)
        {
            // Remove the old content view from the super view.
            [oldContentView removeFromSuperview];
            
            // We have the new content view.
            if (newContentView)
            {
                // Adding the content view as a first view in the super view.
                [self insertSubview:newContentView atIndex:0];
            }
        }
        
        // The content view is last subview.
        else if ((mContentViewOptions & RFUIContainerViewContentViewIsLastSubview) == RFUIContainerViewContentViewIsLastSubview)
        {
            // Remove the old content view from the super view.
            [oldContentView removeFromSuperview];
            
            // We have the new content view.
            if (newContentView)
            {
                // Adding the content view as a last view in the super view.
                [self addSubview:newContentView];
            }
        }
        
        // The content view is the specific view.
        else
        {
            // Remove the old content view from the super view.
            [oldContentView removeFromSuperview];
            
            // Saving the new content view as the specific view.
            mContentView = newContentView;
            
            // We have the new content view.
            if (mContentView)
            {
                // Adding the content view as a last view in the super view.
                [self addSubview:mContentView];
            }
        }
    }
}

- (RFUIContainerViewContentViewOptions)contentViewOptions
{
    // Returning the content view options.
    return mContentViewOptions;
}

- (void)setContentViewOptions:(RFUIContainerViewContentViewOptions)contentViewOptions
{
    // The old content view options and new content view options are different.
    if (mContentViewOptions != contentViewOptions)
    {
        // Setting the default values.
        UIView *contentView = nil;
        
        // We have the content view.
        if (self.hasContentView)
        {
            // Getting the content view.
            contentView = self.contentView;
        }
        
        // Saving the new content view options.
        mContentViewOptions = contentViewOptions;
        
        // We have the content view.
        if (contentView)
        {
            // Creating the position view.
            UIView *positionView = [[UIView alloc] init];
            positionView.userInteractionEnabled = NO;
            
            // The content view is first subview.
            if ((mContentViewOptions & RFUIContainerViewContentViewIsFirstSubview) == RFUIContainerViewContentViewIsFirstSubview)
            {
                // Adding the position view as a first view in the super view.
                [self insertSubview:positionView atIndex:0];
            }
            
            // The content view is last subview.
            else if ((mContentViewOptions & RFUIContainerViewContentViewIsLastSubview) == RFUIContainerViewContentViewIsLastSubview)
            {
                // Adding the position view as a last view in the super view.
                [self addSubview:positionView];
            }
            
            // The content view is the specific view.
            else
            {
                // Adding the position view as a last view in the super view.
                [self addSubview:positionView];
            }
            
            // Searching the index of views.
            NSArray *subviews = self.subviews;
            NSUInteger indexOfContentView = [subviews indexOfObjectIdenticalTo:contentView];
            NSUInteger indexOfPositionView = [subviews indexOfObjectIdenticalTo:positionView];
            
            // We found the indices.
            if ((indexOfContentView != NSNotFound) &&
                (indexOfPositionView != NSNotFound))
            {
                // Movin the content view to the correct position.
                [self exchangeSubviewAtIndex:(NSInteger)indexOfContentView withSubviewAtIndex:(NSInteger)indexOfPositionView];
            }
            
            // Removing the position view from the super view.
            [positionView removeFromSuperview];
        }
    }
}

- (BOOL)hasContentView
{
    // Setting the defalut values.
    UIView *contentView = nil;
    
    // The content view is first subview.
    if ((mContentViewOptions & RFUIContainerViewContentViewIsFirstSubview) == RFUIContainerViewContentViewIsFirstSubview)
    {
        // Getting the first subview.
        contentView = self.subviews.firstObject;
    }
    
    // The content view is last subview.
    else if ((mContentViewOptions & RFUIContainerViewContentViewIsLastSubview) == RFUIContainerViewContentViewIsLastSubview)
    {
        // Getting the last subview.
        contentView = self.subviews.lastObject;
    }
    
    // The content view is the specific view.
    else
    {
        // Saving the specific view.
        contentView = mContentView;
    }
    
    // Calulating the value that we have the content view.
    BOOL hasContentView = !!contentView;
    
    // Returning that we have the content view.
    return hasContentView;
}

@end
