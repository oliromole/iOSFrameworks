//
//  RFNSURLConnection.h
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

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSOperation.h>
#import <Foundation/NSURLConnection.h>

@class NSError;
@class NSHTTPURLResponse;
@class NSInputStream;
@class NSMutableData;
@class NSMutableDictionary;
@class NSMutableString;
@class NSMutableURLRequest;
@class NSOutputStream;
@class NSString;
@class NSURLConnection;
@class NSThread;

@protocol RFNSURLConnectionDelegate;

@class RFUILocalNetworkActivityIndicator;
@class RFNSNetwork;

@interface RFNSURLConnection : NSOperation <NSURLConnectionDataDelegate>
{
@protected
    
    // Delegate
    id<RFNSURLConnectionDelegate> __weak mDelegate;
    
    // Network
    RFNSNetwork __weak *mNetwork;
    
    // Network Activity Indicator
    BOOL                               mIsNetworkActivityIndicatorShown;
    RFUILocalNetworkActivityIndicator *mLocalNetworkActivityIndicator;
    
    // Error
    NSError                           *mError;
    
    // URL Connection Information
    NSMutableDictionary               *mURLConnectionDictionary;
    
    // URL
    NSURL                             *mBaseURL;
    NSMutableString                   *mBaseURLString;
    NSURL                             *mCompiledURL;
    BOOL                               mNeedsCompileURL;
    NSMutableString                   *mRelativeURLString;
    NSURL                             *mURL;
    NSMutableDictionary               *mURLQuery;
    NSMutableString                   *mURLQueryString;
    NSMutableString                   *mURLString;
    
    // Input
    NSInputStream                     *mCompiledInputStream;
    long long                          mCompiledInputStreamLength;
    NSMutableData                     *mInputData;
    NSString                          *mInputFile;
    NSInputStream                     *mInputStream;
    NSURL                             *mInputURL;
    BOOL                               mNeedsCompileInputStream;
    BOOL                               mNeedsOpenInputStream;
    
    // URL Request
    NSMutableURLRequest               *mCompiledURLRequest;
    BOOL                               mNeedsCompileURLRequest;
    NSMutableURLRequest               *mURLRequest;
    
    // HTTP/HTTPS
    NSMutableDictionary               *mHTTPHeaderFields;
    NSMutableString                   *mHTTPMethod;
    BOOL                               mHTTPShouldHandleCookies;
    BOOL                               mHTTPShouldUsePipelining;
    BOOL                               mNeedsConfigureHTTP;
    
    // URL Connection
    NSURLConnection                   *mCompiledURLConnection;
    BOOL                               mIsCompiledURLConnectionCancelled;
    BOOL                               mNeedsCompileURLConnection;
    NSURLConnection                   *mURLConnection;
    
    // Response
    NSURLResponse                     *mURLResponse;
    NSHTTPURLResponse                 *mHTTPURLResponse;
    
    // Output
    NSOutputStream                    *mCompiledOutputStream;
    BOOL                               mOutputAppend;
    long long int                      mOutputBytes;
    long long int                      mOutputBytesWritten;
    NSMutableData                     *mOutputData;
    NSString                          *mOutputPath;
    NSOutputStream                    *mOutputStream;
    NSURL                             *mOutputURL;
    BOOL                               mNeedsCompileOutputStream;
    BOOL                               mNeedsOpenOutputStream;
    
    // Operation status
    BOOL                               mIsConcurrent;
    BOOL                               mIsExecuting;
    BOOL                               mIsFinished;
    
    // Synchronization
    NSThread                          *mDelegateThread;
    BOOL                               mIsDelegateSynchronized;
    NSThread                          *mStartThread;
}

// Configuring a URL Connection

+ (Class)urlRequest;
+ (Class)urlConnection;

// Managing the delegate

@property (nonatomic, weak) id<RFNSURLConnectionDelegate> delegate;

// Managing the Network

@property (nonatomic, weak) RFNSNetwork *network;

// Managing Network Activity Indicator

@property (nonatomic, strong) RFUILocalNetworkActivityIndicator *localNetworkActivityIndicator;

// Managing the Error

@property (nonatomic, strong) NSError *error;

// Managing the URL Connection Information

@property (nonatomic, strong) NSMutableDictionary *urlConnectionDictionary; // Default is nil. The first time the property is accessed, the NSMutableDictionary is created.

// Managing the URL

@property (nonatomic, strong)                              NSURL               *baseURL;           // Default is nil.
@property (nonatomic, strong)                              NSMutableString     *baseURLString;     // Default is nil. The first time the property is accessed, the NSMutableString is created.
@property (nonatomic, strong)                              NSURL               *compiledURL;       // Default is nil.
@property (nonatomic)                                      BOOL                 needsCompileURL;   // Default is YES.
@property (nonatomic, strong)                              NSMutableString     *relativeURLString; // Default is nil. The first time the property is accessed, the NSMutableString is created.
@property (nonatomic, strong, setter = setURL:)            NSURL               *url;               // Default is nil.
@property (nonatomic, strong, setter = setURLQuery:)       NSMutableDictionary *urlQuery;          // Default is nil. The first time the property is accessed, the NSMutableDictionary is created.
@property (nonatomic, strong, setter = setURLQueryString:) NSMutableString     *urlQueryString;    // Default is nil. The first time the property is accessed, the NSMutableString is created.
@property (nonatomic, strong, setter = setURLString:)      NSMutableString     *urlString;         // Default is nil. The first time the property is accessed, the NSMutableString is created.

