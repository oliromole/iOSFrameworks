//
//  RFUITreeView.m
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
#import "RFUITreeView.h"

// Importing the project headers.
#import "RFUITreeViewCell.h"
#import "RFUITreeViewDataSource.h"
#import "RFUITreeViewNode.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUITreeView

#pragma mark - Initializing and Creating a RFUITreeView

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        mTreeViewNodesBlock = [^id(RFUITreeViewNode *treeViewNode, NSIndexPath *indexPath) {
#pragma unused(indexPath)
            
            NSMutableArray *childTreeViewNodes = treeViewNode.childTreeViewNodes;
            return childTreeViewNodes;
        } copy];
        
        mDataSource = nil;
        mDelegate = self.delegate;
        
        mBackgroundView = nil;
        mContentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, viewFrame.size.width, viewFrame.size.width)];
        
        mDeletedTreeViewNodes = [[NSMutableArray alloc] init];
        mReusableTreeViewCells = [[NSMutableArray alloc] init];
        mRootTreeViewNodes = [[NSMutableArray alloc] init];
        mVisibleTreeViewNodes = [[NSMutableArray alloc] init];
        
        mContentViewCalculatedHeight = 0.0f;
        mTreeViewCellMinimumWidth = 0.0f;
        mTreeViewCellHeight = 44.0f;
        
        mUpdateCounter = 0;
        
        mTreeFlags.dataSource_numberOfRowsInRootInTreeView = NO;
        mTreeFlags.dataSource_treeView_numberOfRowsInParentRowAtIndexPath = NO;
        mTreeFlags.dataSource_treeView_expandedRowAtIndexPath = NO;
        mTreeFlags.dataSource_treeView_cellForRowAtIndexPath = NO;
        mTreeFlags.delegete_treeViewShouldUseDynamicWidth = NO;
        mTreeFlags.delegete_minimumWidthForRowAtIndexPath = NO;
        mTreeFlags.delegete_heightForRowAtIndexPath_width = NO;
        mTreeFlags.needsLoadTreeViewCellHeight = NO;
        mTreeFlags.needsLoadTreeViewCellMinimumWidth = NO;
        mTreeFlags.needsReloadData = YES;
        mTreeFlags.usesDynamicWidth = NO;
        
        [self addSubview:mContentView];
    }
    
    return self;
}

+ (id)treeViewWithFrame:(CGRect)viewFrame
{
    return [[self alloc] initWithFrame:viewFrame];
}

#pragma mark - Deallocating a RFUITreeView

- (void)dealloc
{
    mBackgroundView = nil;
    
    mContentView = nil;
    
    mDeletedTreeViewNodes = nil;
    
    mReusableTreeViewCells = nil;
    
    mRootTreeViewNodes = nil;
    
    mVisibleTreeViewNodes = nil;
    
    mTreeViewNodesBlock = nil;
}

#pragma mark - Laying out Subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    @autoreleasepool
    {
        [self reloadDataIfNeeded];
        [self calculateTreeViewCellMinimumWidth]; // IfNeeded.
        [self calculateTreeViewCellFrame];        // IfNeeded.
        
        CGRect viewFrame = self.frame;
        
        CGRect contentViewFrame;
        contentViewFrame.origin.x = 0.0f;
        contentViewFrame.origin.y = 0.0f;
        contentViewFrame.size.width = mTreeViewCellCalculatedMinimumWidth;
        contentViewFrame.size.height = mContentViewCalculatedHeight;
        
        [mContentView setFrameIfNeeded:contentViewFrame];
        
        CGSize contentSize;
        contentSize.width = mTreeViewCellCalculatedMinimumWidth;
        contentSize.height = mContentViewCalculatedHeight;
        
        [self setContentSizeIfNeeded:contentSize];
        
        CGPoint contentOffset = self.contentOffset;
        
        CGRect visibleViewFrame;
        visibleViewFrame.origin = contentOffset;
        visibleViewFrame.size = viewFrame.size;
        
        // Loading, updating, removing tree view cell.
        
        [mRootTreeViewNodes enumerateObjectsUsingChildArrayBlock:mTreeViewNodesBlock
                                                  indexPathBlock:^(RFUITreeViewNode *treeViewNode, NSIndexPath *indexPath, BOOL *stop) {
#pragma unused(stop)
                                                      
                                                      RFUITreeViewCell *treeViewCell = treeViewNode.treeViewCell;
                                                      CGRect treeViewCellFrame = treeViewNode.treeViewCellFrame;
                                                      
                                                      if (CGRectIntersectsRect(visibleViewFrame, treeViewCellFrame))
                                                      {
                                                          if (treeViewCell)
                                                          {
                                                              [treeViewCell setFrameIfNeeded:treeViewCellFrame];
                                                          }
                                                          
                                                          else
                                                          {
                                                              treeViewCell = [self cellForRowAtIndexPathInDataSource:indexPath];
                                                              treeViewCell.indentationLevel = indexPath.length - 1;
                                                              treeViewNode.treeViewCell = treeViewCell;
                                                              [treeViewCell setFrameIfNeeded:treeViewCellFrame];
                                                              [treeViewCell setNeedsLayout];
                                                              
                                                              if (!treeViewCell.superview)
                                                              {
                                                                  [mContentView addSubview:treeViewCell];
                                                              }
                                                          }
                                                      }
                                                      
                                                      else
                                                      {
                                                          if (treeViewCell)
                                                          {
                                                              [treeViewCell removeFromSuperview];
                                                              [self enqueueReusableTreeViewCell:treeViewCell];
                                                              treeViewNode.treeViewCell = nil;
                                                          }
                                                      }
                                                  }];
    }
}

#pragma mark - Managing the Delegate and the Data Source

- (id<RFUITreeViewDataSource>)dataSource
{
    return mDataSource;
}

