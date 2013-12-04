//
//  RFUIKeyboardLayoutView.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2011.12.25.
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
#import "RFUIKeyboardCenter.h"

// Importing the project headers.
#import "RFUIKeyboardLayoutView.h"

// Importing the external headers.
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUIKeyboardLayoutView

#pragma mark - Initializing and Creating a RFUIKeyboardLayoutView

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        RFUIKeyboardDisplayState displayState = [RFUIKeyboardCenter sharedCenter].displayState;
        
        if ((displayState == RFUIKeyboardDisplayStateShowing) ||
            (displayState == RFUIKeyboardDisplayStateShown))
        {
            mHasKeyboad = YES;
        }
        
        else
        {
            mHasKeyboad = NO;
        }
        
        mFirstResponderArrangement = RFUIFirstResponderArrangementSubviews;
        
        mHasFirstResponder = NO;
        
        mHasWindow = NO;
        
        mKyeboadFrameEnd = [RFUIKeyboardCenter sharedCenter].frameEnd;
        
        mBackgroundView = nil;
        
        mContentView = nil;
    }
    
    return self;
}

#pragma mark - Deallocating a Home Layout View

- (void)dealloc
{
    mBackgroundView = nil;
    
    mContentView = nil;
}

#pragma mark - Laying out Subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect viewFrame = self.frame;
    
    CGRect backgroundViewFrame;
    CGRect contentViewFrame;
    
    if (mHasFirstResponder && mHasKeyboad && mHasWindow)
    {
        CGRect keyboardFrameEnd = CGRectZero;
        
        UIWindow *window = self.window;
        
        if (window)
        {
            keyboardFrameEnd = [self.window convertRect:mKyeboadFrameEnd toView:self];
        }
        
        if ((keyboardFrameEnd.origin.y >= 0) &&
            (keyboardFrameEnd.origin.y < viewFrame.size.height))
        {
            backgroundViewFrame.origin = CGPointZero;
            backgroundViewFrame.size = viewFrame.size;
            
            contentViewFrame.origin.x = 0.0f;
            contentViewFrame.origin.y = 0.0f;
            contentViewFrame.size.width = viewFrame.size.width;
            contentViewFrame.size.height = keyboardFrameEnd.origin.y;
        }
        
        else
        {
            backgroundViewFrame.origin = CGPointZero;
            backgroundViewFrame.size = viewFrame.size;
            
            contentViewFrame.origin = CGPointZero;
            contentViewFrame.size = viewFrame.size;
        }
    }
    
    else
    {
        backgroundViewFrame.origin = CGPointZero;
        backgroundViewFrame.size = viewFrame.size;
        
        contentViewFrame.origin = CGPointZero;
        contentViewFrame.size = viewFrame.size;
    }
    
    [mBackgroundView setFrameIfNeeded:backgroundViewFrame];
    [mContentView setFrameIfNeeded:contentViewFrame];
}

#pragma mark - Laying out Subview and Sending RFUIKeyboardCenter Events

- (void)recursiveLayoutSubviewsAndSendKeyboardCenterWillShowKeyboardMessageInView:(UIView *)view
{
    [view layoutSubviews];
    
    NSArray *subviews = [view.subviews copy];
    
    for (UIView *subview in subviews)
    {
        if ([subview isKindOfClass:[RFUIKeyboardLayoutView class]])
        {
            RFUIKeyboardLayoutView *keyboardLayoutView = (RFUIKeyboardLayoutView *)subviews;
            
            [keyboardLayoutView keyboardCenterWillShowKeyboard];
        }
        
        else
        {
            [self recursiveLayoutSubviewsAndSendKeyboardCenterWillShowKeyboardMessageInView:subview];
        }
    }
}

