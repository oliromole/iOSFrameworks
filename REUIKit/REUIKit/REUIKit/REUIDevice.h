//
//  REUIDevice.h
//  REUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.05.10.
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
#import <UIKit/UIDevice.h>

@class NSString;

@interface UIDevice (UIDeviceREUIDevice)

// Getting the Hardware Information.

+ (NSString *)hardwareMachine; // The machine class. The method returns nil if it can not get machine class.
+ (NSString *)hardwareModel;   // The machine model. The method returns nil if it can not get machine model.

// Identifying the Device and Operating System

+ (BOOL)isSystemVersionGraterThanOrEqualTo_5_0;   // See also: http://support.apple.com/kb/DL1456
+ (BOOL)isSystemVersionGraterThanOrEqualTo_5_0_1; // See also: http://support.apple.com/kb/DL1472
+ (BOOL)isSystemVersionGraterThanOrEqualTo_5_1;   // See also: http://support.apple.com/kb/DL1504
+ (BOOL)isSystemVersionGraterThanOrEqualTo_5_1_1; // See also: http://support.apple.com/kb/DL1521
+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_0;   // See also: http://support.apple.com/kb/DL1578
+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_0_1; // See also: http://support.apple.com/kb/DL1606
+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_0_2; // See also: http://support.apple.com/kb/DL1621
+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1;   // See also: http://support.apple.com/kb/DL1624
+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1_1; // See also: http://support.apple.com/kb/DL1631
+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1_2; // See also: http://support.apple.com/kb/DL1639
+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1_3; // See also: http://support.apple.com/kb/DL1646
+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1_4; // See also: http://support.apple.com/kb/DL1652
+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1_5; // See also: http://support.apple.com/kb/DL1702
+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1_6; // See also: http://support.apple.com/kb/DL1722
+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0;   // See also: http://support.apple.com/kb/DL1682
+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0_1; // See also: http://support.apple.com/kb/DL1683
+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0_2; // See also: http://support.apple.com/kb/DL1685
+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0_3; // See also: http://support.apple.com/kb/DL1691
+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0_4; // See also: http://support.apple.com/kb/DL1701
+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0_5; // See also: http://support.apple.com/kb/DL1718
+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0_6; // See also: http://support.apple.com/kb/DL1723

@end
