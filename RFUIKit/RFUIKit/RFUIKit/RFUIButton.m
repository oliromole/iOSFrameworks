//
//  RFUIButton.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2011.09.09.
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
#import "RFUIButton.h"

// Importing the external headers.
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUIButton

#pragma mark - Initializing and Creating a RFUIButton

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        [self addTarget:self action:@selector(rfuiButtonEventAllTouchEventsAction:) forControlEvents:UIControlEventAllTouchEvents];
        
        mStateViewEdgeInsets = UIEdgeInsetsZero;
        
        mStateViews = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark - Deallocating a RFUIButton

- (void)dealloc
{
    [self removeTarget:self action:NULL forControlEvents:UIControlEventAllTouchEvents];
    
    mStateViews = nil;
}

#pragma mark - Laying out Subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect viewFrame = self.frame;
    
    UIEdgeInsets contentEdgeInsets = self.contentEdgeInsets;
    UIEdgeInsets stateViewEdgeInsets = self.stateViewEdgeInsets;
    
    CGRect contentViewFrame;
    CGRect stateViewFrame;
    
    contentViewFrame.origin = CGPointZero;
    contentViewFrame.size = viewFrame.size;
    contentViewFrame = UIEdgeInsetsInsetRect(contentViewFrame, contentEdgeInsets);
    
    stateViewFrame.origin = contentViewFrame.origin;
    stateViewFrame.size = contentViewFrame.size;
    stateViewFrame = UIEdgeInsetsInsetRect(stateViewFrame, stateViewEdgeInsets);
    
    for (NSNumber *stateNumber in mStateViews)
    {
        UIView *stateView = [mStateViews objectForKey:stateNumber];
        
        [stateView setFrameIfNeeded:stateViewFrame];
    }
}

#pragma mark - Setting and Getting Control Attributes

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    [self updateStateView];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self updateStateView];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [self updateStateView];
}

#pragma mark - Configuring Button Presentation

- (UIView *)stateViewForState:(UIControlState)state
{
    NSNumber *stateNumber = [[NSNumber alloc] initWithUnsignedInteger:state];
    UIView   *stateView = nil;
    
    if (stateNumber)
    {
        stateView = [mStateViews objectForKey:stateNumber];
    }
    
    stateNumber = nil;
    
    return stateView;
}

- (void)setStateView:(UIView *)newStateView forState:(UIControlState)state
{
    if (newStateView)
    {
        NSNumber *stateNumber = [[NSNumber alloc] initWithUnsignedInteger:state];
        
        if (stateNumber)
        {
            UIView *oldStateView = [mStateViews objectForKey:stateNumber];
            
            if (oldStateView != newStateView)
            {
                if (oldStateView && oldStateView.superview)
                {
                    [oldStateView removeFromSuperview];
                }
                
                [mStateViews setObject:newStateView forKey:stateNumber];
                
                [self setNeedsLayout];
                [self updateStateView];
            }
        }
    }
}

- (UIView *)disabledView
{
    UIView *disabledView = [self stateViewForState:UIControlStateDisabled];
    return disabledView;
}

- (void)setDisabledView:(UIView *)disabledView
{
    [self setStateView:disabledView forState:UIControlStateDisabled];
}

- (UIView *)highlightedView
{
    UIView *highlightedView = [self stateViewForState:UIControlStateHighlighted];
    return highlightedView;
}

- (void)setHighlightedView:(UIView *)highlightedView
{
    [self setStateView:highlightedView forState:UIControlStateHighlighted];
}

- (UIView *)normalView
{
    UIView *normalView = [self stateViewForState:UIControlStateNormal];
    return normalView;
}

- (void)setNormalView:(UIView *)normalView
{
    [self setStateView:normalView forState:UIControlStateNormal];
}

- (UIView *)selectedView
{
    UIView *selectedView = [self stateViewForState:UIControlStateSelected];
    return selectedView;
}

- (void)setSelectedView:(UIView *)selectedView
{
    [self setStateView:selectedView forState:UIControlStateSelected];
}