- (void)recursiveLayoutSubviewsAndSendKeyboardCenterDidShowKeyboardMessageInView:(UIView *)view
{
    [view layoutSubviews];
    
    NSArray *subviews = [view.subviews copy];
    
    for (UIView *subview in subviews)
    {
        if ([subview isKindOfClass:[RFUIKeyboardLayoutView class]])
        {
            RFUIKeyboardLayoutView *keyboardLayoutView = (RFUIKeyboardLayoutView *)subviews;
            
            [keyboardLayoutView keyboardCenterDidShowKeyboard];
        }
        
        else
        {
            [self recursiveLayoutSubviewsAndSendKeyboardCenterDidShowKeyboardMessageInView:subview];
        }
    }
}

- (void)recursiveLayoutSubviewsAndSendKeyboardCenterWillHideKeyboardMessageInView:(UIView *)view
{
    [view layoutSubviews];
    
    NSArray *subviews = [view.subviews copy];
    
    for (UIView *subview in subviews)
    {
        if ([subview isKindOfClass:[RFUIKeyboardLayoutView class]])
        {
            RFUIKeyboardLayoutView *keyboardLayoutView = (RFUIKeyboardLayoutView *)subviews;
            
            [keyboardLayoutView keyboardCenterWillHideKeyboard];
        }
        
        else
        {
            [self recursiveLayoutSubviewsAndSendKeyboardCenterWillHideKeyboardMessageInView:subview];
        }
    }
}

- (void)recursiveLayoutSubviewsAndSendKeyboardCenterDidHideKeyboardMessageInView:(UIView *)view
{
    [view layoutSubviews];
    
    NSArray *subviews = [view.subviews copy];
    
    for (UIView *subview in subviews)
    {
        if ([subview isKindOfClass:[RFUIKeyboardLayoutView class]])
        {
            RFUIKeyboardLayoutView *keyboardLayoutView = (RFUIKeyboardLayoutView *)subviews;
            
            [keyboardLayoutView keyboardCenterDidHideKeyboard];
        }
        
        else
        {
            [self recursiveLayoutSubviewsAndSendKeyboardCenterDidHideKeyboardMessageInView:subview];
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
    
    RFUIFirstResponderArrangement firstResponderArrangement = [self calculateFirstResponderArrangementInView:self];
    
    if (mFirstResponderArrangement & firstResponderArrangement)
    {
        mHasFirstResponder = YES;
    }
    
    else
    {
        mHasFirstResponder = NO;
    }
    
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
        RFUIKeyboardDisplayState keyboardDisplayState = [RFUIKeyboardCenter sharedCenter].displayState;
        
        if (mHasKeyboad && (keyboardDisplayState == RFUIKeyboardDisplayStateHiding))
        {
            [self keyboardCenterWillHideKeyboard];
        }
        
        else if (mHasKeyboad && (keyboardDisplayState == RFUIKeyboardDisplayStateHidden))
        {
            [self keyboardCenterDidHideKeyboard];
        }
        
        else if (!mHasKeyboad && (keyboardDisplayState == RFUIKeyboardDisplayStateShowing))
        {
            [self keyboardCenterWillShowKeyboard];
        }
        
        else if (!mHasKeyboad && (keyboardDisplayState == RFUIKeyboardDisplayStateShown))
        {
            [self keyboardCenterDidShowKeyboard];
        }
    }
}

#pragma mark - Managing the Views of the RFUIKeyboardLayoutView Object

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
        
        if (mHasFirstResponder && mHasKeyboad && mHasWindow)
        {
            CGRect keyboardFrameEnd = CGRectZero;
            
            UIWindow *window = self.window;
            
            if (window)
            {
                keyboardFrameEnd = [self.window convertRect:mKyeboadFrameEnd toView:self];
            }
            
            if ((keyboardFrameEnd.origin.y >= 0) &&
                (keyboardFrameEnd.origin.y < viewFrame.size.height))
            {
                contentViewFrame.origin.x = 0.0f;
                contentViewFrame.origin.y = 0.0f;
                contentViewFrame.size.width = viewFrame.size.width;
                contentViewFrame.size.height = keyboardFrameEnd.origin.y;
            }
            
            else
            {
                contentViewFrame.origin = CGPointZero;
                contentViewFrame.size = viewFrame.size;
            }
        }
        
        else
        {
            contentViewFrame.origin = CGPointZero;
            contentViewFrame.size = viewFrame.size;
        }
        
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
            NSInteger index = (NSInteger)self.subviews.count;
            
            [self insertSubview:mContentView atIndex:index];
            [self setNeedsLayout];
        }
    }
}

