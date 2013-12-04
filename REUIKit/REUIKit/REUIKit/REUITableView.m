//
//  REUITableView.m
//  REUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.05.24.
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
#import "REUITableView.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation UITableView (UITableViewREUITableView)

#pragma mark - Accessing Cells and Sections

- (UITableViewCell *)cellForRowAtRow:(NSInteger)row inSection:(NSInteger)section
{
    // Creating an index path for the table view cell.
    NSIndexPath *indexPath = [[NSIndexPath alloc] initForRow:row inSection:section];
    
    // Getting the table view cell at the index path.
    UITableViewCell *tableViewCell = [self cellForRowAtIndexPath:indexPath];
    
    // Returning the table view cell.
    return tableViewCell;
}

#pragma mark - Managing Selections

- (void)selectRowsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition
{
    // Setting the default values.
    NSIndexPath *indexPathForPosition = nil;
    
    // Calculating the indexPathForPosition.
    switch (scrollPosition)
    {
        default:
        case UITableViewScrollPositionNone:
        {
            break;
        }
            
        case UITableViewScrollPositionTop:
        {
            // Setting the first index path as an index path for position.
            indexPathForPosition = indexPaths.firstObject;
            
            // Search a top index path.
            for (NSIndexPath *indexPath in indexPaths)
            {
                // We have a new index path for position.
                if ((indexPathForPosition.section > indexPath.section) ||
                    ((indexPathForPosition.section == indexPath.section) &&
                     (indexPathForPosition.row > indexPath.row)))
                {
                    // Saving the index path as an index path for position.
                    indexPathForPosition = indexPath;
                }
            }
            
            break;
        }
            
        case UITableViewScrollPositionMiddle:
        {
            // Copying the index paths.
            NSMutableArray *mutableIndexPaths = [indexPaths mutableCopy];
            
            // Sorting the index paths.
            [mutableIndexPaths sortUsingComparator:^NSComparisonResult(NSIndexPath *indexPath1, NSIndexPath *indexPath2) {
                // Comparing the index paths.
                NSComparisonResult comparisonResult = ({
                    // Getting the sections.
                    NSInteger section1 = indexPath1.section;
                    NSInteger section2 = indexPath2.section;
                    
                    // Comparing the sections.
                    NS_CASCADE_COMPARE(section1, section2, ({
                        // The sections is equal.
                        
                        // Getting the rows.
                        NSInteger row1 = indexPath1.row;
                        NSInteger row2 = indexPath2.row;
                        
                        // Comparing the rows.
                        NS_COMPARE(row1, row2);
                    }));
                });
                
                // Returning the comparison result.
                return comparisonResult;
            }];
            
            // Getting the number of index paths.
            NSUInteger numberOfIndexPaths = mutableIndexPaths.count;
            
            // We have index paths.
            if (numberOfIndexPaths > 0)
            {
                // Getting the middle index path.
                NSUInteger indexOfIndexPath = (numberOfIndexPaths - 1) / 2;
                indexPathForPosition = mutableIndexPaths[indexOfIndexPath];
            }
            
            break;
        }
            
        case UITableViewScrollPositionBottom:
        {
            // Setting the last index path as an index path for position.
            indexPathForPosition = indexPaths.lastObject;
            
            // Search a bottom index path.
            for (NSIndexPath *indexPath in indexPaths)
            {
                // We have a new index path for position.
                if ((indexPathForPosition.section < indexPath.section) ||
                    ((indexPathForPosition.section == indexPath.section) &&
                     (indexPathForPosition.row < indexPath.row)))
                {
                    // Saving the index path as an index path for position.
                    indexPathForPosition = indexPath;
                }
            }
            
            break;
        }
    }
    
    // Selecting rows at the index paths.
    for (NSIndexPath *indexPath in indexPaths)
    {
        // Selecting a row at the index path.
        [self selectRowAtIndexPath:indexPath
                          animated:animated
                    scrollPosition:((indexPath == indexPathForPosition) ? scrollPosition : UITableViewScrollPositionNone)];
    }
}

