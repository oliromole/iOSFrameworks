//
//  RFUIStatusBarLayoutView.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.08.08.
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
#import "RFUIStatusBarLayoutView.h"

// Importing the project headers.
#import "RFUIStatusBarCenter.h"

// Importing the external headers.
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUIStatusBarLayoutView

#pragma mark - Initializing and Creating a RFUIStatusBarLayoutView

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        RFUIStatusBarCenter *statusBarCenter = [RFUIStatusBarCenter sharedCenter];
        
        mBackgroundView = nil;
        mContentView = nil;
        mHasSuperStatusBarLayoutView = NO;
        mHasWindow = NO;
        
        mRotationView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, viewFrame.size.width, viewFrame.size.height)];
        
        mStatusBarFrameEnd = statusBarCenter.frameEnd;
        mSupportedApplicationFrame = YES;
        mSupportedInterfaceOrientation = YES;
        
        [self addSubview:mRotationView];
    }
    
    return self;
}

#pragma mark - Deallocating a Home Layout View

- (void)dealloc
{
    mBackgroundView = nil;
    
    mContentView = nil;
    
    mRotationView = nil;
}

#pragma mark - Laying out Subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect viewBounds = self.bounds;
    
    CGRect backgroundViewFrame;
    CGRect contentViewFrame;
    
    CGAffineTransform rotationViewAffineTransform;
    CGPoint           rotationViewCenter;
    CGRect            rotationViewBounds;
    
    UIInterfaceOrientation interfaceOrientationEnd = [RFUIStatusBarCenter sharedCenter].interfaceOrientationEnd;
    
    if (mHasSuperStatusBarLayoutView)
    {
        rotationViewAffineTransform = CGAffineTransformIdentity;
        
        rotationViewCenter.x = viewBounds.size.width / 2.0f;
        rotationViewCenter.y = viewBounds.size.height / 2.0f;
        
        rotationViewBounds.origin = CGPointZero;
        rotationViewBounds.size = viewBounds.size;
    }
    
    else if (CGRectEqualToRect(mStatusBarFrameEnd, CGRectZero))
    {
        rotationViewBounds.origin = CGPointZero;
        
        rotationViewCenter.x = viewBounds.size.width / 2.0f;
        rotationViewCenter.y = viewBounds.size.height / 2.0f;
        
        switch (interfaceOrientationEnd)
        {
            case UIInterfaceOrientationPortrait:
            {
                rotationViewAffineTransform = CGAffineTransformMakeRotation(0.0f);
                
                rotationViewBounds.size.width = viewBounds.size.width;
                rotationViewBounds.size.height = viewBounds.size.height;
                
                break;
            }
                
            case UIInterfaceOrientationPortraitUpsideDown:
            {
                rotationViewAffineTransform = CGAffineTransformMakeRotation((float)(M_PI));
                
                rotationViewBounds.size.width = viewBounds.size.width;
                rotationViewBounds.size.height = viewBounds.size.height;
                
                break;
            }
                
            case UIInterfaceOrientationLandscapeLeft:
            {
                rotationViewAffineTransform = CGAffineTransformMakeRotation((float)(M_PI + M_PI_2));
                
                rotationViewBounds.size.width = viewBounds.size.height;
                rotationViewBounds.size.height = viewBounds.size.width;
                
                break;
            }
                
            case UIInterfaceOrientationLandscapeRight:
            {
                rotationViewAffineTransform = CGAffineTransformMakeRotation((float)(M_PI_2));
                
                rotationViewBounds.size.width = viewBounds.size.height;
                rotationViewBounds.size.height = viewBounds.size.width;
                
                break;
            }
        }
    }
    
    else
    {
        rotationViewBounds.origin = CGPointZero;
        
        switch (interfaceOrientationEnd)
        {
            case UIInterfaceOrientationPortrait:
            {
                rotationViewAffineTransform = CGAffineTransformMakeRotation(0.0f);
                
                rotationViewCenter.x = viewBounds.size.width / 2.0f;
                rotationViewCenter.y = viewBounds.size.height / 2.0f + 10.0f;
                
                rotationViewBounds.size.width = viewBounds.size.width;
                rotationViewBounds.size.height = viewBounds.size.height - 20.0f;
                
                break;
            }
                
            case UIInterfaceOrientationPortraitUpsideDown:
            {
                rotationViewAffineTransform = CGAffineTransformMakeRotation((float)(M_PI));
                
                rotationViewCenter.x = viewBounds.size.width / 2.0f;
                rotationViewCenter.y = viewBounds.size.height / 2.0f - 10.0f;
                
                rotationViewBounds.size.width = viewBounds.size.width;
                rotationViewBounds.size.height = viewBounds.size.height - 20.0f;
                
                break;
            }
                
            case UIInterfaceOrientationLandscapeLeft:
            {
                rotationViewAffineTransform = CGAffineTransformMakeRotation((float)(M_PI + M_PI_2));
                
                rotationViewCenter.x = viewBounds.size.width / 2.0f + 10.0f;
                rotationViewCenter.y = viewBounds.size.height / 2.0f;
                
                rotationViewBounds.size.width = viewBounds.size.height;
                rotationViewBounds.size.height = viewBounds.size.width - 20.0f;
                
                break;
            }
                
            case UIInterfaceOrientationLandscapeRight:
            {
                rotationViewAffineTransform = CGAffineTransformMakeRotation((float)(M_PI_2));
                
                rotationViewCenter.x = viewBounds.size.width / 2.0f - 10.0f;
                rotationViewCenter.y = viewBounds.size.height / 2.0f;
                
                rotationViewBounds.size.width = viewBounds.size.height;
                rotationViewBounds.size.height = viewBounds.size.width - 20.0f;
                
                break;
            }
        }
    }
    
    backgroundViewFrame.origin = CGPointZero;
    backgroundViewFrame.size = rotationViewBounds.size;
    
    contentViewFrame.origin = CGPointZero;
    contentViewFrame.size = rotationViewBounds.size;
    
    [mRotationView setTransformIfNeeded:rotationViewAffineTransform];
    [mRotationView setCenterIfNeeded:rotationViewCenter];
    [mRotationView setBoundsIfNeeded:rotationViewBounds];
    
    [mBackgroundView setFrameIfNeeded:backgroundViewFrame];
    [mContentView setFrameIfNeeded:contentViewFrame];
}