#pragma mark - Configuring the Behavior of Showing the Keyboard

- (RFUIFirstResponderArrangement)firstResponderArrangement
{
    return mFirstResponderArrangement;
}

- (void)setFirstResponderArrangement:(RFUIFirstResponderArrangement)firstResponderArrangement
{
    if (mFirstResponderArrangement != firstResponderArrangement)
    {
        mFirstResponderArrangement = firstResponderArrangement;
    }
}

#pragma mark - Searching First Responder

- (UIView *)searchFirstResponderViewInView:(UIView *)view
{
    UIView *firstResponderView = nil;
    
    if (view)
    {
        if ([view isFirstResponder])
        {
            firstResponderView = view;
        }
        
        else
        {
            NSArray *subviews = [view.subviews copy];
            
            for (UIView *subview in subviews)
            {
                firstResponderView = [self searchFirstResponderViewInView:subview];
                
                if (firstResponderView)
                {
                    break;
                }
            }
        }
    }
    
    return firstResponderView;
}

#pragma mark - Calculating RFUIFirstResponderArrangement

- (RFUIFirstResponderArrangement)calculateFirstResponderArrangementInView:(UIView *)view
{
    RFUIFirstResponderArrangement firstResponderArrangementForView = RFUIFirstResponderArrangementSuperviews;
    
    UIView *firstResponderView = [self searchFirstResponderViewInView:view];
    
    if (firstResponderView)
    {
        firstResponderArrangementForView = RFUIFirstResponderArrangementSelf;
        
        NSMutableArray *views = [[NSMutableArray alloc] init];
        
        UIView *view2 = firstResponderView;
        
        while (view2 && (view2 != view))
        {
            [views addObject:view2];
            view2 = view2.superview;
        }
        
        for (UIView *view3 in [views reverseObjectEnumerator])
        {
            if (mContentView && (mContentView == view3))
            {
                firstResponderArrangementForView = RFUIFirstResponderArrangementSubviews;
            }
            
            if ((firstResponderArrangementForView & RFUIFirstResponderArrangementSubviews) &&
                [view3 isKindOfClass:[RFUIKeyboardLayoutView class]])
            {
                firstResponderArrangementForView = RFUIFirstResponderArrangementSubkeyboardLayoutView;
                break;
            }
        }
    }
    
    return firstResponderArrangementForView;
}

#pragma mark - Responding to RFUIKeyboardCenter Events

- (void)keyboardCenterWillShowKeyboard
{
    RFUIFirstResponderArrangement firstResponderArrangement = [self calculateFirstResponderArrangementInView:self];
    
    if (mFirstResponderArrangement & firstResponderArrangement)
    {
        mHasFirstResponder = YES;
    }
    
    else
    {
        mHasFirstResponder = NO;
    }
    
    mHasKeyboad = YES;
    
    mKyeboadFrameEnd = [RFUIKeyboardCenter sharedCenter].frameEnd;
    
    UIViewAnimationCurve animationCurve = [RFUIKeyboardCenter sharedCenter].animationCurve;
    double animationDuration = [RFUIKeyboardCenter sharedCenter].animationDuration;
    
    UIViewAnimationOptions viewAnimationOptions = (UIViewAnimationOptionAllowUserInteraction |
                                                   UIViewAnimationOptionAllowAnimatedContent |
                                                   UIViewAnimationOptionBeginFromCurrentState);
    viewAnimationOptions |= UIViewAnimationOptionsFromUIViewAnimationCurve(animationCurve);
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:viewAnimationOptions
                     animations:^{
                         [self recursiveLayoutSubviewsAndSendKeyboardCenterWillShowKeyboardMessageInView:self];
                     }
                     completion:^(BOOL finished) {
#pragma unused(finished)
                     }];
}

