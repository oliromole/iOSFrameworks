//
//  RFUIForwardView.h
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

// Importing the system headers.
#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIView.h>

@class UIView;
@class UIWindow;

@protocol RFUIForwardViewDelegate;

@interface RFUIForwardView : UIView
{
@protected
    
    id<RFUIForwardViewDelegate> __weak mDelegate;
    
    void (^mDidAddSubviewBlock)(UIView *subview);
    void (^mDidMoveToSuperviewBlock)(void);
    void (^mDidMoveToWindowBlock)(void);
    void (^mDrawRectBlock)(CGRect rect);
    void (^mLayoutSubviewsBlock)();
    void (^mWillMoveToSuperviewBlock)(UIView *newSuperview);
    void (^mWillMoveToWindowBlock)(UIWindow *newWindow);
    void (^mWillRemoveSubviewBlock)(UIView *subview);
}

// Initializing and Creating a RFUIForwardView

+ (id)forwardView;
+ (id)forwardViewWithFrame:(CGRect)frame;

// Managing the Delegate

@property (nonatomic, weak) id<RFUIForwardViewDelegate> delegate;

// Laying out Subview

@property (nonatomic, copy) void (^layoutSubviewsBlock)();

// Drawing and Updating the View
@property (nonatomic, copy) void (^drawRectBlock)(CGRect rect);

// Observing View-Related Changes

@property (nonatomic, copy) void (^didAddSubviewBlock)(UIView *subview);
@property (nonatomic, copy) void (^willRemoveSubviewBlock)(UIView *subview);
@property (nonatomic, copy) void (^willMoveToSuperviewBlock)(UIView *newSuperview);
@property (nonatomic, copy) void (^didMoveToSuperviewBlock)(void);
@property (nonatomic, copy) void (^willMoveToWindowBlock)(UIWindow *newWindow);
@property (nonatomic, copy) void (^didMoveToWindowBlock)(void);

@end
