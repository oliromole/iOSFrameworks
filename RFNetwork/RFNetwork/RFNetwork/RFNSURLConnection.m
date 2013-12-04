//
//  RFNSURLConnection.m
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
#import "RFNSURLConnection.h"

// Importing the project headers.
#import "RFNSError.h"
#import "RFNSNetwork.h"
#import "RFNSURLConnectionDelegate.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>
#import <RFFoundation/RFFoundation.h>
#import <RFUIKit/RFUIKit.h>

// Importing the system headers.
#import <Foundation/Foundation.h>

// Importing the system headers.
#import <libkern/OSAtomic.h>

int32_t volatile RFNSURLConnection_Counter = 0;

@implementation RFNSURLConnection

#pragma mark - Initializing and Creating a URL Connection

- (id)init
{
    if ((self = [super init]))
    {
        // Delegate.
        mDelegate = nil;
        
        // Network.
        mNetwork = nil;
        
        // Network Activity Indicator
        mIsNetworkActivityIndicatorShown = NO;
        mLocalNetworkActivityIndicator = [[RFUILocalNetworkActivityIndicator alloc] init];
        
        // Error.
        mError = nil;
        
        // URL Connection Information.
        mURLConnectionDictionary = nil;
        
        // URL.
        mBaseURL = nil;
        mBaseURLString = nil;
        mCompiledURL = nil;
        mNeedsCompileURL = YES;
        mRelativeURLString = nil;
        mURL = nil;
        mURLQuery = nil;
        mURLQueryString = nil;
        mURLString = nil;
        
        // Input.
        mCompiledInputStream = nil;
        mCompiledInputStreamLength = -1;
        mInputData = nil;
        mInputFile = nil;
        mInputStream = nil;
        mInputURL = nil;
        mNeedsCompileInputStream = YES;
        mNeedsOpenInputStream = YES;
        
        // URL Request.
        mCompiledURLRequest = nil;
        mNeedsCompileURLRequest = YES;
        mURLRequest = nil;
        
        // HTTP/HTTPS.
        mHTTPHeaderFields = nil;
        mHTTPMethod = nil;
        mHTTPShouldHandleCookies = YES;
        mHTTPShouldUsePipelining = YES;
        mNeedsConfigureHTTP = YES;
        
        // URL Connection.
        mCompiledURLConnection = nil;
        mIsCompiledURLConnectionCancelled = NO;
        mNeedsCompileURLConnection = YES;
        mURLConnection = nil;
        
        // Response.
        mURLResponse = nil;
        mHTTPURLResponse = nil;
        
        // Output.
        mCompiledOutputStream = nil;
        mOutputAppend = NO;
        mOutputBytes = 0;
        mOutputBytesWritten = 0;
        mOutputData = nil;
        mOutputPath = nil;
        mOutputStream = nil;
        mOutputURL = nil;
        mNeedsCompileOutputStream = YES;
        mNeedsOpenOutputStream = YES;
        
        // Operation status.
        mIsConcurrent = YES;
        mIsExecuting = NO;
        mIsFinished = NO;
        
        // Synchronization.
        mDelegateThread = nil;
        mIsDelegateSynchronized = YES;
        mStartThread = nil;
    }
    
    return self;
}

- (void)dealloc
{
    // Network Activity Indicator
    mLocalNetworkActivityIndicator = nil;
    
    // Error.
    
    mError = nil;
    
    // URL Connection Information.
    
    mURLConnectionDictionary = nil;
    
    // URL.
    
    mBaseURL = nil;
    
    mBaseURLString = nil;
    
    mCompiledURL = nil;
    
    mRelativeURLString = nil;
    
    mURL = nil;
    
    mURLQuery = nil;
    
    mURLQueryString = nil;
    
    mURLString = nil;
    
    // Input.
    
    mCompiledInputStream = nil;
    
    mInputData = nil;
    
    mInputFile = nil;
    
    mInputStream = nil;
    
    mInputURL = nil;
    
    // URL Request.
    
    mCompiledURLRequest = nil;
    
    mURLRequest = nil;
    
    // HTTP/HTTPS.
    
    mHTTPHeaderFields = nil;
    
    mHTTPMethod = nil;
    
    // URL Connection.
    
    mCompiledURLConnection = nil;
    
    mURLConnection = nil;
    
    // Response.
    
    mURLResponse = nil;
    
    mHTTPURLResponse = nil;
    
    // Output.
    
    mCompiledOutputStream = nil;
    
    mOutputData = nil;
    
    mOutputPath = nil;
    
    mOutputStream = nil;
    
    mOutputURL = nil;
    
    // Synchronization.
    
    mDelegateThread = nil;
    
    mStartThread = nil;
}

#pragma mark - Configuring a URL Connection

+ (Class)urlRequest
{
    return [NSMutableURLRequest class];
}

+ (Class)urlConnection
{
    return [NSURLConnection class];
}

