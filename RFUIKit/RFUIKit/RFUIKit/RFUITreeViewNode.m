//
//  RFUITreeViewNode.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.08.01.
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
#import "RFUITreeViewNode.h"

// Importing the project headers.
#import "RFUITreeViewCell.h"

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

@implementation RFUITreeViewNode

#pragma mark - Initializing and Creating a RFUITreeViewNode

- (id)init
{
    if ((self = [super init]))
    {
        mChildTreeViewNodes = nil;
        mDeleteTreeViewRowAnimation = RFUITreeViewRowAnimationNone;
        mIsExpanded = NO;
        mNeedsGetTreeViewCellHeight = NO;
        mParentTreeViewNode = nil;
        mTreeViewCell = nil;
        mTreeViewCellFrame = CGRectZero;
        mTreeViewCellFrameOld = CGRectZero;
        mTreeViewCellMinimumWidth = 0.0f;
        mTreeViewCellHeight = 0.0f;
    }
    
    return self;
}

+ (id)treeViewNode
{
    return [[self alloc] init];
}

#pragma mark - Deallocating a RFUITreeViewNode

- (void)dealloc
{
    mChildTreeViewNodes = nil;
    
    mTreeViewCell = nil;
}

#pragma mark - Managing the RFUITreeViewNode

@synthesize childTreeViewNodes = mChildTreeViewNodes;
@synthesize deleteTreeViewRowAnimation = mDeleteTreeViewRowAnimation;
@synthesize isExpanded = mIsExpanded;
@synthesize needsGetTreeViewCellHeight = mNeedsGetTreeViewCellHeight;
@synthesize parentTreeViewNode = mParentTreeViewNode;
@synthesize treeViewCell = mTreeViewCell;
@synthesize treeViewCellFrame = mTreeViewCellFrame;
@synthesize treeViewCellFrameOld = mTreeViewCellFrameOld;
@synthesize treeViewCellHeight = mTreeViewCellHeight;
@synthesize treeViewCellMinimumWidth = mTreeViewCellMinimumWidth;

@end
