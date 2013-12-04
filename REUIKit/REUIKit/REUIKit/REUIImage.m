//
//  REUIImage.m
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

// Importing the header.
#import "REUIImage.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Importing the system headers.
#import <objc/runtime.h>

NSString *NSStringFromUIImageOrientation(UIImageOrientation imageOrientation)
{
    switch (imageOrientation)
    {
        default:
        case UIImageOrientationUp:
            return @"UIImageOrientationUp";
            
        case UIImageOrientationDown:
            return @"UIImageOrientationDown";
            
        case UIImageOrientationLeft:
            return @"UIImageOrientationLeft";
            
        case UIImageOrientationRight:
            return @"UIImageOrientationRight";
            
        case UIImageOrientationUpMirrored:
            return @"UIImageOrientationUpMirrored";
            
        case UIImageOrientationDownMirrored:
            return @"UIImageOrientationDownMirrored";
            
        case UIImageOrientationLeftMirrored:
            return @"UIImageOrientationLeftMirrored";
            
        case UIImageOrientationRightMirrored:
            return @"UIImageOrientationRightMirrored";
    }
}

UIImageOrientation UIImageOrientationFromNSString(NSString *string)
{
    if ([string isEqual:@"UIImageOrientationUp"])
    {
        return UIImageOrientationUp;
    }
    
    else if ([string isEqual:@"UIImageOrientationDown"])
    {
        return UIImageOrientationDown;
    }
    
    else if ([string isEqual:@"UIImageOrientationLeft"])
    {
        return UIImageOrientationLeft;
    }
    
    else if ([string isEqual:@"UIImageOrientationRight"])
    {
        return UIImageOrientationRight;
    }
    
    else if ([string isEqual:@"UIImageOrientationUpMirrored"])
    {
        return UIImageOrientationUpMirrored;
    }
    
    else if ([string isEqual:@"UIImageOrientationDownMirrored"])
    {
        return UIImageOrientationDownMirrored;
    }
    
    else if ([string isEqual:@"UIImageOrientationLeftMirrored"])
    {
        return UIImageOrientationLeftMirrored;
    }
    
    else if ([string isEqual:@"UIImageOrientationRightMirrored"])
    {
        return UIImageOrientationRightMirrored;
    }
    
    else
    {
        return UIImageOrientationUp;
    }
}

@implementation UIImage (UIImageREUIImage)

#pragma mark - Initializing and Creating a UIImage

- (id)initWithContentsOfFile:(NSString *)path scale:(CGFloat)scale
{
    UIImage *image2 = nil;
    
    self = [self initWithContentsOfFile:path];
    
    if (!self)
    {
        goto jmp_exit;
    }
    
    if (self.scale != scale)
    {
        CGImageRef cgImage = self.CGImage;
        UIImageOrientation orientation = self.imageOrientation;
        
        image2 = [[UIImage alloc] initWithCGImage:cgImage scale:scale orientation:orientation];
        
        self = image2;
    }
    
    if (!self)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    image2 = nil;
    
    return self;
}

+ (UIImage *)imageWithContentsOfFile:(NSString *)path scale:(CGFloat)scale
{
    return [[self alloc] initWithContentsOfFile:path scale:scale];
}

- (id)initWithContentsOfFile:(NSString *)path scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    UIImage *image2 = nil;
    
    self = [self initWithContentsOfFile:path];
    
    if (!self)
    {
        goto jmp_exit;
    }
    
    if (self.scale != scale)
    {
        CGImageRef cgImage = self.CGImage;
        
        image2 = [[UIImage alloc] initWithCGImage:cgImage scale:scale orientation:orientation];
        
        self = image2;
    }
    
    if (!self)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    image2 = nil;
    
    return self;
}

+ (UIImage *)imageWithContentsOfFile:(NSString *)path scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    return [[self alloc] initWithContentsOfFile:path scale:scale orientation:orientation];
}

- (id)initWithData:(NSData *)data scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    UIImage *image2 = nil;
    
    self = [self initWithData:data];
    
    if (!self)
    {
        goto jmp_exit;
    }
    
    if (self.scale != scale)
    {
        CGImageRef cgImage = self.CGImage;
        
        image2 = [[UIImage alloc] initWithCGImage:cgImage scale:scale orientation:orientation];
        
        self = image2;
    }
    
    if (!self)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    image2 = nil;
    
    return self;
}