- (void)setDataSource:(id<RFUITreeViewDataSource>)dataSource
{
    if (mDataSource != dataSource)
    {
        mDataSource = dataSource;
        
        if ([dataSource conformsToProtocol:@protocol(RFUITreeViewDataSource) ])
        {
            mTreeFlags.dataSource_numberOfRowsInRootInTreeView = (unsigned int)[dataSource respondsToSelector:@selector(numberOfRowsInRootInTreeView:)];
            mTreeFlags.dataSource_treeView_numberOfRowsInParentRowAtIndexPath = (unsigned int)[dataSource respondsToSelector:@selector(treeView:numberOfRowsInParentRowAtIndexPath:)];
            mTreeFlags.dataSource_treeView_expandedRowAtIndexPath = (unsigned int)[dataSource respondsToSelector:@selector(treeView:expandedRowAtIndexPath:)];
            mTreeFlags.dataSource_treeView_cellForRowAtIndexPath = (unsigned int)[dataSource respondsToSelector:@selector(treeView:cellForRowAtIndexPath:)];
        }
        
        else
        {
            mTreeFlags.dataSource_numberOfRowsInRootInTreeView = NO;
            mTreeFlags.dataSource_treeView_numberOfRowsInParentRowAtIndexPath = NO;
            mTreeFlags.dataSource_treeView_expandedRowAtIndexPath = NO;
        }
    }
}

- (NSInteger)numberOfRowsInRootInDataSource
{
    NSInteger numberOfRows = 0;
    
    id<RFUITreeViewDataSource> dataSource = mDataSource;
    
    if (dataSource && mTreeFlags.dataSource_numberOfRowsInRootInTreeView)
    {
        numberOfRows = [dataSource numberOfRowsInRootInTreeView:self];
    }
    
    return numberOfRows;
}

- (NSInteger)numberOfRowsInParentRowAtIndexPathInDataSource:(NSIndexPath *)indexPath
{
    NSInteger numberOfRows = 0;
    
    id<RFUITreeViewDataSource> dataSource = mDataSource;
    
    if (dataSource && mTreeFlags.dataSource_treeView_numberOfRowsInParentRowAtIndexPath)
    {
        numberOfRows = [dataSource treeView:self numberOfRowsInParentRowAtIndexPath:indexPath];
    }
    
    return numberOfRows;
}

- (BOOL)expandedRowAtIndexPathInDataSource:(NSIndexPath *)indexPath
{
    BOOL expandedRow = NO;
    
    id<RFUITreeViewDataSource> dataSource = mDataSource;
    
    if (dataSource && mTreeFlags.dataSource_treeView_expandedRowAtIndexPath)
    {
        expandedRow = [dataSource treeView:self expandedRowAtIndexPath:indexPath];
    }
    
    return expandedRow;
}

- (RFUITreeViewCell *)cellForRowAtIndexPathInDataSource:(NSIndexPath *)indexPath
{
    RFUITreeViewCell *cell = nil;
    
    id<RFUITreeViewDataSource> dataSource = mDataSource;
    
    if (dataSource && mTreeFlags.dataSource_treeView_cellForRowAtIndexPath)
    {
        cell = [dataSource treeView:self cellForRowAtIndexPath:indexPath];
    }
    
    if (!cell)
    {
        cell = [[RFUITreeViewCell alloc] initWithReuseIdentifier:nil];
    }
    
    return cell;
}

- (id<RFUITreeViewDelegate>)delegate
{
    id<RFUITreeViewDelegate> delegate = (id<RFUITreeViewDelegate>)super.delegate;
    return delegate;
}

- (void)setDelegate:(id<RFUITreeViewDelegate>)delegate
{
    if (super.delegate != delegate)
    {
        super.delegate = delegate;
        mDelegate = self.delegate;
        
        id<RFUITreeViewDelegate> delegate2 = mDelegate;
        
        if ([delegate2 conformsToProtocol:@protocol(RFUITreeViewDelegate)])
        {
            mTreeFlags.delegete_treeViewShouldUseDynamicWidth = (unsigned int)[delegate2 respondsToSelector:@selector(treeViewShouldUseDynamicWidth:)];
            mTreeFlags.delegete_minimumWidthForRowAtIndexPath = (unsigned int)[delegate2 respondsToSelector:@selector(treeView:minimumWidthForRowAtIndexPath:)];
            mTreeFlags.delegete_heightForRowAtIndexPath_width = (unsigned int)[delegate2 respondsToSelector:@selector(treeView:heightForRowAtIndexPath:width:)];
        }
        
        else
        {
            mTreeFlags.delegete_treeViewShouldUseDynamicWidth = NO;
            mTreeFlags.delegete_minimumWidthForRowAtIndexPath = NO;
            mTreeFlags.delegete_heightForRowAtIndexPath_width = NO;
        }
    }
}

- (BOOL)shouldUseDynamicWidthInDelegate
{
    BOOL shouldUseDynamicWidth = mTreeFlags.usesDynamicWidth;
    
    id<RFUITreeViewDelegate> delegate = mDelegate;
    
    if (delegate && mTreeFlags.delegete_treeViewShouldUseDynamicWidth)
    {
        shouldUseDynamicWidth = [delegate treeViewShouldUseDynamicWidth:self];
    }
    
    return shouldUseDynamicWidth;
}

- (CGFloat)minimumWidthForRowAtIndexPathInDelegate:(NSIndexPath *)indexPath
{
    CGFloat minimumWidthForRow = mTreeViewCellMinimumWidth;
    
    id<RFUITreeViewDelegate> delegate = mDelegate;
    
    if (delegate && mTreeFlags.delegete_minimumWidthForRowAtIndexPath)
    {
        minimumWidthForRow = [delegate treeView:self minimumWidthForRowAtIndexPath:indexPath];
    }
    
    return minimumWidthForRow;
}