#pragma mark - Laying out Subview and Sending RFUIStatusBarCenter Events

- (void)recursiveLayoutSubviewsAndSendStatusBarCenterWillChangeStatusBarFrameMessageInView:(UIView *)view
{
    [view layoutSubviews];
    
    NSArray *subviews = [view.subviews copy];
    
    for (UIView *subview in subviews)
    {
        if ([subview isKindOfClass:[RFUIStatusBarLayoutView class]])
        {
            RFUIStatusBarLayoutView *statusBarLayoutView = (RFUIStatusBarLayoutView *)subviews;
            
            [statusBarLayoutView statusBarCenterWillChangeStatusBarFrame];
        }
        
        else
        {
            [self recursiveLayoutSubviewsAndSendStatusBarCenterWillChangeStatusBarFrameMessageInView:subview];
        }
    }
}

- (void)recursiveLayoutSubviewsAndSendStatusBarCenterDidChangeStatusBarFrameMessageInView:(UIView *)view
{
    [view layoutSubviews];
    
    NSArray *subviews = [view.subviews copy];
    
    for (UIView *subview in subviews)
    {
        if ([subview isKindOfClass:[RFUIStatusBarLayoutView class]])
        {
            RFUIStatusBarLayoutView *statusBarLayoutView = (RFUIStatusBarLayoutView *)subviews;
            
            [statusBarLayoutView statusBarCenterDidChangeStatusBarFrame];
        }
        
        else
        {
            [self recursiveLayoutSubviewsAndSendStatusBarCenterDidChangeStatusBarFrameMessageInView:subview];
        }
    }
}

- (void)recursiveLayoutSubviewsAndSendStatusBarCenterWillChangeStatusBarOrientationFrameMessageInView:(UIView *)view
{
    [view layoutSubviews];
    
    NSArray *subviews = [view.subviews copy];
    
    for (UIView *subview in subviews)
    {
        if ([subview isKindOfClass:[RFUIStatusBarLayoutView class]])
        {
            RFUIStatusBarLayoutView *statusBarLayoutView = (RFUIStatusBarLayoutView *)subviews;
            
            [statusBarLayoutView statusBarCenterWillChangeStatusBarOrientationFrame];
        }
        
        else
        {
            [self recursiveLayoutSubviewsAndSendStatusBarCenterWillChangeStatusBarOrientationFrameMessageInView:subview];
        }
    }
}

