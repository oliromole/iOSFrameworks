//
//  RFUIPageScrollView.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.06.06.
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
#import "RFUIPageScrollView.h"

// Importing the project headers.
#import "RFUIPageScrollViewCell.h"
#import "RFUIPageScrollViewDataSource.h"
#import "RFUIPageScrollViewDelegate.h"

// Importing the external headers.
#import <RECoreGraphics/RECoreGraphics.h>
#import <REFoundation/REFoundation.h>
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUIPageScrollView

#pragma mark - Initializing a RFUIPageScrollView

- (id)init
{
    CGRect mainScreenBounds = [UIScreen mainScreen].bounds;
    
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, mainScreenBounds.size.width, mainScreenBounds.size.height)];
}

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        // Setting the default values.
        mDataSource = nil;
        
        // Setting the default values.
        mNumberOfRows = 0;
        mNumberOfColumns = 0;
        
        // Setting the default values.
        mOldPageIndePath = nil;
        mPageIndexPath = nil;
        mPageSize = self.bounds.size;
        mRows = [[NSMutableArray alloc] init];
        mVisibleCells = [[NSMutableArray alloc] init];
        
        // Creating the container view.
        mContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0, 0.0)];
        
        // Setting the flag to need to reload the data.
        mNeedsReloadData = YES;
        
        // Building the view hierarchy.
        [self addSubview:mContainerView];
        
        // Configuring the page scroll view.
        self.pagingEnabled = YES;
    }
    
    return self;
}

#pragma mark - Deallocating a RFUIPageScrollView

- (void)dealloc
{
    // Releasing the container view.
    mContainerView = nil;
    
    // Releasing the old page index path.
    mOldPageIndePath = nil;
    
    // Releasing the page index path.
    mPageIndexPath = nil;
    
    // Releasing the rows.
    mRows = nil;
    
    // Releasing the visible cells.
    mVisibleCells = nil;
}