- (BOOL)shouldCompileURL;
- (void)compileURL;

// Managing the Input Stream

@property (nonatomic, strong) NSInputStream *compiledInputStream;     // Default is nil.
@property (nonatomic, strong) NSMutableData *inputData;               // Default is nil. The first time the property is accessed, the NSMutableData is created.
@property (nonatomic, strong) NSString      *inputFile;               // Default is nil.
@property (nonatomic, strong) NSInputStream *inputStream;             // Default is nil.
@property (nonatomic, strong) NSURL         *inputURL;                // Default is nil.
@property (nonatomic)         BOOL           needsCompileInputStream; // Default is YES.
@property (nonatomic)         BOOL           needsOpenInputStream;    // Default is YES.

- (BOOL)shouldCompileInputStream;
- (void)compileInputStream;

- (BOOL)shouldOpenInputStream;
- (void)openInputStream;

// Managing the URL Request

@property (nonatomic, strong)                          NSMutableURLRequest *compiledURLRequest;     // Default is nil.
@property (nonatomic)                                  BOOL                 needsCompileURLRequest; // Default is YES.
@property (nonatomic, strong, setter = setURLRequest:) NSMutableURLRequest *urlRequest;             // Default is nil.

- (BOOL)shouldCompileURLRequest;
- (void)compileURLRequest;

// Configuring HTTP/HTTPS Protocol

@property (nonatomic, strong, setter = setHTTPHeaderFields:) NSMutableDictionary *httpHeaderFields;        // Default is nil.  The first time the property is accessed, the NSMutableDictionary is created.
@property (nonatomic, strong, setter = setHTTPMethod:)       NSMutableString     *httpMethod;              // Default is nil.  The first time the property is accessed, the NSMutableString is created.
@property (nonatomic, setter = setHTTPShouldHandleCookies:)  BOOL                 httpShouldHandleCookies; // Default is YES.
@property (nonatomic, setter = setHTTPShouldUsePipelining:)  BOOL                 httpShouldUsePipelining; // Default is YES.
@property (nonatomic)                                        BOOL                 needsConfigureHTTP;      // Default is YES.

- (BOOL)shouldConfigureHTTP;
- (void)configureHTTP;

// Managing the URL Connection

@property (nonatomic, strong)                             NSURLConnection *compiledURLConnection;     // Default is nil.
@property (nonatomic)                                     BOOL             needsCompileURLConnection; // Default is YES.
@property (nonatomic, strong, setter = setURLConnection:) NSURLConnection *urlConnection;             // Default is nil.

- (BOOL)shouldCompileURLConnection;
- (void)compileURLConnection;

- (void)willBeginStartingURLConnection;
- (void)didBeginStartingURLConnection;

// Managing the Response

@property (nonatomic, strong)                               NSURLResponse     *urlResponse;
@property (nonatomic, strong, setter = setHTTPURLResponse:) NSHTTPURLResponse *httpURLResponse;

// Managing the Output Stream

@property (nonatomic, strong) NSOutputStream *compiledOutputStream;      // Default is nil.
@property (nonatomic)         long long       compiledInputStreamLength; // Default is -1.
@property (nonatomic)         BOOL            outputAppend;              // Default is NO.
@property (nonatomic)         long long int   outputBytes;               // Default is 0.
@property (nonatomic)         long long int   outputBytesWritten;        // Default is 0.
@property (nonatomic, strong) NSMutableData  *outputData;                // Default is nil.
@property (nonatomic, strong) NSString       *outputPath;                // Default is nil.
@property (nonatomic, strong) NSOutputStream *outputStream;              // Default is nil.
@property (nonatomic, strong) NSURL          *outputURL;                 // Default is nil.
@property (nonatomic)         BOOL            needsCompileOutputStream;  // Default is YES.
@property (nonatomic)         BOOL            needsOpenOutputStream;     // Default is YES.

- (BOOL)shouldCompileOutputStream;
- (void)compileOutputStream;

- (BOOL)shouldOpenOutputStream;
- (void)openOutputStream;

// Managing the operation status

- (void)setIsConcurrent:(BOOL)isConcurrent;
- (void)setIsExecuting:(BOOL)isExecuting;
- (void)setIsFinished:(BOOL)isFinished;

// Managing the Synchronization

@property (nonatomic, strong)                            NSThread *delegateThread;
@property (nonatomic, setter = setDelegateSynchronized:) BOOL      isDelegateSynchronized; // Default is YES;
@property (nonatomic, strong)                            NSThread *startThread;

- (NSThread *)syncThread;

- (NSInvocation *)delegateInvocationWithSelector:(SEL)selector;
- (NSInvocation *)delegateInvocationWithConformsToProtocol:(Protocol *)protocol respondsToSelector:(SEL)selector;
- (NSInvocation *)delegateInvocationWithRespondsToSelector:(SEL)selector;

- (void)performInvocationOnSyncThread:(NSInvocation *)invocation waitUntilDone:(BOOL)wait modes:(NSArray *)modes;
- (void)performInvocationOnSyncThread:(NSInvocation *)invocation waitUntilDone:(BOOL)wait;
- (void)performInvocationOnSyncThread:(NSInvocation *)invocation;

// Loading data

- (void)startAsSynchronous;
- (void)startAsAsynchronous;

@end