#pragma mark - Loading Data

- (void)startAsSynchronous
{
    RFNSNetwork *network = nil;
    
    if (!network)
    {
        network = mNetwork;
    }
    
    if (!network)
    {
        network = [RFNSNetwork defaultNetwork];
    }
    
    if (network)
    {
        [network addURLConnection:self];
    }
    
    [self waitUntilFinished];
}

- (void)startAsAsynchronous
{
    RFNSNetwork *network = nil;
    
    if (!network)
    {
        network = mNetwork;
    }
    
    if (!network)
    {
        network = [RFNSNetwork defaultNetwork];
    }
    
    if (network)
    {
        [network addURLConnection:self];
    }
}

#pragma mark - Managing the Delegate

@synthesize delegate = mDelegate;

#pragma mark - Managing the Network

@synthesize network = mNetwork;

#pragma mark - Managing Network Activity Indicator

- (RFUILocalNetworkActivityIndicator *)localNetworkActivityIndicator
{
    return mLocalNetworkActivityIndicator;
}

- (void)setLocalNetworkActivityIndicator:(RFUILocalNetworkActivityIndicator *)localNetworkActivityIndicator
{
    if (mLocalNetworkActivityIndicator != localNetworkActivityIndicator)
    {
        if (mIsNetworkActivityIndicatorShown)
        {
            mIsNetworkActivityIndicatorShown = NO;
            [mLocalNetworkActivityIndicator hide];
        }
        
        mLocalNetworkActivityIndicator = localNetworkActivityIndicator;
    }
}

#pragma mark - Managing the Error

@synthesize error = mError;

#pragma mark - Managing the URL Connection Information