#pragma mark - Lays out Subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    @autoreleasepool
    {
        if (mNeedsReloadData)
        {
            [self reloadData];
        }
        
        CGSize oldPageSize = mPageSize;
        CGSize newPageSize = self.bounds.size;
        
        if (!CGSizeEqualToSize(oldPageSize, newPageSize))
        {
            mPageSize = newPageSize;
            
            CGPoint contentOffset = CGPointZero;
            
            if (mOldPageIndePath)
            {
                contentOffset.x = newPageSize.width * mOldPageIndePath.column;
                contentOffset.y = newPageSize.height * mOldPageIndePath.row;
            }
            
            [self setContentOffsetIfNeeded:contentOffset animated:NO];
        }
        
        CGRect viewFrame = self.frame;
        
        CGSize contentSize;
        contentSize.width = mNumberOfColumns * viewFrame.size.width;
        contentSize.height = mNumberOfRows * viewFrame.size.height;
        
        [self setContentSizeIfNeeded:contentSize];
        
        viewFrame = self.frame;
        CGPoint contentOffset = self.contentOffset;
        
        NSMutableSet *indexPaths = [[NSMutableSet alloc] initWithCapacity:4];
        
        NSInteger indexOfRow0 = (NSInteger)cg_trunc(contentOffset.y / viewFrame.size.height);
        NSInteger indexOfRow1 = (NSInteger)cg_trunc((contentOffset.y + viewFrame.size.height - 1.0f) / viewFrame.size.height);
        
        NSInteger indexOfColumn0 = (NSInteger)cg_trunc(contentOffset.x / viewFrame.size.width);
        NSInteger indexOfColumn1 = (NSInteger)cg_trunc((contentOffset.x + viewFrame.size.width - 1.0f) / viewFrame.size.width);
        
        if ((indexOfRow0 >= 0) && (indexOfRow0 < mNumberOfRows) &&
            (indexOfColumn0 >= 0) && (indexOfColumn0 < mNumberOfColumns))
        {
            [indexPaths addObject:[NSIndexPath indexPathForRow:indexOfRow0 column:indexOfColumn0]];
        }
        
        if ((indexOfRow0 >= 0) && (indexOfRow0 < mNumberOfRows) &&
            (indexOfColumn1 >= 0) && (indexOfColumn1 < mNumberOfColumns))
        {
            [indexPaths addObject:[NSIndexPath indexPathForRow:indexOfRow0 column:indexOfColumn1]];
        }
        
        if ((indexOfRow1 >= 0) && (indexOfRow1 < mNumberOfRows) &&
            (indexOfColumn0 >= 0) && (indexOfColumn0 < mNumberOfColumns))
        {
            [indexPaths addObject:[NSIndexPath indexPathForRow:indexOfRow1 column:indexOfColumn0]];
        }
        
        if ((indexOfRow1 >= 0) && (indexOfRow1 < mNumberOfRows) &&
            (indexOfColumn1 >= 0) && (indexOfColumn1 < mNumberOfColumns))
        {
            [indexPaths addObject:[NSIndexPath indexPathForRow:indexOfRow1 column:indexOfColumn1]];
        }
        
        // Removing and updating the cell.
        NSInteger indexOfVisibleCell = 0;
        
        while (indexOfVisibleCell < (NSInteger)mVisibleCells.count)
        {
            RFUIPageScrollViewCell *pageScrollViewCell = [mVisibleCells objectAtIndex:(NSUInteger)indexOfVisibleCell];
            NSIndexPath *indexPath = [self indexPathForCell:pageScrollViewCell];
            
            if (indexPath)
            {
                if ([indexPaths containsObject:indexPath])
                {
                    CGRect pageScrollViewCellFrame;
                    pageScrollViewCellFrame.origin.x = indexPath.column * viewFrame.size.width;
                    pageScrollViewCellFrame.origin.y = indexPath.row * viewFrame.size.height;
                    pageScrollViewCellFrame.size.width = viewFrame.size.width;
                    pageScrollViewCellFrame.size.height = viewFrame.size.height;
                    
                    [pageScrollViewCell setFrameIfNeeded:pageScrollViewCellFrame];
                    
                    [indexPaths removeObject:indexPath];
                    
                    indexOfVisibleCell++;
                }
                
                else
                {
                    [pageScrollViewCell removeFromSuperview];
                    [mVisibleCells removeObjectAtIndex:(NSUInteger)indexOfVisibleCell];
                    [[mRows objectAtIndex:(NSUInteger)indexPath.row] replaceObjectAtIndex:(NSUInteger)indexPath.column withObject:[NSNull null]];
                }
            }
            
            else
            {
                [pageScrollViewCell removeFromSuperview];
                [mVisibleCells removeObjectAtIndex:(NSUInteger)indexOfVisibleCell];
            }
        }
        
        // Loading New Cell.
        for (NSIndexPath *indexPath in indexPaths)
        {
            RFUIPageScrollViewCell *pageScrollViewCell = [self cellForRowAtIndexPathInDataSource:indexPath];
            
            CGRect pageScrollViewCellFrame;
            pageScrollViewCellFrame.origin.x = indexPath.column * viewFrame.size.width;
            pageScrollViewCellFrame.origin.y = indexPath.row * viewFrame.size.height;
            pageScrollViewCellFrame.size.width = viewFrame.size.width;
            pageScrollViewCellFrame.size.height = viewFrame.size.height;
            
            [pageScrollViewCell setFrameIfNeeded:pageScrollViewCellFrame];
            
            [[mRows objectAtIndex:(NSUInteger)indexPath.row] replaceObjectAtIndex:(NSUInteger)indexPath.column withObject:pageScrollViewCell];
            [mVisibleCells addObject:pageScrollViewCell];
            
            [mContainerView addSubview:pageScrollViewCell];
        }
    }
}

#pragma mark - Managing the Display of Content