- (CGFloat)heightForRowAtIndexPathInDelegate:(NSIndexPath *)indexPath width:(CGFloat)width
{
    CGFloat treeViewCellHeight = mTreeViewCellHeight;
    
    id<RFUITreeViewDelegate> delegate = mDelegate;
    
    if (delegate && mTreeFlags.delegete_heightForRowAtIndexPath_width)
    {
        treeViewCellHeight = [delegate treeView:self heightForRowAtIndexPath:indexPath width:width];
    }
    
    return treeViewCellHeight;
}

#pragma mark - Configuring a Tree View

- (UIView *)backgroundView
{
    if (!mBackgroundView)
    {
        CGRect viewFrame = self.frame;
        
        CGRect backgroundViewFrame;
        
        backgroundViewFrame.origin = CGPointZero;
        backgroundViewFrame.size = viewFrame.size;
        
        mBackgroundView = [[UIView alloc] initWithFrame:backgroundViewFrame];
        mBackgroundView.userInteractionEnabled = NO;
    }
    
    return mBackgroundView;
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (mBackgroundView != backgroundView)
    {
        if (mBackgroundView)
        {
            [mBackgroundView removeFromSuperview];
        }
        
        mBackgroundView = backgroundView;
        
        if (mBackgroundView)
        {
            [self insertSubview:mBackgroundView atIndex:0];
        }
    }
}

- (BOOL)usesDynamicWidth
{
    return mTreeFlags.usesDynamicWidth;
}

- (void)setUsesDynamicWidth:(BOOL)usesDynamicWidth
{
    if (mTreeFlags.usesDynamicWidth != usesDynamicWidth)
    {
        mTreeFlags.usesDynamicWidth = (unsigned int)usesDynamicWidth;
        
        [self setNeedsReloadData];
        [self setNeedsLayout];
    }
}

- (CGFloat)minimumRowWidth
{
    return mTreeViewCellMinimumWidth;
}

- (void)setMinimumRowWidth:(CGFloat)treeViewCellMinimumWidth
{
    if (mTreeViewCellMinimumWidth != treeViewCellMinimumWidth)
    {
        mTreeViewCellMinimumWidth = treeViewCellMinimumWidth;
        
        [self setNeedsReloadData];
        [self setNeedsLayout];
    }
}

- (CGFloat)rowHeight
{
    return mTreeViewCellHeight;
}

- (void)setRowHeight:(CGFloat)treeViewCellHeight
{
    if (mTreeViewCellHeight != treeViewCellHeight)
    {
        mTreeViewCellHeight = treeViewCellHeight;
        
        [self setNeedsReloadData];
        [self setNeedsLayout];
    }
}

- (NSInteger)numberOfRowsInRoot
{
    NSInteger numberOfRowsInRoot = (NSInteger)mRootTreeViewNodes.count;
    return numberOfRowsInRoot;
}

- (NSInteger)numberOfRowsInParentRowAtIndexPath:(NSIndexPath *)indexPath
{
    RENSAssert(indexPath, @"The indexPath argument is nil.");
    
    RFUITreeViewNode *treeViewNode = [mRootTreeViewNodes objectAtIndexPath:indexPath usingChildArrayBlock:mTreeViewNodesBlock];
    NSInteger numberOfRowsInParent = (NSInteger)treeViewNode.childTreeViewNodes.count;
    return numberOfRowsInParent;
}

#pragma mark - Creating Tree View Cells

- (void)enqueueReusableTreeViewCell:(RFUITreeViewCell *)treeViewCell
{
    RENSAssert(treeViewCell, @"The treeViewCell argument is nil.");
    
    if (treeViewCell.reuseIdentifier)
    {
        NSUInteger indexOfReusableTreeViewCell = [mReusableTreeViewCells indexOfObjectIdenticalTo:treeViewCell];
        RENSAssert((indexOfReusableTreeViewCell == NSNotFound), @"The method has a logical error.");
        
        [mReusableTreeViewCells addObject:treeViewCell];
        
        if (mReusableTreeViewCells.count > 100)
        {
            [mReusableTreeViewCells removeObjectsInRange:NSMakeRange(0, 11)];
        }
    }
    
    else
    {
        [treeViewCell removeFromSuperview];
    }
}