- (void)keyboardCenterDidShowKeyboard
{
    RFUIFirstResponderArrangement firstResponderArrangement = [self calculateFirstResponderArrangementInView:self];
    
    if (mFirstResponderArrangement & firstResponderArrangement)
    {
        mHasFirstResponder = YES;
    }
    
    else
    {
        mHasFirstResponder = NO;
    }
    
    mHasKeyboad = YES;
    
    mKyeboadFrameEnd = [RFUIKeyboardCenter sharedCenter].frameEnd;
    
    UIViewAnimationCurve animationCurve = [RFUIKeyboardCenter sharedCenter].animationCurve;
    double animationDuration = [RFUIKeyboardCenter sharedCenter].animationDuration;
    
    UIViewAnimationOptions viewAnimationOptions = (UIViewAnimationOptionAllowUserInteraction |
                                                   UIViewAnimationOptionAllowAnimatedContent |
                                                   UIViewAnimationOptionBeginFromCurrentState);
    viewAnimationOptions |= UIViewAnimationOptionsFromUIViewAnimationCurve(animationCurve);
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:viewAnimationOptions
                     animations:^{
                         [self recursiveLayoutSubviewsAndSendKeyboardCenterDidShowKeyboardMessageInView:self];
                     }
                     completion:^(BOOL finished) {
#pragma unused(finished)
                     }];
}

- (void)keyboardCenterWillHideKeyboard
{
    RFUIFirstResponderArrangement firstResponderArrangement = [self calculateFirstResponderArrangementInView:self];
    
    if (mFirstResponderArrangement & firstResponderArrangement)
    {
        mHasFirstResponder = YES;
    }
    
    else
    {
        mHasFirstResponder = NO;
    }
    
    mHasKeyboad = NO;
    
    mKyeboadFrameEnd = [RFUIKeyboardCenter sharedCenter].frameEnd;
    
    UIViewAnimationCurve animationCurve = [RFUIKeyboardCenter sharedCenter].animationCurve;
    double animationDuration = [RFUIKeyboardCenter sharedCenter].animationDuration;
    
    UIViewAnimationOptions viewAnimationOptions = (UIViewAnimationOptionAllowUserInteraction |
                                                   UIViewAnimationOptionAllowAnimatedContent |
                                                   UIViewAnimationOptionBeginFromCurrentState);
    viewAnimationOptions |= UIViewAnimationOptionsFromUIViewAnimationCurve(animationCurve);
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:viewAnimationOptions
                     animations:^{
                         [self recursiveLayoutSubviewsAndSendKeyboardCenterWillHideKeyboardMessageInView:self];
                     }
                     completion:^(BOOL finished) {
#pragma unused(finished)
                     }];
}

- (void)keyboardCenterDidHideKeyboard
{
    RFUIFirstResponderArrangement firstResponderArrangement = [self calculateFirstResponderArrangementInView:self];
    
    if (mFirstResponderArrangement & firstResponderArrangement)
    {
        mHasFirstResponder = YES;
    }
    
    else
    {
        mHasFirstResponder = NO;
    }
    
    mHasKeyboad = NO;
    
    mKyeboadFrameEnd = [RFUIKeyboardCenter sharedCenter].frameEnd;
    
    UIViewAnimationCurve animationCurve = [RFUIKeyboardCenter sharedCenter].animationCurve;
    double animationDuration = [RFUIKeyboardCenter sharedCenter].animationDuration;
    
    UIViewAnimationOptions viewAnimationOptions = (UIViewAnimationOptionAllowUserInteraction |
                                                   UIViewAnimationOptionAllowAnimatedContent |
                                                   UIViewAnimationOptionBeginFromCurrentState);
    viewAnimationOptions |= UIViewAnimationOptionsFromUIViewAnimationCurve(animationCurve);
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:viewAnimationOptions
                     animations:^{
                         [self recursiveLayoutSubviewsAndSendKeyboardCenterDidHideKeyboardMessageInView:self];
                     }
                     completion:^(BOOL finished) {
#pragma unused(finished)
                     }];
}

@end