- (void)calculatePageIndex
{
    CGRect visibleContentFrame;
    visibleContentFrame.origin = self.contentOffset;
    visibleContentFrame.size = self.frame.size;
    
    BOOL needNewPageIndex = NO;
    
    if (mPageIndexPath)
    {
        CGRect pageFrame;
        pageFrame.origin.x = mPageIndexPath.column * visibleContentFrame.size.width - visibleContentFrame.size.width / 2.0f;
        pageFrame.origin.y = mPageIndexPath.row * visibleContentFrame.size.height - visibleContentFrame.size.height / 2.0f;
        pageFrame.size.width = visibleContentFrame.size.width / 2.0f;
        pageFrame.size.height = visibleContentFrame.size.height / 2.0f;
        
        if (!CGRectIntersectsRect(visibleContentFrame, pageFrame))
        {
            needNewPageIndex = YES;
        }
    }
    
    else
    {
        needNewPageIndex = YES;
    }
    
    if (needNewPageIndex)
    {
        NSIndexPath *pageIndexPath = nil;
        
        if ((mNumberOfRows > 0) && (mNumberOfColumns > 0))
        {
            CGPoint point;
            point.x = CGRectGetMidX(visibleContentFrame);
            point.y = CGRectGetMidY(visibleContentFrame);
            
            NSInteger column = (NSInteger)cg_trunc(point.x / visibleContentFrame.size.width);
            NSInteger row = (NSInteger)cg_trunc(point.y / visibleContentFrame.size.height);
            
            if (row < 0)
            {
                row = 0;
            }
            
            if (row >= mNumberOfRows)
            {
                row = mNumberOfRows - 1;
            }
            
            if (column < 0)
            {
                column = 0;
            }
            
            if (column >= mNumberOfColumns)
            {
                column = 0;
            }
            
            pageIndexPath = [NSIndexPath indexPathForRow:row column:column];
        }
        
        if ((mPageIndexPath != pageIndexPath) &&  ![mPageIndexPath isEqual:pageIndexPath])
        {
            NSIndexPath *oldPageIndexPath = mPageIndexPath;
            
            mPageIndexPath = pageIndexPath;
            
            id delegate = self.delegate;
            
            if ([delegate conformsToProtocol:@protocol(RFUIPageScrollViewDelegate)] &&
                [delegate respondsToSelector:@selector(pageScrollView:didChangeToPageIndexPath:fromPageIndexPath:)])
            {
                [delegate pageScrollView:self didChangeToPageIndexPath:mPageIndexPath fromPageIndexPath:oldPageIndexPath];
            }
        }
    }
}

- (void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
    
    CGSize pageSize = self.bounds.size;
    
    [self calculatePageIndex];
    
    if (CGSizeEqualToSize(mPageSize, pageSize))
    {
        mOldPageIndePath = mPageIndexPath;
    }
}

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated
{
    [super setContentOffset:contentOffset animated:animated];
    
    CGSize pageSize = self.bounds.size;
    
    [self calculatePageIndex];
    
    if (CGSizeEqualToSize(mPageSize, pageSize))
    {
        if (mOldPageIndePath != mPageIndexPath)
        {
            mOldPageIndePath = mPageIndexPath;
        }
    }
}

- (CGSize)contentSize
{
    // Getting the content size.
    CGSize contentSize = super.contentSize;
    
    // Returning the content size.
    return contentSize;
}

- (void)setContentSize:(CGSize)contentSize
{
    // Setting new content size.
    super.contentSize = contentSize;
    
    // Getting the actual content size
    contentSize = super.contentSize;
    
    // Calculating the frame for the container view.
    CGRect containerFrame;
    containerFrame.origin = CGPointZero;
    containerFrame.size = contentSize;
    
    // Applying the calculated frame for the container view.
    [mContainerView setFrameIfNeeded:containerFrame];
}

#pragma mark - Managing the Delegate

- (id<RFUIPageScrollViewDelegate, UIScrollViewDelegate>)delegate
{
    return (id<RFUIPageScrollViewDelegate, UIScrollViewDelegate>)super.delegate;
}

- (void)setDelegate:(id<RFUIPageScrollViewDelegate,UIScrollViewDelegate>)delegate
{
    super.delegate = delegate;
}

