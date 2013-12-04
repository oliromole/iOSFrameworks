//
//  REUIBarButtonItem.m
//  REUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.11.08.
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
#import "REUIBarButtonItem.h"

// Importing the project headers.
#import "REUIBlockAction.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NSString * const UIBarButtonItemBlockActionKey = @"UIBarButtonItemBlockActionKey";

@implementation UIBarButtonItem (UIBarButtonItemREUIBarButtonItem)

#pragma mark - Initializing and Creating a UIBarButtonItem

+ (id)barButtonItemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    return [[self alloc] initWithImage:image style:style target:target action:action];
}

+ (id)barButtonItemWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    return [[self alloc] initWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:target action:action];
}

+ (id)barButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    return [[self alloc] initWithTitle:title style:style target:target action:action];
}

+ (id)barButtonItemWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action
{
    return [[self alloc] initWithBarButtonSystemItem:systemItem target:target action:action];
}

+ (id)barButtonItemWithCustomView:(UIView *)customView
{
    return [[self alloc] initWithCustomView:customView];
}

- (id)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style blockAction:(void (^)(id sender))block
{
    REUIBlockAction *blockAction = [[REUIBlockAction alloc] init];
    blockAction.block = block;
    
    NSMutableDictionary *objectDictionary = self.objectDictionary;
    [objectDictionary setObject:blockAction forKey:UIBarButtonItemBlockActionKey];
    
    if ((self = [self initWithImage:image style:style target:blockAction action:@selector(sendAction:)]))
    {
    }
    
    return self;
}

+ (id)barButtonItemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style blockAction:(void (^)(id sender))block
{
    return [[self alloc] initWithImage:image style:style blockAction:block];
}

- (id)initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style blockAction:(void (^)(id sender))block
{
    REUIBlockAction *blockAction = [[REUIBlockAction alloc] init];
    blockAction.block = block;
    
    NSMutableDictionary *objectDictionary = self.objectDictionary;
    [objectDictionary setObject:blockAction forKey:UIBarButtonItemBlockActionKey];
    
    if ((self = [self initWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:blockAction action:@selector(sendAction:)]))
    {
    }
    
    return self;
}

+ (id)barButtonItemWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style blockAction:(void (^)(id sender))block
{
    return [[self alloc] initWithImage:image landscapeImagePhone:landscapeImagePhone style:style blockAction:block];
}

- (id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style blockAction:(void (^)(id sender))block
{
    REUIBlockAction *blockAction = [[REUIBlockAction alloc] init];
    blockAction.block = block;
    
    NSMutableDictionary *objectDictionary = self.objectDictionary;
    [objectDictionary setObject:blockAction forKey:UIBarButtonItemBlockActionKey];
    
    if ((self = [self initWithTitle:title style:style target:blockAction action:@selector(sendAction:)]))
    {
    }
    
    blockAction = nil;
    
    return self;
}

+ (id)barButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style blockAction:(void (^)(id sender))block
{
    return [[self alloc] initWithTitle:title style:style blockAction:block];
}

- (id)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem blockAction:(void (^)(id sender))block
{
    REUIBlockAction *blockAction = [[REUIBlockAction alloc] init];
    blockAction.block = block;
    
    NSMutableDictionary *objectDictionary = self.objectDictionary;
    [objectDictionary setObject:blockAction forKey:UIBarButtonItemBlockActionKey];
    
    if ((self = [self initWithBarButtonSystemItem:systemItem target:blockAction action:@selector(sendAction:)]))
    {
    }
    
    return self;
}

+ (id)barButtonItemWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem blockAction:(void (^)(id sender))block
{
    return [[self alloc] initWithBarButtonSystemItem:systemItem blockAction:block];
}

#pragma mark - Getting and Setting Properties

- (void (^)(id sender))blockAction
{
    NSMutableDictionary *objectDictionary = self.objectDictionary;
    REUIBlockAction *blockAction = [objectDictionary objectForKey:UIBarButtonItemBlockActionKey];
    void (^block)(id sender) = blockAction.block;
    return block;
}

- (void)setBlockAction:(void (^)(id sender))newBlock
{
    NSMutableDictionary *objectDictionary = self.objectDictionary;
    REUIBlockAction *oldBlockAction = [objectDictionary objectForKey:UIBarButtonItemBlockActionKey];
    void (^oldBlock)(id sender) = oldBlockAction.block;
    
    if (oldBlock != newBlock)
    {
        REUIBlockAction *newBlockAction = [[REUIBlockAction alloc] init];
        newBlockAction.block = newBlock;
        
        [objectDictionary setObject:newBlockAction forKey:UIBarButtonItemBlockActionKey];
    }
}

@end
