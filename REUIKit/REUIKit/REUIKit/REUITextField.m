//
//  REUITextField.m
//  REUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.11.22.
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
#import "REUITextField.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation UITextField (UITextFieldREUITextField)

#pragma mark - Replacing and Returning Text

- (NSString *)nsTextInRange:(NSRange)nsTextRange
{
    UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
    
    UITextPosition *uiTextStartPosition = [self positionFromPosition:uiBeginningOfDocument offset:(NSInteger)nsTextRange.location];
    UITextPosition *uiTextEndPosition = [self positionFromPosition:uiTextStartPosition offset:(NSInteger)nsTextRange.length];
    UITextRange *uiTextRange = [self textRangeFromPosition:uiTextStartPosition toPosition:uiTextEndPosition];
    
    NSString *text = [self textInRange:uiTextRange];
    
    return text;
}

- (void)nsReplaceRange:(NSRange)nsTextRange withText:(NSString *)text
{
    UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
    
    UITextPosition *uiTextStartPosition = [self positionFromPosition:uiBeginningOfDocument offset:(NSInteger)nsTextRange.location];
    UITextPosition *uiTextEndPosition = [self positionFromPosition:uiTextStartPosition offset:(NSInteger)nsTextRange.length];
    UITextRange *uiTextRange = [self textRangeFromPosition:uiTextStartPosition toPosition:uiTextEndPosition];
    
    [self replaceRange:uiTextRange withText:text];
}

#pragma mark - Working with Marked and Selected Text

- (NSRange)nsSelectedTextRange
{
    @synchronized(self)
    {
        NSRange nsSelectedRange = NSRangeNotFound;
        
        UITextRange *uiSelectedTextRange = self.selectedTextRange;
        
        if (uiSelectedTextRange)
        {
            UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
            
            if (uiBeginningOfDocument)
            {
                nsSelectedRange.location = (NSUInteger)[self offsetFromPosition:uiBeginningOfDocument toPosition:uiSelectedTextRange.start];
                nsSelectedRange.length = (NSUInteger)[self offsetFromPosition:uiSelectedTextRange.start toPosition:uiSelectedTextRange.end];
            }
        }
        
        return nsSelectedRange;
    }
}

- (void)setNSMarkedTextRange:(NSRange)nsMarkedTextRange
{
    @synchronized(self)
    {
        UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
        
        UITextPosition *uiMarkedTextStartPosition = [self positionFromPosition:uiBeginningOfDocument offset:(NSInteger)nsMarkedTextRange.location];
        UITextPosition *uiMarkedTextEndPosition = [self positionFromPosition:uiMarkedTextStartPosition offset:(NSInteger)nsMarkedTextRange.length];
        UITextRange *uiMarkedTextRange = [self textRangeFromPosition:uiMarkedTextStartPosition toPosition:uiMarkedTextEndPosition];
        
        self.selectedTextRange = uiMarkedTextRange;
    }
}

- (NSRange)nsMarkedTextRange
{
    NSRange nsMarkedTextRange = NSRangeNotFound;
    
    UITextRange *uiMmarkedTextRange = self.markedTextRange;
    
    if (uiMmarkedTextRange)
    {
        UITextPosition *beginningOfDocument = self.beginningOfDocument;
        
        if (beginningOfDocument)
        {
            nsMarkedTextRange.location = (NSUInteger)[self offsetFromPosition:beginningOfDocument toPosition:uiMmarkedTextRange.start];
            nsMarkedTextRange.length = (NSUInteger)[self offsetFromPosition:uiMmarkedTextRange.start toPosition:uiMmarkedTextRange.end];
        }
    }
    
    return nsMarkedTextRange;
}

- (NSRange)nsTextRange
{
    @synchronized(self)
    {
        NSRange nsTextRange = NSRangeNotFound;
        
        UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
        UITextPosition *uiEndOfDocument = self.endOfDocument;
        
        if (uiBeginningOfDocument && uiEndOfDocument)
        {
            nsTextRange.location = 0;
            nsTextRange.length = (NSUInteger)[self offsetFromPosition:uiBeginningOfDocument toPosition:uiEndOfDocument];
        }
        
        return nsTextRange;
    }
}

