//
//  RFUIImageSplitBackgroundView.m
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

// Importing the header.
#import "RFUIImageSplitBackgroundView.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>
#import <REUIKit/REUIKit.h>

// Importing the system headers.
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation RFUIImageSplitBackgroundView

#pragma mark - Initializing and Creating a RFUIImageSplitBackgroundView

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
    }
    
    return self;
}

- (id)initWithImage00:(UIImage *)image00 image01:(UIImage *)image01 image02:(UIImage *)image02 image10:(UIImage *)image10 image11:(UIImage *)image11 image12:(UIImage *)image12 image20:(UIImage *)image20 image21:(UIImage *)image21 image22:(UIImage *)image22
{
    CGSize image00Size = (image00 ? image00.size : CGSizeZero);
    CGSize image01Size = (image01 ? image01.size : CGSizeZero);
    CGSize image02Size = (image02 ? image02.size : CGSizeZero);
    CGSize image10Size = (image10 ? image10.size : CGSizeZero);
    CGSize image11Size = (image11 ? image11.size : CGSizeZero);
    CGSize image12Size = (image12 ? image12.size : CGSizeZero);
    CGSize image20Size = (image20 ? image20.size : CGSizeZero);
    CGSize image21Size = (image21 ? image21.size : CGSizeZero);
    CGSize image22Size = (image22 ? image22.size : CGSizeZero);
    
    CGFloat width0 = MAX(image00Size.width, image10Size.width);
    width0 = MAX(width0, image20Size.width);
    
    CGFloat width1 = MAX(image01Size.width, image11Size.width);
    width1 = MAX(width1, image21Size.width);
    
    CGFloat width2 = MAX(image02Size.width, image12Size.width);
    width2 = MAX(width2, image22Size.width);
    
    CGFloat height0 = MAX(image00Size.height, image01Size.height);
    height0 = MAX(height0, image02Size.height);
    
    CGFloat height1 = MAX(image10Size.height, image11Size.height);
    height1 = MAX(height1, image12Size.height);
    
    CGFloat height2 = MAX(image20Size.height, image21Size.height);
    height2 = MAX(height2, image22Size.height);
    
    CGRect imageSplitBackgroundViewFrame;
    imageSplitBackgroundViewFrame.origin.x = 0.0f;
    imageSplitBackgroundViewFrame.origin.y = 0.0f;
    imageSplitBackgroundViewFrame.size.width = width0 + width1 + width2;
    imageSplitBackgroundViewFrame.size.height = height0 + height1 + height2;
    
    if ((self = [self initWithFrame:imageSplitBackgroundViewFrame]))
    {
        self.height0 = height0;
        self.height2 = height2;
        self.width0 = width0;
        self.width2 = width2;
        
        if (image00)
        {
            self.imageView00.image = image00;
        }
        
        if (image01)
        {
            self.imageView01.image = image01;
        }
        
        if (image02)
        {
            self.imageView02.image = image02;
        }
        
        if (image10)
        {
            self.imageView10.image = image10;
        }
        
        if (image11)
        {
            self.imageView11.image = image11;
        }
        
        if (image12)
        {
            self.imageView12.image = image12;
        }
        
        if (image20)
        {
            self.imageView20.image = image20;
        }
        
        if (image21)
        {
            self.imageView21.image = image21;
        }
        
        if (image22)
        {
            self.imageView22.image = image22;
        }
    }
    
    return self;
}

+ (id)imageSplitBackgroundViewWithImage00:(UIImage *)image00 image01:(UIImage *)image01 image02:(UIImage *)image02 image10:(UIImage *)image10 image11:(UIImage *)image11 image12:(UIImage *)image12 image20:(UIImage *)image20 image21:(UIImage *)image21 image22:(UIImage *)image22
{
    return [[self alloc] initWithImage00:image00 image01:image01 image02:image02 image10:image10 image11:image11 image12:image12 image20:image20 image21:image21 image22:image22];
}

