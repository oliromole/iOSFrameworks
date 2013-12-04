//
//  RENSPathUtilities.m
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.05.24.
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
#import "RENSPathUtilities.h"

// Importing the project headers.
#import "RENSObject.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

NSString * RENSPathUtilities_RENSHomeDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSHomeDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~" path.
NSString *RENSHomeDirectoryPath(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSHomeDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSHomeDirectoryPathInUserDomain_ExpandedTilde)
                {
                    RENSPathUtilities_RENSHomeDirectoryPathInUserDomain_ExpandedTilde = [NSHomeDirectory() copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSHomeDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSHomeDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSHomeDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    RENSPathUtilities_RENSHomeDirectoryPathInUserDomain_AbbreviatedTilde = @"~";
                }
            }
        }
        
        return RENSPathUtilities_RENSHomeDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSHomeDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~" path as URL.
NSURL *RENSHomeDirectoryURL(void)
{
    if (!RENSPathUtilities_RENSHomeDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSHomeDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *homeDirectoryPath = RENSHomeDirectoryPath(YES);
                RENSPathUtilities_RENSHomeDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:homeDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSHomeDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSApplicationDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSApplicationDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Applications" path.
NSString *RENSApplicationDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSApplicationDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSApplicationDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSApplicationDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Applications"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSApplicationDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSApplicationDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSApplicationDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSApplicationDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Applications"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSApplicationDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSApplicationDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Applications" path as URL.
NSURL *RENSApplicationDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSApplicationDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSApplicationDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *applicationDirectoryPath = RENSApplicationDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSApplicationDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:applicationDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSHomeDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSDemoApplicationDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSDemoApplicationDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Applications/Demos" path.
NSString *RENSDemoApplicationDirectoryPathInUserDomain(BOOL expandTilde)
{
    
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSDemoApplicationDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDemoApplicationDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDemoApplicationDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Applications/Demos"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDemoApplicationDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSDemoApplicationDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDemoApplicationDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDemoApplicationDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Applications/Demos"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDemoApplicationDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSDemoApplicationDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Applications/Demos" path as URL.
NSURL *RENSDemoApplicationDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSDemoApplicationDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSDemoApplicationDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *demoApplicationDirectoryPath = RENSDemoApplicationDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSDemoApplicationDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:demoApplicationDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSDemoApplicationDirectoryURLInUserDomain_ExpandedTilde;
};

NSString * RENSPathUtilities_RENSAdminApplicationDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSAdminApplicationDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Applications/Utilities" path.
NSString *RENSAdminApplicationDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSAdminApplicationDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSAdminApplicationDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSAdminApplicationDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Applications/Utilities"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSAdminApplicationDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSAdminApplicationDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSAdminApplicationDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSAdminApplicationDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Applications/Utilities"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSAdminApplicationDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSAdminApplicationDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Applications/Utilities" path as URL.
NSURL *RENSAdminApplicationDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSAdminApplicationDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSAdminApplicationDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *adminApplicationDirectoryPath = RENSAdminApplicationDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSAdminApplicationDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:adminApplicationDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSAdminApplicationDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSDesktopDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSDesktopDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Desktop" path.
NSString *RENSDesktopDirectoryPathInUserDomain(BOOL expandTilde)
{
    
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSDesktopDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDesktopDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDesktopDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Desktop"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDesktopDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSDesktopDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDesktopDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDesktopDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Desktop"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDesktopDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSDesktopDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Desktop" path as URL.
NSURL *RENSDesktopDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSDesktopDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSDesktopDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *desktopDirectoryPath = RENSDesktopDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSDesktopDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:desktopDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSDesktopDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSDeveloperDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSDeveloperDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Developer" path.
NSString *RENSDeveloperDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSDeveloperDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDeveloperDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDeveloperDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Developer"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDeveloperDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSDeveloperDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDeveloperDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDeveloperDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Developer"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDeveloperDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSDeveloperDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Developer" path as URL.
NSURL *RENSDeveloperDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSDeveloperDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSDeveloperDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *developerDirectoryPath = RENSDeveloperDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSDeveloperDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:developerDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSDeveloperDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSDeveloperApplicationDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSDeveloperApplicationDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Developer/Applications" path.
NSString *RENSDeveloperApplicationDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSDeveloperApplicationDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDeveloperApplicationDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDeveloperApplicationDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Developer/Applications"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDeveloperApplicationDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSDeveloperApplicationDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDeveloperApplicationDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDeveloperApplicationDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Developer/Applications"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDeveloperApplicationDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSDeveloperApplicationDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Developer/Applications" path as URL.
NSURL *RENSDeveloperApplicationDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSDeveloperApplicationDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSDeveloperApplicationDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *developerApplicationDirectoryPath = RENSDeveloperApplicationDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSDeveloperApplicationDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:developerApplicationDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSDeveloperApplicationDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSDocumentDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSDocumentDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Documents" path.
NSString *RENSDocumentDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSDocumentDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDocumentDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDocumentDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Documents"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDocumentDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSDocumentDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDocumentDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDocumentDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Documents"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDocumentDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSDocumentDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Documents" path as URL.
NSURL *RENSDocumentDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSDocumentDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSDocumentDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *documentDirectoryPath = RENSDocumentDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSDocumentDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:documentDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSDocumentDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSInboxDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSInboxDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Documents/Inbox" path.
NSString *RENSInboxDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSInboxDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSInboxDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSInboxDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Documents/Inbox"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSInboxDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSInboxDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSInboxDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSInboxDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Documents/Inbox"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSInboxDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSInboxDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Documents/Inbox" path as URL.
NSURL *RENSInboxDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSInboxDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSInboxDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *inboxDirectoryPath = RENSInboxDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSInboxDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:inboxDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSInboxDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSDownloadsDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSDownloadsDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Downloads" path.
NSString *RENSDownloadsDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSDownloadsDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDownloadsDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDownloadsDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Downloads"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDownloadsDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSDownloadsDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDownloadsDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDownloadsDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Downloads"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDownloadsDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSDownloadsDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Downloads" path as URL.
NSURL *RENSDownloadsDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSDownloadsDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSDownloadsDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *downloadsDirectoryPath = RENSDownloadsDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSDownloadsDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:downloadsDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSDownloadsDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSLibraryDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSLibraryDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Library" path.
NSString *RENSLibraryDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSLibraryDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSLibraryDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSLibraryDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSLibraryDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSLibraryDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSLibraryDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSLibraryDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSLibraryDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSLibraryDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Library" path as URL.
NSURL *RENSLibraryDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSLibraryDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSLibraryDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *libraryDirectoryPath = RENSLibraryDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSLibraryDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:libraryDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSLibraryDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSApplicationDataDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSApplicationDataDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Library/Application Data" path.
NSString *RENSApplicationDataDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSApplicationDataDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSApplicationDataDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSApplicationDataDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Application Data"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSApplicationDataDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSApplicationDataDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSApplicationDataDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSApplicationDataDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Application Data"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSApplicationDataDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSApplicationDataDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Library/Application Data" path as URL.
NSURL *RENSApplicationDataDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSApplicationDataDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSApplicationDataDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *applicationDataDirectoryPath = RENSApplicationDataDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSApplicationDataDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:applicationDataDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSApplicationDataDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSApplicationSupportDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSApplicationSupportDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Library/Application Support" path.
NSString *RENSApplicationSupportDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSApplicationSupportDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSApplicationSupportDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSApplicationSupportDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Application Support"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSApplicationSupportDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSApplicationSupportDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSApplicationSupportDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSApplicationSupportDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Application Support"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSApplicationSupportDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSApplicationSupportDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Library/Application Support" path as URL.
NSURL *RENSApplicationSupportDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSApplicationSupportDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSApplicationSupportDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *applicationSupportDirectoryPath = RENSApplicationSupportDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSApplicationSupportDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:applicationSupportDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSApplicationSupportDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSAutosavedInformationDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSAutosavedInformationDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Library/Autosave Information" path.
NSString *RENSAutosavedInformationDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSAutosavedInformationDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSAutosavedInformationDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSAutosavedInformationDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Autosave Information"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSAutosavedInformationDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSAutosavedInformationDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSAutosavedInformationDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSAutosavedInformationDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Autosave Information"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSAutosavedInformationDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSAutosavedInformationDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Library/Autosave Information" path as URL.
NSURL *RENSAutosavedInformationDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSAutosavedInformationDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSAutosavedInformationDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *autosavedInformationDirectoryPath = RENSAutosavedInformationDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSAutosavedInformationDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:autosavedInformationDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSAutosavedInformationDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSCachesDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSCachesDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Library/Caches" path.
NSString *RENSCachesDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSCachesDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSCachesDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSCachesDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Caches"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSCachesDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSCachesDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSCachesDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSCachesDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Caches"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSCachesDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSCachesDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Library/Caches" path as URL.
NSURL *RENSCachesDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSCachesDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSCachesDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *cachesDirectoryPath = RENSCachesDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSCachesDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:cachesDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSCachesDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSCookiesDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSCookiesDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Library/Cookies" path.
NSString *RENSCookiesDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSCookiesDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSCookiesDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSCookiesDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Cookies"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSCookiesDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSCookiesDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSCookiesDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSCookiesDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Cookies"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSCookiesDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSCookiesDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Library/Cookies" path as URL.
NSURL *RENSCookiesDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSCookiesDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSCookiesDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *cookiesDirectoryPath = RENSCookiesDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSCookiesDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:cookiesDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSCookiesDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSDocumentationDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSDocumentationDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Library/Documentation" path.
NSString *RENSDocumentationDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSDocumentationDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDocumentationDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDocumentationDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Documentation"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDocumentationDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSDocumentationDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSDocumentationDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSDocumentationDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Documentation"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSDocumentationDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSDocumentationDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Library/Documentation" path as URL.
NSURL *RENSDocumentationDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSDocumentationDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSDocumentationDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *documentationDirectoryPath = RENSDocumentationDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSDocumentationDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:documentationDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSDocumentationDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSFrameworksDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSFrameworksDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Library/Frameworks" path.
NSString *RENSFrameworksDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSFrameworksDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSFrameworksDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSFrameworksDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Frameworks"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSFrameworksDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSFrameworksDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSFrameworksDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSFrameworksDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Frameworks"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSFrameworksDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSFrameworksDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Library/Frameworks" path as URL.
NSURL *RENSFrameworksDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSFrameworksDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSFrameworksDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *frameworksDirectoryPath = RENSFrameworksDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSFrameworksDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:frameworksDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSFrameworksDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSInputMethodsDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSInputMethodsDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Library/Input Methods" path.
NSString *RENSInputMethodsDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSInputMethodsDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSInputMethodsDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSInputMethodsDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Input Methods"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSInputMethodsDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSInputMethodsDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSInputMethodsDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSInputMethodsDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Input Methods"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSInputMethodsDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSInputMethodsDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Library/Input Methods" path as URL.
NSURL *RENSInputMethodsDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSInputMethodsDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSInputMethodsDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *inputMethodsDirectoryPath = RENSInputMethodsDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSInputMethodsDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:inputMethodsDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSInputMethodsDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSPreferencePanesDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSPreferencePanesDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Library/PreferencePanes" path.
NSString *RENSPreferencePanesDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSPreferencePanesDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSPreferencePanesDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSPreferencePanesDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/PreferencePanes"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSPreferencePanesDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSPreferencePanesDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSPreferencePanesDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSPreferencePanesDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/PreferencePanes"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSPreferencePanesDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSPreferencePanesDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Library/PreferencePanes" path as URL.
NSURL *RENSPreferencePanesDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSPreferencePanesDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSPreferencePanesDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *preferencePanesDirectoryPath = RENSPreferencePanesDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSPreferencePanesDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:preferencePanesDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSPreferencePanesDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSPreferencesDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSPreferencesDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Library/Preferences" path.
NSString *RENSPreferencesDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSPreferencesDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSPreferencesDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSPreferencesDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Preferences"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSPreferencesDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSPreferencesDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSPreferencesDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSPreferencesDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Library/Preferences"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSPreferencesDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSPreferencesDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Library/Preferences" path as URL.
NSURL *RENSPreferencesDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSPreferencesDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSPreferencesDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *preferencesDirectoryPath = RENSPreferencesDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSPreferencesDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:preferencesDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSPreferencesDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSMoviesDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSMoviesDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Movies" path.
NSString *RENSMoviesDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSMoviesDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSMoviesDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSMoviesDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Movies"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSMoviesDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSMoviesDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSMoviesDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSMoviesDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Movies"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSMoviesDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSMoviesDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Movies" path as URL.
NSURL *RENSMoviesDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSMoviesDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSMoviesDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *moviesDirectoryPath = RENSMoviesDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSMoviesDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:moviesDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSMoviesDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSMusicDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSMusicDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Music" path.
NSString *RENSMusicDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSMusicDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSMusicDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSMusicDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Music"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSMusicDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSMusicDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSMusicDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSMusicDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Music"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSMusicDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSMusicDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Music" path as URL.
NSURL *RENSMusicDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSMusicDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSMusicDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *musicDirectoryPath = RENSMusicDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSMusicDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:musicDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSMusicDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSPicturesDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSPicturesDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Pictures" path.
NSString *RENSPicturesDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSPicturesDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSPicturesDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSPicturesDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Pictures"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSPicturesDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSPicturesDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSPicturesDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSPicturesDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Pictures"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSPicturesDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSPicturesDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Pictures" path as URL.
NSURL *RENSPicturesDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSPicturesDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSPicturesDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *picturesDirectoryPath = RENSPicturesDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSPicturesDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:picturesDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSPicturesDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSSharedPublicDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSSharedPublicDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/Public" path.
NSString *RENSSharedPublicDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSSharedPublicDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSSharedPublicDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSSharedPublicDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Public"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSSharedPublicDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSSharedPublicDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSSharedPublicDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSSharedPublicDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"Public"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSSharedPublicDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSSharedPublicDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/Public" path as URL.
NSURL *RENSSharedPublicDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSSharedPublicDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSSharedPublicDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *sharedPublicDirectoryPath = RENSSharedPublicDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSSharedPublicDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:sharedPublicDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSSharedPublicDirectoryURLInUserDomain_ExpandedTilde;
}

NSString * RENSPathUtilities_RENSTemporaryDirectoryPathInUserDomain_AbbreviatedTilde = nil;
NSString * RENSPathUtilities_RENSTemporaryDirectoryPathInUserDomain_ExpandedTilde = nil;

// Returning the abbreviated/expanded "~/tmp" path.
NSString *RENSTemporaryDirectoryPathInUserDomain(BOOL expandTilde)
{
    if (expandTilde)
    {
        if (!RENSPathUtilities_RENSTemporaryDirectoryPathInUserDomain_ExpandedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSTemporaryDirectoryPathInUserDomain_ExpandedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSTemporaryDirectoryPathInUserDomain_ExpandedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"tmp"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSTemporaryDirectoryPathInUserDomain_ExpandedTilde;
    }
    
    else
    {
        if (!RENSPathUtilities_RENSTemporaryDirectoryPathInUserDomain_AbbreviatedTilde)
        {
            NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
            
            @synchronized(singletonSynchronizer)
            {
                if (!RENSPathUtilities_RENSTemporaryDirectoryPathInUserDomain_AbbreviatedTilde)
                {
                    NSString *homeDirectoryPath = RENSHomeDirectoryPath(expandTilde);
                    RENSPathUtilities_RENSTemporaryDirectoryPathInUserDomain_AbbreviatedTilde = [[homeDirectoryPath stringByAppendingPathComponent:@"tmp"] copy];
                }
            }
        }
        
        return RENSPathUtilities_RENSTemporaryDirectoryPathInUserDomain_AbbreviatedTilde;
    }
}

NSURL * RENSPathUtilities_RENSTemporaryDirectoryURLInUserDomain_ExpandedTilde = nil;

// Returning the expanded "~/tmp" path as URL.
NSURL *RENSTemporaryDirectoryURLInUserDomain(void)
{
    if (!RENSPathUtilities_RENSTemporaryDirectoryURLInUserDomain_ExpandedTilde)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!RENSPathUtilities_RENSTemporaryDirectoryURLInUserDomain_ExpandedTilde)
            {
                NSString *temporaryDirectoryPath = RENSTemporaryDirectoryPathInUserDomain(YES);
                RENSPathUtilities_RENSTemporaryDirectoryURLInUserDomain_ExpandedTilde = [[NSURL fileURLWithPath:temporaryDirectoryPath isDirectory:YES] absoluteURL];
            }
        }
    }
    
    return RENSPathUtilities_RENSTemporaryDirectoryURLInUserDomain_ExpandedTilde;
}