- (NSUInteger)nsTextLength
{
    @synchronized(self)
    {
        NSUInteger nsTextLength = 0;
        
        UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
        UITextPosition *uiEndOfDocument = self.endOfDocument;
        
        if (uiBeginningOfDocument && uiEndOfDocument)
        {
            nsTextLength = (NSUInteger)[self offsetFromPosition:uiBeginningOfDocument toPosition:uiEndOfDocument];
        }
        
        return nsTextLength;
    }
}

#pragma mark - Computing Text Ranges and Text Positions

- (NSInteger)nsPositionFromPosition:(NSInteger)nsOldTextPosition inDirection:(UITextLayoutDirection)direction offset:(NSInteger)offset
{
    NSInteger nsNewTextPosition = NSNotFound;
    
    UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
    
    if (uiBeginningOfDocument)
    {
        UITextPosition *uiOldTextPosition = [self positionFromPosition:uiBeginningOfDocument offset:nsOldTextPosition];
        UITextPosition *uiNewTextPosition = [self positionFromPosition:uiOldTextPosition inDirection:direction offset:offset];
        
        if (uiNewTextPosition)
        {
            nsNewTextPosition = [self offsetFromPosition:uiBeginningOfDocument toPosition:uiNewTextPosition];
        }
    }
    
    return nsNewTextPosition;
}

#pragma mark - Determining Layout and Writing Direction

- (NSInteger)nsPositionWithinRange:(NSRange)nsTextRange farthestInDirection:(UITextLayoutDirection)direction
{
    NSInteger nsTextPosition = NSNotFound;
    
    UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
    
    if (uiBeginningOfDocument)
    {
        UITextPosition *uiTextBeginPosition = [self positionFromPosition:uiBeginningOfDocument offset:(NSInteger)nsTextRange.location];
        UITextPosition *uiTextEndPosition = [self positionFromPosition:uiTextBeginPosition offset:(NSInteger)nsTextRange.length];
        UITextRange *uiTextRange = [self textRangeFromPosition:uiTextBeginPosition toPosition:uiTextEndPosition];
        
        UITextPosition *uiTextPosition = [self positionWithinRange:uiTextRange farthestInDirection:direction];
        
        if (uiBeginningOfDocument && uiTextBeginPosition)
        {
            nsTextPosition = [self offsetFromPosition:uiBeginningOfDocument toPosition:uiTextPosition];
        }
    }
    
    return nsTextPosition;
}

- (NSRange)nsCharacterRangeByExtendingPosition:(NSInteger)nsExtendingTextPosition inDirection:(UITextLayoutDirection)direction
{
    NSRange nsCharecterTextRange = NSRangeNotFound;
    
    UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
    
    if (uiBeginningOfDocument)
    {
        UITextPosition *uiExtendingTextPosition = [self positionFromPosition:uiBeginningOfDocument offset:nsExtendingTextPosition];
        UITextRange *uiCharecterTextRange = [self characterRangeByExtendingPosition:uiExtendingTextPosition inDirection:direction];
        
        if (uiCharecterTextRange)
        {
            nsCharecterTextRange.location = (NSUInteger)[self offsetFromPosition:uiBeginningOfDocument toPosition:uiCharecterTextRange.start];
            nsCharecterTextRange.length = (NSUInteger)[self offsetFromPosition:uiCharecterTextRange.start toPosition:uiCharecterTextRange.end];
        }
    }
    
    return nsCharecterTextRange;
}

- (UITextWritingDirection)nsBaseWritingDirectionForPosition:(NSInteger)nsTextPosition inDirection:(UITextStorageDirection)direction
{
    UITextWritingDirection baseWritingDirection = UITextWritingDirectionNatural;
    
    UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
    
    if (uiBeginningOfDocument)
    {
        UITextPosition *uiTextPosition = [self positionFromPosition:uiBeginningOfDocument offset:nsTextPosition];
        
        if (uiTextPosition)
        {
            baseWritingDirection = [self baseWritingDirectionForPosition:uiTextPosition inDirection:direction];
        }
    }
    
    return baseWritingDirection;
}