+ (UIImage *)imageWithData:(NSData *)data scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    return [[self alloc] initWithData:data scale:scale orientation:orientation];
}

- (id)initWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale
{
    return [self initWithCGImage:cgImage scale:scale orientation:UIImageOrientationUp];
}

+ (UIImage *)imageWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale
{
    return [[self alloc] initWithCGImage:cgImage scale:scale];
}

- (id)initWithImage:(UIImage *)image scale:(CGFloat)scale
{
    UIImageOrientation orientation = UIImageOrientationUp;
    
    if (image)
    {
        orientation = image.imageOrientation;
    }
    
    return [self initWithImage:image scale:scale orientation:orientation];
}

+ (UIImage *)imageWithImage:(UIImage *)image scale:(CGFloat)scale
{
    return [[self alloc] initWithImage:image scale:scale];
}

- (id)initWithImage:(UIImage *)image orientation:(UIImageOrientation)orientation
{
    CGFloat scale = 1.0f;
    
    if (image)
    {
        scale = image.scale;
    }
    
    return [self initWithImage:image scale:scale orientation:orientation];
}

+ (UIImage *)imageWithImage:(UIImage *)image orientation:(UIImageOrientation)orientation
{
    return [[self alloc] initWithImage:image orientation:orientation];
}

- (id)initWithImage:(UIImage *)image scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    CGImageRef cgImage = NULL;
    
    if (!image)
    {
        goto jmp_error;
    }
    
    cgImage = image.CGImage;
    
    self = [self initWithCGImage:cgImage scale:scale orientation:orientation];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (UIImage *)imageWithImage:(UIImage *)image scale:(CGFloat)scale orientation:(UIImageOrientation)orientation
{
    return [[self alloc] initWithImage:image scale:scale orientation:orientation];
}

+ (UIImage *)imageNamed:(NSString *)name orientation:(UIImageOrientation)orientation
{
    // Loading the image from the main bundle.
    UIImage *uiImage1 = [UIImage imageNamed:name];
    
    // Setting the default values.
    UIImage *uiImage2 = nil;
    
    // We have loaded image.
    if (uiImage1)
    {
        // The image orientation is same the specific orientation.
        if (uiImage1.imageOrientation == orientation)
        {
            // Saving the image.
            uiImage2 = uiImage1;
        }
        
        // The image orientation is not the specific orientation.
        else
        {
            // Getting the core graphics image.
            CGImageRef cfImage = uiImage1.CGImage;
            
            // Getting the image scale.
            CGFloat scale = uiImage1.scale;
            
            // We have the core graphics image.
            if (cfImage)
            {
                // Creating the image with the specific orientation.
                uiImage2 = [[UIImage alloc] initWithCGImage:cfImage scale:scale orientation:orientation];
            }
            
            // We do not have the core graphics image.
            else
            {
                // Getting the core image.
                CIImage *ciImage = uiImage1.CIImage;
                
                // We have the core image.
                if (ciImage)
                {
                    // Creating the image with the specific orientation.
                    uiImage2 = [[UIImage alloc] initWithCIImage:ciImage scale:scale orientation:orientation];
                }
            }
        }
    }
    
    // Returning the image with the specific orientation.
    return uiImage2;
}

#pragma mark - Write an Image

- (BOOL)writeAsJPEGRepresentationWithCompressionQuality:(CGFloat)compressionQuality toFile:(NSString *)filePath options:(NSDataWritingOptions)options error:(NSError **)pError
{
    // Setting the defalut values.
    NSError *error = nil;
    BOOL     result = NO;
    
    // Getting the JPEG representation.
    NSData *imageData = UIImageJPEGRepresentation(self, compressionQuality);
    
    // We have JPEG representation.
    if (imageData)
    {
        // Write the JPEG representation to the file.
        result = [imageData writeToFile:filePath options:options error:(pError ? &error : nil)];
    }
    
    // The user want to get en error.
    if (pError)
    {
        // Saving the error.
        *pError = error;
    }
    
    // Returning the result operation.
    return result;
}

- (BOOL)writeAsJPEGRepresentationWithCompressionQuality:(CGFloat)compressionQuality toURL:(NSURL *)fileURL options:(NSDataWritingOptions)options error:(NSError **)pError
{
    // Setting the defalut values.
    NSError *error = nil;
    BOOL     result = NO;
    
    // Getting the JPEG representation.
    NSData *imageData = UIImageJPEGRepresentation(self, compressionQuality);
    
    // We have JPEG representation.
    if (imageData)
    {
        // Write the JPEG representation to the file.
        result = [imageData writeToURL:fileURL options:options error:(pError ? &error : nil)];
    }
    
    // The user want to get en error.
    if (pError)
    {
        // Saving the error.
        *pError = error;
    }
    
    // Returning the result operation.
    return result;
}