#pragma mark - Configuring Edge Insets

- (UIEdgeInsets)stateViewEdgeInsets
{
    return mStateViewEdgeInsets;
}

- (void)setStateViewEdgeInsets:(UIEdgeInsets)stateViewEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(mStateViewEdgeInsets, stateViewEdgeInsets))
    {
        mStateViewEdgeInsets = stateViewEdgeInsets;
        
        [self layoutIfNeeded];
    }
}

#pragma mark - Updating the State View

- (void)updateStateView
{
    // Getting some information about the conroll.
    UIControlState controlState = self.state;
    BOOL tracking = self.tracking;
    
    // The user is tracking touches.
    if (!tracking)
    {
        // Correcting the control state.
        controlState &= ~UIControlStateHighlighted;
    }
    
    // Setting to need updata the state view.
    BOOL needsUpdateStateView = YES;
    
    // Needs to update state view.
    if (needsUpdateStateView)
    {
        // Trying to update the state view for multi control state.
        
        // Getting the control state as a number.
        NSNumber *controlStateNumber = [[NSNumber alloc] initWithUnsignedInteger:controlState];
        
        // Getting the state view for the control state.
        UIView *stateView = [mStateViews objectForKey:controlStateNumber];
        
        // We have the state view.
        if (stateView)
        {
            // Resetting the flag to need update the state view.
            needsUpdateStateView = NO;
            
            // Enumerating all the state.
            for (NSNumber *stateNumber in mStateViews)
            {
                // Getting the state view for the state.
                UIView *stateView2 = [mStateViews objectForKey:stateNumber];
                
                // The state view is not the current state view.
                if (stateView2 != stateView)
                {
                    // The state view is shown.
                    if (stateView2.superview)
                    {
                        // Hiding the state view.
                        [stateView2 removeFromSuperview];
                    }
                }
            }
            
            // We need to show the current state view.
            if (stateView && !stateView.superview)
            {
                // Showing the current state view.
                [self addSubview:stateView];
            }
        }
    }
    
    // Needs to update state view.
    if (needsUpdateStateView)
    {
        // Trying to update the state view for simple control state.
        
        // Getting the control state as a number.
        needsUpdateStateView = NO;
        
        // Calculating the simple conrol state.
        UIControlState simpleControlState = UIControlStateNormal;
        
        if ((controlState & UIControlStateDisabled) == UIControlStateDisabled)
        {
            simpleControlState = UIControlStateDisabled;
        }
        
        else if ((controlState & UIControlStateHighlighted) == UIControlStateHighlighted)
        {
            simpleControlState = UIControlStateHighlighted;
        }
        
        else if ((controlState & UIControlStateSelected) == UIControlStateSelected)
        {
            simpleControlState = UIControlStateSelected;
        }
        
        // Getting the simple control state as a number.
        NSNumber *simpleControlStateNumber = [[NSNumber alloc] initWithUnsignedInteger:simpleControlState];
        
        // Getting the state view for the simple control state.
        UIView *simpleStateView = [mStateViews objectForKey:simpleControlStateNumber];
        
        // Enumerating all the state.
        for (NSNumber *stateNumber in mStateViews)
        {
            // Getting the state view for the state.
            UIView *stateView = [mStateViews objectForKey:stateNumber];
            
            // The state view is not the current state view.
            if (stateView != simpleStateView)
            {
                // The state view is shown.
                if (stateView.superview)
                {
                    // Hiding the state view.
                    [stateView removeFromSuperview];
                }
            }
        }
        
        // We need to show the current state view.
        if (simpleStateView && !simpleStateView.superview)
        {
            // Showing the current state view.
            [self addSubview:simpleStateView];
        }
    }
    
    // Deceiving the static analyzer.
    needsUpdateStateView = needsUpdateStateView;
    
}

#pragma mark - UIControl Events

- (void)rfuiButtonEventAllTouchEventsAction:(UIButton *)sender
{
    if (sender && (sender == self))
    {
        [self updateStateView];
    }
}

@end