- (id)initWithImageNamed00:(NSString *)imageNamed00 imageNamed01:(NSString *)imageNamed01 imageNamed02:(NSString *)imageNamed02 imageNamed10:(NSString *)imageNamed10 imageNamed11:(NSString *)imageNamed11 imageNamed12:(NSString *)imageNamed12 imageNamed20:(NSString *)imageNamed20 imageNamed21:(NSString *)imageNamed21 imageNamed22:(NSString *)imageNamed22
{
    UIImage *image00 = [UIImage imageNamed:imageNamed00];
    UIImage *image01 = [UIImage imageNamed:imageNamed01];
    UIImage *image02 = [UIImage imageNamed:imageNamed02];
    UIImage *image10 = [UIImage imageNamed:imageNamed10];
    UIImage *image11 = [UIImage imageNamed:imageNamed11];
    UIImage *image12 = [UIImage imageNamed:imageNamed12];
    UIImage *image20 = [UIImage imageNamed:imageNamed20];
    UIImage *image21 = [UIImage imageNamed:imageNamed21];
    UIImage *image22 = [UIImage imageNamed:imageNamed22];
    
    if ((self = [self initWithImage00:image00 image01:image01 image02:image02 image10:image10 image11:image11 image12:image12 image20:image20 image21:image21 image22:image22]))
    {
    }
    
    return self;
}

+ (id)imageSplitBackgroundViewWithImageNamed00:(NSString *)imageNamed00 imageNamed01:(NSString *)imageNamed01 imageNamed02:(NSString *)imageNamed02 imageNamed10:(NSString *)imageNamed10 imageNamed11:(NSString *)imageNamed11 imageNamed12:(NSString *)imageNamed12 imageNamed20:(NSString *)imageNamed20 imageNamed21:(NSString *)imageNamed21 imageNamed22:(NSString *)imageNamed22
{
    return [[self alloc] initWithImageNamed00:imageNamed00 imageNamed01:imageNamed01 imageNamed02:imageNamed02 imageNamed10:imageNamed10 imageNamed11:imageNamed11 imageNamed12:imageNamed12 imageNamed20:imageNamed20 imageNamed21:imageNamed21 imageNamed22:imageNamed22];
}

