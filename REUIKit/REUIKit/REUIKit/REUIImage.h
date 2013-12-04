//
//  REUIImage.h
//  REUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2011.07.09.
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
#import <CoreGraphics/CGBase.h>
#import <CoreGraphics/CGImage.h>
#import <Foundation/NSData.h>
#import <Foundation/NSObjCRuntime.h>
#import <UIKit/UIImage.h>
#import <UIKit/UIKitDefines.h>

@class NSError;
@class NSString;
@class NSURL;
@class UIImage;

UIKIT_EXTERN NSString *NSStringFromUIImageOrientation(UIImageOrientation imageOrientation);
UIKIT_EXTERN UIImageOrientation UIImageOrientationFromNSString(NSString *string);

@interface UIImage (UIImageREUIImage)

// Initializing and Creating a UIImage

- (id)initWithContentsOfFile:(NSString *)path scale:(CGFloat)scale;
+ (UIImage *)imageWithContentsOfFile:(NSString *)path scale:(CGFloat)scale;

- (id)initWithContentsOfFile:(NSString *)path scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;
+ (UIImage *)imageWithContentsOfFile:(NSString *)path scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;

- (id)initWithData:(NSData *)data scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;
+ (UIImage *)imageWithData:(NSData *)data scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;

- (id)initWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale;
+ (UIImage *)imageWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale;

- (id)initWithImage:(UIImage *)image scale:(CGFloat)scale;
+ (UIImage *)imageWithImage:(UIImage *)image scale:(CGFloat)scale;

- (id)initWithImage:(UIImage *)image orientation:(UIImageOrientation)orientation;
+ (UIImage *)imageWithImage:(UIImage *)image orientation:(UIImageOrientation)orientation;

- (id)initWithImage:(UIImage *)image scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;
+ (UIImage *)imageWithImage:(UIImage *)image scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;

+ (UIImage *)imageNamed:(NSString *)name orientation:(UIImageOrientation)orientation;

// Write an Image

- (BOOL)writeAsJPEGRepresentationWithCompressionQuality:(CGFloat)compressionQuality toFile:(NSString *)path options:(NSDataWritingOptions)mask error:(NSError **)error;
- (BOOL)writeAsJPEGRepresentationWithCompressionQuality:(CGFloat)compressionQuality toURL:(NSURL *)url options:(NSDataWritingOptions)mask error:(NSError **)error;
- (BOOL)writeAsJPEGRepresentationWithCompressionQuality:(CGFloat)compressionQuality inDocumentDirectoryToFileName:(NSString *)fileName options:(NSDataWritingOptions)mask error:(NSError **)error;

- (BOOL)writeAsPNGRepresentationToFile:(NSString *)path options:(NSDataWritingOptions)mask error:(NSError **)error;
- (BOOL)writeAsPNGRepresentationToURL:(NSURL *)url options:(NSDataWritingOptions)mask error:(NSError **)error;
- (BOOL)writeAsPNGRepresentationInDocumentDirectoryToFileName:(NSString *)fileName options:(NSDataWritingOptions)mask error:(NSError **)error;

@end

@interface UIImage (UIImageREUIImage_6_0_Dynamic)
@end

#ifndef __IPHONE_6_0
#   warning The "__IPHONE_6_0" is not defined.
#endif

#ifndef __IPHONE_OS_VERSION_MAX_ALLOWED
#   warning The "__IPHONE_OS_VERSION_MAX_ALLOWED" is not defined.
#endif

#if __IPHONE_6_0 > __IPHONE_OS_VERSION_MAX_ALLOWED

@interface UIImage (UIImageREUIImage_6_0)

// Initializing and Creating a UIImage

- (id)initWithData:(NSData *)data scale:(CGFloat)scale;
+ (UIImage *)imageWithData:(NSData *)data scale:(CGFloat)scale;

@end

#endif
