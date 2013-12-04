//
//  RFNSNetwork.m
//  RFNetwork
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2011.12.12.
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
#import "RFNSNetwork.h"

// Importing the project headers.
#import "RFNSURLConnection.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>

static RFNSNetwork * volatile RFNSNetwork_DefaultNetwork = nil;

@implementation RFNSNetwork

#pragma mark - Getting the RFNSNetwork Instance

+ (RFNSNetwork *)defaultNetwork
{
    if (!RFNSNetwork_DefaultNetwork)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RFNSNetwork_DefaultNetwork)
            {
                NSString *baseURLString = nil;
                
                if ([NSThread isMainThread])
                {
                    baseURLString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RFNSNetworkBaseURL"];
                }
                
                NSURL *baseURL = nil;
                
                if (baseURLString)
                {
                    baseURL = [[NSURL alloc] initWithString:baseURLString];
                }
                
                RFNSNetwork_DefaultNetwork = [[RFNSNetwork alloc] initWithBaseURL:baseURL];
            }
        }
    }
    
    return RFNSNetwork_DefaultNetwork;
}

#pragma mark - Initializing and Creating a RFNSNetwork

- (id)init
{
    return [self initWithBaseURL:nil];
}

- (id)initWithBaseURL:(NSURL *)baseURL
{
    if (!baseURL)
    {
        goto jmp_error;
    }
    
    self  = [super init];
    
    if (!self)
    {
        goto jmp_error;
    }
    
    mOperationQueue = [[NSOperationQueue alloc] init];
    
    if (!mOperationQueue)
    {
        goto jmp_error;
    }
    
    mBaseURL = baseURL;
    
    return self;
    
jmp_error:
    
    self = nil;
    
    return self;
}

+ (id)networkWithBaseURL:(NSURL *)baseURL
{
    return [[self alloc] initWithBaseURL:baseURL];
}

#pragma mark - Deallocating a RFNSNetwork

- (void)dealloc
{
    mOperationQueue = nil;
    
    mBaseURL = nil;
}

#pragma mark - Accessing the Operation Queue

@synthesize operationQueue = mOperationQueue;

#pragma mark - Getting the Base URLs

@synthesize baseURL = mBaseURL;

#pragma mark - Managing the URL Connection in Queue

- (void)addURLConnection:(RFNSURLConnection *)urlConnection
{
    if (urlConnection)
    {
        urlConnection.network = self;
        urlConnection.startThread = [NSThread currentThread];
        
        [mOperationQueue addOperation:urlConnection];
    }
}

- (void)canelURLConnection:(RFNSURLConnection *)urlConnection
{
    if (urlConnection)
    {
        if (urlConnection.network != self)
        {
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The network of url connection and the network are different." userInfo:nil];
        }
        
        else
        {
            [urlConnection cancel];
        }
    }
}

@end