- (void)selectAllRowsInSections:(NSIndexSet *)sections animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition
{
    // Setting the default values.
    NSInteger rowForPosition = NSNotFound;
    NSInteger sectionForPosition = NSNotFound;
    
    // We have sections.
    if (sections.count > 0)
    {
        // Calculating the section for position.
        switch (scrollPosition)
        {
            default:
            case UITableViewScrollPositionNone:
            {
                break;
            }
                
            case UITableViewScrollPositionTop:
            {
                // Getting a top section.
                NSUInteger section = sections.firstIndex;
                
                // Searching a top row.
                while (section != NSNotFound)
                {
                    // Getting the number of rows in the section.
                    NSInteger numberOfRows = [self numberOfRowsInSection:(NSInteger)section];
                    
                    // The section has rows.
                    if (numberOfRows > 0)
                    {
                        // Getting the top row in section.
                        sectionForPosition = (NSInteger)section;
                        rowForPosition = 0;
                        
                        break;
                    }
                    
                    // Getting the next section.
                    section = [sections indexGreaterThanIndex:section];
                }
                
                break;
            }
                
            case UITableViewScrollPositionMiddle:
            {
                // Getting the infomation about the bottom section.
                NSInteger bottomSection = (NSInteger)sections.lastIndex;
                NSInteger bottomNumberOfRows = [self numberOfRowsInSection:bottomSection];
                
                // Getting the infomation about the tom section.
                NSInteger topSection = (NSInteger)sections.firstIndex;
                NSInteger topNumberOfRows = [self numberOfRowsInSection:topSection];
                NSInteger topTotalNumberOfRows = topNumberOfRows;
                
                // Searching a middle row.
                do
                {
                    // Calculating the middle row for the current rows.
                    
                    if (topNumberOfRows < bottomNumberOfRows)
                    {
                        topNumberOfRows = 0;
                        bottomNumberOfRows -= topNumberOfRows;
                        
                        sectionForPosition = bottomSection;
                        rowForPosition = (bottomNumberOfRows - 1) / 2;
                    }
                    
                    else if (topNumberOfRows > bottomNumberOfRows)
                    {
                        topNumberOfRows -= bottomNumberOfRows;
                        bottomNumberOfRows = 0;
                        
                        sectionForPosition = topSection;
                        rowForPosition = topTotalNumberOfRows - (topNumberOfRows / 2) - 1;
                    }
                    
                    // (topTotalNumberOfRows == bottomNumberOfRows)
                    else
                    {
                        if (topTotalNumberOfRows > 0)
                        {
                            sectionForPosition = topSection;
                            rowForPosition = topTotalNumberOfRows - (topNumberOfRows / 2) - 1;
                            
                            topNumberOfRows = 0;
                            bottomNumberOfRows = 0;
                        }
                        
                        else if (bottomNumberOfRows > 0)
                        {
                            sectionForPosition = bottomSection;
                            rowForPosition = (bottomNumberOfRows - 1) / 2;
                            
                            topNumberOfRows = 0;
                            bottomNumberOfRows = 0;
                        }
                    }
                    
                    // Getting the information about the next/previous section.
                    
                    if (topSection < bottomSection)
                    {
                        // We must get the next top section.
                        if (topNumberOfRows == 0)
                        {
                            // Getting the infomation about the next top section.
                            topSection = (NSInteger)[sections indexGreaterThanIndex:(NSUInteger)topSection];
                            topNumberOfRows = [self numberOfRowsInSection:topSection];
                            topTotalNumberOfRows = topNumberOfRows;
                        }
                        
                        // We must to get the previous bottom section.
                        else if (bottomNumberOfRows == 0)
                        {
                            // Getting the infomation about the previous bottom section.
                            bottomSection = (NSInteger)[sections indexLessThanIndex:(NSUInteger)bottomSection];
                            bottomNumberOfRows = [self numberOfRowsInSection:bottomSection];
                        }
                    }
                } while (topSection < bottomSection);
                
                break;
            }
                
            case UITableViewScrollPositionBottom:
            {
                // Getting a bottom section.
                NSUInteger section = sections.lastIndex;
                
                // Searching a bottom row.
                while (section != NSNotFound)
                {
                    // Getting the number of rows in the section.
                    NSInteger numberOfRows = [self numberOfRowsInSection:(NSInteger)section];
                    
                    // The section has rows.
                    if (numberOfRows > 0)
                    {
                        // Getting the bottom row in section.
                        sectionForPosition = (NSInteger)section;
                        rowForPosition = numberOfRows - 1;
                        
                        break;
                    }
                    
                    // Getting the previous section.
                    section = [sections indexLessThanIndex:section];
                }
                
                break;
            }
        }
    }
    
    // Selecting all rows in the sections.
    [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL *stop) {
#pragma unused(stop)
        
        // Getting the number of rows in the section.
        NSInteger numberOfRows = [self numberOfRowsInSection:(NSInteger)section];
        
        // Selecting all the rows in the section.
        for (NSInteger row = 0; row < numberOfRows; row++)
        {
            // Creating an index path for the row.
            NSIndexPath *indexPath = [[NSIndexPath alloc] initForRow:row inSection:(NSInteger)section];
            
            // Selecting the row at the index path.
            [self selectRowAtIndexPath:indexPath
                              animated:animated
                        scrollPosition:((((NSInteger)section == sectionForPosition) && (row == rowForPosition)) ? scrollPosition : UITableViewScrollPositionNone)];
        }
    }];
}

