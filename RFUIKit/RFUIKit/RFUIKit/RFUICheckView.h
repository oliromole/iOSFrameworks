//
//  RFUICheckView.h
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.07.11.
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
#import <Foundation/NSObjCRuntime.h>
#import <UIKit/UIButton.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIGeometry.h>

@class NSMutableArray;

@interface RFUICheckView : UIButton
{
@protected
    
    NSUInteger      mCurrentState;
    NSMutableArray *mEntities;
    UIEdgeInsets    mStateViewEdgeInsets;
}

// Initializing and Creating a RFUICheckView

- (id)initWithNumberOfStates:(NSUInteger)numberOfStates;

// Counting States

@property (nonatomic) NSUInteger numberOfStates;

// Managing Check View Content

- (UIView *)stateViewForState:(NSUInteger)state controlState:(UIControlState)conrolState;
- (void)setStateView:(UIView *)stateView forState:(NSUInteger)state controlState:(UIControlState)conrolState;

- (UIView *)lastStateViewForControlState:(UIControlState)conrolState;
- (void)setLastStateView:(UIView *)stateView forControlState:(UIControlState)conrolState;

// Managing Check View Content

@property (nonatomic) NSUInteger currentState;

- (void)addState;
- (void)insertState:(NSUInteger)state;
- (void)removeState:(NSUInteger)state;
- (void)removeLastState;

// Configuring Edge Insets

@property (nonatomic) UIEdgeInsets stateViewEdgeInsets; // Default is UIEdgeInsetsZero.

@end