- (UIImage *)copySubimageFromImage:(UIImage *)image subimageMetadata:(NSDictionary *)subimageMetadata
{
    // Setting the default values.
    UIImage *subimage = nil;
    
    // We have data to create images.
    if (image && subimageMetadata)
    {
        // Getting some information about the image.
        CGSize imageSize = image.size;
        CGFloat imageScale = image.scale;
        
        // Getting the subimage alpha.
        NSNumber *subimageAlphaNumber = NSNumberCast(subimageMetadata[@"Alpha"]);
        CGFloat subimageAlpha = (subimageAlphaNumber ? subimageAlphaNumber.floatValue : 1.0f);
        subimageAlpha = ((subimageAlpha >= 0.0f) ? subimageAlpha : 0.0f);
        subimageAlpha = ((subimageAlpha <= 1.0f) ? subimageAlpha : 1.0f);
        
        // Getting the subimage background color.
        NSString *subimageBackgroundColorString = NSStringCast(subimageMetadata[@"BackgroundColorRGBA"]);
        UIColor *subimageBackgroundColor = (subimageBackgroundColorString ? UIColorFromNSString(subimageBackgroundColorString) : ({
            NSString * subimageBackgroundColorString255 = NSStringCast(subimageMetadata[@"BackgroundColorRGBA255"]);
            (subimageBackgroundColorString255 ? UIColorFromNSString255(subimageBackgroundColorString255) : nil);
        }));
        
        // Getting the subimage blend mode.
        NSString *subimageBlendModeString = NSStringCast(subimageMetadata[@"BlendMode"]);
        CGBlendMode subimageBlendMode = (subimageBlendModeString ? CGBlendModeFromNSString(subimageBlendModeString) : kCGBlendModeNormal);
        
        // Getting the subimage frame.
        NSString *subimageFrameString = NSStringCast(subimageMetadata[@"Frame"]);
        CGRect subimageFrame = (subimageFrameString ? CGRectFromString(subimageFrameString) : CGRectZero);
        
        // Getting the subimage opaque.
        NSNumber *subimageOpaqueNumber = NSNumberCast(subimageMetadata[@"Opaque"]);
        BOOL subimageOpaque = (subimageOpaqueNumber ? subimageOpaqueNumber.boolValue : NO);
        
        // Getting the subimage orientation.
        NSString *subimageOrientationString = NSStringCast(subimageMetadata[@"Orientation"]);
        UIImageOrientation subimageOrientation = (subimageOrientationString ? UIImageOrientationFromNSString(subimageOrientationString) : UIImageOrientationUp);
        
        // Getting the subimage size.
        NSString *subimageSizeString = NSStringCast(subimageMetadata[@"Size"]);
        CGSize subimageSize = (subimageSizeString ? CGSizeFromString(subimageSizeString) : subimageFrame.size);
        
        // We have an image size.
        if ((subimageSize.width > 0.0f) &&
            (subimageSize.height > 0.0f))
        {
            // We do not zoom the image size.
            if (CGSizeEqualToSize(subimageSize, subimageFrame.size))
            {
                // Creating a image context to create the subimage from the image.
                UIGraphicsBeginImageContextWithOptions(subimageSize, subimageOpaque, imageScale);
                
                // We have background color.
                if (subimageBackgroundColor)
                {
                    // Setting the color for filling.
                    [subimageBackgroundColor setFill];
                    
                    // Calculating the frame for filling
                    CGRect backgroundFrameForFill;
                    backgroundFrameForFill.origin = CGPointZero;
                    backgroundFrameForFill.size = subimageSize;
                    
                    // Drawing the background.
                    UIRectFill(backgroundFrameForFill);
                }
                
                // Calculating the frame for drawing the image.
                CGRect imageFrameForDraw;
                imageFrameForDraw.origin.x = -subimageFrame.origin.x;
                imageFrameForDraw.origin.y = -subimageFrame.origin.y;
                imageFrameForDraw.size.width = imageSize.width;
                imageFrameForDraw.size.height = imageSize.height;
                
                // Drawing the image.
                [image drawInRect:imageFrameForDraw blendMode:subimageBlendMode alpha:subimageAlpha];
                
                // Getting the current context.
                CGContextRef contextRef = UIGraphicsGetCurrentContext();
                
                // We have the current context.
                if (contextRef)
                {
                    // Creating an image with the current context.
                    CGImageRef subimageRef = CGBitmapContextCreateImage(contextRef);
                    
                    // We have the image from the current context.
                    if (subimageRef)
                    {
                        // Creating the subimage.
                        subimage = [[UIImage alloc] initWithCGImage:subimageRef scale:imageScale orientation:subimageOrientation];
                    }
                    
                    // Releasing the subimage.
                    CGImageRelease(subimageRef);
                    subimageRef = NULL;
                }
                
                // Releasing the image context.
                UIGraphicsEndImageContext();
            }
            
            // We zoom the image size.
            else
            {
                // Creating a image context to create the image #2 from the image.
                UIGraphicsBeginImageContextWithOptions(subimageFrame.size, NO, imageScale);
                
                // Calculating the frame for drawing the image.
                CGRect imageFrameForDraw;
                imageFrameForDraw.origin.x = -subimageFrame.origin.x;
                imageFrameForDraw.origin.y = -subimageFrame.origin.y;
                imageFrameForDraw.size.width = imageSize.width;
                imageFrameForDraw.size.height = imageSize.height;
                
                // Drawing the image.
                [image drawInRect:imageFrameForDraw blendMode:subimageBlendMode alpha:subimageAlpha];
                
                // Getting the current context.
                CGContextRef contextRef = UIGraphicsGetCurrentContext();
                
                // Setting the default value;
                UIImage *image2 = nil;
                
                // We have the current context.
                if (contextRef)
                {
                    // Creating an image with the current context.
                    CGImageRef image2Ref = CGBitmapContextCreateImage(contextRef);
                    
                    // We have the image from the current context.
                    if (image2Ref)
                    {
                        image2 = [[UIImage alloc] initWithCGImage:image2Ref scale:imageScale orientation:UIImageOrientationUp];
                    }
                    
                    // Releasing the image #2.
                    CGImageRelease(image2Ref);
                    image2Ref = NULL;
                }
                
                // Releasing the image context.
                UIGraphicsEndImageContext();
                
                // Creating a image context to create the subimage from the image #2.
                UIGraphicsBeginImageContextWithOptions(subimageSize, subimageOpaque, imageScale);
                
                // We have background color.
                if (subimageBackgroundColor)
                {
                    // Setting the color for filling.
                    [subimageBackgroundColor setFill];
                    
                    // Calculating the frame for filling
                    CGRect backgroundFrameForFill;
                    backgroundFrameForFill.origin = CGPointZero;
                    backgroundFrameForFill.size = subimageSize;
                    
                    // Drawing the background.
                    UIRectFill(backgroundFrameForFill);
                }
                
                // Calculating the frame for drawing the image #2.
                CGRect image2FrameForDraw;
                image2FrameForDraw.origin = CGPointZero;
                image2FrameForDraw.size = subimageSize;
                
                // Drawing the image #2.
                [image2 drawInRect:image2FrameForDraw blendMode:subimageBlendMode alpha:subimageAlpha];
                
                // Getting the current context.
                contextRef = UIGraphicsGetCurrentContext();
                
                // We have the current context.
                if (contextRef)
                {
                    // Creating an image with the current context.
                    CGImageRef subimageRef = CGBitmapContextCreateImage(contextRef);
                    
                    // We have the image from the current context.
                    if (subimageRef)
                    {
                        // Creating the subimage.
                        subimage = [[UIImage alloc] initWithCGImage:subimageRef scale:imageScale orientation:subimageOrientation];
                    }
                    
                    // Releasing the subimage.
                    CGImageRelease(subimageRef);
                    subimageRef = NULL;
                }
                
                // Releasing the image context.
                UIGraphicsEndImageContext();
            }
        }
    }
    
    // Returning the subimage.
    return subimage;
}