- (id)dequeueReusableTreeViewCellWithIdentifier:(NSString *)reuseIdentifier
{
    RENSAssert(reuseIdentifier, @"The reuseIdentifier argument is nil.");
    
    RFUITreeViewCell *reusableTreeViewCell = nil;
    
    if (reuseIdentifier)
    {
        NSInteger indexOfReusableTreeViewCell = ((NSInteger)mReusableTreeViewCells.count) - 1;
        
        while (indexOfReusableTreeViewCell > -1)
        {
            RFUITreeViewCell *reusableTreeViewCell2 = [mReusableTreeViewCells objectAtIndex:(NSUInteger)indexOfReusableTreeViewCell];
            
            if ([reusableTreeViewCell2.reuseIdentifier isEqual:reuseIdentifier])
            {
                reusableTreeViewCell = reusableTreeViewCell2;
                
                [mReusableTreeViewCells removeObjectAtIndex:(NSUInteger)indexOfReusableTreeViewCell];
                
                break;
            }
        }
        
        if (reusableTreeViewCell)
        {
            reusableTreeViewCell.hidden = NO;
            [reusableTreeViewCell prepareForReuse];
        }
    }
    
    return reusableTreeViewCell;
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier
{
    RENSAssert(reuseIdentifier, @"The reuseIdentifier argument is nil.");
    
    RFUITreeViewCell *reusableTreeViewCell = [self dequeueReusableTreeViewCellWithIdentifier:reuseIdentifier];
    return reusableTreeViewCell;
}

#pragma mark - Reloading the Tree View

#pragma mark Loading the Tree View Node

- (RFUITreeViewNode *)copyRecursiveLoadTreeViewNodeAtIndexPath:(NSIndexPath *)indexPath
{
    RENSAssert(indexPath, @"The indexPath argument is nil.");
    
    RFUITreeViewNode *parentTreeViewNode = [[RFUITreeViewNode alloc] init];
    
    parentTreeViewNode.isExpanded = [self expandedRowAtIndexPathInDataSource:indexPath];
    parentTreeViewNode.needsGetTreeViewCellHeight = YES;
    
    if (parentTreeViewNode.isExpanded)
    {
        NSMutableArray *childTreeViewNodes = [[NSMutableArray alloc] init];
        parentTreeViewNode.childTreeViewNodes = childTreeViewNodes;
        
        NSInteger numberOfChildTreeViewNodes = [self numberOfRowsInParentRowAtIndexPathInDataSource:indexPath];
        
        for (NSInteger indexOfChildTreeViewNode = 0; indexOfChildTreeViewNode < numberOfChildTreeViewNodes; indexOfChildTreeViewNode++)
        {
            NSIndexPath *indexPathOfChildTreeViewNode = [indexPath copyIndexPathByAddingIndex:(NSUInteger)indexOfChildTreeViewNode];
            
            RFUITreeViewNode *childTreeViewNode = [self copyRecursiveLoadTreeViewNodeAtIndexPath:indexPathOfChildTreeViewNode];
            childTreeViewNode.parentTreeViewNode = parentTreeViewNode;
            
            [parentTreeViewNode.childTreeViewNodes addObject:childTreeViewNode];
        }
        
        if (parentTreeViewNode.childTreeViewNodes.count == 0)
        {
            parentTreeViewNode.childTreeViewNodes = nil;
        }
    }
    
    return parentTreeViewNode;
}

- (void)loadRootTreeViewNodes
{
    NSInteger numberOfRootTreeViewNodes = [self numberOfRowsInRootInDataSource];
    
    for (NSInteger indexOfRootTreeViewNode = 0; indexOfRootTreeViewNode < numberOfRootTreeViewNodes; indexOfRootTreeViewNode++)
    {
        NSIndexPath *indexPathOfRootTreeViewNode = [[NSIndexPath alloc] initWithIndex:(NSUInteger)indexOfRootTreeViewNode];
        
        RFUITreeViewNode *rootTreeViewNode = [self copyRecursiveLoadTreeViewNodeAtIndexPath:indexPathOfRootTreeViewNode];
        
        [mRootTreeViewNodes addObject:rootTreeViewNode];
    }
}

- (void)setNeedsReloadData
{
    if (mTreeFlags.needsReloadData)
    {
        mTreeFlags.needsReloadData = YES;
    }
}

- (void)reloadDataIfNeeded
{
    if (mTreeFlags.needsReloadData)
    {
        [self reloadData];
    }
}

- (void)reloadData
{
    @autoreleasepool
    {
        mTreeFlags.needsReloadData = NO;
        
        // Remove all of Tree View Nodes.
        //[self removeAllTreeViewNodeInRoot];
        
        // Loading Tree View Nodes.
        [self loadRootTreeViewNodes];
        
        [self setNeedsLayout];
    }
}

- (CGFloat)recursiveCalculateTreeViewCellMinimumWidthAtIndexPath:(NSIndexPath *)indexPath
{
    RENSAssert(indexPath, @"The indexPath argument is nil.");
    
    RFUITreeViewNode *parentTreeViewNode = [mRootTreeViewNodes objectAtIndexPath:indexPath usingChildArrayBlock:mTreeViewNodesBlock];
    parentTreeViewNode.treeViewCellMinimumWidth = [self minimumWidthForRowAtIndexPathInDelegate:indexPath];
    
    CGFloat treeViewCellMinimumWidth = parentTreeViewNode.treeViewCellMinimumWidth;
    
    if (parentTreeViewNode.isExpanded)
    {
        NSInteger numberOfChildTreeViewNodes = (NSInteger)parentTreeViewNode.childTreeViewNodes.count;
        
        for (NSInteger indexOfChildTreeViewNode = 0; indexOfChildTreeViewNode < numberOfChildTreeViewNodes; indexOfChildTreeViewNode++)
        {
            NSIndexPath *indexPathOfChildTreeViewNode = [indexPath copyIndexPathByAddingIndex:(NSUInteger)indexOfChildTreeViewNode];
            
            CGFloat childTreeViewCellMinimumWidth = [self recursiveCalculateTreeViewCellMinimumWidthAtIndexPath:indexPathOfChildTreeViewNode];
            
            treeViewCellMinimumWidth = MAX(treeViewCellMinimumWidth, childTreeViewCellMinimumWidth);
        }
    }
    
    return treeViewCellMinimumWidth;
}

- (void)calculateTreeViewCellMinimumWidth
{
    BOOL shouldUseDynamic = [self shouldUseDynamicWidthInDelegate];
    
    if (shouldUseDynamic)
    {
        NSUInteger numberOfRootTreeViewNodes = mRootTreeViewNodes.count;
        
        CGFloat treeViewCellCalculatedMinimumWidth = mTreeViewCellMinimumWidth;
        
        for (NSInteger indexOfRootTreeViewNode = 0; indexOfRootTreeViewNode < (NSInteger)numberOfRootTreeViewNodes; indexOfRootTreeViewNode++)
        {
            NSIndexPath *indexPathOfRootTreeViewNode = [[NSIndexPath alloc] initWithIndex:(NSUInteger)indexOfRootTreeViewNode];
            
            CGFloat rootTreeViewCellMinimumWidth = [self recursiveCalculateTreeViewCellMinimumWidthAtIndexPath:indexPathOfRootTreeViewNode];
            
            treeViewCellCalculatedMinimumWidth = MAX(treeViewCellCalculatedMinimumWidth, rootTreeViewCellMinimumWidth);
        }
        
        mTreeViewCellCalculatedMinimumWidth = treeViewCellCalculatedMinimumWidth;
        
        CGRect viewFrame = self.frame;
        
        if (mTreeViewCellCalculatedMinimumWidth < viewFrame.size.width)
        {
            mTreeViewCellCalculatedMinimumWidth = viewFrame.size.width;
        }
    }
    
    else
    {
        CGRect viewFrame = self.frame;
        
        mTreeViewCellCalculatedMinimumWidth = viewFrame.size.width;
    }
}

- (void)recursiveCalculateTreeViewCellFrameAtIndexPath:(NSIndexPath *)indexPath
{
    RENSAssert(indexPath, @"The indexPath argument is nil.");
    
    RFUITreeViewNode *parentTreeViewNode = [mRootTreeViewNodes objectAtIndexPath:indexPath usingChildArrayBlock:mTreeViewNodesBlock];
    parentTreeViewNode.treeViewCellHeight = [self heightForRowAtIndexPathInDelegate:indexPath width:mTreeViewCellCalculatedMinimumWidth];
    
    CGRect parentTreeViewCellFrame;
    parentTreeViewCellFrame.origin.x = 0.0f;
    parentTreeViewCellFrame.origin.y = mContentViewCalculatedHeight;
    parentTreeViewCellFrame.size.width = mTreeViewCellCalculatedMinimumWidth;
    parentTreeViewCellFrame.size.height = parentTreeViewNode.treeViewCellHeight;
    
    parentTreeViewNode.treeViewCellFrame = parentTreeViewCellFrame;
    
    mContentViewCalculatedHeight = CGRectGetMaxY(parentTreeViewCellFrame);
    
    if (parentTreeViewNode.isExpanded)
    {
        NSInteger numberOfChildTreeViewNodes = (NSInteger)parentTreeViewNode.childTreeViewNodes.count;
        
        for (NSInteger indexOfChildTreeViewNode = 0; indexOfChildTreeViewNode < numberOfChildTreeViewNodes; indexOfChildTreeViewNode++)
        {
            NSIndexPath *indexPathOfChildTreeViewNode = [indexPath copyIndexPathByAddingIndex:(NSUInteger)indexOfChildTreeViewNode];
            
            [self recursiveCalculateTreeViewCellFrameAtIndexPath:indexPathOfChildTreeViewNode];
        }
    }
}

- (void)calculateTreeViewCellFrame
{
    NSInteger numberOfRootTreeViewNodes = (NSInteger)mRootTreeViewNodes.count;
    
    mContentViewCalculatedHeight = 0.0f;
    
    for (NSInteger indexOfRootTreeViewNode = 0; indexOfRootTreeViewNode < numberOfRootTreeViewNodes; indexOfRootTreeViewNode++)
    {
        NSIndexPath *indexPathOfRootTreeViewNode = [[NSIndexPath alloc] initWithIndex:(NSUInteger)indexOfRootTreeViewNode];
        
        [self recursiveCalculateTreeViewCellFrameAtIndexPath:indexPathOfRootTreeViewNode];
    }
}

#pragma mark - Accessing Drawing Areas of the Tree View

- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RENSAssert(indexPath, @"The indexPath argument is nil.");
    
    CGRect rect = CGRectZero;
    
    RFUITreeViewNode *treeViewNode = [mRootTreeViewNodes objectAtIndexPath:indexPath usingChildArrayBlock:mTreeViewNodesBlock];
    
    if (treeViewNode)
    {
        rect = treeViewNode.treeViewCellFrame;
    }
    
    return rect;
}

