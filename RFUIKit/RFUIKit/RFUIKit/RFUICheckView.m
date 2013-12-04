//
//  RFUICheckView.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.07.11.
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
#import "RFUICheckView.h"

// Importing the external headers.
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUICheckView

#pragma mark - Initializing and Creating a RFUICheckView

- (id)init
{
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, 16.0f, 16.0f)];
}

- (id)initWithFrame:(CGRect)viewFrame
{
    viewFrame.size.width = 16.0f;
    viewFrame.size.width = 16.0f;
    
    if ((self = [super initWithFrame:viewFrame]))
    {
        [self addTarget:self action:@selector(rfuiCheckViewEventTouchEventsAction:) forControlEvents:(UIControlEventAllTouchEvents & ~UIControlEventTouchUpInside)];
        [self addTarget:self action:@selector(rfuiCheckViewEventTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        
        mEntities = [[NSMutableArray alloc] initWithCapacity:3];
        
        mCurrentState = NSNotFound;
        
        mStateViewEdgeInsets = UIEdgeInsetsZero;
    }
    
    return self;
}

- (id)initWithNumberOfStates:(NSUInteger)numberOfStates
{
    if ((self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 16.0f, 16.0f)]))
    {
        [self addTarget:self action:@selector(rfuiCheckViewEventTouchEventsAction:) forControlEvents:(UIControlEventAllTouchEvents & ~UIControlEventTouchUpInside)];
        [self addTarget:self action:@selector(rfuiCheckViewEventTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        
        mEntities = [[NSMutableArray alloc] initWithCapacity:numberOfStates];
        
        for (NSUInteger indexOfState = 0; indexOfState < numberOfStates; indexOfState++)
        {
            NSMutableDictionary *entity = [[NSMutableDictionary alloc] initWithCapacity:4];
            
            [mEntities addObject:entity];
        }
        
        mCurrentState = (numberOfStates > 0 ? 0 : NSNotFound);
        
        mStateViewEdgeInsets = UIEdgeInsetsZero;
    }
    
    return self;
}

#pragma mark - Deallocating a RFUICheckView

- (void)dealloc
{
    [self removeTarget:self action:NULL forControlEvents:UIControlEventAllTouchEvents];
    
    mEntities = nil;
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
    
    for (NSMutableDictionary *entity in mEntities)
    {
        for (NSNumber *conrolStateNumber in entity)
        {
            UIView *stateView = [entity objectForKey:conrolStateNumber];
            
            [stateView setFrameIfNeeded:stateViewFrame];
        }
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

#pragma mark - Counting States

- (NSUInteger)numberOfStates
{
    NSUInteger numberOfStates = mEntities.count;
    
    return numberOfStates;
}

- (void)setNumberOfStates:(NSUInteger)numberOfStates
{
    NSUInteger currentNumberOfStates = mEntities.count;
    
    if (currentNumberOfStates != numberOfStates)
    {
        while (mEntities.count < numberOfStates)
        {
            NSMutableDictionary *entity = [[NSMutableDictionary alloc] initWithCapacity:4];
            
            [mEntities addObject:entity];
        }
        
        while (mEntities.count > numberOfStates)
        {
            NSMutableDictionary *entity = mEntities.lastObject;
            
            for (NSNumber *conrolStateNumber in entity)
            {
                UIView *stateView = [entity objectForKey:conrolStateNumber];
                
                if (stateView.superview)
                {
                    [stateView removeFromSuperview];
                }
            }
            
            [mEntities removeLastObject];
        }
        
        if (mCurrentState != NSNotFound)
        {
            if (mCurrentState >= numberOfStates)
            {
                mCurrentState = NSNotFound;
                
                [self updateStateView];
            }
        }
    }
}

#pragma mark - Managing Check View Content

- (UIView *)stateViewForState:(NSUInteger)state controlState:(UIControlState)conrolState
{
    NSNumber *conrolStateNumber = [[NSNumber alloc] initWithUnsignedInteger:conrolState];
    
    NSMutableDictionary *entity = [mEntities objectAtIndex:state];
    
    UIView *stateView = [entity objectForKey:conrolStateNumber];
    
    return stateView;
}

- (void)setStateView:(UIView *)newStateView forState:(NSUInteger)state controlState:(UIControlState)conrolState
{
    NSNumber *conrolStateNumber = [[NSNumber alloc] initWithUnsignedInteger:conrolState];
    
    NSMutableDictionary *entity = [mEntities objectAtIndex:state];
    UIView *oldStateView = [entity objectForKey:conrolStateNumber];
    
    if (oldStateView != newStateView)
    {
        if (oldStateView && oldStateView.superview)
        {
            [oldStateView removeFromSuperview];
        }
        
        [entity setObject:newStateView forKey:conrolStateNumber];
        
        [self setNeedsLayout];
        [self updateStateView];
    }
}

- (UIView *)lastStateViewForControlState:(UIControlState)conrolState
{
    UIView *stateView = nil;
    
    NSUInteger state = mEntities.count;
    
    if (state > 0)
    {
        state -= 1;
        
        stateView = [self stateViewForState:state controlState:conrolState];
    }
    
    return stateView;
}

- (void)setLastStateView:(UIView *)stateView forControlState:(UIControlState)conrolState
{
    NSUInteger state = mEntities.count;
    
    if (state > 0)
    {
        state -= 1;
        
        [self setStateView:stateView forState:state controlState:conrolState];
    }
}

#pragma mark - Managing Check View Content

- (NSUInteger)currentState
{
    return mCurrentState;
}

- (void)setCurrentState:(NSUInteger)currentState
{
    if (mCurrentState != currentState)
    {
        mCurrentState = currentState;
        
        NSUInteger numberOfState = mEntities.count;
        
        if (mCurrentState >= numberOfState)
        {
            mCurrentState = NSNotFound;
        }
        
        [self updateStateView];
    }
}

- (void)addState
{
    NSUInteger state = mEntities.count;
    
    [self insertState:state];
    
}

- (void)insertState:(NSUInteger)state
{
    NSMutableDictionary *entity = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    [mEntities insertObject:entity atIndex:state];
    
    if (mCurrentState != NSNotFound)
    {
        if (mCurrentState >= state)
        {
            mCurrentState++;
            
            [self updateStateView];
        }
    }
}

- (void)removeState:(NSUInteger)state
{
    NSMutableDictionary *entity = [mEntities objectAtIndex:state];
    
    for (NSNumber *conrolStateNumber in entity)
    {
        UIView *stateView = [entity objectForKey:conrolStateNumber];
        
        if (stateView.superview)
        {
            [stateView removeFromSuperview];
        }
    }
    
    if (state != NSNotFound)
    {
        if (mCurrentState == state)
        {
            mCurrentState = NSNotFound;
            
            [self updateStateView];
        }
        
        else if (mCurrentState > state)
        {
            mCurrentState--;
        }
    }
}

- (void)removeLastState
{
    NSUInteger state = mEntities.count;
    state -= 1;
    
    [self removeState:state];
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
    UIControlState controlState = self.state;
    BOOL tracking = self.tracking;
    
    if (!tracking)
    {
        controlState &= ~UIControlStateHighlighted;
    }
    
    UIControlState simpleControlState = UIControlStateNormal;
    
    if ((controlState & UIControlStateDisabled) == UIControlStateDisabled)
    {
        simpleControlState = UIControlStateDisabled;
    }
    
    else if ((controlState & UIControlStateHighlighted) == UIControlStateHighlighted)
    {
        simpleControlState = UIControlStateHighlighted;
    }
    
    NSUInteger numberOfStates = mEntities.count;
    NSUInteger state = mCurrentState;
    
    if (simpleControlState == UIControlStateHighlighted)
    {
        simpleControlState = UIControlStateNormal;
        
        if (state == NSNotFound)
        {
            if (numberOfStates > 0)
            {
                state = 0;
            }
        }
        
        else if (numberOfStates == 0)
        {
            state = NSNotFound;
        }
        
        else if (state >= (numberOfStates - 1))
        {
            state = 0;
        }
        
        // state < (numberOfStates - 1).
        else
        {
            state = state + 1;
            
            if (state >= numberOfStates)
            {
                state = 0;
            }
        }
    }
    
    NSNumber *simpleControlStateNumber = [[NSNumber alloc] initWithUnsignedInteger:simpleControlState];
    
    UIView *simpleStateView = nil;
    
    if (state != NSNotFound)
    {
        NSMutableDictionary *entity = [mEntities objectAtIndex:state];
        simpleStateView = [entity objectForKey:simpleControlStateNumber];
    }
    
    for (NSMutableDictionary *entity in mEntities)
    {
        for (NSNumber *conrolStateNumber in entity)
        {
            UIView *stateView = [entity objectForKey:conrolStateNumber];
            
            if (stateView != simpleStateView)
            {
                if (stateView.superview)
                {
                    [stateView removeFromSuperview];
                }
            }
        }
    }
    
    if (simpleStateView && !simpleStateView.superview)
    {
        [self addSubview:simpleStateView];
    }
}

#pragma mark - UIControl Events

- (void)rfuiCheckViewEventTouchEventsAction:(UIButton *)sender
{
    if (sender && (sender == self))
    {
        [self updateStateView];
    }
}

- (void)rfuiCheckViewEventTouchUpInsideAction:(UIButton *)sender
{
    if (sender && (sender == self))
    {
        NSUInteger numberOfStates = mEntities.count;
        
        NSUInteger oldSate = mCurrentState;
        NSUInteger newState = mCurrentState;
        
        if (newState == NSNotFound)
        {
            if (numberOfStates > 0)
            {
                newState = 0;
            }
        }
        
        else if (numberOfStates == 0)
        {
            newState = NSNotFound;
        }
        
        else if (newState >= (numberOfStates - 1))
        {
            newState = 0;
        }
        
        // newState < (numberOfStates - 1).
        else
        {
            newState = newState + 1;
            
            if (newState >= numberOfStates)
            {
                newState = 0;
            }
        }
        
        mCurrentState = newState;
        
        [self updateStateView];
        
        if (oldSate != newState)
        {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

@end