- (id)initWithImage:(UIImage *)image metadata:(NSDictionary *)metadata
{
    // Getting the metadata version.
    NSString *version = metadata[@"Version"];
    
    // The version is 1.0.
    if ([version isEqual:@"1.0"])
    {
        // Creating the image #00.
        NSDictionary *image00Metadata = NSDictionaryCast(metadata[@"Image00"]);
        UIImage *image00 = [self copySubimageFromImage:image subimageMetadata:image00Metadata];
        
        // Creating the image #01.
        NSDictionary *image01Metadata = NSDictionaryCast(metadata[@"Image01"]);
        UIImage *image01 = [self copySubimageFromImage:image subimageMetadata:image01Metadata];
        
        // Creating the image #02.
        NSDictionary *image02Metadata = NSDictionaryCast(metadata[@"Image02"]);
        UIImage *image02 = [self copySubimageFromImage:image subimageMetadata:image02Metadata];
        
        // Creating the image #10.
        NSDictionary *image10Metadata = NSDictionaryCast(metadata[@"Image10"]);
        UIImage *image10 = [self copySubimageFromImage:image subimageMetadata:image10Metadata];
        
        // Creating the image #11.
        NSDictionary *image11Metadata = NSDictionaryCast(metadata[@"Image11"]);
        UIImage *image11 = [self copySubimageFromImage:image subimageMetadata:image11Metadata];
        
        // Creating the image #12.
        NSDictionary *image12Metadata = NSDictionaryCast(metadata[@"Image12"]);
        UIImage *image12 = [self copySubimageFromImage:image subimageMetadata:image12Metadata];
        
        // Creating the image #20.
        NSDictionary *image20Metadata = NSDictionaryCast(metadata[@"Image20"]);
        UIImage *image20 = [self copySubimageFromImage:image subimageMetadata:image20Metadata];
        
        // Creating the image #21.
        NSDictionary *image21Metadata = NSDictionaryCast(metadata[@"Image21"]);
        UIImage *image21 = [self copySubimageFromImage:image subimageMetadata:image21Metadata];
        
        // Creating the image #22.
        NSDictionary *image22Metadata = NSDictionaryCast(metadata[@"Image22"]);
        UIImage *image22 = [self copySubimageFromImage:image subimageMetadata:image22Metadata];
        
        if ((self = [self initWithImage00:image00 image01:image01 image02:image02 image10:image10 image11:image11 image12:image12 image20:image20 image21:image21 image22:image22]))
        {
        }
        
        return self;
    }
    
    else
    {
        return nil;
    }
}

+ (id)imageSplitBackgroundViewWithImage:(UIImage *)image metadata:(NSDictionary *)metadata
{
    return [[self alloc] initWithImage:image metadata:metadata];
}

- (id)initWithMetadata:(NSDictionary *)metadata
{
    // Getting the metadata version.
    NSString *version = metadata[@"Version"];
    
    // The version is 1.0.
    if ([version isEqual:@"1.0"])
    {
        // Getting the image name.
        NSString *imageNamed = NSStringCast(metadata[@"ImageNamed"]);
        
        // Setting the default values.
        UIImage *image = nil;
        
        // We have a image name.
        if (imageNamed.length > 0)
        {
            // Creating the image.
            image = [UIImage imageNamed:imageNamed];
        }
        
        return [self initWithImage:image metadata:metadata];
    }
    
    else
    {
        return nil;
    }
}

+ (id)imageSplitBackgroundViewWithMetadata:(NSDictionary *)metadata
{
    return [[self alloc] initWithMetadata:metadata];
}

