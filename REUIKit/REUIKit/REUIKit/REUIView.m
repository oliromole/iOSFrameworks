//
//  REUIView.m
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
#import "REUIView.h"

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation UIView (UIViewREUIView)

#pragma mark - Initializing and Creating a UIView

+ (id)view
{
    return [[self alloc] init];
}

+ (id)viewWithFrame:(CGRect)viewFrame
{
    return [[self alloc] initWithFrame:viewFrame];
}

#pragma mark - Configuring a View’s Visual Appearance

- (void)setAlphaIfNeeded:(CGFloat)newAlpha
{
    // Getting the old alpha.
    CGFloat oldAlpha = self.alpha;
    
    // The old alpha and the new alpha are different,
    if (oldAlpha != newAlpha)
    {
        // Setting the new alpha.
        self.alpha = newAlpha;
    }
}

- (void)setHiddenIfNeeded:(BOOL)newHidden
{
    // Getting the old value.
    BOOL oldHidden = self.hidden;
    
    // The old value and new value are different.
    if (oldHidden != newHidden)
    {
        // Setting the new value.
        self.hidden = newHidden;
    }
}

- (void)setOpaqueIfNeeded:(BOOL)newOpaque
{
    // Getting the old value.
    BOOL oldOpaque = self.opaque;
    
    // The old value and new value are different.
    if (oldOpaque != newOpaque)
    {
        // Setting the new value.
        self.opaque = newOpaque;
    }
}

#pragma mark - Configuring the Bounds and Frame Rectangles

- (void)setFrameIfNeeded:(CGRect)newFrame
{
    CGRect oldFrame = self.frame;
    
    if (!CGRectEqualToRect(oldFrame, newFrame))
    {
        self.frame = newFrame;
    }
}

- (void)setBoundsIfNeeded:(CGRect)newBounds
{
    CGRect oldBounds = self.bounds;
    
    if (!CGRectEqualToRect(oldBounds, newBounds))
    {
        self.bounds = newBounds;
    }
}

- (void)setCenterIfNeeded:(CGPoint)newCenter
{
    CGPoint oldCenter = self.center;
    
    if (!CGPointEqualToPoint(oldCenter, newCenter))
    {
        self.center = newCenter;
    }
}

- (void)setTransformIfNeeded:(CGAffineTransform)newTransform
{
    CGAffineTransform oldTransform = self.transform;
    
    if (!CGAffineTransformEqualToTransform(oldTransform, newTransform))
    {
        self.transform = newTransform;
    }
}

#pragma mark - Managing the View Hierarchy

- (UIView *)lastSuperview
{
    UIView *lastSuperview = nil;
    UIView *superview = self.superview;
    
    do
    {
        lastSuperview = superview;
        superview = superview.superview;
    } while (superview);
    
    return lastSuperview;
}

- (void)bringToFront
{
    UIView *superview = self.superview;
    [superview bringSubviewToFront:self];
}

- (void)sendToBack
{
    UIView *superview = self.superview;
    [superview sendSubviewToBack:self];
}

#pragma mark - Laying out Subviews

- (void)recursiveLayoutSubviews
{
    [self layoutSubviews];
    
    NSArray *subviews = [self.subviews copy];
    
    for (UIView *subview in subviews)
    {
        [subview recursiveLayoutSubviews];
    }
}

- (void)recursiveSetNeedsLayout
{
    [self setNeedsLayout];
    
    NSArray *subviews = [self.subviews copy];
    
    for (UIView *subview in subviews)
    {
        [subview recursiveSetNeedsLayout];
    }
}

- (void)recursiveLayoutIfNeeded
{
    [self layoutIfNeeded];
    
    NSArray *subviews = [self.subviews copy];
    
    for (UIView *subview in subviews)
    {
        [subview recursiveSetNeedsLayout];
    }
}

#pragma mark - Rendring the view

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

- (UIImage *)renderImage
{
    // Getting some information about the view.
    CGRect viewFrame = self.frame;
    
    CGFloat contentScaleFactor = self.contentScaleFactor;
    
    // Creating the image context.
    UIGraphicsBeginImageContextWithOptions(viewFrame.size, NO, contentScaleFactor);
    
    // Getting the created context.
    CGContextRef viewContextRef = UIGraphicsGetCurrentContext();
    
    // Rendering the view.
    id viewLayer = self.layer;
    [viewLayer performSelector:@selector(renderInContext:) withObject:(__bridge id)viewContextRef];
    
    // Getting the rendered image.
    UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Releasing the created context.
    UIGraphicsEndImageContext();
    
    // Returning the rendered image.
    return renderedImage;
}

#pragma clang diagnostic pop

@end
