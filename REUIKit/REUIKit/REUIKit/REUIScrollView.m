//
//  REUIScrollView.m
//  REUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.06.26.
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
#import "REUIScrollView.h"

// Importing the project headers.
#import "REUIView.h"

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation UIScrollView (UIScrollViewREUIScrollView)

#pragma mark - Initializing and Creating a UIScrollView

+ (id)scrollView
{
    return [self view];
}

+ (id)scrollViewWithFrame:(CGRect)viewFrame
{
    return [self viewWithFrame:viewFrame];
}

#pragma mark - Managing the Display of Content

- (void)setContentOffsetIfNeeded:(CGPoint)newContentOffset
{
    CGPoint oldContentOffset = self.contentOffset;
    
    if (!CGPointEqualToPoint(oldContentOffset, newContentOffset))
    {
        self.contentOffset = newContentOffset;
    }
}

- (void)setContentSizeIfNeeded:(CGSize)newContentSize
{
    CGSize oldContentSize = self.contentSize;
    
    if (!CGSizeEqualToSize(oldContentSize, newContentSize))
    {
        self.contentSize = newContentSize;
    }
}

- (void)setContentOffsetIfNeeded:(CGPoint)newContentOffset animated:(BOOL)animated
{
    CGPoint oldContentOffset = self.contentOffset;
    
    if (!CGPointEqualToPoint(oldContentOffset, newContentOffset))
    {
        [self setContentOffset:newContentOffset animated:(BOOL)animated];
    }
}

#pragma mark - Managing Scrolling

- (void)scrollRectToVisibleIfNeeded:(CGRect)visibleFrame2 animated:(BOOL)animated
{
    CGRect viewFrame = self.frame;
    
    CGRect visibleFrame1;
    visibleFrame1.origin = self.contentOffset;
    visibleFrame1.size = viewFrame.size;
    
    if (!CGRectContainsRect(visibleFrame1, visibleFrame2))
    {
        [self scrollRectToVisible:visibleFrame2 animated:animated];
    }
}

- (void)setAlwaysBounceHorizontalIfNeeded:(BOOL)newAlwaysBounceHorizontal
{
    BOOL oldAlwaysBounceHorizontal = self.alwaysBounceHorizontal;
    
    if (oldAlwaysBounceHorizontal != newAlwaysBounceHorizontal)
    {
        self.alwaysBounceHorizontal = newAlwaysBounceHorizontal;
    }
}

- (void)setAlwaysBounceVerticalIfNeeded:(BOOL)newAlwaysBounceVertical
{
    BOOL oldAlwaysBounceVertical = self.alwaysBounceVertical;
    
    if (oldAlwaysBounceVertical != newAlwaysBounceVertical)
    {
        self.alwaysBounceVertical = newAlwaysBounceVertical;
    }
}

- (void)setBouncesIfNeeded:(BOOL)newBounces
{
    BOOL oldBounces = self.bounces;
    
    if (oldBounces != newBounces)
    {
        self.bounces = newBounces;
    }
}

- (void)setCanCancelContentTouchesIfNeeded:(BOOL)newCanCancelContentTouches
{
    BOOL oldCanCancelContentTouches = self.canCancelContentTouches;
    
    if (oldCanCancelContentTouches != newCanCancelContentTouches)
    {
        self.canCancelContentTouches = newCanCancelContentTouches;
    }
}

- (void)setDecelerationRateIfNeeded:(CGFloat)newDecelerationRate
{
    CGFloat oldDecelerationRate = self.decelerationRate;
    
    if (oldDecelerationRate != newDecelerationRate)
    {
        self.decelerationRate = newDecelerationRate;
    }
}

- (void)setDelaysContentTouchesIfNeeded:(BOOL)newDelaysContentTouches
{
    BOOL oldDelaysContentTouches = self.delaysContentTouches;
    
    if (oldDelaysContentTouches != newDelaysContentTouches)
    {
        self.delaysContentTouches = newDelaysContentTouches;
    }
}

- (void)setDirectionalLockEnabledIfNeeded:(BOOL)newDirectionalLockEnabled
{
    BOOL oldDirectionalLockEnabled = self.directionalLockEnabled;
    
    if (oldDirectionalLockEnabled != newDirectionalLockEnabled)
    {
        self.directionalLockEnabled = newDirectionalLockEnabled;
    }
}

- (void)setPagingEnabledIfNeeded:(BOOL)newPagingEnabled
{
    BOOL oldPagingEnabled = self.pagingEnabled;
    
    if (oldPagingEnabled != newPagingEnabled)
    {
        self.pagingEnabled = newPagingEnabled;
    }
}

- (void)setScrollEnabledIfNeeded:(BOOL)newScrollEnabled
{
    BOOL oldScrollEnabled = self.scrollEnabled;
    
    if (oldScrollEnabled != newScrollEnabled)
    {
        self.scrollEnabled = newScrollEnabled;
    }
}

- (void)setScrollsToTopIfNeeded:(BOOL)newScrollsToTop
{
    BOOL oldScrollsToTop = self.scrollsToTop;
    
    if (oldScrollsToTop != newScrollsToTop)
    {
        self.scrollsToTop = newScrollsToTop;
    }
}

@end