- (void)selectAllRowsAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition
{
    // Setting the default values.
    NSInteger rowForPosition = NSNotFound;
    NSInteger sectionForPosition = NSNotFound;
    
    // Getting the number of sections.
    NSInteger numberOfSections = [self numberOfSections];
    
    // We have sections.
    if (numberOfSections > 0)
    {
        // Calculating the section for position.
        switch (scrollPosition)
        {
            default:
            case UITableViewScrollPositionNone:
            {
                break;
            }
                
            case UITableViewScrollPositionTop:
            {
                // Searching a top row.
                for (NSInteger section = 0; section < numberOfSections; section++)
                {
                    // Getting the number of rows in the section.
                    NSInteger numberOfRows = [self numberOfRowsInSection:section];
                    
                    // The section has rows.
                    if (numberOfRows > 0)
                    {
                        // Getting the top row in section.
                        sectionForPosition = section;
                        rowForPosition = 0;
                        
                        break;
                    }
                }
                
                break;
            }
                
            case UITableViewScrollPositionMiddle:
            {
                // Getting the infomation about the bottom section.
                NSInteger bottomSection = numberOfSections - 1;
                NSInteger bottomNumberOfRows = [self numberOfRowsInSection:bottomSection];
                
                // Getting the infomation about the tom section.
                NSInteger topSection = 0;
                NSInteger topNumberOfRows = [self numberOfRowsInSection:topSection];
                NSInteger topTotalNumberOfRows = topNumberOfRows;
                
                // Searching a middle row.
                do
                {
                    // Calculating the middle row for the current rows.
                    
                    if (topNumberOfRows < bottomNumberOfRows)
                    {
                        topNumberOfRows = 0;
                        bottomNumberOfRows -= topNumberOfRows;
                        
                        sectionForPosition = bottomSection;
                        rowForPosition = (bottomNumberOfRows - 1) / 2;
                    }
                    
                    else if (topNumberOfRows > bottomNumberOfRows)
                    {
                        topNumberOfRows -= bottomNumberOfRows;
                        bottomNumberOfRows = 0;
                        
                        sectionForPosition = topSection;
                        rowForPosition = topTotalNumberOfRows - (topNumberOfRows / 2) - 1;
                    }
                    
                    // (topTotalNumberOfRows == bottomNumberOfRows)
                    else
                    {
                        if (topTotalNumberOfRows > 0)
                        {
                            sectionForPosition = topSection;
                            rowForPosition = topTotalNumberOfRows - (topNumberOfRows / 2) - 1;
                            
                            topNumberOfRows = 0;
                            bottomNumberOfRows = 0;
                        }
                        
                        else if (bottomNumberOfRows > 0)
                        {
                            sectionForPosition = bottomSection;
                            rowForPosition = (bottomNumberOfRows - 1) / 2;
                            
                            topNumberOfRows = 0;
                            bottomNumberOfRows = 0;
                        }
                    }
                    
                    // Getting the information about the next/previous section.
                    
                    if (topSection < bottomSection)
                    {
                        // We must to get the next top section.
                        if (topNumberOfRows == 0)
                        {
                            // Getting the infomation about the next top section.
                            topSection++;
                            topNumberOfRows = [self numberOfRowsInSection:topSection];
                            topTotalNumberOfRows = topNumberOfRows;
                        }
                        
                        // We must to get the previous bottom section.
                        else if (bottomNumberOfRows == 0)
                        {
                            // Getting the infomation about the next bottom section.
                            bottomNumberOfRows--;
                            bottomNumberOfRows = [self numberOfRowsInSection:bottomSection];
                        }
                    }
                } while (topSection < bottomSection);
                
                break;
            }
                
            case UITableViewScrollPositionBottom:
            {
                // Searching a bottom row.
                for (NSInteger section =numberOfSections - 1; section > -1; section--)
                {
                    // Getting the number of rows in the section.
                    NSInteger numberOfRows = [self numberOfRowsInSection:section];
                    
                    // The section has rows.
                    if (numberOfRows > 0)
                    {
                        // Getting the bottom row in section.
                        sectionForPosition = section;
                        rowForPosition = numberOfRows - 1;
                        
                        break;
                    }
                }
                
                break;
            }
        }
    }
    
    // Selecting all rows in the sections.
    for (NSInteger section = 0; section < numberOfSections; section++)
    {
        // Getting the number of rows in the section.
        NSInteger numberOfRows = [self numberOfRowsInSection:section];
        
        // Selecting all the rows in the section.
        for (NSInteger row = 0; row < numberOfRows; row++)
        {
            // Creating an index path for the row.
            NSIndexPath *indexPath = [[NSIndexPath alloc] initForRow:row inSection:section];
            
            // Selecting the row at the index path.
            [self selectRowAtIndexPath:indexPath
                              animated:animated
                        scrollPosition:(((section == sectionForPosition) && (row == rowForPosition)) ? scrollPosition : UITableViewScrollPositionNone)];
        }
    };
}