#pragma mark - Specifying the Data Source

@synthesize dataSource = mDataSource;

- (NSInteger)numberOfColumnsInDataSource
{
    NSInteger numberOfCollumns = 0;
    
    id<RFUIPageScrollViewDataSource> dataSource = mDataSource;
    
    if (dataSource)
    {
        numberOfCollumns = [dataSource numberOfColumnInPageScrollView:self];
    }
    
    return numberOfCollumns;
}

- (NSInteger)numberOfRowsInDataSource
{
    NSInteger numberOfRows = 0;
    
    id<RFUIPageScrollViewDataSource> dataSource = mDataSource;
    
    if (dataSource)
    {
        numberOfRows = [dataSource numberOfRowsInPageScrollView:self];
    }
    
    return numberOfRows;
}

- (RFUIPageScrollViewCell *)cellForRowAtIndexPathInDataSource:(NSIndexPath *)indexPath
{
    RFUIPageScrollViewCell *pageScrollViewCell = nil;
    
    id<RFUIPageScrollViewDataSource> dataSource = mDataSource;
    
    if (dataSource)
    {
        pageScrollViewCell = [dataSource pageScrollView:self cellForRowAtIndexPath:indexPath];
    }
    
    if (!pageScrollViewCell)
    {
        pageScrollViewCell = [[RFUIPageScrollViewCell alloc] init];
    }
    
    return pageScrollViewCell;
}

#pragma mark - Accessing Info

- (NSInteger)numberOfColumns
{
    return mNumberOfColumns;
}

- (NSInteger)numberOfRows
{
    return mNumberOfRows;
}

- (CGRect)rectForCellAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect = CGRectZero;
    
    if (indexPath &&
        (indexPath.row >= 0) && (indexPath.row < mNumberOfRows) &&
        (indexPath.column >= 0) && (indexPath.column < mNumberOfColumns))
    {
        CGRect viewFrame = self.frame;
        
        CGRect pageScrollViewCellFrame;
        pageScrollViewCellFrame.origin.x = indexPath.column * viewFrame.size.width;
        pageScrollViewCellFrame.origin.y = indexPath.row * viewFrame.size.height;
        pageScrollViewCellFrame.size.width = viewFrame.size.width;
        pageScrollViewCellFrame.size.height = viewFrame.size.height;
    }
    
    return rect;
}

- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point
{
    CGRect viewFrame = self.frame;
    
    NSInteger row = (NSInteger)cg_trunc(point.y / viewFrame.size.height);
    NSInteger column = (NSInteger)cg_trunc(point.x / viewFrame.size.width);
    
    NSIndexPath *indexPath = nil;
    
    if ((row >= 0) && (row < mNumberOfRows) &&
        (column >= 0) && (column < mNumberOfColumns))
    {
        indexPath = [NSIndexPath indexPathForRow:row column:column];
    }
    
    return indexPath;
}

- (NSIndexPath *)indexPathForCell:(RFUIPageScrollViewCell *)cell
{
    NSIndexPath *indexPath = nil;
    
    if (cell)
    {
        for (NSInteger indexOfRow = 0; indexOfRow < mNumberOfRows; indexOfRow++)
        {
            NSMutableArray *columns = [mRows objectAtIndex:(NSUInteger)indexOfRow];
            
            NSInteger indexOfColumn = (NSInteger)[columns indexOfObjectIdenticalTo:cell];
            
            if (indexOfColumn != NSNotFound)
            {
                indexPath = [NSIndexPath indexPathForRow:indexOfRow column:indexOfColumn];
                break;
            }
        }
    }
    
    return indexPath;
}