- (NSMutableDictionary *)urlConnectionDictionary
{
    if (!mURLConnectionDictionary)
    {
        mURLConnectionDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return mURLConnectionDictionary;
}

- (void)setUrlConnectionDictionary:(NSMutableDictionary *)urlConnectionDictionary
{
    if (mURLConnectionDictionary != urlConnectionDictionary)
    {
        mURLConnectionDictionary = urlConnectionDictionary;
    }
}

#pragma mark - Managing the URL

@synthesize baseURL = mBaseURL;

- (NSMutableString *)baseURLString
{
    if (!mBaseURLString)
    {
        mBaseURLString = [[NSMutableString alloc] init];
    }
    
    return mBaseURLString;
}

- (void)setBaseURLString:(NSMutableString *)baseURLString
{
    if (mBaseURLString != baseURLString)
    {
        mBaseURLString = baseURLString;
    }
}

@synthesize compiledURL = mCompiledURL;

@synthesize needsCompileURL = mNeedsCompileURL;

- (NSMutableString *)relativeURLString
{
    if (!mRelativeURLString)
    {
        mRelativeURLString = [[NSMutableString alloc] init];
    }
    
    return mRelativeURLString;
}

- (void)setRelativeURLString:(NSMutableString *)relativeURLString
{
    if (mRelativeURLString != relativeURLString)
    {
        mRelativeURLString = relativeURLString;
    }
}

- (NSURL *)url
{
    return mURL;
}

- (void)setURL:(NSURL *)url
{
    if (mURL != url)
    {
        mURL = url;
    }
}

- (NSMutableDictionary *)urlQuery
{
    if (!mURLQuery)
    {
        mURLQuery = [[NSMutableDictionary alloc] init];
    }
    
    return mURLQuery;
}

- (void)setURLQuery:(NSMutableDictionary *)urlQuery
{
    if (mURLQuery != urlQuery)
    {
        mURLQuery = urlQuery;
    }
}

- (NSMutableString *)urlQueryString
{
    if (!mURLQueryString)
    {
        mURLQueryString = [[NSMutableString alloc] init];
    }
    
    return mURLQueryString;
}

- (void)setURLQueryString:(NSMutableString *)urlQueryString
{
    if (mURLQueryString != urlQueryString)
    {
        mURLQueryString = urlQueryString;
    }
}

- (NSMutableString *)urlString
{
    if (!mURLString)
    {
        mURLString = [[NSMutableString alloc] init];
    }
    
    return mURLString;
}

- (void)setURLString:(NSMutableString *)urlString
{
    if (mURLString != urlString)
    {
        mURLString = urlString;
    }
}

- (BOOL)shouldCompileURL
{
    return mNeedsCompileURL;
}

- (void)compileURL
{
    NSURL *url = nil;
    
    if (mURL)
    {
        url = mURL;
    }
    
    else if (mURLString && (mURLString.length > 0))
    {
        url = [[NSURL alloc] initWithString:mURLString];
    }
    
    else
    {
        NSURL *baseURL = nil;
        
        RFNSNetwork *network = mNetwork;
        
        if (mBaseURL)
        {
            baseURL = mBaseURL;
        }
        
        else if (mBaseURLString && (mBaseURLString.length > 0))
        {
            baseURL = [[NSURL alloc] initWithString:mBaseURLString];
        }
        
        else if (network.baseURL)
        {
            baseURL = network.baseURL;
        }
        
        NSMutableString *relativeURLString = nil;
        
        if (mRelativeURLString && (mRelativeURLString.length > 0))
        {
            relativeURLString = [mRelativeURLString mutableCopy];
        }
        
        NSMutableString *urlQueryString = [[NSMutableString alloc] init];
        
        if (mURLQueryString && (mURLQueryString.length > 0))
        {
            [urlQueryString appendString:mURLQueryString];
        }
        
        else if (mURLQuery && (mURLQuery.count > 0))
        {
            Class numberClass = [NSNumber class];
            Class stringClass = [NSString class];
            
            for (id key in [mURLQuery keyEnumerator])
            {
                NSString *keyString = nil;
                
                if ([key isKindOfClass:stringClass])
                {
                    keyString = (NSString *)key;
                }
                
                else if ([key isKindOfClass:numberClass])
                {
                    NSNumber *keyNumber = (NSNumber *)key;
                    keyString =  keyNumber.description;
                }
                
                else
                {
                    RENSAssert(NO, @"The key local variable is not one of types: NSString, NSNumber.");
                }
                
                id value = [mURLQuery objectForKey:key];
                
                NSString *valueString = nil;
                
                if ([value isKindOfClass:stringClass])
                {
                    valueString = (NSString *)value;
                }
                
                else if ([value isKindOfClass:numberClass])
                {
                    NSNumber *valueNumber = (NSNumber *)value;
                    valueString =  valueNumber.description;
                }
                
                else
                {
                    RENSAssert(NO, @"The value local variable is not one of types: NSString, NSNumber.");
                }
                
                
                NSString *keyAddedPercentEscapes = [keyString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *valueAddedPercentEscapes = [valueString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                if (keyAddedPercentEscapes && valueAddedPercentEscapes)
                {
                    [urlQueryString appendFormat:@"%@=%@&", keyAddedPercentEscapes, valueAddedPercentEscapes];
                }
            }
        }
        
        [urlQueryString trimLeftStrings:@"?", nil];
        
        if (urlQueryString && (urlQueryString.length > 0))
        {
            [urlQueryString insertString:@"?" atIndex:0];
        }
        
        [urlQueryString trimRightStrings:@"&", nil];
        
        if (relativeURLString && urlQueryString && (urlQueryString.length > 0))
        {
            [relativeURLString appendString:urlQueryString];
        }
        
        if (relativeURLString && (relativeURLString.length > 0))
        {
            if (baseURL)
            {
                url = [[NSURL alloc] initWithString:relativeURLString relativeToURL:baseURL];
            }
            
            else
            {
                url = [[NSURL alloc] initWithString:relativeURLString];
            }
        }
    }
    
    url = [url absoluteURL];
    
    self.compiledURL = url;
}

#pragma mark - Managing the Input Stream

@synthesize compiledInputStream = mCompiledInputStream;

@synthesize compiledInputStreamLength = mCompiledInputStreamLength;

- (NSMutableData *)inputData
{
    if (!mInputData)
    {
        mInputData = [[NSMutableData alloc] init];
    }
    
    return mInputData;
}

- (void)setInputData:(NSMutableData *)inputData
{
    if (mInputData != inputData)
    {
        mInputData = inputData;
    }
}

@synthesize inputData = mInputData;

@synthesize inputFile = mInputFile;

@synthesize inputStream = mInputStream;

@synthesize inputURL = mInputURL;

@synthesize needsCompileInputStream = mNeedsCompileInputStream;

@synthesize needsOpenInputStream = mNeedsOpenInputStream;

- (BOOL)shouldCompileInputStream
{
    return mNeedsCompileInputStream;
}

- (void)compileInputStream
{
    NSInputStream *inputStream = nil;
    long long compiledInputStreamLength = -1;
    
    if (mInputStream)
    {
        inputStream = mInputStream;
    }
    
    else if (mInputData && (mInputData.length > 0))
    {
        inputStream = [[NSInputStream alloc] initWithData:mInputData];
        compiledInputStreamLength = mInputData.length;
    }
    
    else if (mInputFile && (mInputFile.length > 0))
    {
        inputStream = [[NSInputStream alloc] initWithFileAtPath:mInputFile];
    }
    
    else if (mInputURL)
    {
        inputStream = [[NSInputStream alloc] initWithURL:mInputURL];
    }
    
    self.compiledInputStream = inputStream;
    self.compiledInputStreamLength = compiledInputStreamLength;
}

- (BOOL)shouldOpenInputStream
{
    return mNeedsOpenInputStream;
}

- (void)openInputStream
{
    [mCompiledInputStream open];
}

#pragma mark - Managing the URL Request

@synthesize compiledURLRequest = mCompiledURLRequest;

@synthesize needsCompileURLRequest = mNeedsCompileURLRequest;

@synthesize urlRequest = mURLRequest;

- (BOOL)shouldCompileURLRequest
{
    return mNeedsCompileURLRequest;
}

- (void)compileURLRequest
{
    NSMutableURLRequest *urlRequest = nil;
    
    if (mURLRequest)
    {
        urlRequest = mURLRequest;
    }
    
    else if (mCompiledURL)
    {
        urlRequest = [[[[self class] urlRequest] alloc] init];
        [urlRequest setURL:mCompiledURL];
    }
    
    self.compiledURLRequest = urlRequest;
}

#pragma mark - Configuring HTTP/HTTPS Protocol

- (NSMutableDictionary *)httpHeaderFields
{
    if (!mHTTPHeaderFields)
    {
        mHTTPHeaderFields = [[NSMutableDictionary alloc] init];
    }
    
    return mHTTPHeaderFields;
}

- (void)setHTTPHeaderFields:(NSMutableDictionary *)httpHeaderFields
{
    if (mHTTPHeaderFields != httpHeaderFields)
    {
        mHTTPHeaderFields = httpHeaderFields;
    }
}

- (NSMutableString *)httpMethod
{
    if (!mHTTPMethod)
    {
        mHTTPMethod = [[NSMutableString alloc] init];
    }
    
    return mHTTPMethod;
}

- (void)setHTTPMethod:(NSMutableString *)httpMethod
{
    if (mHTTPMethod != httpMethod)
    {
        mHTTPMethod = httpMethod;
    }
}

@synthesize httpShouldHandleCookies = mHTTPShouldHandleCookies;
@synthesize httpShouldUsePipelining = mHTTPShouldUsePipelining;
@synthesize needsConfigureHTTP = mNeedsConfigureHTTP;

- (BOOL)shouldConfigureHTTP
{
    return mNeedsConfigureHTTP;
}

- (void)configureHTTP
{
    if (mHTTPHeaderFields && (mHTTPHeaderFields.count > 0))
    {
        for (NSString *key in [mHTTPHeaderFields keyEnumerator])
        {
            NSString *value = [mHTTPHeaderFields objectForKey:key];
            
            [mCompiledURLRequest setValue:value forHTTPHeaderField:key];
        }
    }
    
    if (mHTTPMethod && (mHTTPMethod.length > 0))
    {
        [mCompiledURLRequest setHTTPMethod:mHTTPMethod];
    }
    
    [mCompiledURLRequest setHTTPShouldHandleCookies:mHTTPShouldHandleCookies];
    
    [mCompiledURLRequest setHTTPShouldUsePipelining:mHTTPShouldUsePipelining];
}

#pragma mark - Managing the URL Connection

@synthesize compiledURLConnection = mCompiledURLConnection;

@synthesize needsCompileURLConnection = mNeedsCompileURLConnection;

@synthesize urlConnection = mURLConnection;

- (BOOL)shouldCompileURLConnection
{
    return mNeedsCompileURLConnection;
}

- (void)compileURLConnection
{
    NSURLConnection *urlConnection = nil;
    
    if (mURLConnection)
    {
        urlConnection = mURLConnection;
    }
    
    else if (mCompiledURLRequest)
    {
        urlConnection = [[[[self class] urlConnection] alloc] initWithRequest:mCompiledURLRequest delegate:self];
    }
    
    self.compiledURLConnection = urlConnection;
}

- (void)willBeginStartingURLConnection
{
    // This stub.
}

- (void)didBeginStartingURLConnection
{
    // This stub.
}

#pragma mark - Managing the Response

@synthesize urlResponse = mURLResponse;

@synthesize httpURLResponse = mHTTPURLResponse;

#pragma mark - Managing the Output Stream

@synthesize compiledOutputStream = mCompiledOutputStream;

@synthesize outputAppend = mOutputAppend;

@synthesize outputBytes = mOutputBytes;

@synthesize outputBytesWritten = mOutputBytesWritten;

@synthesize outputData = mOutputData;

@synthesize outputPath = mOutputPath;

@synthesize outputStream = mOutputStream;

@synthesize outputURL = mOutputURL;

@synthesize needsCompileOutputStream = mNeedsCompileOutputStream;

@synthesize needsOpenOutputStream = mNeedsOpenOutputStream;

- (BOOL)shouldCompileOutputStream
{
    return mNeedsCompileOutputStream;
}

- (void)compileOutputStream
{
    NSOutputStream *outputStream = nil;
    
    if (mOutputStream)
    {
        outputStream = mOutputStream;
    }
    
    else if (mOutputPath && (mOutputPath.length > 0))
    {
        outputStream = [[NSOutputStream alloc] initToFileAtPath:mOutputPath append:mOutputAppend];
    }
    
    else if (mOutputURL)
    {
        outputStream = [[NSOutputStream alloc] initWithURL:mOutputURL append:mOutputAppend];
    }
    
    else
    {
        NSMutableData *outputData = self.outputData;
        
        if (!outputData)
        {
            outputData = [[NSMutableData alloc] init];
            
            self.outputData = outputData;
        }
        
        if (mOutputData)
        {
            outputStream = [[RFNSOutputStream alloc] initToMutableData:mOutputData];
        }
    }
    
    self.compiledOutputStream = outputStream;
}

- (BOOL)shouldOpenOutputStream
{
    return mNeedsOpenOutputStream;
}

- (void)openOutputStream
{
    if (mCompiledOutputStream)
    {
        [mCompiledOutputStream open];
    }
}

#pragma mark - Managing the Operation Status

- (BOOL)isConcurrent
{
    return mIsConcurrent;
}

- (void)setIsConcurrent:(BOOL)isConcurrent
{
    if (mIsConcurrent != isConcurrent)
    {
        [self willChangeValueForKey:@"isConcurrent"];
        mIsConcurrent = isConcurrent;
        [self didChangeValueForKey:@"isConcurrent"];
    }
}

- (void)cancel
{
    [super cancel];
}

- (BOOL)isExecuting
{
    return mIsExecuting;
}

- (void)setIsExecuting:(BOOL)isExecuting
{
    if (mIsExecuting != isExecuting)
    {
        [self willChangeValueForKey:@"isExecuting"];
        mIsExecuting = isExecuting;
        [self didChangeValueForKey:@"isExecuting"];
    }
}

- (BOOL)isFinished
{
    return mIsFinished;
}

- (void)setIsFinished:(BOOL)isFinished
{
    if (mIsFinished != isFinished)
    {
        [self willChangeValueForKey:@"isFinished"];
        mIsFinished = isFinished;
        [self didChangeValueForKey:@"isFinished"];
    }
}

#pragma mark - Managing the Synchronization

@synthesize delegateThread = mDelegateThread;

@synthesize isDelegateSynchronized = mIsDelegateSynchronized;

@synthesize startThread = mStartThread;

- (NSThread *)syncThread
{
    NSThread *syncThread = nil;
    
    if (mIsDelegateSynchronized)
    {
        syncThread = mDelegateThread;
        
        if (!syncThread)
        {
            syncThread = mStartThread;
        }
        
        if (!syncThread)
        {
            syncThread = [NSThread mainThread];
        }
    }
    
    else
    {
        syncThread = [NSThread currentThread];
    }
    
    return syncThread;
}

- (NSInvocation *)delegateInvocationWithSelector:(SEL)selector
{
    NSInvocation *invocation = nil;
    
    id<RFNSURLConnectionDelegate> delegate = mDelegate;
    
    if (delegate &&
        selector &&
        [delegate respondsToSelector:@selector(methodSignatureForSelector:)])
    {
        NSMethodSignature *methodSignature = [((id)delegate) methodSignatureForSelector:selector];
        
        if (methodSignature)
        {
            invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
            [invocation setSelector:selector];
            [invocation setTarget:delegate];
        }
    }
    
    return invocation;
}

- (NSInvocation *)delegateInvocationWithConformsToProtocol:(Protocol *)protocol respondsToSelector:(SEL)selector
{
    NSInvocation *invocation = nil;
    
    id<RFNSURLConnectionDelegate> delegate = mDelegate;
    
    if (delegate &&
        protocol &&
        selector &&
        [delegate conformsToProtocol:protocol] &&
        [delegate respondsToSelector:selector] &&
        [delegate respondsToSelector:@selector(methodSignatureForSelector:)])
    {
        NSMethodSignature *methodSignature = [((id)delegate) methodSignatureForSelector:selector];
        
        if (methodSignature)
        {
            invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
            [invocation setSelector:selector];
            [invocation setTarget:delegate];
        }
    }
    
    return invocation;
}

- (NSInvocation *)delegateInvocationWithRespondsToSelector:(SEL)selector
{
    NSInvocation *invocation = nil;
    
    id<RFNSURLConnectionDelegate> delegate = mDelegate;
    
    if (delegate &&
        selector &&
        [delegate respondsToSelector:selector] &&
        [delegate respondsToSelector:@selector(methodSignatureForSelector:)])
    {
        NSMethodSignature *methodSignature = [((id)delegate) methodSignatureForSelector:selector];
        
        if (methodSignature)
        {
            invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
            [invocation setSelector:selector];
            [invocation setTarget:delegate];
        }
    }
    
    return invocation;
}

- (void)performInvocationOnSyncThread:(NSInvocation *)invocation waitUntilDone:(BOOL)wait modes:(NSArray *)modes
{
    if (invocation)
    {
        [invocation performSelector:@selector(invoke) onThread:self.syncThread withObject:nil waitUntilDone:wait modes:modes];
    }
}

- (void)performInvocationOnSyncThread:(NSInvocation *)invocation waitUntilDone:(BOOL)wait
{
    if (invocation)
    {
        [self performInvocationOnSyncThread:invocation waitUntilDone:wait modes:[NSArray arrayWithObjects:NSRunLoopCommonModes, nil]];
    }
}

- (void)performInvocationOnSyncThread:(NSInvocation *)invocation
{
    if (invocation)
    {
        [self performInvocationOnSyncThread:invocation waitUntilDone:YES];
    }
}

#pragma mark - Executing the Operation

- (void)main
{
    @autoreleasepool
    {
        @autoreleasepool
        {
            int32_t numberOfURLConnection = OSAtomicIncrement32Barrier(&RFNSURLConnection_Counter);
            
            if ([NSThread currentThread].name.length == 0)
            {
                NSString *className = NSStringFromClass(self.class);
                NSString *threadName = [[NSString alloc] initWithFormat:@"com.oliromole.%@-%ld", className, (long)numberOfURLConnection];
                [NSThread currentThread].name = threadName;
            }
            
            if (!self.isCancelled)
            {
                self.isExecuting = YES;
                
                if (!self.isCancelled && self.shouldCompileURL)
                {
                    [self compileURL];
                }
                
                if (!self.isCancelled && self.shouldCompileInputStream)
                {
                    [self compileInputStream];
                }
                
                if (!self.isCancelled && self.shouldOpenInputStream)
                {
                    [self openInputStream];
                }
                
                if (!self.isCancelled && self.shouldCompileURLRequest)
                {
                    [self compileURLRequest];
                }
                
                if ([mCompiledURLRequest.URL.scheme isEqual:@"http"] ||
                    [mCompiledURLRequest.URL.scheme isEqual:@"https"])
                {
                    if (!self.isCancelled && self.shouldConfigureHTTP)
                    {
                        [self configureHTTP];
                    }
                    
                    if (!self.isCancelled && mCompiledInputStream)
                    {
                        [mCompiledURLRequest setHTTPBodyStream:mCompiledInputStream];
                        
                        if (mCompiledInputStreamLength >= 0)
                        {
                            [mCompiledURLRequest addValue:[NSString stringWithFormat:@"%lld", mCompiledInputStreamLength] forHTTPHeaderField:@"Content-Length"];
                        }
                    }
                }
                
                if (!self.isCancelled && self.shouldCompileOutputStream)
                {
                    [self compileOutputStream];
                }
                
                if (!self.isCancelled && self.shouldOpenOutputStream)
                {
                    [self openOutputStream];
                }
                
                if (!self.isCancelled && self.shouldCompileURLConnection)
                {
                    [self compileURLConnection];
                }
                
                if (!self.isCancelled)
                {
                    [self willBeginStartingURLConnection];
                    
                    [mCompiledURLConnection start];
                    
                    [self didBeginStartingURLConnection];
                }
            }
        }
        
        SInt32 runLoopRunResult = kCFRunLoopRunTimedOut;
        
        while (YES)
        {
            @autoreleasepool
            {
                //BOOL needsRepeat = (!self.isCancelled && !self.isFinished && (runLoopRunResult != kCFRunLoopRunStopped) && (runLoopRunResult != kCFRunLoopRunFinished));
                BOOL needsRepeat = (!self.isFinished && (runLoopRunResult != kCFRunLoopRunStopped) && (runLoopRunResult != kCFRunLoopRunFinished));
                
                if (!needsRepeat)
                {
                    break;
                }
                
                if (self.isCancelled && !mIsCompiledURLConnectionCancelled)
                {
                    mIsCompiledURLConnectionCancelled = YES;
                    [mCompiledURLConnection cancel];
                }
                
                runLoopRunResult = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10.0, YES);
            }
        }
        
        if (self.isCancelled)
        {
            [mURLConnection cancel];
            
            NSMutableDictionary * networkErrorUserInfo = [[NSMutableDictionary alloc] init];
            [networkErrorUserInfo setObject:@"Request is cancelled." forKey:NSLocalizedDescriptionKey];
            
            NSError *networkError = [[NSError alloc] initWithDomain:RFNSNetworkErrorDomain code:RFNSNetworkCancelledError userInfo:networkErrorUserInfo];
            
            self.error = networkError;
            
            NSInvocation *invocation = [self delegateInvocationWithConformsToProtocol:@protocol(RFNSURLConnectionDelegate) respondsToSelector:@selector(connection:didFailWithError:)];
            
            if (invocation)
            {
                RFNSURLConnection *urlConnection = self;
                
                [invocation setArgument:&urlConnection atIndex:2];
                [invocation setArgument:&mError atIndex:3];
                
                [invocation retainArguments];
                
                [self performInvocationOnSyncThread:invocation];
            }
        }
        
        else if (runLoopRunResult == kCFRunLoopRunStopped)
        {
            [mURLConnection cancel];
            
            NSMutableDictionary * networkErrorUserInfo = [[NSMutableDictionary alloc] init];
            [networkErrorUserInfo setObject:@"An internal error occurred." forKey:NSLocalizedDescriptionKey];
            
            NSError *networkError = [[NSError alloc] initWithDomain:RFNSNetworkErrorDomain code:RFNSNetworkInternalErrorCode userInfo:networkErrorUserInfo];
            
            self.error = networkError;
            
            NSInvocation *invocation = [self delegateInvocationWithConformsToProtocol:@protocol(RFNSURLConnectionDelegate) respondsToSelector:@selector(connection:didFailWithError:)];
            
            if (invocation)
            {
                RFNSURLConnection *urlConnection = self;
                
                [invocation setArgument:&urlConnection atIndex:2];
                [invocation setArgument:&mError atIndex:3];
                
                [invocation retainArguments];
                
                [self performInvocationOnSyncThread:invocation];
            }
        }
        
        self.isExecuting = NO;
        self.isFinished = YES;
    }
}

#pragma mark - Conforming the NSStreamDelegate Protocol

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
#pragma unused(aStream)
#pragma unused(eventCode)
}

#pragma mark - Conforming the NSURLConnectionDataDelegate Protocol

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    if (connection && (connection == mCompiledURLConnection))
    {
        if (!mIsNetworkActivityIndicatorShown)
        {
            mIsNetworkActivityIndicatorShown = YES;
            [mLocalNetworkActivityIndicator show];
        }
        
        self.outputBytes = 0;
        self.outputBytesWritten = 0;
        
        NSURLRequest *resultURLRequest = request;
        
        NSInvocation *invocation = [self delegateInvocationWithConformsToProtocol:@protocol(RFNSURLConnectionDelegate) respondsToSelector:@selector(connection:willSendRequest:redirectResponse:)];
        
        if (invocation)
        {
            RFNSURLConnection *urlConnection = self;
            
            [invocation setArgument:&urlConnection atIndex:2];
            [invocation setArgument:&request atIndex:3];
            [invocation setArgument:&response atIndex:4];
            
            [invocation retainArguments];
            
            [self performInvocationOnSyncThread:invocation];
            
            [invocation getReturnValue:&resultURLRequest];
        }
        
        return resultURLRequest;
    }
    
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection && (connection == mCompiledURLConnection))
    {
        self.urlResponse = response;
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]])
        {
            self.httpURLResponse = (NSHTTPURLResponse *)response;
            
            NSDictionary *allHeaderFields = self.httpURLResponse.allHeaderFields;
            
            NSString *contentLengthHeaderField = [allHeaderFields objectForKey:@"Content-Length"];
            
            if (contentLengthHeaderField && (contentLengthHeaderField.length > 0))
            {
                long long int outputBytes = contentLengthHeaderField.longLongValue;
                self.outputBytes = outputBytes;
            }
        }
        
        NSInvocation *invocation = [self delegateInvocationWithConformsToProtocol:@protocol(RFNSURLConnectionDelegate) respondsToSelector:@selector(connectionDidReceiveResponse:)];
        
        if (invocation)
        {
            RFNSURLConnection *urlConnection = self;
            
            [invocation setArgument:&urlConnection atIndex:2];
            
            [invocation retainArguments];
            
            [self performInvocationOnSyncThread:invocation];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection && (connection == mCompiledURLConnection) && data)
    {
        if (mCompiledOutputStream)
        {
            const uint8_t *buffer = (const uint8_t *)data.bytes;
            
            NSUInteger bufferLength = data.length;
            NSInteger  bytesWritten = 0;
            NSUInteger totalBytesWritten = 0;
            
            while (totalBytesWritten < bufferLength)
            {
                bytesWritten = [mCompiledOutputStream write:(buffer + totalBytesWritten) maxLength:(bufferLength - totalBytesWritten)];
                
                if (bytesWritten <= 0)
                {
                    break;
                }
                
                else
                {
                    totalBytesWritten += (NSUInteger)bytesWritten;
                }
            }
            
            long long int oldOutputBytesWritten = self.outputBytesWritten;
            
            self.outputBytesWritten = oldOutputBytesWritten + totalBytesWritten;
            
            long long int newOutputBytesWritten = self.outputBytesWritten;
            
            if (oldOutputBytesWritten != newOutputBytesWritten)
            {
                NSInvocation *invocation = [self delegateInvocationWithConformsToProtocol:@protocol(RFNSURLConnectionDelegate) respondsToSelector:@selector(connectionDidWriteDataInOutput:)];
                
                if (invocation)
                {
                    RFNSURLConnection *urlConnection = self;
                    
                    [invocation setArgument:&urlConnection atIndex:2];
                    
                    [invocation retainArguments];
                    
                    [self performInvocationOnSyncThread:invocation];
                }
            }
        }
    }
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
#pragma unused(bytesWritten)
#pragma unused(totalBytesWritten)
#pragma unused(totalBytesExpectedToWrite)
    
    if (connection && (connection == mCompiledURLConnection))
    {
        
    }
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
#pragma unused(cachedResponse)
    
    if (connection && (connection == mCompiledURLConnection))
    {
        return nil;
    }
    
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection && (connection == mCompiledURLConnection))
    {
        if (mIsNetworkActivityIndicatorShown)
        {
            mIsNetworkActivityIndicatorShown = NO;
            [mLocalNetworkActivityIndicator hide];
        }
        
        if (mCompiledOutputStream)
        {
            [mCompiledOutputStream close];
        }
        
        NSInvocation *invocation = [self delegateInvocationWithConformsToProtocol:@protocol(RFNSURLConnectionDelegate) respondsToSelector:@selector(connectionDidFinishLoading:)];
        
        if (invocation)
        {
            RFNSURLConnection *urlConnection = self;
            
            [invocation setArgument:&urlConnection atIndex:2];
            
            [invocation retainArguments];
            
            [self performInvocationOnSyncThread:invocation];
        }
    }
}