- (void)deselectRowsAtIndexPaths:(NSArray *)indexPaths animated:(BOOL)animated
{
    // Deselecting rows at the index paths
    for (NSIndexPath *indexPath in indexPaths)
    {
        // Deselecting a row at the index path.
        [self deselectRowAtIndexPath:indexPath animated:animated];
    }
}

- (void)deselectRowsInSections:(NSIndexSet *)sections animated:(BOOL)animated
{
    // Deselecting all the rows in the sections.
    [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL *stop) {
#pragma unused(stop)
        
        // Getting the number of rows in the section.
        NSInteger numberOfRows = [self numberOfRowsInSection:(NSInteger)section];
        
        // Deselecting the rows in the section.
        for (NSInteger row = 0; row < numberOfRows; row++)
        {
            // Creating an index path for the row.
            NSIndexPath *indexPath = [[NSIndexPath alloc] initForRow:row inSection:(NSInteger)section];
            
            // Deselect the row at the index path.
            [self deselectRowAtIndexPath:indexPath animated:animated];
        }
        
    }];
}

- (void)deselectRowsAnimated:(BOOL)animated
{
    // Getting the number of sections.
    NSInteger numberOfSections = [self numberOfSections];
    
    // Deselecting all the rows.
    for (NSInteger section = 0; section < numberOfSections; section++)
    {
        // Getting the number of rows in the section.
        NSInteger numberOfRows = [self numberOfRowsInSection:section];
        
        // Deselecting the rows in the section.
        for (NSInteger row = 0; row < numberOfRows; row++)
        {
            // Creating an index path for the row.
            NSIndexPath *indexPath = [[NSIndexPath alloc] initForRow:row inSection:section];
            
            // Deselect the row at the index path.
            [self deselectRowAtIndexPath:indexPath animated:animated];
        }
    }
}

- (void)deselectSelectedRowsInSections:(NSIndexSet *)sections animated:(BOOL)animated
{
    // Getting the index paths for selected rows.
    NSArray *indexPaths = self.indexPathsForSelectedRows;
    
    // Deselecting rows at the index paths
    for (NSIndexPath *indexPath in indexPaths)
    {
        // We must deselect a row at the index path.
        if ([sections containsIndex:(NSUInteger)indexPath.section])
        {
            // Deselecting the row at the index path.
            [self deselectRowAtIndexPath:indexPath animated:animated];
        }
    }
}

- (void)deselectSelectedRowsAnimated:(BOOL)animated
{
    // Getting the index paths for selected rows.
    NSArray *indexPaths = self.indexPathsForSelectedRows;
    
    // Deselecting rows at the index paths
    for (NSIndexPath *indexPath in indexPaths)
    {
        // Deselecting a row at the index path.
        [self deselectRowAtIndexPath:indexPath animated:animated];
    }
}

@end

@implementation NSIndexPath (NSIndexPathREUITableView)

#pragma mark - Initializing and Creating a NSIndexPath

- (id)initForRow:(NSInteger)row inSection:(NSInteger)section
{
    // Creating an array of indexes.
    NSUInteger indexes[2] = {(NSUInteger)section, (NSUInteger)row};
    
    if ((self = [self initWithIndexes:indexes length:2]))
    {
    }
    
    return self;
}

@end