#pragma mark - Accessing Cells

- (NSIndexPath *)copyIndexPathForCell:(RFUITreeViewCell *)treeViewCell
{
    RENSAssert(treeViewCell, @"The treeViewCell argument is nil.");
    
    __block NSIndexPath *indexPathForCell = nil;
    
    if (treeViewCell)
    {
        [mRootTreeViewNodes enumerateObjectsUsingChildArrayBlock:mTreeViewNodesBlock
                                                  indexPathBlock:^(RFUITreeViewNode *treeViewNode, NSIndexPath *indexPath, BOOL *stop) {
                                                      if (treeViewNode.treeViewCell == treeViewCell)
                                                      {
                                                          indexPathForCell = indexPath;
                                                          
                                                          if (stop)
                                                          {
                                                              *stop = YES;
                                                          }
                                                      }
                                                  }];
    }
    
    return indexPathForCell;
}

- (NSIndexPath *)indexPathForCell:(RFUITreeViewCell *)treeViewCell
{
    RENSAssert(treeViewCell, @"The treeViewCell argument is nil.");
    
    NSIndexPath *indexPathForCell = [self copyIndexPathForCell:treeViewCell];
    return indexPathForCell;
}

- (NSIndexPath *)copyIndexPathForRowAtPoint:(CGPoint)point
{
    __block NSIndexPath *indexPath = nil;
    
    [mRootTreeViewNodes enumerateObjectsUsingChildArrayBlock:mTreeViewNodesBlock
                                              indexPathBlock:^(RFUITreeViewNode *treeViewNode, NSIndexPath *indexPath2, BOOL *stop) {
                                                  CGRect treeViewCellFrame = treeViewNode.treeViewCellFrame;
                                                  
                                                  if (CGRectContainsPoint(treeViewCellFrame, point))
                                                  {
                                                      indexPath = indexPath2;
                                                      
                                                      if (stop)
                                                      {
                                                          *stop = YES;
                                                      }
                                                  }
                                              }];
    
    return indexPath;
}

- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point
{
    NSIndexPath *indexPath = [self copyIndexPathForRowAtPoint:point];
    return indexPath;
}

- (NSMutableArray *)copyIndexPathsForRowsInRect:(CGRect)rect
{
    __block NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    [mRootTreeViewNodes enumerateObjectsUsingChildArrayBlock:mTreeViewNodesBlock
                                              indexPathBlock:^(RFUITreeViewNode *treeViewNode, NSIndexPath *indexPath, BOOL *stop) {
#pragma unused(stop)
                                                  
                                                  CGRect treeViewCellFrame = treeViewNode.treeViewCellFrame;
                                                  
                                                  if (CGRectIntersectsRect(treeViewCellFrame, rect))
                                                  {
                                                      [indexPaths addObject:indexPath];
                                                  }
                                              }];
    
    return indexPaths;
}

- (NSMutableArray *)indexPathsForRowsInRect:(CGRect)rect
{
    NSMutableArray *indexPaths = [self copyIndexPathsForRowsInRect:rect];
    return indexPaths;
}

- (RFUITreeViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RENSAssert(indexPath, @"The indexPath argument is nil.");
    
    RFUITreeViewNode *treeViewNode = [mRootTreeViewNodes objectAtIndexPath:indexPath usingChildArrayBlock:mTreeViewNodesBlock];
    RFUITreeViewCell *treeViewCell = treeViewNode.treeViewCell;
    return treeViewCell;
}

- (NSMutableArray *)copyVisibleCells
{
    NSMutableArray *visibleCells = [[NSMutableArray alloc] initWithCapacity:mVisibleTreeViewNodes.count];
    
    [mRootTreeViewNodes enumerateObjectsUsingChildArrayBlock:mTreeViewNodesBlock
                                              indexPathBlock:^(RFUITreeViewNode *treeViewNode, NSIndexPath *indexPath, BOOL *stop) {
#pragma unused(indexPath)
#pragma unused(stop)
                                                  
                                                  RFUITreeViewCell *treeViewCell = treeViewNode.treeViewCell;
                                                  
                                                  if (treeViewCell)
                                                  {
                                                      [visibleCells addObject:treeViewCell];
                                                  }
                                              }];
    
    return visibleCells;
}

- (NSMutableArray *)visibleCells
{
    NSMutableArray *visibleCells = [self copyVisibleCells];
    return visibleCells;
}

- (NSMutableArray *)copyIndexPathsForVisibleRows
{
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    [mRootTreeViewNodes enumerateObjectsUsingChildArrayBlock:mTreeViewNodesBlock
                                              indexPathBlock:^(RFUITreeViewNode *treeViewNode, NSIndexPath *indexPath, BOOL *stop) {
#pragma unused(stop)
                                                  
                                                  RFUITreeViewCell *treeViewCell = treeViewNode.treeViewCell;
                                                  
                                                  if (treeViewCell)
                                                  {
                                                      [indexPaths addObject:indexPath];
                                                  }
                                              }];
    
    return indexPaths;
}

- (NSMutableArray *)indexPathsForVisibleRows
{
    NSMutableArray *indexPaths = [self copyIndexPathsForVisibleRows];
    return indexPaths;
}

#pragma mark - Scrolling the Tree View

//- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(RFUITreeViewScrollPosition)scrollPosition animated:(BOOL)animated
//{
//    RENSAssert(indexPath, @"The indexPath argument is nil.");
//
//    RFUITreeViewNode *treeViewNode = [mRootTreeViewNodes objectAtIndexPath:indexPath usingChildArrayBlock:mTreeViewNodesBlock];
//
//    if (treeViewNode)
//    {
//        CGRect viewFrame = self.frame;
//
//        CGPoint contentOffset = self.contentOffset;
//        CGSize contentSize = self.contentSize;
//
//        CGRect visibleFrame;
//        visibleFrame.origin = contentOffset;
//        visibleFrame.size = viewFrame.size;
//
//        CGRect treeViewCellFrame = treeViewNode.treeViewCellFrame;
//
//        if (scrollPosition == RFUITreeViewScrollPositionTop)
//        {
//        }
//
//        else if (scrollPosition == RFUITreeViewScrollPositionMiddle)
//        {
//        }
//
//        else if (scrollPosition == RFUITreeViewScrollPositionBottom)
//        {
//        }
//
//        // (scrollPosition == RFUITreeViewScrollPositionNone) || (scrollPosition is RFUITreeViewScrollPositionUnknown)
//        else
//        {
//
//        }
//
//        //[self scrollRectToVisible:rect animated:animated];
//    }
//}

#pragma mark - Inserting, Deleting and Reloading Rows

- (BOOL)isUpdating
{
    BOOL isUpdating = (mUpdateCounter != 0);
    return isUpdating;
}

- (void)beginUpdates
{
    mUpdateCounter++;
}