- (id)initWithMetadataNamed:(NSString *)metadataNamed
{
    // Setting the default values.
    NSDictionary *metadata = nil;
    
    // We have a metadata name.
    if (metadataNamed.length > 0)
    {
        // Getting a metadata path with the metadata name.
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *metadataPath = [mainBundle pathForResource:[metadataNamed stringByDeletingPathExtension] ofType:[metadataNamed pathExtension]];
        
        // We have the metadata path.
        if (metadataPath.length > 0)
        {
            // Opening the metadata from the main bundle.
            metadata = [[NSDictionary alloc] initWithContentsOfFile:metadataPath];
        }
    }
    
    return [self initWithMetadata:metadata];
}

/*
 * The example of "metadata.plist" file:
 *
 *  <?xml version="1.0" encoding="UTF-8"?>
 *  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 *  <plist version="1.0">
 *  <dict>
 *      <key>Image00</key>
 *      <dict>
 *          <key>Alpha</key>
 *          <integer>1</integer>
 *          <key>BackgroundColorRGBA</key>
 *          <string>{0.0, 0.0, 0.0, 0.0}</string>
 *          <key>BackgroundColorRGBA255</key>
 *          <string>{255, 255, 255, 0}</string>
 *          <key>BlendMode</key>
 *          <string>CGBlendModeNormal</string>
 *          <key>Frame</key>
 *          <string>{{0, 0}, {5, 5}}</string>
 *          <key>Opaque</key>
 *          <false/>
 *          <key>Orientation</key>
 *          <string>UIImageOrientationUp</string>
 *          <key>Size</key>
 *          <string>{5, 5}</string>
 *      </dict>
 *      <key>Image01</key>
 *          <dict>
 *          <key>Alpha</key>
 *          <integer>1</integer>
 *          <key>BackgroundColorRGBA</key>
 *          <string>{0.0, 0.0, 0.0, 0.0}</string>
 *          <key>BackgroundColorRGBA255</key>
 *          <string>{255, 255, 255, 0}</string>
 *          <key>BlendMode</key>
 *          <string>CGBlendModeNormal</string>
 *          <key>Frame</key>
 *          <string>{{5, 0}, {2, 5}}</string>
 *          <key>Opaque</key>
 *          <false/>
 *          <key>Orientation</key>
 *          <string>UIImageOrientationUp</string>
 *          <key>Size</key>
 *          <string>{2, 5}</string>
 *      </dict>
 *      <key>Image02</key>
 *          <dict>
 *          <key>Alpha</key>
 *          <integer>1</integer>
 *          <key>BackgroundColorRGBA</key>
 *          <string>{0.0, 0.0, 0.0, 0.0}</string>
 *          <key>BackgroundColorRGBA255</key>
 *          <string>{255, 255, 255, 0}</string>
 *          <key>BlendMode</key>
 *          <string>CGBlendModeNormal</string>
 *          <key>Frame</key>
 *          <string>{{7, 0}, {5, 5}}</string>
 *          <key>Opaque</key>
 *          <false/>
 *          <key>Orientation</key>
 *          <string>UIImageOrientationUp</string>
 *          <key>Size</key>
 *          <string>{5, 5}</string>
 *      </dict>
 *      <key>Image10</key>
 *          <dict>
 *          <key>Alpha</key>
 *          <integer>1</integer>
 *          <key>BackgroundColorRGBA</key>
 *          <string>{0.0, 0.0, 0.0, 0.0}</string>
 *          <key>BackgroundColorRGBA255</key>
 *          <string>{255, 255, 255, 0}</string>
 *          <key>BlendMode</key>
 *          <string>CGBlendModeNormal</string>
 *          <key>Frame</key>
 *          <string>{{0, 5}, {5, 2}}</string>
 *          <key>Opaque</key>
 *          <false/>
 *          <key>Orientation</key>
 *          <string>UIImageOrientationUp</string>
 *          <key>Size</key>
 *          <string>{5, 2}</string>
 *      </dict>
 *      <key>Image11</key>
 *          <dict>
 *          <key>Alpha</key>
 *          <integer>1</integer>
 *          <key>BackgroundColorRGBA</key>
 *          <string>{0.0, 0.0, 0.0, 0.0}</string>
 *          <key>BackgroundColorRGBA255</key>
 *          <string>{255, 255, 255, 0}</string>
 *          <key>BlendMode</key>
 *          <string>CGBlendModeNormal</string>
 *          <key>Frame</key>
 *          <string>{{5, 5}, {2, 2}}</string>
 *          <key>Opaque</key>
 *          <false/>
 *          <key>Orientation</key>
 *          <string>UIImageOrientationUp</string>
 *          <key>Size</key>
 *          <string>{2, 2}</string>
 *      </dict>
 *      <key>Image12</key>
 *          <dict>
 *          <key>Alpha</key>
 *          <integer>1</integer>
 *          <key>BackgroundColorRGBA</key>
 *          <string>{0.0, 0.0, 0.0, 0.0}</string>
 *          <key>BackgroundColorRGBA255</key>
 *          <string>{255, 255, 255, 0}</string>
 *          <key>BlendMode</key>
 *          <string>CGBlendModeNormal</string>
 *          <key>Frame</key>
 *          <string>{{7, 5}, {5, 2}}</string>
 *          <key>Opaque</key>
 *          <false/>
 *          <key>Orientation</key>
 *          <string>UIImageOrientationUp</string>
 *          <key>Size</key>
 *          <string>{5, 2}</string>
 *      </dict>
 *      <key>Image20</key>
 *          <dict>
 *          <key>Alpha</key>
 *          <integer>1</integer>
 *          <key>BackgroundColorRGBA</key>
 *          <string>{0.0, 0.0, 0.0, 0.0}</string>
 *          <key>BackgroundColorRGBA255</key>
 *          <string>{255, 255, 255, 0}</string>
 *          <key>BlendMode</key>
 *          <string>CGBlendModeNormal</string>
 *          <key>Frame</key>
 *          <string>{{0, 7}, {5, 5}}</string>
 *          <key>Opaque</key>
 *          <false/>
 *          <key>Orientation</key>
 *          <string>UIImageOrientationUp</string>
 *          <key>Size</key>
 *          <string>{5, 5}</string>
 *      </dict>
 *      <key>Image21</key>
 *          <dict>
 *          <key>Alpha</key>
 *          <integer>1</integer>
 *          <key>BackgroundColorRGBA</key>
 *          <string>{0.0, 0.0, 0.0, 0.0}</string>
 *          <key>BackgroundColorRGBA255</key>
 *          <string>{255, 255, 255, 0}</string>
 *          <key>BlendMode</key>
 *          <string>CGBlendModeNormal</string>
 *          <key>Frame</key>
 *          <string>{{5, 7}, {2, 5}}</string>
 *          <key>Opaque</key>
 *          <false/>
 *          <key>Orientation</key>
 *          <string>UIImageOrientationUp</string>
 *          <key>Size</key>
 *          <string>{2, 5}</string>
 *      </dict>
 *      <key>Image22</key>
 *          <dict>
 *          <key>Alpha</key>
 *          <integer>1</integer>
 *          <key>BackgroundColorRGBA</key>
 *          <string>{0.0, 0.0, 0.0, 0.0}</string>
 *          <key>BackgroundColorRGBA255</key>
 *          <string>{255, 255, 255, 0}</string>
 *          <key>BlendMode</key>
 *          <string>CGBlendModeNormal</string>
 *          <key>Frame</key>
 *          <string>{{7, 7}, {5, 5}}</string>
 *          <key>Opaque</key>
 *          <false/>
 *          <key>Orientation</key>
 *          <string>UIImageOrientationUp</string>
 *          <key>Size</key>
 *          <string>{5, 5}</string>
 *      </dict>
 *      <key>ImageNamed</key>
 *      <string>Button-Style-02-Normal-12x12.png</string>
 *      <key>Version</key>
 *      <string>1.0</string>
 *  </dict>
 *  </plist>
 *
 */