- (void)recursiveLayoutSubviewsAndSendStatusBarCenterDidChangeStatusBarOrientationFrameMessageInView:(UIView *)view
{
    [view layoutSubviews];
    
    NSArray *subviews = [view.subviews copy];
    
    for (UIView *subview in subviews)
    {
        if ([subview isKindOfClass:[RFUIStatusBarLayoutView class]])
        {
            RFUIStatusBarLayoutView *statusBarLayoutView = (RFUIStatusBarLayoutView *)subviews;
            
            [statusBarLayoutView statusBarCenterDidChangeStatusBarOrientationFrame];
        }
        
        else
        {
            [self recursiveLayoutSubviewsAndSendStatusBarCenterDidChangeStatusBarOrientationFrameMessageInView:subview];
        }
    }
}

#pragma mark - Observing View-Related Changes

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    RFUIStatusBarCenter *statusBarCenter = [RFUIStatusBarCenter sharedCenter];
    
    RFUIStatusBarLayoutView *superStatusBarLayoutView = [self searchSuperStatusBarLayoutViewInView:self];
    mHasSuperStatusBarLayoutView = (superStatusBarLayoutView != nil);
    
    mStatusBarFrameEnd = statusBarCenter.frameEnd;
    
    BOOL mHasWindowOld = mHasWindow;
    
    if (self.window)
    {
        mHasWindow = YES;
    }
    
    else
    {
        mHasWindow = NO;
    }
    
    if (mHasWindowOld ^ mHasWindow)
    {
        BOOL isFrameChanging = statusBarCenter.isFrameChanging;
        
        if (isFrameChanging)
        {
            [self statusBarCenterWillChangeStatusBarFrame];
        }
        
        else
        {
            [self statusBarCenterDidChangeStatusBarFrame];
        }
        
        BOOL isInterfaceOrientationChanging = statusBarCenter.isInterfaceOrientationChanging;
        
        if (isInterfaceOrientationChanging)
        {
            [self statusBarCenterWillChangeStatusBarOrientationFrame];
        }
        
        else
        {
            [self statusBarCenterDidChangeStatusBarOrientationFrame];
        }
    }
}

#pragma mark - Managing the Views of the RFUIStatusBarLayoutView Object

- (UIView *)backgroundView
{
    if (!mBackgroundView)
    {
        CGRect viewBounds = self.bounds;
        
        CGRect backgroundViewFrame;
        
        CGRect            rotationViewBounds;
        
        UIInterfaceOrientation interfaceOrientationEnd = [RFUIStatusBarCenter sharedCenter].interfaceOrientationEnd;
        
        if (mHasSuperStatusBarLayoutView)
        {
            rotationViewBounds.origin = CGPointZero;
            rotationViewBounds.size = viewBounds.size;
        }
        
        else if (CGRectEqualToRect(mStatusBarFrameEnd, CGRectZero))
        {
            rotationViewBounds.origin = CGPointZero;
            
            switch (interfaceOrientationEnd)
            {
                case UIInterfaceOrientationPortrait:
                {
                    rotationViewBounds.size.width = viewBounds.size.width;
                    rotationViewBounds.size.height = viewBounds.size.height;
                    
                    break;
                }
                    
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    rotationViewBounds.size.width = viewBounds.size.width;
                    rotationViewBounds.size.height = viewBounds.size.height;
                    
                    break;
                }
                    
                case UIInterfaceOrientationLandscapeLeft:
                {
                    rotationViewBounds.size.width = viewBounds.size.height;
                    rotationViewBounds.size.height = viewBounds.size.width;
                    
                    break;
                }
                    
                case UIInterfaceOrientationLandscapeRight:
                {
                    rotationViewBounds.size.width = viewBounds.size.height;
                    rotationViewBounds.size.height = viewBounds.size.width;
                    
                    break;
                }
            }
        }
        
        else
        {
            rotationViewBounds.origin = CGPointZero;
            
            switch (interfaceOrientationEnd)
            {
                case UIInterfaceOrientationPortrait:
                {
                    rotationViewBounds.size.width = viewBounds.size.width;
                    rotationViewBounds.size.height = viewBounds.size.height - 20.0f;
                    
                    break;
                }
                    
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    rotationViewBounds.size.width = viewBounds.size.width;
                    rotationViewBounds.size.height = viewBounds.size.height - 20.0f;
                    
                    break;
                }
                    
                case UIInterfaceOrientationLandscapeLeft:
                {
                    rotationViewBounds.size.width = viewBounds.size.height;
                    rotationViewBounds.size.height = viewBounds.size.width - 20.0f;
                    
                    break;
                }
                    
                case UIInterfaceOrientationLandscapeRight:
                {
                    rotationViewBounds.size.width = viewBounds.size.height;
                    rotationViewBounds.size.height = viewBounds.size.width - 20.0f;
                    
                    break;
                }
            }
        }
        
        backgroundViewFrame.origin = CGPointZero;
        backgroundViewFrame.size = rotationViewBounds.size;
        
        mBackgroundView = [[UIView alloc] initWithFrame:backgroundViewFrame];
        mBackgroundView.userInteractionEnabled = NO;
    }
    
    return mBackgroundView;
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (mBackgroundView != backgroundView)
    {
        [mBackgroundView removeFromSuperview];
        
        mBackgroundView = backgroundView;
        
        if (mBackgroundView)
        {
            [mRotationView insertSubview:mBackgroundView atIndex:0];
        }
    }
}

