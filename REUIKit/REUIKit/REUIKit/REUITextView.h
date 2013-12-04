//
//  REUITextView.h
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

// Importing the system headers.
#import <CoreGraphics/CGGeometry.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSRange.h>
#import <UIKit/UITextInput.h>
#import <UIKit/UITextView.h>

@class NSString;

@interface UITextView (UITextViewREUITextView)

// Replacing and Returning Text

- (NSString *)nsTextInRange:(NSRange)range;
- (void)nsReplaceRange:(NSRange)range withText:(NSString *)text;

// Working with Marked and Selected Text

@property (readwrite, setter = setNSMarkedTextRange:) NSRange    nsSelectedTextRange; // NSRangeNotFound if no selected text.
@property (nonatomic, readonly)                       NSRange    nsMarkedTextRange;   // NSRangeNotFound if no marked text.
@property (nonatomic, readonly)                       NSRange    nsTextRange;         // NSRangeNotFound if no text.
@property (nonatomic, readonly)                       NSUInteger nsTextLength;

// Computing Text Ranges and Text Positions

- (NSInteger)nsPositionFromPosition:(NSInteger)position inDirection:(UITextLayoutDirection)direction offset:(NSInteger)offset;

// Determining Layout and Writing Direction

- (NSInteger)nsPositionWithinRange:(NSRange)range farthestInDirection:(UITextLayoutDirection)direction;
- (NSRange)nsCharacterRangeByExtendingPosition:(NSInteger)position inDirection:(UITextLayoutDirection)direction;

- (UITextWritingDirection)nsBaseWritingDirectionForPosition:(NSInteger)position inDirection:(UITextStorageDirection)direction;
- (void)setNSBaseWritingDirection:(UITextWritingDirection)writingDirection forRange:(NSRange)range;

// Geometry and Hit-Testing Methods

- (CGRect)nsFirstRectForRange:(NSRange)range;
- (CGRect)nsCaretRectForPosition:(NSInteger)position;

- (NSInteger)nsClosestPositionToPoint:(CGPoint)point;
- (NSInteger)nsClosestPositionToPoint:(CGPoint)point withinRange:(NSRange)range;
- (NSRange)nsCharacterRangeAtPoint:(CGPoint)point;

@end