- (void)endUpdates
{
    RENSAssert((mUpdateCounter > 0), @"The method has a logical error.");
    
    mUpdateCounter--;
    
    if (mUpdateCounter == 0)
    {
        [mRootTreeViewNodes enumerateObjectsUsingChildArrayBlock:mTreeViewNodesBlock
                                                  indexPathBlock:^(RFUITreeViewNode *treeViewNode, NSIndexPath *indexPath, BOOL *stop) {
#pragma unused(indexPath)
#pragma unused(stop)
                                                      
                                                      CGRect treeViewCellFrame = treeViewNode.treeViewCellFrame;
                                                      treeViewNode.treeViewCellFrameOld = treeViewCellFrame;
                                                  }];
        
        [self calculateTreeViewCellMinimumWidth]; // IfNeeded.
        [self calculateTreeViewCellFrame];        // IfNeeded.
        
        CGRect viewFrame = self.frame;
        
        CGRect contentViewFrame;
        contentViewFrame.origin.x = 0.0f;
        contentViewFrame.origin.y = 0.0f;
        contentViewFrame.size.width = mTreeViewCellCalculatedMinimumWidth;
        contentViewFrame.size.height = mContentViewCalculatedHeight;
        
        CGSize contentSize;
        contentSize.width = mTreeViewCellCalculatedMinimumWidth;
        contentSize.height = mContentViewCalculatedHeight;
        
        CGPoint contentOffset = self.contentOffset;
        
        CGRect visibleViewFrame;
        visibleViewFrame.origin = contentOffset;
        visibleViewFrame.size = viewFrame.size;
        
        // Loading, updating, removing tree view cell.
        
        [mRootTreeViewNodes enumerateObjectsUsingChildArrayBlock:mTreeViewNodesBlock
                                                  indexPathBlock:^(RFUITreeViewNode *treeViewNode, NSIndexPath *indexPath, BOOL *stop) {
#pragma unused(stop)
                                                      
                                                      RFUITreeViewCell *treeViewCell = treeViewNode.treeViewCell;
                                                      CGRect treeViewCellFrameOld = treeViewNode.treeViewCellFrameOld;
                                                      CGRect treeViewCellFrameNew = treeViewNode.treeViewCellFrame;
                                                      
                                                      if (CGRectIntersectsRect(visibleViewFrame, treeViewCellFrameNew))
                                                      {
                                                          if (CGRectIsEmpty(treeViewCellFrameOld))
                                                          {
                                                              treeViewCellFrameOld = treeViewCellFrameNew;
                                                          }
                                                          
                                                          if (treeViewCell)
                                                          {
                                                              [treeViewCell setFrameIfNeeded:treeViewCellFrameOld];
                                                              [treeViewCell recursiveLayoutSubviews];
                                                          }
                                                          
                                                          else
                                                          {
                                                              treeViewCell = [self cellForRowAtIndexPathInDataSource:indexPath];
                                                              treeViewCell.indentationLevel = indexPath.length - 1;
                                                              treeViewNode.treeViewCell = treeViewCell;
                                                              [treeViewCell setFrameIfNeeded:treeViewCellFrameOld];
                                                              [mContentView addSubview:treeViewCell];
                                                              [treeViewCell recursiveLayoutSubviews];
                                                          }
                                                      }
                                                  }];
        
        __block NSMutableArray *deletedTreeViewNodes = [mDeletedTreeViewNodes mutableCopy];
        
        [UIView animateWithDuration:0.25
                              delay:0.0
                            options:(UIViewAnimationOptionAllowAnimatedContent)
                         animations:^{
                             [mRootTreeViewNodes enumerateObjectsUsingChildArrayBlock:mTreeViewNodesBlock
                                                                       indexPathBlock:^(RFUITreeViewNode *treeViewNode, NSIndexPath *indexPath, BOOL *stop) {
#pragma unused(indexPath)
#pragma unused(stop)
                                                                           
                                                                           RFUITreeViewCell *treeViewCell = treeViewNode.treeViewCell;
                                                                           CGRect treeViewCellFrame = treeViewNode.treeViewCellFrame;
                                                                           
                                                                           if (CGRectIntersectsRect(visibleViewFrame, treeViewCellFrame))
                                                                           {
                                                                               if (treeViewCell)
                                                                               {
                                                                                   [treeViewCell setFrameIfNeeded:treeViewCellFrame];
                                                                               }
                                                                           }
                                                                           
                                                                           else
                                                                           {
                                                                               if (treeViewCell)
                                                                               {
                                                                                   [treeViewCell removeFromSuperview];
                                                                                   [self enqueueReusableTreeViewCell:treeViewCell];
                                                                                   treeViewNode.treeViewCell = nil;
                                                                               }
                                                                           }
                                                                       }];
                             
                             for (RFUITreeViewNode *deletedTreeViewNode in deletedTreeViewNodes)
                             {
                                 RFUITreeViewCell *treeViewCell = deletedTreeViewNode.treeViewCell;
                                 
                                 if (treeViewCell)
                                 {
                                     RFUITreeViewRowAnimation treeViewRowAnimation = deletedTreeViewNode.deleteTreeViewRowAnimation;
                                     treeViewRowAnimation = RFUITreeViewRowAnimationCorrectDeletingAnimation(treeViewRowAnimation);
                                     
                                     [treeViewCell sendToBack];
                                     
                                     if ((treeViewRowAnimation & RFUITreeViewRowAnimationFade) == RFUITreeViewRowAnimationFade)
                                     {
                                         [treeViewCell setAlphaIfNeeded:0.0f];
                                     }
                                     
                                     CGRect treeViewCellFrame = treeViewCell.frame;
                                     
                                     if ((treeViewRowAnimation & RFUITreeViewRowAnimationLeft) == RFUITreeViewRowAnimationLeft)
                                     {
                                         treeViewCellFrame.origin.x -= treeViewCellFrame.size.width;
                                     }
                                     
                                     if ((treeViewRowAnimation & RFUITreeViewRowAnimationRight) == RFUITreeViewRowAnimationRight)
                                     {
                                         treeViewCellFrame.origin.x += treeViewCellFrame.size.width;
                                     }
                                     
                                     if ((treeViewRowAnimation & RFUITreeViewRowAnimationTop) == RFUITreeViewRowAnimationTop)
                                     {
                                         treeViewCellFrame.origin.y -= treeViewCellFrame.size.height;
                                     }
                                     
                                     if ((treeViewRowAnimation & RFUITreeViewRowAnimationBottom) == RFUITreeViewRowAnimationBottom)
                                     {
                                         treeViewCellFrame.origin.y += treeViewCellFrame.size.height;
                                     }
                                     
                                     if (treeViewRowAnimation == RFUITreeViewRowAnimationNone)
                                     {
                                         [treeViewCell setAlphaIfNeeded:1.0f];
                                         
                                         [treeViewCell removeFromSuperview];
                                         [self enqueueReusableTreeViewCell:treeViewCell];
                                         deletedTreeViewNode.treeViewCell = nil;
                                     }
                                 }
                             }
                         }
                         completion:^(BOOL finished) {
#pragma unused(finished)
                             
                             for (RFUITreeViewNode *deletedTreeViewNode in deletedTreeViewNodes)
                             {
                                 RFUITreeViewCell *treeViewCell = deletedTreeViewNode.treeViewCell;
                                 
                                 if (treeViewCell)
                                 {
                                     [treeViewCell setAlphaIfNeeded:1.0f];
                                     
                                     [treeViewCell removeFromSuperview];
                                     [self enqueueReusableTreeViewCell:treeViewCell];
                                     deletedTreeViewNode.treeViewCell = nil;
                                 }
                             }
                             
                             deletedTreeViewNodes = nil;
                         }];
        
        [mContentView setFrameIfNeeded:contentViewFrame];
        [self setContentSizeIfNeeded:contentSize];
    }
}

//- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(RFUITreeViewRowAnimation)animation
//{
//    RENSAssert(indexPaths, @"The method has a logical error.");
//
//    if (indexPaths.count > 0)
//    {
//    }
//}

//- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(RFUITreeViewRowAnimation)animation
//{
//    RENSAssert(indexPaths, @"The method has a logical error.");
//
//    if (indexPaths.count > 0)
//    {
//        [self beginUpdates];
//
//        [self endUpdates];
//    }
//}

//- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(RFUITreeViewRowAnimation)animation
//{
//    RENSAssert(indexPaths, @"The method has a logical error.");
//
//    if (indexPaths.count > 0)
//    {
//        [self beginUpdates];
//
//        [self endUpdates];
//    }
//}

#pragma mark - Expanding and Collapsing the Row

- (void)expandRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(RFUITreeViewRowAnimation)animation
{
#pragma unused(animation)
    
    RENSAssert(indexPaths, @"The indexPaths argument is nil.");
    
    if (indexPaths.count > 0)
    {
        [self beginUpdates];
        
        for (NSIndexPath *indexPath in indexPaths)
        {
            RFUITreeViewNode *parentTreeViewNode = [mRootTreeViewNodes objectAtIndexPath:indexPath usingChildArrayBlock:mTreeViewNodesBlock];
            
            if (!parentTreeViewNode.isExpanded)
            {
                parentTreeViewNode.isExpanded = YES;
                
                NSMutableArray *childTreeViewNodes = [[NSMutableArray alloc] init];
                parentTreeViewNode.childTreeViewNodes = childTreeViewNodes;
                
                NSInteger numberOfChildTreeViewNodes = [self numberOfRowsInParentRowAtIndexPathInDataSource:indexPath];
                
                for (NSInteger indexOfChildTreeViewNode = 0; indexOfChildTreeViewNode < numberOfChildTreeViewNodes; indexOfChildTreeViewNode++)
                {
                    NSIndexPath *indexPathOfChildTreeViewNode = [indexPath copyIndexPathByAddingIndex:(NSUInteger)indexOfChildTreeViewNode];
                    
                    RFUITreeViewNode *childTreeViewNode = [self copyRecursiveLoadTreeViewNodeAtIndexPath:indexPathOfChildTreeViewNode];
                    childTreeViewNode.parentTreeViewNode = parentTreeViewNode;
                    
                    [parentTreeViewNode.childTreeViewNodes addObject:childTreeViewNode];
                }
                
                if (parentTreeViewNode.childTreeViewNodes.count == 0)
                {
                    parentTreeViewNode.childTreeViewNodes = nil;
                }
            }
        }
        
        [self endUpdates];
    }
}

- (void)collapseRowAtIndexPats:(NSArray *)indexPaths withRowAnimation:(RFUITreeViewRowAnimation)treeViewRowAnimation
{
    RENSAssert(indexPaths, @"The indexPaths argument is nil.");
    
    if (indexPaths.count > 0)
    {
        [self beginUpdates];
        
        for (NSIndexPath *indexPath in indexPaths.reverseObjectEnumerator)
        {
            RFUITreeViewNode *treeViewNode = [mRootTreeViewNodes objectAtIndexPath:indexPath usingChildArrayBlock:mTreeViewNodesBlock];
            
            if (treeViewNode.isExpanded)
            {
                treeViewNode.isExpanded = NO;
                
                NSMutableArray *childTreeViewNodes = [[NSMutableArray alloc] init];
                
                if (treeViewNode.childTreeViewNodes)
                {
                    [childTreeViewNodes addObjectsFromArray:treeViewNode.childTreeViewNodes];
                    treeViewNode.childTreeViewNodes = nil;
                }
                
                while (childTreeViewNodes.count > 0)
                {
                    RFUITreeViewNode *childTreeViewNode = childTreeViewNodes.lastObject;
                    [childTreeViewNodes removeLastObject];
                    
                    childTreeViewNode.parentTreeViewNode = nil;
                    
                    if (childTreeViewNode.childTreeViewNodes)
                    {
                        [childTreeViewNodes addObjectsFromArray:childTreeViewNode.childTreeViewNodes];
                        childTreeViewNode.childTreeViewNodes = nil;
                    }
                    
                    if (childTreeViewNode.treeViewCell)
                    {
                        childTreeViewNode.deleteTreeViewRowAnimation = treeViewRowAnimation;
                        [mDeletedTreeViewNodes addObject:childTreeViewNode];
                    }
                }
            }
        }
        
        [self endUpdates];
    }
}

@end