+ (id)imageSplitBackgroundViewWithMetadataNamed:(NSString *)metadataNamed
{
    return [[self alloc] initWithMetadataNamed:metadataNamed];
}

#pragma mark - Deallocating a RFUIImageSplitBackgroundView

- (void)dealloc
{
}

#pragma mark - Managing the Content

#pragma mark Managing the Image Views

- (UIImageView *)imageView00
{
    UIImageView *imageView00 = (UIImageView *)self.view00;
    
    return imageView00;
}

- (void)setImageView00:(UIImageView *)imageView00
{
    self.view00 = imageView00;
}

- (UIImageView *)imageView01
{
    UIImageView *imageView01 = (UIImageView *)self.view01;
    
    return imageView01;
}

- (void)setImageView01:(UIImageView *)imageView01
{
    self.view01 = imageView01;
}

- (UIImageView *)imageView02
{
    UIImageView *imageView02 = (UIImageView *)self.view02;
    
    return imageView02;
}

- (void)setImageView02:(UIImageView *)imageView02
{
    self.view02 = imageView02;
}

- (UIImageView *)imageView10
{
    UIImageView *imageView10 = (UIImageView *)self.view10;
    
    return imageView10;
}

- (void)setImageView10:(UIImageView *)imageView10
{
    self.view10 = imageView10;
}

