//
//  RFUIImageCache.m
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.07.11.
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
#import "RFUIImageCache.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static RFUIImageCache * volatile RFUIImageCache_DefaultCache = nil;

@implementation RFUIImageCache

#pragma mark - Getting the RFUIImageCache Instance

+ (RFUIImageCache *)defaultCache
{
    if (!RFUIImageCache_DefaultCache)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RFUIImageCache_DefaultCache)
            {
                RFUIImageCache_DefaultCache = [[RFUIImageCache alloc] init];
            }
        }
    }
    
    return RFUIImageCache_DefaultCache;
}

#pragma mark - Initializing and Creating a RFUIImageCache

- (id)init
{
    if ((self = [super init]))
    {
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        
        UIApplication *application = [UIApplication sharedApplication];
        [notificationCenter addObserver:self selector:@selector(applicationDidReceiveMemoryWarningNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:application];
        
        mCachedImages = [[NSMutableDictionary alloc] init];
        
        mNotImageNamedBlock = nil;
    }
    
    return self;
}

#pragma mark - Deallocating a RFUIImageCache

- (void)dealloc
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
    
    mCachedImages = nil;
    
    mNotImageNamedBlock = nil;
}

#pragma mark - Managing the Image Cache

- (void)clean
{
    NSMutableArray *deleteImageNameds = [[NSMutableArray alloc] init];
    
    for (id imageNamed in mCachedImages)
    {
        UIImage *image = mCachedImages[imageNamed];
        
        CFIndex imageRetainCount = CFGetRetainCount((__bridge CFTypeRef)image);
        
        if (imageRetainCount <= 2)
        {
            [deleteImageNameds addObject:imageNamed];
        }
    }
    
    [mCachedImages removeObjectsForKeys:deleteImageNameds];
}

- (void)cleanAll
{
    [mCachedImages removeAllObjects];
}

@synthesize notImageNamedBlock = mNotImageNamedBlock;

- (UIImage *)imageNamed:(NSString *)imageNamed
{
    UIImage *image = nil;
    
    if (imageNamed)
    {
        image = mCachedImages[imageNamed];
    }
    
    if (!image)
    {
        image = [UIImage imageNamed:imageNamed];
        
        if (!image && mNotImageNamedBlock)
        {
            mNotImageNamedBlock(self, imageNamed);
        }
        
        if (image)
        {
            mCachedImages[imageNamed] = image;
        }
    }
    
    return image;
}

#pragma mark - Notifications

#pragma mark FTLocalizationManager Notitications

- (void)applicationDidReceiveMemoryWarningNotification:(NSNotification *)notification
{
    UIApplication *application = [UIApplication sharedApplication];
    
    if (NSNotificationEqualToNotificationNameAndObject(notification, UIApplicationDidReceiveMemoryWarningNotification, application))
    {
        [self clean];
    }
}

@end
