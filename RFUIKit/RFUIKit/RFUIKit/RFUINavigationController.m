//
//  RFUINavigationController.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2011.12.11.
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
#import "RFUINavigationController.h"

// Importing the system headers.
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUINavigationController

#pragma mark - Initializing and Creating a RFUINavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        mInterfaceOrientationMode = RFUIInterfaceOrientationModeDefault;
    }
    
    return self;
}

#pragma mark - Deallocating a RFUINavigationController

- (void)dealloc
{
}

#pragma mark - Managing the View

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - Handling Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Configuring the View Rotation Settings

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (mInterfaceOrientationMode == RFUIInterfaceOrientationModeDefault)
    {
        BOOL shouldAutorotate = [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
        return shouldAutorotate;
    }
    
    else if (mInterfaceOrientationMode == RFUIInterfaceOrientationModeFixedV1)
    {
        BOOL shouldAutorotate = [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
        return shouldAutorotate;
    }
    
    BOOL shouldAutorotate = [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    return shouldAutorotate;
}

- (BOOL)shouldAutorotate
{
    if (mInterfaceOrientationMode == RFUIInterfaceOrientationModeDefault)
    {
        BOOL shouldAutorotate = [super shouldAutorotate];
        return shouldAutorotate;
    }
    
    else if (mInterfaceOrientationMode == RFUIInterfaceOrientationModeFixedV1)
    {
        BOOL shouldAutorotate = YES;
        
        UIViewController *topViewController = self.topViewController;
        
        if (topViewController)
        {
            BOOL childShouldAutorotate = topViewController.shouldAutorotate;
            shouldAutorotate &= childShouldAutorotate;
        }
        
        return shouldAutorotate;
    }
    
    BOOL shouldAutorotate = [super shouldAutorotate];
    return shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if (mInterfaceOrientationMode == RFUIInterfaceOrientationModeDefault)
    {
        UIInterfaceOrientationMask supportedInterfaceOrientations = [super supportedInterfaceOrientations];
        return supportedInterfaceOrientations;
    }
    
    else if (mInterfaceOrientationMode == RFUIInterfaceOrientationModeFixedV1)
    {
        UIInterfaceOrientationMask supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
        
        UIViewController *topViewController = self.topViewController;
        
        if (topViewController)
        {
            UIInterfaceOrientationMask childSupportedInterfaceOrientations = topViewController.supportedInterfaceOrientations;
            supportedInterfaceOrientations &= childSupportedInterfaceOrientations;
        }
        
        return supportedInterfaceOrientations;
    }
    
    UIInterfaceOrientationMask supportedInterfaceOrientations = [super supportedInterfaceOrientations];
    return supportedInterfaceOrientations;
}

#pragma mark - Responding to View Events

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Configuring the View Rotation Settings

@synthesize interfaceOrientationMode = mInterfaceOrientationMode;

@end
