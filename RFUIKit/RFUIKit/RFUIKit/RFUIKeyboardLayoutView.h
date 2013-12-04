//
//  RFUIKeyboardLayoutView.h
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

// Importing the project headers.
#import "RFUIFirstResponderArrangement.h"

// Importing the system headers.
#import <CoreGraphics/CGGeometry.h>
#import <Foundation/NSObjCRuntime.h>
#import <UIKit/UIView.h>

@interface RFUIKeyboardLayoutView : UIView
{
@protected
    
    UIView                        *mBackgroundView;
    UIView                        *mContentView;
    RFUIFirstResponderArrangement  mFirstResponderArrangement;
    BOOL                           mHasFirstResponder;
    BOOL                           mHasKeyboad;
    BOOL                           mHasWindow;
    CGRect                         mKyeboadFrameEnd;
}

// Managing the Views of the RFUIKeyboardLayoutView Object

@property (nonatomic, strong) UIView *backgroundView; // Default is nil. The first time the property is accessed, the UIView is created.
@property (nonatomic, strong) UIView *contentView;    // Default is nil. The first time the property is accessed, the UIView is created.

// Configuring the Behavior of Showing the Keyboard

@property (nonatomic) RFUIFirstResponderArrangement firstResponderArrangement; // Default value is RFUIFirstResponderArrangementSubviews.

// Responding to RFUIKeyboardCenter Events

- (void)keyboardCenterWillShowKeyboard;
- (void)keyboardCenterDidShowKeyboard;
- (void)keyboardCenterWillHideKeyboard;
- (void)keyboardCenterDidHideKeyboard;

@end
