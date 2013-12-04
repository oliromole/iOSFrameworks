//
//  RFUIImageSplitBackgroundView.h
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2011.12.07.
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
#import "RFUISplitBackgroundView.h"

@class NSDictionary;
@class NSString;
@class UIImage;
@class UIImageView;

@interface RFUIImageSplitBackgroundView : RFUISplitBackgroundView
{
@protected
    
}

// Initialize and Creating a RFUISplitBackgroundView

- (id)initWithImage00:(UIImage *)image00 image01:(UIImage *)image01 image02:(UIImage *)image02 image10:(UIImage *)image10 image11:(UIImage *)image11 image12:(UIImage *)image12 image20:(UIImage *)image20 image21:(UIImage *)image21 image22:(UIImage *)image22;
+ (id)imageSplitBackgroundViewWithImage00:(UIImage *)image00 image01:(UIImage *)image01 image02:(UIImage *)image02 image10:(UIImage *)image10 image11:(UIImage *)image11 image12:(UIImage *)image12 image20:(UIImage *)image20 image21:(UIImage *)image21 image22:(UIImage *)image22;

- (id)initWithImageNamed00:(NSString *)imageNamed00 imageNamed01:(NSString *)imageNamed01 imageNamed02:(NSString *)imageNamed02 imageNamed10:(NSString *)imageNamed10 imageNamed11:(NSString *)imageNamed11 imageNamed12:(NSString *)imageNamed12 imageNamed20:(NSString *)imageNamed20 imageNamed21:(NSString *)imageNamed21 imageNamed22:(NSString *)imageNamed22;
+ (id)imageSplitBackgroundViewWithImageNamed00:(NSString *)imageNamed00 imageNamed01:(NSString *)imageNamed01 imageNamed02:(NSString *)imageNamed02 imageNamed10:(NSString *)imageNamed10 imageNamed11:(NSString *)imageNamed11 imageNamed12:(NSString *)imageNamed12 imageNamed20:(NSString *)imageNamed20 imageNamed21:(NSString *)imageNamed21 imageNamed22:(NSString *)imageNamed22;

- (id)initWithImage:(UIImage *)image metadata:(NSDictionary *)metadata;
+ (id)imageSplitBackgroundViewWithImage:(UIImage *)image metadata:(NSDictionary *)metadata;

- (id)initWithMetadata:(NSDictionary *)metadata;
+ (id)imageSplitBackgroundViewWithMetadata:(NSDictionary *)metadata;

- (id)initWithMetadataNamed:(NSString *)metadataNamed;
+ (id)imageSplitBackgroundViewWithMetadataNamed:(NSString *)metadataNamed;

// Managing the Content

@property (nonatomic, strong) UIImageView *imageView00; // Default is nil. The first time the property is accessed, the UIImageView is created.
@property (nonatomic, strong) UIImageView *imageView01; // Default is nil. The first time the property is accessed, the UIImageView is created.
@property (nonatomic, strong) UIImageView *imageView02; // Default is nil. The first time the property is accessed, the UIImageView is created.
@property (nonatomic, strong) UIImageView *imageView10; // Default is nil. The first time the property is accessed, the UIImageView is created.
@property (nonatomic, strong) UIImageView *imageView11; // Default is nil. The first time the property is accessed, the UIImageView is created.
@property (nonatomic, strong) UIImageView *imageView12; // Default is nil. The first time the property is accessed, the UIImageView is created.
@property (nonatomic, strong) UIImageView *imageView20; // Default is nil. The first time the property is accessed, the UIImageView is created.
@property (nonatomic, strong) UIImageView *imageView21; // Default is nil. The first time the property is accessed, the UIImageView is created.
@property (nonatomic, strong) UIImageView *imageView22; // Default is nil. The first time the property is accessed, the UIImageView is created.

@end
