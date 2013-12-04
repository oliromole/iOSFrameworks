//
//  REUIPopoverController.m
//  REUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.05.18.
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
#import "REUIPopoverController.h"

// Importing the project headers.
#import "REUIView.h"

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation UIPopoverController (UIPopoverControllerREUIPopoverController)

#pragma mark - Configuring the Popover Attributes

- (void)setPopoverContentSizeIfNeeded:(CGSize)popoverContentSize
{
    //
    // See also:
    // https://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIPopoverController_class/Reference/Reference.html
    //
    
    // Setting the new popover content size with animation.
    [self setPopoverContentSizeIfNeeded:popoverContentSize animated:YES];
}

- (void)setPopoverContentSizeIfNeeded:(CGSize)newPopoverContentSize animated:(BOOL)animated
{
    // Getting the old popover content size.
    CGSize oldPopoverContentSize = self.popoverContentSize;
    
    // The old popover content size and the new popover content size are different.
    if (!CGSizeEqualToSize(oldPopoverContentSize, newPopoverContentSize))
    {
        // Setting the new popover content size.
        [self setPopoverContentSize:newPopoverContentSize animated:animated];
    }
}

#pragma mark - Presenting and Dismissing the Popover

- (void)presentPopoverInView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;
{
    // Getting the view frame.
    CGRect viewFrame = UIViewGetFrame(view);
    
    // Present the popover in the view.
    [self presentPopoverFromRect:CGRectMake(0.0f, 0.0f, viewFrame.size.width, viewFrame.size.height) inView:view permittedArrowDirections:arrowDirections animated:animated];
}

@end
