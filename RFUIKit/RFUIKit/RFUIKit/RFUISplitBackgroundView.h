//
//  RFUISplitBackgroundView.h
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2011.12.05.
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

// Importing the system headers.
#import <CoreGraphics/CGBase.h>
#import <UIKit/UIView.h>

@class UIView;

/*
 The RFUISplitBackgroundView split the background view into 9 views.
 
 w0 w1 w2
 
 h0  00 01 02
 h1  10 11 12
 h2  20 21 22
 
 w0, w1, w2 - widths.
 h0, h1, h2 - heights.
 
 w1, h1 - determined automatically.
 
 */
@interface RFUISplitBackgroundView : UIView
{
@protected
    
    CGFloat  mHeight0;
    CGFloat  mHeight2;
    UIView  *mView00;
    UIView  *mView01;
    UIView  *mView02;
    UIView  *mView10;
    UIView  *mView11;
    UIView  *mView12;
    UIView  *mView20;
    UIView  *mView21;
    UIView  *mView22;
    CGFloat  mWidth0;
    CGFloat  mWidth2;
}

// Configuring the RFUISplitBackgroundView

@property (nonatomic) CGFloat height0;
@property (nonatomic) CGFloat height2;
@property (nonatomic) CGFloat width0;
@property (nonatomic) CGFloat width2;

// Managing the Content

@property (nonatomic, strong) UIView *view00; // Default is nil. The first time the property is accessed, the UIView is created.
@property (nonatomic, strong) UIView *view01; // Default is nil. The first time the property is accessed, the UIView is created.
@property (nonatomic, strong) UIView *view02; // Default is nil. The first time the property is accessed, the UIView is created.
@property (nonatomic, strong) UIView *view10; // Default is nil. The first time the property is accessed, the UIView is created.
@property (nonatomic, strong) UIView *view11; // Default is nil. The first time the property is accessed, the UIView is created.
@property (nonatomic, strong) UIView *view12; // Default is nil. The first time the property is accessed, the UIView is created.
@property (nonatomic, strong) UIView *view20; // Default is nil. The first time the property is accessed, the UIView is created.
@property (nonatomic, strong) UIView *view21; // Default is nil. The first time the property is accessed, the UIView is created.
@property (nonatomic, strong) UIView *view22; // Default is nil. The first time the property is accessed, the UIView is created.

@end