- (UIImageView *)imageView11
{
    UIImageView *imageView11 = (UIImageView *)self.view11;
    
    return imageView11;
}

- (void)setImageView11:(UIImageView *)imageView11
{
    self.view11 = imageView11;
}

- (UIImageView *)imageView12
{
    UIImageView *imageView12 = (UIImageView *)self.view12;
    
    return imageView12;
}

- (void)setImageView12:(UIImageView *)imageView12
{
    self.view12 = imageView12;
}

- (UIImageView *)imageView20
{
    UIImageView *imageView20 = (UIImageView *)self.view20;
    
    return imageView20;
}

- (void)setImageView20:(UIImageView *)imageView20
{
    self.view20 = imageView20;
}

- (UIImageView *)imageView21
{
    UIImageView *imageView21 = (UIImageView *)self.view21;
    
    return imageView21;
}

- (void)setImageView21:(UIImageView *)imageView21
{
    self.view21 = imageView21;
}

- (UIImageView *)imageView22
{
    UIImageView *imageView22 = (UIImageView *)self.view22;
    
    return imageView22;
}

- (void)setImageView22:(UIImageView *)imageView22
{
    self.view22 = imageView22;
}

#pragma mark Managing the View

- (UIView *)view00
{
    if (!mView00)
    {
        CGRect imageView00Frame;
        imageView00Frame.origin.x = 0.0f;
        imageView00Frame.origin.y = 0.0f;
        imageView00Frame.size.width = mWidth0;
        imageView00Frame.size.height = mHeight0;
        
        mView00 = [[UIImageView alloc] initWithFrame:imageView00Frame];
        
        UIImageView *imageView00 = (UIImageView *)mView00;
        imageView00.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:mView00];
        
        [self setNeedsLayout];
    }
    
    return mView00;
}

