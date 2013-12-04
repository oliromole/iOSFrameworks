//
//  RFUITreeView.h
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

// Importing the project headers.
#import "RFUITreeViewDelegate.h"
#import "RFUITreeViewRowAnimation.h"
#import "RFUITreeViewScrollPosition.h"

// Importing the system headers.
#import <CoreGraphics/CGBase.h>
#import <Foundation/NSObjCRuntime.h>
#import <UIKit/UIScrollView.h>

@class NSArray;
@class NSIndexPath;
@class NSMutableArray;
@class NSString;
@class UIView;

@protocol RFUITreeViewDataSource;

@class RFUITreeView;
@class RFUITreeViewCell;

@interface RFUITreeView : UIScrollView
{
@protected
    
    id<RFUITreeViewDataSource> __weak mDataSource;
    id<RFUITreeViewDelegate>   __weak mDelegate;
    
    UIView         *mBackgroundView;
    UIView         *mContentView;
    CGFloat         mContentViewCalculatedHeight;
    NSMutableArray *mDeletedTreeViewNodes;
    NSMutableArray *mReusableTreeViewCells;
    NSMutableArray *mRootTreeViewNodes;
    CGFloat         mTreeViewCellCalculatedMinimumWidth;
    CGFloat         mTreeViewCellHeight;
    CGFloat         mTreeViewCellMinimumWidth;
    NSInteger       mUpdateCounter;
    NSMutableArray *mVisibleTreeViewNodes;
    
    id (^mTreeViewNodesBlock)(id object, NSIndexPath *indexPath);
    
    struct
    {
        unsigned int dataSource_numberOfRowsInRootInTreeView : 1;
        unsigned int dataSource_treeView_numberOfRowsInParentRowAtIndexPath : 1;
        unsigned int dataSource_treeView_expandedRowAtIndexPath : 1;
        unsigned int dataSource_treeView_cellForRowAtIndexPath : 1;
        unsigned int delegete_treeViewShouldUseDynamicWidth : 1;
        unsigned int delegete_minimumWidthForRowAtIndexPath : 1;
        unsigned int delegete_heightForRowAtIndexPath_width : 1;
        unsigned int needsLoadTreeViewCellHeight : 1;
        unsigned int needsLoadTreeViewCellMinimumWidth : 1;
        unsigned int needsReloadData : 1;
        unsigned int usesDynamicWidth : 1;
    } mTreeFlags;
}

// Initializing and Creating a RFUITreeView

+ (id)treeViewWithFrame:(CGRect)frame;

// Managing the Delegate and the Data Source

@property (nonatomic, weak) id<RFUITreeViewDataSource> dataSource;
@property (nonatomic, weak) id<RFUITreeViewDelegate>   delegate;

// Configuring a Tree View

@property (nonatomic, strong) UIView  *backgroundView;   // Default is nil. The first time the property is accessed, the UIView is created.
@property (nonatomic)         BOOL     usesDynamicWidth; // Default is NO.
@property (nonatomic)         CGFloat  minimumRowWidth;  // Default is 0.0f.
@property (nonatomic)         CGFloat  rowHeight;        // Default is 44.0f.

- (NSInteger)numberOfRowsInRoot;
- (NSInteger)numberOfRowsInParentRowAtIndexPath:(NSIndexPath *)indexPath;

// Creating Tree View Cells

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

// Reloading the Tree View

- (void)reloadData;

// Accessing Drawing Areas of the Tree View

- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath;

// Accessing Cells

- (NSIndexPath *)copyIndexPathForCell:(RFUITreeViewCell *)treeViewCell;   // Returns nil if cell is not visible.
- (NSIndexPath *)indexPathForCell:(RFUITreeViewCell *)treeViewCell;       // Returns nil if cell is not visible.

- (NSIndexPath *)copyIndexPathForRowAtPoint:(CGPoint)point;               // Returns nil if point is outside tree view,
- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point;                   // Returns nil if point is outside tree view,

- (NSMutableArray *)copyIndexPathsForRowsInRect:(CGRect)rect;             // Returns nil if rect not valid,
- (NSMutableArray *)indexPathsForRowsInRect:(CGRect)rect;                 // Returns nil if rect not valid,

- (RFUITreeViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;     // Returns nil if cell is not visible or index path is out of range.

- (NSMutableArray *)copyVisibleCells;
- (NSMutableArray *)visibleCells;

- (NSMutableArray *)copyIndexPathsForVisibleRows;
- (NSMutableArray *)indexPathsForVisibleRows;

// Scrolling the Tree View

//- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(RFUITreeViewScrollPosition)scrollPosition animated:(BOOL)animated;

// Inserting, Deleting and Reloading Rows

@property (nonatomic, readonly) BOOL isUpdating; // Default is NO.

- (void)beginUpdates;
- (void)endUpdates;

//- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(RFUITreeViewRowAnimation)animation;
//- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(RFUITreeViewRowAnimation)animation;
//- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(RFUITreeViewRowAnimation)animation;

// Expanding and Collapsing the Row

- (void)expandRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(RFUITreeViewRowAnimation)animation;
- (void)collapseRowAtIndexPats:(NSArray *)indexPaths withRowAnimation:(RFUITreeViewRowAnimation)animation;

@end

