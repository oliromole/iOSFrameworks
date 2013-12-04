//
//  RFUIForwardView.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.07.30.
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
#import "RFUIForwardView.h"

// Importing the project headers.
#import "RFUIForwardViewDelegate.h"

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUIForwardView

#pragma mark - Initializing and Creating a RFUIForwardView

+ (id)forwardView
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        // Setting the defalut values.
        mDelegate = nil;
        
        // Setting the defalut values.
        mDidAddSubviewBlock = nil;
        mDidMoveToSuperviewBlock = nil;
        mDidMoveToWindowBlock = nil;
        mDrawRectBlock = nil;
        mLayoutSubviewsBlock = nil;
        mWillMoveToSuperviewBlock = nil;
        mWillMoveToWindowBlock = nil;
        mWillRemoveSubviewBlock = nil;
    }
    
    return self;
}

+ (id)forwardViewWithFrame:(CGRect)viewFrame
{
    return [[self alloc] initWithFrame:viewFrame];
}

#pragma mark - Deallocating a RFUIForwardView

- (void)dealloc
{
    mDelegate = nil;
    
    // Releasing the did add subview block.
    mDidAddSubviewBlock = nil;
    
    // Releasing the did move to superview block.
    mDidMoveToSuperviewBlock = nil;
    
    // Releasing the did move to window block.
    mDidMoveToWindowBlock = nil;
    
    // Releasing the draw rect block.
    mDrawRectBlock = nil;
    
    // Releasing the layout subviews block.
    mLayoutSubviewsBlock = nil;
    
    // Releasing the will move to superview block.
    mWillMoveToSuperviewBlock = nil;
    
    // Releasing the will move to window block.
    mWillMoveToWindowBlock = nil;
    
    // Rleasing the will remove subview block.
    mWillRemoveSubviewBlock = nil;
}

#pragma mark - Laying out Subview

@synthesize layoutSubviewsBlock = mLayoutSubviewsBlock;

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    id<RFUIForwardViewDelegate> delegate = mDelegate;
    
    if ([delegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [delegate respondsToSelector:@selector(forwardViewLayoutSubviews:)])
    {
        [delegate forwardViewLayoutSubviews:self];
    }
    
    if (mLayoutSubviewsBlock)
    {
        mLayoutSubviewsBlock();
    }
}

#pragma mark - Drawing and Updating the View

@synthesize drawRectBlock = mDrawRectBlock;

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    id<RFUIForwardViewDelegate> delegate = mDelegate;
    
    if ([delegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [delegate respondsToSelector:@selector(forwardView:drawRect:)])
    {
        [delegate forwardView:self drawRect:rect];
    }
    
    if (mDrawRectBlock)
    {
        mDrawRectBlock(rect);
    }
}

#pragma mark - Observing View-Related Changes

@synthesize didAddSubviewBlock = mDidAddSubviewBlock;
@synthesize willRemoveSubviewBlock = mWillRemoveSubviewBlock;
@synthesize willMoveToSuperviewBlock = mWillMoveToSuperviewBlock;
@synthesize didMoveToSuperviewBlock = mDidMoveToSuperviewBlock;
@synthesize willMoveToWindowBlock = mWillMoveToWindowBlock;
@synthesize didMoveToWindowBlock = mDidMoveToWindowBlock;

- (void)didAddSubview:(UIView *)subview
{
    [super didAddSubview:subview];
    
    id<RFUIForwardViewDelegate> delegate = mDelegate;
    
    if ([delegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [delegate respondsToSelector:@selector(forwardView:didAddSubview:)])
    {
        [delegate forwardView:self didAddSubview:subview];
    }
    
    if (mDidAddSubviewBlock)
    {
        mDidAddSubviewBlock(subview);
    }
}

- (void)willRemoveSubview:(UIView *)subview
{
    [super willRemoveSubview:subview];
    
    id<RFUIForwardViewDelegate> delegate = mDelegate;
    
    if ([delegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [delegate respondsToSelector:@selector(forwardView:willRemoveSubview:)])
    {
        [delegate forwardView:self willRemoveSubview:subview];
    }
    
    if (mWillRemoveSubviewBlock)
    {
        mWillRemoveSubviewBlock(subview);
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    id<RFUIForwardViewDelegate> delegate = mDelegate;
    
    if ([delegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [delegate respondsToSelector:@selector(forwardView:willMoveToSuperview:)])
    {
        [delegate forwardView:self willMoveToSuperview:newSuperview];
    }
    
    if (mWillMoveToSuperviewBlock)
    {
        mWillMoveToSuperviewBlock(newSuperview);
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    id<RFUIForwardViewDelegate> delegate = mDelegate;
    
    if ([delegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [delegate respondsToSelector:@selector(forwardViewDidMoveToSuperview:)])
    {
        [delegate forwardViewDidMoveToSuperview:self];
    }
    
    if (mDidMoveToSuperviewBlock)
    {
        mDidMoveToSuperviewBlock();
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    
    id<RFUIForwardViewDelegate> delegate = mDelegate;
    
    if ([delegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [delegate respondsToSelector:@selector(forwardView:willMoveToWindow:)])
    {
        [delegate forwardView:self willMoveToWindow:newWindow];
    }
    
    if (mWillMoveToWindowBlock)
    {
        mWillMoveToWindowBlock(newWindow);
    }
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    id<RFUIForwardViewDelegate> delegate = mDelegate;
    
    if ([delegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [delegate respondsToSelector:@selector(forwardViewDidMoveToWindow:)])
    {
        [delegate forwardViewDidMoveToWindow:self];
    }
    
    if (mDidMoveToWindowBlock)
    {
        mDidMoveToWindowBlock();
    }
}

#pragma mark - Managing the Delegate

@synthesize delegate = mDelegate;

@end
