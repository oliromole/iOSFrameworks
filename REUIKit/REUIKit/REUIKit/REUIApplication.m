//
//  REUIApplication.m
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
#import "REUIApplication.h"

// Importing the system headers.
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation UIApplication (UIApplicationREUIApplication)

#pragma mark - Controlling and Handling Events

- (void)setApplicationSupportsShakeToEditIfNeeded:(BOOL)newApplicationSupportsShakeToEdit
{
    BOOL oldApplicationSupportsShakeToEdit = self.applicationSupportsShakeToEdit;
    
    if (oldApplicationSupportsShakeToEdit != newApplicationSupportsShakeToEdit)
    {
        self.applicationSupportsShakeToEdit = newApplicationSupportsShakeToEdit;
    }
}

#pragma mark - Managing Status Bar Orientation

- (void)setStatusBarOrientationIfNeeded:(UIInterfaceOrientation)newStatusBarOrientation
{
    UIInterfaceOrientation oldStatusBarOrientation = self.statusBarOrientation;
    
    if (oldStatusBarOrientation != newStatusBarOrientation)
    {
        self.statusBarOrientation = newStatusBarOrientation;
    }
}

- (void)setStatusBarOrientationIfNeeded:(UIInterfaceOrientation)newStatusBarOrientation animated:(BOOL)animated
{
    UIInterfaceOrientation oldStatusBarOrientation = self.statusBarOrientation;
    
    if (oldStatusBarOrientation != newStatusBarOrientation)
    {
        [self setStatusBarOrientation:newStatusBarOrientation animated:animated];
    }
}

#pragma mark - Controlling Application Appearance

- (void)setApplicationIconBadgeNumberIfNeeded:(NSInteger)newApplicationIconBadgeNumber
{
    NSInteger oldApplicationIconBadgeNumber = self.applicationIconBadgeNumber;
    
    if (oldApplicationIconBadgeNumber != newApplicationIconBadgeNumber)
    {
        self.applicationIconBadgeNumber = newApplicationIconBadgeNumber;
    }
}

- (void)setNetworkActivityIndicatorVisibleIfNeeded:(BOOL)newNetworkActivityIndicatorVisible
{
    BOOL oldNnetworkActivityIndicatorVisible = self.networkActivityIndicatorVisible;
    
    if (oldNnetworkActivityIndicatorVisible != newNetworkActivityIndicatorVisible)
    {
        self.networkActivityIndicatorVisible = newNetworkActivityIndicatorVisible;
    }
}

- (void)setStatusBarHiddenIfNeeded:(BOOL)newStatusBarHidden
{
    BOOL oldStatusBarHidden = self.statusBarHidden;
    
    if (oldStatusBarHidden != newStatusBarHidden)
    {
        self.statusBarHidden = newStatusBarHidden;
    }
}

- (void)setStatusBarHiddenIfNeeded:(BOOL)newStatusBarHidden withAnimation:(UIStatusBarAnimation)statusBarAnimation
{
    BOOL oldStatusBarHidden = self.statusBarHidden;
    
    if (oldStatusBarHidden != newStatusBarHidden)
    {
        [self setStatusBarHidden:newStatusBarHidden withAnimation:statusBarAnimation];
    }
}

- (void)setStatusBarStyleIfNeeded:(UIStatusBarStyle)newStatusBarStyle
{
    UIStatusBarStyle oldStatusBarStyle = self.statusBarStyle;
    
    if (oldStatusBarStyle != newStatusBarStyle)
    {
        self.statusBarStyle = newStatusBarStyle;
    }
}

- (void)setStatusBarStyleIfNeeded:(UIStatusBarStyle)newStatusBarStyle animated:(BOOL)animated
{
    UIStatusBarStyle oldStatusBarStyle = self.statusBarStyle;
    
    if (oldStatusBarStyle != newStatusBarStyle)
    {
        [self setStatusBarStyle:newStatusBarStyle animated:animated];
    }
}

@end
