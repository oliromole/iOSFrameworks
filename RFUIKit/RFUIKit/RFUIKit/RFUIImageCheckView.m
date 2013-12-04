//
//  RFUIImageCheckView.m
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

// Importing the header.
#import "RFUIImageCheckView.h"

// Importing the system headers.
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUIImageCheckView

#pragma mark - Initializing and Creating a RFUICheckView

- (id)initWithNormalStateImageNameds:(NSArray *)normalStateImageNameds disabledStateImageNameds:(NSArray *)disabledStateImageNameds
{
    NSUInteger numberOfState = 0;
    
    if (normalStateImageNameds && (numberOfState < normalStateImageNameds.count))
    {
        numberOfState = normalStateImageNameds.count;
    }
    
    if (disabledStateImageNameds && (numberOfState < disabledStateImageNameds.count))
    {
        numberOfState = disabledStateImageNameds.count;
    }
    
    if ((self = [super initWithNumberOfStates:numberOfState]))
    {
        for (NSUInteger state = 0; state < normalStateImageNameds.count; state++)
        {
            NSString *normalStateImageNamed = [normalStateImageNameds objectAtIndex:state];
            
            [self setStateImageNamed:normalStateImageNamed forState:state controlState:UIControlStateNormal];
        }
        
        for (NSUInteger state = 0; state < disabledStateImageNameds.count; state++)
        {
            NSString *disabledStateImageNamed = [disabledStateImageNameds objectAtIndex:state];
            
            [self setStateImageNamed:disabledStateImageNamed forState:state controlState:UIControlStateDisabled];
        }
    }
    
    return self;
}

#pragma mark - Deallocating a RFUICheckView

- (void)dealloc
{
}

#pragma mark - Managing Check View Content

- (UIImageView *)stateImageViewForState:(NSUInteger)state controlState:(UIControlState)conrolState
{
    UIImageView *stateImageView = (UIImageView *)[self stateViewForState:state controlState:conrolState];
    return stateImageView;
}

- (void)setStateImageView:(UIImageView *)stateImageView forState:(NSUInteger)state controlState:(UIControlState)conrolState
{
    [self setStateView:stateImageView forState:state controlState:conrolState];
}

- (UIImageView *)lastStateImageViewForControlState:(UIControlState)conrolState
{
    UIImageView *lastStateImageView = (UIImageView *)[self lastStateViewForControlState:conrolState];
    return lastStateImageView;
}

- (void)setLastStateImageView:(UIImageView *)stateImageView forControlState:(UIControlState)conrolState
{
    [self setLastStateView:stateImageView forControlState:conrolState];
}

- (void)setStateImageNamed:(NSString *)stateImageNamed forState:(NSUInteger)state controlState:(UIControlState)conrolState
{
    UIImage *stateImage = [UIImage imageNamed:stateImageNamed];
    
    UIImageView *stateImageView = [[UIImageView alloc] initWithImage:stateImage];
    
    [self setStateImageView:stateImageView forState:state controlState:conrolState];
}

- (void)setLastStateImageNamed:(NSString *)stateImageNamed forControlState:(UIControlState)conrolState
{
    UIImage *stateImage = [UIImage imageNamed:stateImageNamed];
    
    UIImageView *stateImageView = [[UIImageView alloc] initWithImage:stateImage];
    
    [self setLastStateImageView:stateImageView forControlState:conrolState];
}

@end
