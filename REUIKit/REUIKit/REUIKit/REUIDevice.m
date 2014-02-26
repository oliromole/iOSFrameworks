//
//  REUIDevice.m
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

// Importing the header.
#import "REUIDevice.h"

// Importing the project headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Importing the system headers.
#import <sys/sysctl.h>

NSString * volatile UIDevice_UIDeviceREUIDevice_HardwareMachine = nil;
NSString * volatile UIDevice_UIDeviceREUIDevice_HardwareModel = nil;

volatile BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersion_NeedsInitialize = YES;

BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_5_0 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_5_0_1 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_5_1 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_5_1_1 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_0 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_0_1 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_0_2 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_1 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_2 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_3 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_4 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_5 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_6 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_1 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_2 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_3 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_4 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_5 = NO;
BOOL UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_6 = NO;

BOOL *UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTos[] =
{
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_5_0,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_5_0_1,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_5_1,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_5_1_1,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_0,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_0_1,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_0_2,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_1,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_2,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_3,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_4,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_5,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_6,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_1,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_2,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_3,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_4,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_5,
    &UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_6,
};

NSInteger UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_Count = (sizeof(UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTos) / sizeof(UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTos[0]));

NSString *UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualToAsStrings[] =
{
    @"5",
    @"5.0.1",
    @"5.1",
    @"5.1.1",
    @"6",
    @"6.0.1",
    @"6.0.2",
    @"6.1",
    @"6.1.1",
    @"6.1.2",
    @"6.1.3",
    @"6.1.4",
    @"6.1.5",
    @"6.1.6",
    @"7",
    @"7.0.1",
    @"7.0.2",
    @"7.0.3",
    @"7.0.4",
    @"7.0.5",
    @"7.0.6",
};

void UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize(void);
void UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize()
{
    // We must inizialize the static variables.
    if (UIDevice_UIDeviceREUIDevice_IsSystemVersion_NeedsInitialize)
    {
        // Getting the Singleton Synchronizer instance.
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        // Locking the critical section.
        @synchronized(singletonSynchronizer)
        {
            // We must inizialize the static variables.
            if (UIDevice_UIDeviceREUIDevice_IsSystemVersion_NeedsInitialize)
            {
                // Getting the system version.
                NSString *systemVersion = [UIDevice currentDevice].systemVersion;
                
                // Calculating the values of the static variables.
                for (NSInteger UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_Index = 0; UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_Index < UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_Count; UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_Index++)
                {
                    // Calculating the value of the static variable.
                    *UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTos[UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_Index] = ([systemVersion compare:UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualToAsStrings[UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_Index] options:NSNumericSearch] >= NSOrderedSame);
                }
                
                // Resetting the flag to need to initialize the static variables.
                UIDevice_UIDeviceREUIDevice_IsSystemVersion_NeedsInitialize = NO;
            }
        }
    }
}

@implementation UIDevice (UIDeviceREUIDevice)

#pragma mark - Getting the Hardware Information.

+ (NSString *)hardwareMachine
{
    if (!UIDevice_UIDeviceREUIDevice_HardwareMachine)
    {
        // Getting the Singleton Synchronizer instance.
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        // Locking the critical section.
        @synchronized(singletonSynchronizer)
        {
            if (!UIDevice_UIDeviceREUIDevice_HardwareMachine)
            {
                char   *cHardwareMachine = NULL;
                size_t  cHardwareMachineSize = 0;
                
                int result0 = sysctlbyname("hw.machine", NULL, &cHardwareMachineSize, NULL, 0);
                
                if ((result0 == 0) && (cHardwareMachineSize > 0))
                {
                    cHardwareMachine = malloc(cHardwareMachineSize);
                    
                    if (cHardwareMachine)
                    {
                        memset(cHardwareMachine, 0, cHardwareMachineSize);
                        
                        int result1 = sysctlbyname("hw.machine", cHardwareMachine, &cHardwareMachineSize, NULL, 0);
                        
                        if (result1 == 0)
                        {
                            UIDevice_UIDeviceREUIDevice_HardwareMachine = [[NSString alloc] initWithCString:cHardwareMachine encoding: NSUTF8StringEncoding];
                        }
                    }
                    
                    free(cHardwareMachine);
                    cHardwareMachine = NULL;
                }
            }
        }
    }
    
    return UIDevice_UIDeviceREUIDevice_HardwareMachine;
}

+ (NSString *)hardwareModel
{
    if (!UIDevice_UIDeviceREUIDevice_HardwareModel)
    {
        // Getting the Singleton Synchronizer instance.
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        // Locking the critical section.
        @synchronized(singletonSynchronizer)
        {
            if (!UIDevice_UIDeviceREUIDevice_HardwareModel)
            {
                char   *cHardwareModel = NULL;
                size_t  cHardwareModelSize = 0;
                
                int result0 = sysctlbyname("hw.model", NULL, &cHardwareModelSize, NULL, 0);
                
                if ((result0 == 0) && (cHardwareModelSize > 0))
                {
                    cHardwareModel = malloc(cHardwareModelSize);
                    
                    if (cHardwareModel)
                    {
                        memset(cHardwareModel, 0, cHardwareModelSize);
                        
                        int result1 = sysctlbyname("hw.model", cHardwareModel, &cHardwareModelSize, NULL, 0);
                        
                        if (result1 == 0)
                        {
                            UIDevice_UIDeviceREUIDevice_HardwareModel = [[NSString alloc] initWithCString:cHardwareModel encoding: NSUTF8StringEncoding];
                        }
                    }
                    
                    free(cHardwareModel);
                    cHardwareModel = NULL;
                }
            }
        }
    }
    
    return UIDevice_UIDeviceREUIDevice_HardwareModel;
}

#pragma mark - Identifying the Device and Operating System

+ (BOOL)isSystemVersionGraterThanOrEqualTo_5_0
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_5_0;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_5_0_1
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_5_0_1;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_5_1
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_5_1;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_5_1_1
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_5_1_1;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_0
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_0;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_0_1
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_0_1;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_0_2
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_0_2;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1_1
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_1;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1_2
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_2;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1_3
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_3;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1_4
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_4;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1_5
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_5;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_6_1_6
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_6_1_6;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0_1
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_1;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0_2
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_2;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0_3
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_3;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0_4
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_4;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0_5
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_5;
}

+ (BOOL)isSystemVersionGraterThanOrEqualTo_7_0_6
{
    UIDevice_UIDeviceREUIDevice_IsSystemVersion_Initialize();
    
    return UIDevice_UIDeviceREUIDevice_IsSystemVersionGraterThanOrEqualTo_7_0_6;
}

@end