- (RFUIPageScrollViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath
{
    RFUIPageScrollViewCell *pageScrollViewCell = nil;
    
    if ((indexPath.row >= 0) && (indexPath.row < mNumberOfRows) &&
        (indexPath.column >= 0) && (indexPath.column < mNumberOfColumns))
    {
        NSMutableArray *columns = [mRows objectAtIndex:(NSUInteger)indexPath.row];
        pageScrollViewCell = [columns objectAtIndex:(NSUInteger)indexPath.column];
        
        if ([pageScrollViewCell isEqual:[NSNull null]])
        {
            pageScrollViewCell = nil;
        }
    }
    
    return pageScrollViewCell;
}

- (NSArray *)visibleCells
{
    NSArray *visibleCells = [mVisibleCells copy];
    return visibleCells;
}

- (NSArray *)indexPathsForVisibleCells
{
    NSMutableArray *mutableIndexPaths = [[NSMutableArray alloc] initWithCapacity:mVisibleCells.count];
    
    for (RFUIPageScrollViewCell *pageScrollViewCell in mVisibleCells)
    {
        NSIndexPath *indexPath = [self indexPathForCell:pageScrollViewCell];
        
        if (indexPath)
        {
            [mutableIndexPaths addObject:indexPath];
        }
    }
    
    NSArray *indexPaths = [mutableIndexPaths copy];
    
    return indexPaths;
}

#pragma mark - Reloading Data

- (void)reloadData
{
    @autoreleasepool
    {
        mNeedsReloadData = NO;
        
        // Removing All Cells.
        
        [mRows removeAllObjects];
        
        for (RFUIPageScrollViewCell *pageScrollViewCell in mVisibleCells)
        {
            [pageScrollViewCell removeFromSuperview];
        }
        
        [mVisibleCells removeAllObjects];
        
        // Getting Info.
        
        mNumberOfRows = [self numberOfRowsInDataSource];
        mNumberOfColumns = [self numberOfColumnsInDataSource];
        
        // Adding Empty Cells.
        for (NSInteger indexOfRow = 0; indexOfRow < mNumberOfRows; indexOfRow++)
        {
            NSMutableArray *columns = [[NSMutableArray alloc] initWithCapacity:(NSUInteger)mNumberOfColumns];
            
            for (NSInteger indexOfColumn = 0; indexOfColumn < mNumberOfColumns; indexOfColumn++)
            {
                [columns addObject:[NSNull null]];
            }
            
            [mRows addObject:columns];
        }
        
        CGRect viewFrame = self.frame;
        
        CGSize contentSize;
        contentSize.width = mNumberOfColumns * viewFrame.size.width;
        contentSize.height = mNumberOfRows * viewFrame.size.height;
        
        [self setContentSizeIfNeeded:contentSize];
        
        [self setNeedsLayout];
        
        CGPoint contentOffset = CGPointZero;
        
        [self setContentOffsetIfNeeded:contentOffset animated:NO];
        
        [self calculatePageIndex];
    }
}

#pragma mark - Insertion, Deleting, Reloading the Row.

- (void)insertRow:(NSInteger)row
{
    NSMutableArray *columns = [[NSMutableArray alloc] initWithCapacity:(NSUInteger)mNumberOfColumns];
    
    for (NSInteger indexOfColumn = 0; indexOfColumn < mNumberOfColumns; indexOfColumn++)
    {
        [columns addObject:[NSNull null]];
    }
    
    [mRows insertObject:columns atIndex:(NSUInteger)row];
    mNumberOfRows++;
    
    [self layoutIfNeeded];
}

- (void)insertColumn:(NSInteger)indexOfColumn
{
    for (NSInteger indexOfRow = 0; indexOfRow < mNumberOfRows; indexOfRow++)
    {
        NSMutableArray *columns = [mRows objectAtIndex:(NSUInteger)indexOfRow];
        [columns insertObject:[NSNull null] atIndex:(NSUInteger)indexOfColumn];
    }
    
    mNumberOfColumns++;
    
    [self layoutIfNeeded];
}

- (void)deleteRow:(NSInteger)indexOfRow
{
    NSMutableArray *columns = [mRows objectAtIndex:(NSUInteger)indexOfRow];
    
    for (NSInteger indexOfColumn = 0; indexOfColumn < mNumberOfColumns; indexOfColumn++)
    {
        RFUIPageScrollViewCell *pageScrollViewCell = [columns objectAtIndex:(NSUInteger)indexOfColumn];
        
        if (![pageScrollViewCell isEqual:[NSNull null]])
        {
            [pageScrollViewCell removeFromSuperview];
            [mVisibleCells removeObjectIdenticalTo:pageScrollViewCell];
        }
    }
    
    [mRows removeObjectAtIndex:(NSUInteger)indexOfRow];
    
    mNumberOfRows--;
    
    [self layoutIfNeeded];
}

- (void)deleteColumn:(NSInteger)indexOfColumn
{
    for (NSInteger indexOfRow = 0; indexOfRow < mNumberOfRows; indexOfRow++)
    {
        NSMutableArray *columns = [mRows objectAtIndex:(NSUInteger)indexOfRow];
        
        RFUIPageScrollViewCell *pageScrollViewCell = [columns objectAtIndex:(NSUInteger)indexOfColumn];
        
        if (![pageScrollViewCell isEqual:[NSNull null]])
        {
            [pageScrollViewCell removeFromSuperview];
            [mVisibleCells removeObjectIdenticalTo:pageScrollViewCell];
        }
        
        [columns removeObjectAtIndex:(NSUInteger)indexOfColumn];
    }
    
    mNumberOfColumns--;
    
    [self layoutIfNeeded];
}

- (void)reloadCellIndexPaths:(NSArray *)indexPaths
{
    for (NSIndexPath *indexPath in indexPaths)
    {
        RFUIPageScrollViewCell *pageScrollViewCell = [self cellAtIndexPath:indexPath];
        
        if (pageScrollViewCell)
        {
            RFUIPageScrollViewCell *pageScrollViewCell2 = [self cellForRowAtIndexPathInDataSource:indexPath];
            
            CGRect pageScrollViewCell2Frame = pageScrollViewCell.frame;
            
            [pageScrollViewCell2 setFrameIfNeeded:pageScrollViewCell2Frame];
            
            [[mRows objectAtIndex:(NSUInteger)indexPath.row] replaceObjectAtIndex:(NSUInteger)indexPath.column withObject:pageScrollViewCell2];
            [mVisibleCells removeObjectIdenticalTo:pageScrollViewCell];
            [mVisibleCells addObject:pageScrollViewCell2];
            
            [pageScrollViewCell removeFromSuperview];
            [mContainerView addSubview:pageScrollViewCell2];
        }
    }
}

- (NSIndexPath *)pageIndexPath
{
    return mPageIndexPath;
}

- (void)setPageIndexPath:(NSIndexPath *)pageIndexPath
{
    [self setPageIndexPath:pageIndexPath animated:NO];
}

- (void)setPageIndexPath:(NSIndexPath *)pageIndexPath animated:(BOOL)animated
{
    RENSAssert(pageIndexPath, @"The pageIndexPath argument is nil.");
    
    CGRect viewBounds = self.bounds;
    
    CGPoint contentOffset;
    contentOffset.x = viewBounds.size.width * pageIndexPath.column;
    contentOffset.y = viewBounds.size.height * pageIndexPath.row;
    
    [self setContentOffsetIfNeeded:contentOffset animated:animated];
}

@end

@implementation NSIndexPath (NSIndexPathRFUIPageScrollView)

#pragma mark - Initializing and Creating a NSIndexPath

- (id)initForRow:(NSInteger)row column:(NSInteger)column
{
    // Creating an array of indexes.
    NSUInteger indexes[2] = {(NSUInteger)column, (NSUInteger)row};
    
    if ((self = [self initWithIndexes:indexes length:2]))
    {
    }
    
    return self;
}

+ (id)indexPathForRow:(NSInteger)row column:(NSInteger)column
{
    return [[self alloc] initForRow:row column:column];
}

#pragma mark - Properties

- (NSInteger)column
{
    // Getting the column.
    NSInteger column = (NSInteger)[self indexAtPosition:0];
    
    // Returning the column.
    return column;
}

@end
