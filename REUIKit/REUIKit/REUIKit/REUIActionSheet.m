//
//  REUIActionSheet.m
//  REUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.11.30.
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
#import "REUIActionSheet.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Importing the system headers.
#import <objc/message.h>
#import <objc/runtime.h>

static id (* UIActionSheet_REUIActionSheet_PreviousInitWithFrame)(id self, SEL _cmd, CGRect frame) = NULL;
static NSInteger (* UIActionSheet_REUIActionSheet_PreviousAddButtonWithTitle)(id self, SEL _cmd, NSString *title) = NULL;
static Class UIActionSheet_REUIActionSheet_Class = Nil;
static Class UIActionSheet_REUIActionSheet_SuperClass = Nil;

id UIActionSheet_REUIActionSheet_InitWithFrame(id self, SEL _cmd, CGRect frame);

id UIActionSheet_REUIActionSheet_InitWithFrame(id self, SEL _cmd, CGRect frame)
{
    if (UIActionSheet_REUIActionSheet_PreviousInitWithFrame)
    {
        self = UIActionSheet_REUIActionSheet_PreviousInitWithFrame(self, _cmd, frame);
    }
    
    else
    {
        struct objc_super objectSuper;
        objectSuper.receiver = self;
        objectSuper.super_class = UIActionSheet_REUIActionSheet_SuperClass;
        
        self = objc_msgSendSuper(&objectSuper, _cmd, frame);
    }
    
    if (self)
    {
        NSMutableArray *buttonDictionaries = [[NSMutableArray alloc] init];
        
        NSMutableDictionary *objectDictionary = [self objectDictionary];
        objectDictionary[REUIActionSheetButtonDictionariesKey] = buttonDictionaries;
    }
    
    return self;
}

NSInteger UIActionSheet_REUIActionSheet_AddButtonWithTitle(id self, SEL _cmd, NSString *title);

NSInteger UIActionSheet_REUIActionSheet_AddButtonWithTitle(id self, SEL _cmd, NSString *title)
{
    NSInteger indexOfButton = 0;
    
    if (UIActionSheet_REUIActionSheet_PreviousAddButtonWithTitle)
    {
        indexOfButton = UIActionSheet_REUIActionSheet_PreviousAddButtonWithTitle(self, _cmd, title);
    }
    
    else
    {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"The global UIActionSheet_REUIActionSheet_PreviousAddButtonWithTitle argument is NULL." userInfo:nil];
    }
    
    NSMutableDictionary *buttonDictionary = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *objectDictionary = [self objectDictionary];
    NSMutableArray *buttonDictionaries = objectDictionary[REUIActionSheetButtonDictionariesKey];
    [buttonDictionaries insertObject:buttonDictionary atIndex:(NSUInteger)indexOfButton];
    
    return indexOfButton;
}

@implementation UIActionSheet (UIActionSheetREUIActionSheet)

#pragma mark - Initializing a Class

+ (void)load
{
    UIActionSheet_REUIActionSheet_Class = [UIActionSheet class];
    UIActionSheet_REUIActionSheet_SuperClass =  [UIActionSheet superclass];
    
    BOOL success;
    
    success = class_addMethod(UIActionSheet_REUIActionSheet_Class, @selector(initWithFrame:), (IMP)UIActionSheet_REUIActionSheet_InitWithFrame, "@24@0:4{CGRect={CGPoint=ff}{CGSize=ff}}8");
    
    if (!success)
    {
        UIActionSheet_REUIActionSheet_PreviousInitWithFrame = (id (*)(id self, SEL _cmd, CGRect frame))class_replaceMethod(UIActionSheet_REUIActionSheet_Class, @selector(initWithFrame:), (IMP)UIActionSheet_REUIActionSheet_InitWithFrame, "@24@0:4{CGRect={CGPoint=ff}{CGSize=ff}}8");
    }
    
    success = class_addMethod(UIActionSheet_REUIActionSheet_Class, @selector(addButtonWithTitle:), (IMP)UIActionSheet_REUIActionSheet_AddButtonWithTitle, "i12@0:4@8");
    
    if (!success)
    {
        UIActionSheet_REUIActionSheet_PreviousAddButtonWithTitle = (NSInteger (*)(id self, SEL _cmd, NSString *title))class_replaceMethod(UIActionSheet_REUIActionSheet_Class, @selector(addButtonWithTitle:), (IMP)UIActionSheet_REUIActionSheet_AddButtonWithTitle, "i12@0:4@8");
    }
}

#pragma mark - Configuring Button Infomation

- (NSMutableDictionary *)buttonDictionaryAtIndex:(NSInteger)index
{
    NSMutableDictionary *objectDictionary = [self objectDictionary];
    NSMutableArray *buttonDictionaries = objectDictionary[REUIActionSheetButtonDictionariesKey];
    NSMutableDictionary *buttonDictionary = buttonDictionaries[(NSUInteger)index];
    
    return buttonDictionary;
}

- (void)setButtonDictionary:(NSMutableDictionary *)buttonDictionary atIndex:(NSInteger)index
{
    if (!buttonDictionary)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The buttonDictionary argument is nil." userInfo:nil];
    }
    
    NSMutableDictionary *objectDictionary = [self objectDictionary];
    NSMutableArray *buttonDictionaries = objectDictionary[REUIActionSheetButtonDictionariesKey];
    buttonDictionaries[(NSUInteger)index] = buttonDictionary;
}

- (NSMutableDictionary *)lastButtonDictionary
{
    NSInteger numberOfButtons = self.numberOfButtons;
    
    NSMutableDictionary *lastButtonDictionary = nil;
    
    if (numberOfButtons > 0)
    {
        lastButtonDictionary = [self buttonDictionaryAtIndex:(numberOfButtons - 1)];
    }
    
    return lastButtonDictionary;
}

- (void)setLastButtonDictionary:(NSMutableDictionary *)buttonDictionary
{
    NSInteger numberOfButtons = self.numberOfButtons;
    
    if (numberOfButtons > 0)
    {
        [self setButtonDictionary:buttonDictionary atIndex:(numberOfButtons - 1)];
    }
}

#pragma mark - Dismissing the Action Sheet

- (void)dismissWithClickedCancelButtonAnimated:(BOOL)animated
{
    NSInteger cancelButtonIndex = self.cancelButtonIndex;
    [self dismissWithClickedButtonIndex:cancelButtonIndex animated:animated];
}

- (void)dismissWithClickedDestructiveButtonAnimated:(BOOL)animated
{
    NSInteger destructiveButtonIndex = self.destructiveButtonIndex;
    [self dismissWithClickedButtonIndex:destructiveButtonIndex animated:animated];
}

@end

NSString * const REUIActionSheetButtonDictionariesKey = @"REUIActionSheetButtonDictionariesKey";
