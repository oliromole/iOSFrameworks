//
//  REUIViewController.m
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
#import "REUIViewController.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Importing the system headers.
#import <objc/runtime.h>

NSString * const UIViewController_UIViewControllerREUIViewController_IsAppearedKey = @"UIViewController_UIViewControllerREUIViewController_IsAppearedKey";

void (*UIViewController_UIViewControllerREUIViewController_Old_viewWillAppear)(id self, SEL _cmd, BOOL animated) = NULL;

void UIViewController_UIViewControllerREUIViewController_New_viewWillAppear(id self, SEL _cmd, BOOL animated);
void UIViewController_UIViewControllerREUIViewController_New_viewWillAppear(id self, SEL _cmd, BOOL animated)
{
    if (UIViewController_UIViewControllerREUIViewController_Old_viewWillAppear)
    {
        UIViewController_UIViewControllerREUIViewController_Old_viewWillAppear(self, _cmd, animated);
    }
    
    [self setAssociatedObject:@(YES) forKey:(const void *)UIViewController_UIViewControllerREUIViewController_IsAppearedKey policy:NSObjectAssociationPolicyStrongNonatomic];
}

void (*UIViewController_UIViewControllerREUIViewController_Old_viewDidAppear)(id self, SEL _cmd, BOOL animated) = NULL;

void UIViewController_UIViewControllerREUIViewController_New_viewDidAppear(id self, SEL _cmd, BOOL animated);
void UIViewController_UIViewControllerREUIViewController_New_viewDidAppear(id self, SEL _cmd, BOOL animated)
{
    if (UIViewController_UIViewControllerREUIViewController_Old_viewDidAppear)
    {
        UIViewController_UIViewControllerREUIViewController_Old_viewDidAppear(self, _cmd, animated);
    }
    
    [self setAssociatedObject:@(YES) forKey:(const void *)UIViewController_UIViewControllerREUIViewController_IsAppearedKey policy:NSObjectAssociationPolicyStrongNonatomic];
}

void (*UIViewController_UIViewControllerREUIViewController_Old_viewWillDisappear)(id self, SEL _cmd, BOOL animated) = NULL;

void UIViewController_UIViewControllerREUIViewController_New_viewWillDisppear(id self, SEL _cmd, BOOL animated);
void UIViewController_UIViewControllerREUIViewController_New_viewWillDisppear(id self, SEL _cmd, BOOL animated)
{
    if (UIViewController_UIViewControllerREUIViewController_Old_viewWillDisappear)
    {
        UIViewController_UIViewControllerREUIViewController_Old_viewWillDisappear(self, _cmd, animated);
    }
    
    [self setAssociatedObject:@(NO) forKey:(const void *)UIViewController_UIViewControllerREUIViewController_IsAppearedKey policy:NSObjectAssociationPolicyStrongNonatomic];
}

void (*UIViewController_UIViewControllerREUIViewController_Old_viewDidDisppear)(id self, SEL _cmd, BOOL animated) = NULL;

void UIViewController_UIViewControllerREUIViewController_New_viewDidDisppear(id self, SEL _cmd, BOOL animated);
void UIViewController_UIViewControllerREUIViewController_New_viewDidDisppear(id self, SEL _cmd, BOOL animated)
{
    if (UIViewController_UIViewControllerREUIViewController_Old_viewDidDisppear)
    {
        UIViewController_UIViewControllerREUIViewController_Old_viewDidDisppear(self, _cmd, animated);
    }
    
    [self setAssociatedObject:@(NO) forKey:(const void *)UIViewController_UIViewControllerREUIViewController_IsAppearedKey policy:NSObjectAssociationPolicyStrongNonatomic];
}

@implementation UIViewController (UIViewControllerREUIViewController)

#pragma mark - Initializing a Class

