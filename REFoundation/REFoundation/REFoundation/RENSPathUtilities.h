//
//  RENSPathUtilities.h
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

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>

@class NSString;
@class NSURL;

//
// See also:
// https://developer.apple.com/library/ios/#documentation/FileManagement/Conceptual/FileSystemProgrammingGUide/FileSystemOverview/FileSystemOverview.html
// https://developer.apple.com/library/ios/#documentation/FileManagement/Conceptual/FileSystemProgrammingGUide/MacOSXDirectories/MacOSXDirectories.html
//

FOUNDATION_EXPORT NSString *RENSHomeDirectoryPath(BOOL expandTilde);                             // Returning the abbreviated/expanded "~" path.
FOUNDATION_EXPORT NSURL    *RENSHomeDirectoryURL(void);                                          // Returning the expanded "~" path as URL.
FOUNDATION_EXPORT NSString *RENSApplicationDirectoryPathInUserDomain(BOOL expandTilde);          // Returning the abbreviated/expanded "~/Applications" path.
FOUNDATION_EXPORT NSURL    *RENSApplicationDirectoryURLInUserDomain(void);                       // Returning the expanded "~/Applications" path as URL.
FOUNDATION_EXPORT NSString *RENSDemoApplicationDirectoryPathInUserDomain(BOOL expandTilde);      // Returning the abbreviated/expanded "~/Applications/Demos" path.
FOUNDATION_EXPORT NSURL    *RENSDemoApplicationDirectoryURLInUserDomain(void);                   // Returning the expanded "~/Applications/Demos" path as URL.
FOUNDATION_EXPORT NSString *RENSAdminApplicationDirectoryPathInUserDomain(BOOL expandTilde);     // Returning the abbreviated/expanded "~/Applications/Utilities" path.
FOUNDATION_EXPORT NSURL    *RENSAdminApplicationDirectoryURLInUserDomain(void);                  // Returning the expanded "~/Applications/Utilities" path as URL.
FOUNDATION_EXPORT NSString *RENSDesktopDirectoryPathInUserDomain(BOOL expandTilde);              // Returning the abbreviated/expanded "~/Desktop" path.
FOUNDATION_EXPORT NSURL    *RENSDesktopDirectoryURLInUserDomain(void);                           // Returning the expanded "~/Desktop" path as URL.
FOUNDATION_EXPORT NSString *RENSDeveloperDirectoryPathInUserDomain(BOOL expandTilde);            // Returning the abbreviated/expanded "~/Developer" path.
FOUNDATION_EXPORT NSURL    *RENSDeveloperDirectoryURLInUserDomain(void);                         // Returning the expanded "~/Developer" path as URL.
FOUNDATION_EXPORT NSString *RENSDeveloperApplicationDirectoryPathInUserDomain(BOOL expandTilde); // Returning the abbreviated/expanded "~/Developer/Applications" path.
FOUNDATION_EXPORT NSURL    *RENSDeveloperApplicationDirectoryURLInUserDomain(void);              // Returning the expanded "~/Developer/Applications" path as URL.
FOUNDATION_EXPORT NSString *RENSDocumentDirectoryPathInUserDomain(BOOL expandTilde);             // Returning the abbreviated/expanded "~/Documents" path.
FOUNDATION_EXPORT NSURL    *RENSDocumentDirectoryURLInUserDomain(void);                          // Returning the expanded "~/Documents" path as URL.
FOUNDATION_EXPORT NSString *RENSInboxDirectoryPathInUserDomain(BOOL expandTilde);                // Returning the abbreviated/expanded "~/Documents/Inbox" path.
FOUNDATION_EXPORT NSURL    *RENSInboxDirectoryURLInUserDomain(void);                             // Returning the expanded "~/Documents/Inbox" path as URL.
FOUNDATION_EXPORT NSString *RENSDownloadsDirectoryPathInUserDomain(BOOL expandTilde);            // Returning the abbreviated/expanded "~/Downloads" path.
FOUNDATION_EXPORT NSURL    *RENSDownloadsDirectoryURLInUserDomain(void);                         // Returning the expanded "~/Downloads" path as URL.
FOUNDATION_EXPORT NSString *RENSLibraryDirectoryPathInUserDomain(BOOL expandTilde);              // Returning the abbreviated/expanded "~/Library" path.
FOUNDATION_EXPORT NSURL    *RENSLibraryDirectoryURLInUserDomain(void);                           // Returning the expanded "~/Library" path as URL.
FOUNDATION_EXPORT NSString *RENSApplicationDataDirectoryPathInUserDomain(BOOL expandTilde);      // Returning the abbreviated/expanded "~/Library/Application Data" path.
FOUNDATION_EXPORT NSURL    *RENSApplicationDataDirectoryURLInUserDomain(void);                   // Returning the expanded "~/Library/Application Data" path as URL.
FOUNDATION_EXPORT NSString *RENSApplicationSupportDirectoryPathInUserDomain(BOOL expandTilde);   // Returning the abbreviated/expanded "~/Library/Application Support" path.
FOUNDATION_EXPORT NSURL    *RENSApplicationSupportDirectoryURLInUserDomain(void);                // Returning the expanded "~/Library/Application Support" path as URL.
FOUNDATION_EXPORT NSString *RENSAutosavedInformationDirectoryPathInUserDomain(BOOL expandTilde); // Returning the abbreviated/expanded "~/Library/Autosave Information" path.
FOUNDATION_EXPORT NSURL    *RENSAutosavedInformationDirectoryURLInUserDomain(void);              // Returning the expanded "~/Library/Autosave Information" path as URL.
FOUNDATION_EXPORT NSString *RENSCachesDirectoryPathInUserDomain(BOOL expandTilde);               // Returning the abbreviated/expanded "~/Library/Caches" path.
FOUNDATION_EXPORT NSURL    *RENSCachesDirectoryURLInUserDomain(void);                            // Returning the expanded "~/Library/Caches" path as URL.
FOUNDATION_EXPORT NSString *RENSCookiesDirectoryPathInUserDomain(BOOL expandTilde);              // Returning the abbreviated/expanded "~/Library/Cookies" path.
FOUNDATION_EXPORT NSURL    *RENSCookiesDirectoryURLInUserDomain(void);                           // Returning the expanded "~/Library/Cookies" path as URL.
FOUNDATION_EXPORT NSString *RENSDocumentationDirectoryPathInUserDomain(BOOL expandTilde);        // Returning the abbreviated/expanded "~/Library/Documentation" path.
FOUNDATION_EXPORT NSURL    *RENSDocumentationDirectoryURLInUserDomain(void);                     // Returning the expanded "~/Library/Documentation" path as URL.
FOUNDATION_EXPORT NSString *RENSFrameworksDirectoryPathInUserDomain(BOOL expandTilde);           // Returning the abbreviated/expanded "~/Library/Frameworks" path.
FOUNDATION_EXPORT NSURL    *RENSFrameworksDirectoryURLInUserDomain(void);                        // Returning the expanded "~/Library/Frameworks" path as URL.
FOUNDATION_EXPORT NSString *RENSInputMethodsDirectoryPathInUserDomain(BOOL expandTilde);         // Returning the abbreviated/expanded "~/Library/Input Methods" path.
FOUNDATION_EXPORT NSURL    *RENSInputMethodsDirectoryURLInUserDomain(void);                      // Returning the expanded "~/Library/Input Methods" path as URL.
FOUNDATION_EXPORT NSString *RENSPreferencePanesDirectoryPathInUserDomain(BOOL expandTilde);      // Returning the abbreviated/expanded "~/Library/PreferencePanes" path.
FOUNDATION_EXPORT NSURL    *RENSPreferencePanesDirectoryURLInUserDomain(void);                   // Returning the expanded "~/Library/PreferencePanes" path as URL.
FOUNDATION_EXPORT NSString *RENSPreferencesDirectoryPathInUserDomain(BOOL expandTilde);          // Returning the abbreviated/expanded "~/Library/Preferences" path.
FOUNDATION_EXPORT NSURL    *RENSPreferencesDirectoryURLInUserDomain(void);                       // Returning the expanded "~/Library/Preferences" path as URL.
FOUNDATION_EXPORT NSString *RENSMoviesDirectoryPathInUserDomain(BOOL expandTilde);               // Returning the abbreviated/expanded "~/Movies" path.
FOUNDATION_EXPORT NSURL    *RENSMoviesDirectoryURLInUserDomain(void);                            // Returning the expanded "~/Movies" path as URL.
FOUNDATION_EXPORT NSString *RENSMusicDirectoryPathInUserDomain(BOOL expandTilde);                // Returning the abbreviated/expanded "~/Music" path.
FOUNDATION_EXPORT NSURL    *RENSMusicDirectoryURLInUserDomain(void);                             // Returning the expanded "~/Music" path as URL.
FOUNDATION_EXPORT NSString *RENSPicturesDirectoryPathInUserDomain(BOOL expandTilde);             // Returning the abbreviated/expanded "~/Pictures" path.
FOUNDATION_EXPORT NSURL    *RENSPicturesDirectoryURLInUserDomain(void);                          // Returning the expanded "~/Pictures" path as URL.
FOUNDATION_EXPORT NSString *RENSSharedPublicDirectoryPathInUserDomain(BOOL expandTilde);         // Returning the abbreviated/expanded "~/Public" path.
FOUNDATION_EXPORT NSURL    *RENSSharedPublicDirectoryURLInUserDomain(void);                      // Returning the expanded "~/Public" path as URL.
FOUNDATION_EXPORT NSString *RENSTemporaryDirectoryPathInUserDomain(BOOL expandTilde);            // Returning the abbreviated/expanded "~/tmp" path.
FOUNDATION_EXPORT NSURL    *RENSTemporaryDirectoryURLInUserDomain(void);                         // Returning the expanded "~/tmp" path as URL.
