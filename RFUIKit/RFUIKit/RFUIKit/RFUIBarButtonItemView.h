//
//  RFUIBarButtonItemView.h
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.05.11.
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

// Importing the project headers.
#import "RFUIBarButtonItemViewContentHeightMode.h"
#import "RFUIBarButtonItemViewContentWidthMode.h"

// Importing the system headers.
#import <CoreGraphics/CGGeometry.h>
#import <Foundation/NSObjCRuntime.h>
#import <UIKit/UIGeometry.h>
#import <UIKit/UIView.h>

@interface RFUIBarButtonItemView : UIView
{
@protected
    
    UIEdgeInsets                            mContentEdgeInsets;
    RFUIBarButtonItemViewContentHeightMode  mContentHeightMode;
    CGSize                                  mContentSize;
    UIView                                 *mContentView;
    RFUIBarButtonItemViewContentWidthMode   mContentWidthMode;
}

// Managing the Content View

// Recomented content edge insets for iPad:
//  {0.0f, 0.0f, 0.0f, 0.0f},
//  {0.0f, -7.0f, 0.0f, -4.0f},
//  {0.0f, -4.0f, 0.0f, -4.0f},
//  {0.0f, -4.0f, 0.0f, -7.0f}.
@property (nonatomic)           UIEdgeInsets                            contentEdgeInsets; // Default is UIEdgeInsetsZero.

@property (nonatomic)           RFUIBarButtonItemViewContentHeightMode  contentHeightMode; // Default is RFUIBarButtonItemViewContentHeightModeAuto.
@property (nonatomic)           CGSize                                  contentSize;
@property (nonatomic, readonly) UIView                                 *contentView;
@property (nonatomic)           RFUIBarButtonItemViewContentWidthMode   contentWidthMode;  // Default is RFUIBarButtonItemViewContentWidthModeLeft.

@end

FOUNDATION_EXTERN const UIEdgeInsets RFUIBarButtonItemViewContentEdgeInsetsZero;        // {0.0f, 0.0f, 0.0f, 0.0f}
FOUNDATION_EXTERN const UIEdgeInsets RFUIBarButtonItemViewContentEdgeInsetsLeft_iPad;   // {0.0f, -7.0f, 0.0f, -4.0f}
FOUNDATION_EXTERN const UIEdgeInsets RFUIBarButtonItemViewContentEdgeInsetsCenter_iPad; // {0.0f, -4.0f, 0.0f, -4.0f}
FOUNDATION_EXTERN const UIEdgeInsets RFUIBarButtonItemViewContentEdgeInsetsRight_iPad;  // {0.0f, -4.0f, 0.0f, -7.0f}