+ (void)load
{
    BOOL success;
    
    Class viewControllerClass = [UIViewController class];
    
    success = class_addMethod(viewControllerClass, @selector(viewWillAppear:), (IMP)UIViewController_UIViewControllerREUIViewController_New_viewWillAppear, "v12@0:4c8");
    
    if (!success)
    {
        UIViewController_UIViewControllerREUIViewController_Old_viewWillAppear = (void (*)(id self, SEL _cmd, BOOL animated))class_replaceMethod(viewControllerClass, @selector(viewWillAppear:), (IMP)UIViewController_UIViewControllerREUIViewController_New_viewWillAppear, "v12@0:4c8");
    }
    
    success = class_addMethod(viewControllerClass, @selector(viewDidAppear:), (IMP)UIViewController_UIViewControllerREUIViewController_New_viewDidAppear, "v12@0:4c8");
    
    if (!success)
    {
        UIViewController_UIViewControllerREUIViewController_Old_viewDidAppear = (void (*)(id self, SEL _cmd, BOOL animated))class_replaceMethod(viewControllerClass, @selector(viewDidAppear:), (IMP)UIViewController_UIViewControllerREUIViewController_New_viewDidAppear, "v12@0:4c8");
    }
    
    success = class_addMethod(viewControllerClass, @selector(viewWillDisappear:), (IMP)UIViewController_UIViewControllerREUIViewController_New_viewWillDisppear, "v12@0:4c8");
    
    if (!success)
    {
        UIViewController_UIViewControllerREUIViewController_Old_viewWillDisappear = (void (*)(id self, SEL _cmd, BOOL animated))class_replaceMethod(viewControllerClass, @selector(viewWillDisappear:), (IMP)UIViewController_UIViewControllerREUIViewController_New_viewWillDisppear, "v12@0:4c8");
    }
    
    success = class_addMethod(viewControllerClass, @selector(viewDidDisappear:), (IMP)UIViewController_UIViewControllerREUIViewController_New_viewDidDisppear, "v12@0:4c8");
    
    if (!success)
    {
        UIViewController_UIViewControllerREUIViewController_Old_viewDidDisppear = (void (*)(id self, SEL _cmd, BOOL animated))class_replaceMethod(viewControllerClass, @selector(viewDidDisappear:), (IMP)UIViewController_UIViewControllerREUIViewController_New_viewDidDisppear, "v12@0:4c8");
    }
}

#pragma mark - Initializing and Creating a UIViewController

+ (id)viewController
{
    return [[self alloc] init];
}

+ (id)viewControllerWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [[self alloc] initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

#pragma mark - Responding to View Events

- (BOOL)isAppeared
{
    // Getting the value that indicates the view controller is appeared.
    NSNumber *isAppearedNumber = [self associatedObjectForKey:(const void *)UIViewController_UIViewControllerREUIViewController_IsAppearedKey];
    BOOL isAppeared = isAppearedNumber.boolValue;
    
    // Returning the value that indicates the view controller is appeared.
    return isAppeared;
}

#pragma mark - Configuring Display in a Popover Controller

- (void)setContentSizeForViewInPopoverIfNeeded:(CGSize)newContentSizeForViewInPopover
{
    // Getting the old content size for the view in a popover.
    CGSize oldContentSizeForViewInPopover = self.contentSizeForViewInPopover;
    
    // The olnd content size and new content size are different.
    if (!CGSizeEqualToSize(oldContentSizeForViewInPopover, newContentSizeForViewInPopover))
    {
        // Applying the new content size for the view in a popover.
        self.contentSizeForViewInPopover = newContentSizeForViewInPopover;
    }
}

- (void)setModalInPopoverIfNeeded:(BOOL)newModalInPopover
{
    // Getting the old modal in a popover.
    BOOL oldModalInPopover = self.modalInPopover;
    
    // The old modal and the new modal are diffeerent.
    if (oldModalInPopover != newModalInPopover)
    {
        // Applying the new model in a popover.
        self.modalInPopover = newModalInPopover;
    }
}

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

static id UIViewController_PopoverController(UIViewController *self, SEL _cmd)
{
#pragma unused(_cmd)
    
    // Setting the default values.
    UIPopoverController *popoverController = nil;
    
    // Getting the getter selector for the "popoverController" private property .
    SEL popoverControllerSelector = NSSelectorFromString(@"_popoverController");
    
    if (popoverControllerSelector && [self respondsToSelector:popoverControllerSelector])
    {
        // Getting the popover controller via the privete property.
        popoverController = [self performSelector:popoverControllerSelector];
    }
    
    // Returning the popover controller.
    return popoverController;
}

#pragma clang diagnostic pop

@implementation UIViewController (UIViewControllerPrivateREUIViewController_Dynamic)

#pragma mark - Initializing a Class

+ (void)load
{
    // Getting the getter selector for the "popoverController" private property .
    SEL popoverControllerSelector = NSSelectorFromString(@"popoverController");
    
    // Adding the getter of the popoverController property if if is needed.
    class_addMethod([UIViewController class], popoverControllerSelector, (IMP)UIViewController_PopoverController, "@8@0:4");
}

@end