#pragma mark - Conforming the NSURLConnectionDelegate Protocol

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (connection && (connection == mCompiledURLConnection))
    {
        if (mIsNetworkActivityIndicatorShown)
        {
            mIsNetworkActivityIndicatorShown = NO;
            [mLocalNetworkActivityIndicator hide];
        }
        
        NSMutableDictionary *networkErrorUserInfo = nil;
        NSError *networkError = nil;
        
        if (!error)
        {
            networkErrorUserInfo = [[NSMutableDictionary alloc] init];
            [networkErrorUserInfo setObject:@"An unknown internal error request." forKey:NSLocalizedDescriptionKey];
            
            networkError = [[NSError alloc] initWithDomain:RFNSNetworkErrorDomain code:RFNSNetworkUnknownError userInfo:networkErrorUserInfo];
        }
        
        else if (error && ([error code] == NSURLErrorCancelled))
        {
            networkErrorUserInfo = [[NSMutableDictionary alloc] init];
            [networkErrorUserInfo setObject:@"Request canceled." forKey:NSLocalizedDescriptionKey];
            [networkErrorUserInfo setObject:error forKey:NSUnderlyingErrorKey];
            
            networkError = [[NSError alloc] initWithDomain:RFNSNetworkErrorDomain code:RFNSNetworkCancelledError userInfo:networkErrorUserInfo];
        }
        
        else
        {
            networkErrorUserInfo = [[NSMutableDictionary alloc] init];
            [networkErrorUserInfo setObject:@"An internal error request." forKey:NSLocalizedDescriptionKey];
            [networkErrorUserInfo setObject:error forKey:NSUnderlyingErrorKey];
            
            networkError = [[NSError alloc] initWithDomain:RFNSNetworkErrorDomain code:RFNSNetworkInternalErrorCode userInfo:networkErrorUserInfo];
        }
        
        self.error = networkError;
        
        NSInvocation *invocation = [self delegateInvocationWithConformsToProtocol:@protocol(RFNSURLConnectionDelegate) respondsToSelector:@selector(connection:didFailWithError:)];
        
        if (invocation)
        {
            RFNSURLConnection *urlConnection = self;
            
            [invocation setArgument:&urlConnection atIndex:2];
            [invocation setArgument:&mError atIndex:3];
            
            [invocation retainArguments];
            
            [self performInvocationOnSyncThread:invocation];
        }
    }
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    if (connection && (connection == mCompiledURLConnection))
    {
        return YES;
    }
    
    return YES;
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if (connection && (connection == mCompiledURLConnection))
    {
        if ([challenge previousFailureCount] == 0)
        {
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        }
        
        else
        {
            [[challenge sender] cancelAuthenticationChallenge:challenge];
        }
    }
}

// Deprecated authentication delegates.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    if (connection && (connection == mCompiledURLConnection))
    {
        NSString *authenticationMethod = [protectionSpace authenticationMethod];
        
        if ([authenticationMethod isEqual:NSURLAuthenticationMethodClientCertificate] ||
            [authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        {
            return NO;
        }
        
        return YES;
    }
    
    NSString *authenticationMethod = [protectionSpace authenticationMethod];
    
    if ([authenticationMethod isEqual:NSURLAuthenticationMethodClientCertificate] ||
        [authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        return NO;
    }
    
    return YES;
}

// Deprecated authentication delegates.
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if (connection && (connection == mCompiledURLConnection))
    {
        if ([challenge previousFailureCount] == 0)
        {
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        }
        
        else
        {
            [[challenge sender] cancelAuthenticationChallenge:challenge];
        }
    }
}

// Deprecated authentication delegates.
- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
#pragma unused(challenge)
    
    if (connection && (connection == mCompiledURLConnection))
    {
    }
}

@end