- (UIView *)contentView
{
    if (!mContentView)
    {
        CGRect viewBounds = self.bounds;
        
        CGRect contentViewFrame;
        
        CGRect rotationViewBounds;
        
        UIInterfaceOrientation interfaceOrientationEnd = [RFUIStatusBarCenter sharedCenter].interfaceOrientationEnd;
        
        if (mHasSuperStatusBarLayoutView)
        {
            rotationViewBounds.origin = CGPointZero;
            rotationViewBounds.size = viewBounds.size;
        }
        
        else if (CGRectEqualToRect(mStatusBarFrameEnd, CGRectZero))
        {
            rotationViewBounds.origin = CGPointZero;
            
            switch (interfaceOrientationEnd)
            {
                case UIInterfaceOrientationPortrait:
                {
                    rotationViewBounds.size.width = viewBounds.size.width;
                    rotationViewBounds.size.height = viewBounds.size.height;
                    
                    break;
                }
                    
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    rotationViewBounds.size.width = viewBounds.size.width;
                    rotationViewBounds.size.height = viewBounds.size.height;
                    
                    break;
                }
                    
                case UIInterfaceOrientationLandscapeLeft:
                {
                    rotationViewBounds.size.width = viewBounds.size.height;
                    rotationViewBounds.size.height = viewBounds.size.width;
                    
                    break;
                }
                    
                case UIInterfaceOrientationLandscapeRight:
                {
                    rotationViewBounds.size.width = viewBounds.size.height;
                    rotationViewBounds.size.height = viewBounds.size.width;
                    
                    break;
                }
            }
        }
        
        else
        {
            rotationViewBounds.origin = CGPointZero;
            
            switch (interfaceOrientationEnd)
            {
                case UIInterfaceOrientationPortrait:
                {
                    rotationViewBounds.size.width = viewBounds.size.width;
                    rotationViewBounds.size.height = viewBounds.size.height - 20.0f;
                    
                    break;
                }
                    
                case UIInterfaceOrientationPortraitUpsideDown:
                {
                    rotationViewBounds.size.width = viewBounds.size.width;
                    rotationViewBounds.size.height = viewBounds.size.height - 20.0f;
                    
                    break;
                }
                    
                case UIInterfaceOrientationLandscapeLeft:
                {
                    rotationViewBounds.size.width = viewBounds.size.height;
                    rotationViewBounds.size.height = viewBounds.size.width - 20.0f;
                    
                    break;
                }
                    
                case UIInterfaceOrientationLandscapeRight:
                {
                    rotationViewBounds.size.width = viewBounds.size.height;
                    rotationViewBounds.size.height = viewBounds.size.width - 20.0f;
                    
                    break;
                }
            }
        }
        
        contentViewFrame.origin = CGPointZero;
        contentViewFrame.size = rotationViewBounds.size;
        
        mContentView = [[UIView alloc] initWithFrame:contentViewFrame];
        mContentView.userInteractionEnabled = YES;
    }
    
    return mContentView;
}