- (void)setNSBaseWritingDirection:(UITextWritingDirection)writingDirection forRange:(NSRange)nsTextRange
{
    UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
    
    if (uiBeginningOfDocument)
    {
        UITextPosition *uiTextBeginPosition = [self positionFromPosition:uiBeginningOfDocument offset:(NSInteger)nsTextRange.location];
        UITextPosition *uiTextEndPosition = [self positionFromPosition:uiTextBeginPosition offset:(NSInteger)nsTextRange.length];
        UITextRange *uiTextRange = [self textRangeFromPosition:uiTextBeginPosition toPosition:uiTextEndPosition];
        
        if (uiTextRange)
        {
            [self setBaseWritingDirection:writingDirection forRange:uiTextRange];
        }
    }
}

#pragma mark - Geometry and Hit-Testing Methods

- (CGRect)nsFirstRectForRange:(NSRange)nsTextRange
{
    CGRect rirstRect = CGRectZero;
    
    UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
    
    if (uiBeginningOfDocument)
    {
        UITextPosition *uiTextBeginPosition = [self positionFromPosition:uiBeginningOfDocument offset:(NSInteger)nsTextRange.location];
        UITextPosition *uiTextEndPosition = [self positionFromPosition:uiTextBeginPosition offset:(NSInteger)nsTextRange.length];
        UITextRange *uiTextRange = [self textRangeFromPosition:uiTextBeginPosition toPosition:uiTextEndPosition];
        
        if (uiTextRange)
        {
            rirstRect = [self firstRectForRange:uiTextRange];
        }
    }
    
    return rirstRect;
}

- (CGRect)nsCaretRectForPosition:(NSInteger)nsTextPosition
{
    CGRect rirstRect = CGRectZero;
    
    UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
    
    if (uiBeginningOfDocument)
    {
        UITextPosition *uiTextPosition = [self positionFromPosition:uiBeginningOfDocument offset:nsTextPosition];
        
        if (uiTextPosition)
        {
            rirstRect = [self caretRectForPosition:uiTextPosition];
        }
    }
    
    return rirstRect;
}

- (NSInteger)nsClosestPositionToPoint:(CGPoint)point
{
    NSInteger nsClosestTextPosition = NSNotFound;
    
    UITextPosition *uiClosestTextPosition = [self closestPositionToPoint:point];
    
    if (uiClosestTextPosition)
    {
        UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
        
        if (uiBeginningOfDocument)
        {
            nsClosestTextPosition = [self offsetFromPosition:uiBeginningOfDocument toPosition:uiClosestTextPosition];
        }
    }
    
    return nsClosestTextPosition;
}

- (NSInteger)nsClosestPositionToPoint:(CGPoint)point withinRange:(NSRange)nsTextRange
{
    NSInteger nsClosestTextPosition = NSNotFound;
    
    UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
    
    if (uiBeginningOfDocument)
    {
        UITextPosition *uiTextBeginPosition = [self positionFromPosition:uiBeginningOfDocument offset:(NSInteger)nsTextRange.location];
        UITextPosition *uiTextEndPosition = [self positionFromPosition:uiTextBeginPosition offset:(NSInteger)nsTextRange.length];
        UITextRange *uiTextRange = [self textRangeFromPosition:uiTextBeginPosition toPosition:uiTextEndPosition];
        
        if (uiTextRange)
        {
            UITextPosition *uiClosestTextPosition = [self closestPositionToPoint:point withinRange:uiTextRange];
            
            if (uiClosestTextPosition)
            {
                nsClosestTextPosition = [self offsetFromPosition:uiBeginningOfDocument toPosition:uiClosestTextPosition];
            }
        }
    }
    
    return nsClosestTextPosition;
}

- (NSRange)nsCharacterRangeAtPoint:(CGPoint)point
{
    NSRange nsCharacterRange = NSRangeNotFound;
    
    UITextRange *uiCharacterTextRange = [self characterRangeAtPoint:point];
    
    if (uiCharacterTextRange)
    {
        UITextPosition *uiBeginningOfDocument = self.beginningOfDocument;
        
        if (uiBeginningOfDocument)
        {
            nsCharacterRange.location = (NSUInteger)[self offsetFromPosition:uiBeginningOfDocument toPosition:uiCharacterTextRange.start];
            nsCharacterRange.length = (NSUInteger)[self offsetFromPosition:uiCharacterTextRange.start toPosition:uiCharacterTextRange.end];
        }
    }
    
    return nsCharacterRange;
}

@end