- (void)setView00:(UIView *)view00
{
    if (mView00 != view00)
    {
        [mView00 removeFromSuperview];
        
        mView00 = view00;
        
        [self addSubview:mView00];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view01
{
    if (!mView01)
    {
        CGRect viewFrame = self.frame;
        
        CGRect imageView01Frame;
        imageView01Frame.origin.x = mWidth0;
        imageView01Frame.origin.y = 0.0f;
        imageView01Frame.size.width = viewFrame.size.width - mWidth0 - mWidth2;
        imageView01Frame.size.height = mHeight0;
        
        mView01 = [[UIImageView alloc] initWithFrame:imageView01Frame];
        
        UIImageView *imageView01 = (UIImageView *)mView01;
        imageView01.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:mView01];
        
        [self setNeedsLayout];
    }
    
    return mView01;
}

- (void)setView01:(UIView *)view01
{
    if (mView01 != view01)
    {
        [mView01 removeFromSuperview];
        
        mView01 = view01;
        
        [self addSubview:mView01];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view02
{
    if (!mView02)
    {
        CGRect viewFrame = self.frame;
        
        CGRect imageView02Frame;
        imageView02Frame.origin.x = viewFrame.size.width - mWidth2;
        imageView02Frame.origin.y = 0.0f;
        imageView02Frame.size.width = mWidth2;
        imageView02Frame.size.height = mHeight0;
        
        mView02 = [[UIImageView alloc] initWithFrame:imageView02Frame];
        
        UIImageView *imageView02 = (UIImageView *)mView02;
        imageView02.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:mView02];
        
        [self setNeedsLayout];
    }
    
    return mView02;
}

- (void)setView02:(UIView *)view02
{
    if (mView02 != view02)
    {
        [mView02 removeFromSuperview];
        
        mView02 = view02;
        
        [self addSubview:mView02];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view10
{
    if (!mView10)
    {
        CGRect viewFrame = self.frame;
        
        CGRect imageView10Frame;
        imageView10Frame.origin.x = 0.0f;
        imageView10Frame.origin.y = mHeight0;
        imageView10Frame.size.width = mWidth0;
        imageView10Frame.size.height = viewFrame.size.height - mHeight0 - mHeight2;
        
        mView10 = [[UIImageView alloc] initWithFrame:imageView10Frame];
        
        UIImageView *imageView10 = (UIImageView *)mView10;
        imageView10.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:mView10];
        
        [self setNeedsLayout];
    }
    
    return mView10;
}

- (void)setView10:(UIView *)view10
{
    if (mView10 != view10)
    {
        [mView10 removeFromSuperview];
        
        mView10 = view10;
        
        [self addSubview:mView10];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view11
{
    if (!mView11)
    {
        CGRect viewFrame = self.frame;
        
        CGRect imageView11Frame;
        imageView11Frame.origin.x = mWidth0;
        imageView11Frame.origin.y = mHeight0;
        imageView11Frame.size.width = viewFrame.size.width - mWidth0 - mWidth2;
        imageView11Frame.size.height = viewFrame.size.height - mHeight0 - mHeight2;
        
        mView11 = [[UIImageView alloc] initWithFrame:imageView11Frame];
        
        UIImageView *imageView11 = (UIImageView *)mView11;
        imageView11.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:mView11];
        
        [self setNeedsLayout];
    }
    
    return mView11;
}

- (void)setView11:(UIView *)view11
{
    if (mView11 != view11)
    {
        [mView11 removeFromSuperview];
        
        mView11 = view11;
        
        [self addSubview:mView11];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view12
{
    if (!mView12)
    {
        CGRect viewFrame = self.frame;
        
        CGRect imageView12Frame;
        imageView12Frame.origin.x = viewFrame.size.width - mWidth2;
        imageView12Frame.origin.y = mHeight0;
        imageView12Frame.size.width = mWidth2;
        imageView12Frame.size.height = viewFrame.size.height - mHeight0 - mHeight2;
        
        mView12 = [[UIImageView alloc] initWithFrame:imageView12Frame];
        
        UIImageView *imageView12 = (UIImageView *)mView12;
        imageView12.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:mView12];
        
        [self setNeedsLayout];
    }
    
    return mView12;
}

- (void)setView12:(UIView *)view12
{
    if (mView12 != view12)
    {
        [mView12 removeFromSuperview];
        
        mView12 = view12;
        
        [self addSubview:mView12];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view20
{
    if (!mView20)
    {
        CGRect viewFrame = self.frame;
        
        CGRect imageView20Frame;
        imageView20Frame.origin.x = 0.0f;
        imageView20Frame.origin.y = viewFrame.size.height - mHeight2;
        imageView20Frame.size.width = mWidth0;
        imageView20Frame.size.height = mHeight2;
        
        mView20 = [[UIImageView alloc] initWithFrame:imageView20Frame];
        
        UIImageView *imageView20 = (UIImageView *)mView20;
        imageView20.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:mView20];
        
        [self setNeedsLayout];
    }
    
    return mView20;
}

- (void)setView20:(UIView *)view20
{
    if (mView20 != view20)
    {
        [mView20 removeFromSuperview];
        
        mView20 = view20;
        
        [self addSubview:mView20];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view21
{
    if (!mView21)
    {
        CGRect viewFrame = self.frame;
        
        CGRect imageView21Frame;
        imageView21Frame.origin.x = mWidth0;
        imageView21Frame.origin.y = viewFrame.size.height - mHeight2;
        imageView21Frame.size.width = viewFrame.size.width - mWidth0 - mWidth2;
        imageView21Frame.size.height = mHeight2;
        
        mView21 = [[UIImageView alloc] initWithFrame:imageView21Frame];
        
        UIImageView *imageView21 = (UIImageView *)mView21;
        imageView21.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:mView21];
        
        [self setNeedsLayout];
    }
    
    return mView21;
}

- (void)setView21:(UIView *)view21
{
    if (mView21 != view21)
    {
        [mView21 removeFromSuperview];
        
        mView21 = view21;
        
        [self addSubview:mView21];
        
        [self setNeedsLayout];
    }
}

- (UIView *)view22
{
    if (!mView22)
    {
        CGRect viewFrame = self.frame;
        
        CGRect imageView22Frame;
        imageView22Frame.origin.x = viewFrame.size.width - mWidth2;
        imageView22Frame.origin.y = viewFrame.size.height - mHeight2;
        imageView22Frame.size.width = mWidth2;
        imageView22Frame.size.height = mHeight2;
        
        mView22 = [[UIImageView alloc] initWithFrame:imageView22Frame];
        
        UIImageView *imageView22 = (UIImageView *)mView22;
        imageView22.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:mView22];
        
        [self setNeedsLayout];
    }
    
    return mView22;
}

- (void)setView22:(UIView *)view22
{
    if (mView22 != view22)
    {
        [mView22 removeFromSuperview];
        
        mView22 = view22;
        
        [self addSubview:mView22];
        
        [self setNeedsLayout];
    }
}

@end