- (void)setContentView:(UIView *)contentView
{
    if (mContentView != contentView)
    {
        [mContentView removeFromSuperview];
        
        mContentView = contentView;
        
        if (mContentView)
        {
            NSInteger index = (NSInteger)mRotationView.subviews.count;
            
            [mRotationView insertSubview:mContentView atIndex:index];
            [self setNeedsLayout];
        }
    }
}

#pragma mark - Configuring the Behavior of Showing the Status Bar

@synthesize supportedApplicationFrame = mSupportedApplicationFrame;
@synthesize supportedInterfaceOrientation = mSupportedInterfaceOrientation;

#pragma mark - Searching Super RFUIStatusBarLayoutView

- (RFUIStatusBarLayoutView *)searchSuperStatusBarLayoutViewInView:(UIView *)view
{
    RFUIStatusBarLayoutView *superStatusBarLayoutView = nil;
    
    UIView *superview = view.superview;
    
    while (superview)
    {
        if ([superview isKindOfClass:[RFUIStatusBarLayoutView class]])
        {
            superStatusBarLayoutView = (RFUIStatusBarLayoutView *)superview;
            break;
        }
        
        else
        {
            superview = superview.superview;
        }
    }
    
    return superStatusBarLayoutView;
}

#pragma mark - Responding to RFUIStatusBarCenter Events

- (void)statusBarCenterWillChangeStatusBarFrame
{
    RFUIStatusBarCenter *statusBarCenter = [RFUIStatusBarCenter sharedCenter];
    
    RFUIStatusBarLayoutView *superStatusBarLayoutView = [self searchSuperStatusBarLayoutViewInView:self];
    mHasSuperStatusBarLayoutView = (superStatusBarLayoutView != nil);
    
    mStatusBarFrameEnd = statusBarCenter.frameEnd;
    
    [self recursiveLayoutSubviewsAndSendStatusBarCenterWillChangeStatusBarFrameMessageInView:self];
}

- (void)statusBarCenterDidChangeStatusBarFrame
{
    RFUIStatusBarCenter *statusBarCenter = [RFUIStatusBarCenter sharedCenter];
    
    RFUIStatusBarLayoutView *superStatusBarLayoutView = [self searchSuperStatusBarLayoutViewInView:self];
    mHasSuperStatusBarLayoutView = (superStatusBarLayoutView != nil);
    
    mStatusBarFrameEnd = statusBarCenter.frameEnd;
    
    [self recursiveLayoutSubviewsAndSendStatusBarCenterDidChangeStatusBarFrameMessageInView:self];
}

- (void)statusBarCenterWillChangeStatusBarOrientationFrame
{
    RFUIStatusBarCenter *statusBarCenter = [RFUIStatusBarCenter sharedCenter];
    
    RFUIStatusBarLayoutView *superStatusBarLayoutView = [self searchSuperStatusBarLayoutViewInView:self];
    mHasSuperStatusBarLayoutView = (superStatusBarLayoutView != nil);
    
    mStatusBarFrameEnd = statusBarCenter.frameEnd;
    
    [self recursiveLayoutSubviewsAndSendStatusBarCenterWillChangeStatusBarOrientationFrameMessageInView:self];
}

- (void)statusBarCenterDidChangeStatusBarOrientationFrame
{
    RFUIStatusBarCenter *statusBarCenter = [RFUIStatusBarCenter sharedCenter];
    
    RFUIStatusBarLayoutView *superStatusBarLayoutView = [self searchSuperStatusBarLayoutViewInView:self];
    mHasSuperStatusBarLayoutView = (superStatusBarLayoutView != nil);
    
    mStatusBarFrameEnd = statusBarCenter.frameEnd;
    
    [self recursiveLayoutSubviewsAndSendStatusBarCenterDidChangeStatusBarOrientationFrameMessageInView:self];
}

@end