- (BOOL)writeAsJPEGRepresentationWithCompressionQuality:(CGFloat)compressionQuality inDocumentDirectoryToFileName:(NSString *)fileName options:(NSDataWritingOptions)options error:(NSError **)pError
{
    // Building the image path.
    NSString *documentPath = RENSDocumentDirectoryPathInUserDomain(YES);
    NSString *imagePath = [documentPath stringByAppendingPathComponent:fileName];
    
    // Write the image as JPEG representation to the file.
    BOOL result = [self writeAsJPEGRepresentationWithCompressionQuality:compressionQuality toFile:imagePath options:options error:pError];
    
    // Returning the result operation.
    return result;
}

- (BOOL)writeAsPNGRepresentationToFile:(NSString *)filePath options:(NSDataWritingOptions)options error:(NSError **)pError
{
    // Setting the defalut values.
    NSError *error = nil;
    BOOL     result = NO;
    
    // Getting the PNG representation.
    NSData *imageData = UIImagePNGRepresentation(self);
    
    // We have PNG representation.
    if (imageData)
    {
        // Write the PNG representation to the file.
        result = [imageData writeToFile:filePath options:options error:(pError ? &error : nil)];
    }
    
    // The user want to get en error.
    if (pError)
    {
        // Saving the error.
        *pError = error;
    }
    
    // Returning the result operation.
    return result;
}

- (BOOL)writeAsPNGRepresentationToURL:(NSURL *)fileURL options:(NSDataWritingOptions)options error:(NSError **)pError
{
    // Setting the defalut values.
    NSError *error = nil;
    BOOL     result = NO;
    
    // Getting the PNG representation.
    NSData *imageData = UIImagePNGRepresentation(self);
    
    // We have PNG representation.
    if (imageData)
    {
        // Write the PNG representation to the file.
        result = [imageData writeToURL:fileURL options:options error:(pError ? &error : nil)];
    }
    
    // The user want to get en error.
    if (pError)
    {
        // Saving the error.
        *pError = error;
    }
    
    // Returning the result operation.
    return result;
}

- (BOOL)writeAsPNGRepresentationInDocumentDirectoryToFileName:(NSString *)fileName options:(NSDataWritingOptions)options error:(NSError **)pError
{
    // Building the image path.
    NSString *documentPath = RENSDocumentDirectoryPathInUserDomain(YES);
    NSString *imagePath = [documentPath stringByAppendingPathComponent:fileName];
    
    // Write the image as PNG representation to the file.
    BOOL result = [self writeAsPNGRepresentationToFile:imagePath options:options error:pError];
    
    // Returning the result operation.
    return result;
}

@end

static id UIImage_InitWithData_Scale(UIImage *self, SEL _cmd, NSData *data, CGFloat scale)
{
#pragma unused(_cmd)
    
    UIImage *image2 = nil;
    
    self = [self initWithData:data];
    
    if (!self)
    {
        goto jmp_exit;
    }
    
    if (self.scale != scale)
    {
        CGImageRef cgImage = self.CGImage;
        UIImageOrientation orientation = self.imageOrientation;
        
        image2 = [[UIImage alloc] initWithCGImage:cgImage scale:scale orientation:orientation];
        
        self = image2;
    }
    
    if (!self)
    {
        goto jmp_exit;
    }
    
jmp_exit:
    
    image2 = nil;
    
    return self;
    
}

static UIImage *UIImage_ImageWithData_Scale(Class self, SEL _cmd, NSData *data, CGFloat scale)
{
#pragma unused(_cmd)
    
    return [[self alloc] initWithData:data scale:scale];
}

@implementation UIImage (UIImageREUIImage_6_0_Dynamic)

+ (void)load
{
    class_addMethod([UIImage class], @selector(initWithData:scale:), (IMP)UIImage_InitWithData_Scale, "@16@0:4@8f12");
    class_addMethod([UIImage class], @selector(imageWithData:scale:), (IMP)UIImage_ImageWithData_Scale, "@16@0:4@8f12");
}

@end
