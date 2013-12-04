//
//  RWSQLiteRow.m
//  RWSQLite
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.11.18.
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
#import "RWSQLiteRow.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

// Importing the system headers.
#import <libkern/OSAtomic.h>
#import <objc/runtime.h>

typedef struct
{
    Class        class;
    SEL          selector;
    const char * parameter;
} RWSQLiteSelectorCacheEntity;

RWSQLiteSelectorCacheEntity *RWSQLiteGetterSelectorCacheEntities       = NULL;
long                         RWSQLiteGetterSelectorCacheEntitiesNumber = 0;
volatile OSSpinLock          RWSQLiteGetterSelectorCacheLock           = 0;

RWSQLiteSelectorCacheEntity *RWSQLiteSetterSelectorCacheEntities       = NULL;
long                         RWSQLiteSetterSelectorCacheEntitiesNumber = 0;
volatile OSSpinLock          RWSQLiteSetterSelectorCacheLock           = 0;

SEL RWSQLiteGetterCacheGetSelectorForParameter(Class cls, const char *parameter)
{
    SEL selector = NULL;
    
    if (cls && parameter)
    {
        OSSpinLockLock(&RWSQLiteGetterSelectorCacheLock);
        
        long left = 0;
        long right = RWSQLiteGetterSelectorCacheEntitiesNumber - 1;
        long mid = 0;
        long result = 1;
        
        while (left <= right)
        {
            mid = (left + right) >> 1;
            
            if (RWSQLiteGetterSelectorCacheEntities[mid].class < cls)
            {
                result = -1;
            }
            
            else if (RWSQLiteGetterSelectorCacheEntities[mid].class > cls)
            {
                result = 1;
            }
            
            else
            {
                result = strcmp(RWSQLiteGetterSelectorCacheEntities[mid].parameter, parameter);
            }
            
            if (result < 0)
            {
                left = mid + 1;
            }
            
            else if (result > 0)
            {
                right = mid - 1;
            }
            
            else
            {
                break;
            }
        }
        
        if (result == 0)
        {
            selector = RWSQLiteGetterSelectorCacheEntities[mid].selector;
        }
        
        OSSpinLockUnlock(&RWSQLiteGetterSelectorCacheLock);
        
        if (result != 0)
        {
            selector = [cls sqliteGetterSelectorForCParameter:parameter];
            
            if (selector)
            {
                OSSpinLockLock(&RWSQLiteGetterSelectorCacheLock);
                
                left = 0;
                right = RWSQLiteGetterSelectorCacheEntitiesNumber - 1;
                mid = 0;
                result = 1;
                
                while (left <= right)
                {
                    mid = (left + right) >> 1;
                    
                    if (RWSQLiteGetterSelectorCacheEntities[mid].class < cls)
                    {
                        result = -1;
                    }
                    
                    else if (RWSQLiteGetterSelectorCacheEntities[mid].class > cls)
                    {
                        result = 1;
                    }
                    
                    else
                    {
                        result = strcmp(RWSQLiteGetterSelectorCacheEntities[mid].parameter, parameter);
                    }
                    
                    if (result < 0)
                    {
                        left = mid + 1;
                    }
                    
                    else if (result > 0)
                    {
                        right = mid - 1;
                    }
                    
                    else
                    {
                        break;
                    }
                }
                
                if (result < 0)
                {
                    mid += 1;
                }
                
                RWSQLiteSelectorCacheEntity *getterSelectorCacheEntities2 = (RWSQLiteSelectorCacheEntity *)malloc(sizeof(RWSQLiteSelectorCacheEntity) * (size_t)(RWSQLiteGetterSelectorCacheEntitiesNumber + 1));
                
                if (!getterSelectorCacheEntities2)
                {
                    NSCAssert(NO, @"Low memory");
                    abort();
                }
                
                size_t parameter2Size = strlen(parameter) + 1;
                char *parameter2 = (char *)malloc(parameter2Size);
                
                if (!parameter2)
                {
                    NSCAssert(NO, @"Low memory");
                    abort();
                }
                
                memcpy(parameter2, parameter, parameter2Size);
                
                memcpy(getterSelectorCacheEntities2, RWSQLiteGetterSelectorCacheEntities, (sizeof(RWSQLiteSelectorCacheEntity) * (size_t)mid));
                getterSelectorCacheEntities2[mid].class = cls;
                getterSelectorCacheEntities2[mid].selector = selector;
                getterSelectorCacheEntities2[mid].parameter = parameter2;
                memcpy((getterSelectorCacheEntities2 + mid + 1), (RWSQLiteGetterSelectorCacheEntities + mid), (sizeof(RWSQLiteSelectorCacheEntity) * (size_t)(RWSQLiteGetterSelectorCacheEntitiesNumber - mid)));
                
                free(RWSQLiteGetterSelectorCacheEntities);
                RWSQLiteGetterSelectorCacheEntities = getterSelectorCacheEntities2;
                
                RWSQLiteGetterSelectorCacheEntitiesNumber++;
                
                OSSpinLockUnlock(&RWSQLiteGetterSelectorCacheLock);
            }
        }
    }
    
    return selector;
}

SEL RWSQLiteSetterCacheGetSelectorForParameter(Class cls, const char *parameter)
{
    SEL selector = NULL;
    
    if (cls && parameter)
    {
        OSSpinLockLock(&RWSQLiteSetterSelectorCacheLock);
        
        long left = 0;
        long right = RWSQLiteSetterSelectorCacheEntitiesNumber - 1;
        long mid = 0;
        long result = 1;
        
        while (left <= right)
        {
            mid = (left + right) >> 1;
            
            if (RWSQLiteSetterSelectorCacheEntities[mid].class < cls)
            {
                result = -1;
            }
            
            else if (RWSQLiteSetterSelectorCacheEntities[mid].class > cls)
            {
                result = 1;
            }
            
            else
            {
                result = strcmp(RWSQLiteSetterSelectorCacheEntities[mid].parameter, parameter);
            }
            
            if (result < 0)
            {
                left = mid + 1;
            }
            
            else if (result > 0)
            {
                right = mid - 1;
            }
            
            else
            {
                break;
            }
        }
        
        if (result == 0)
        {
            selector = RWSQLiteSetterSelectorCacheEntities[mid].selector;
        }
        
        OSSpinLockUnlock(&RWSQLiteSetterSelectorCacheLock);
        
        if (result != 0)
        {
            selector = [cls sqliteSetterSelectorForCParameter:parameter];
            
            if (selector)
            {
                OSSpinLockLock(&RWSQLiteSetterSelectorCacheLock);
                
                left = 0;
                right = RWSQLiteSetterSelectorCacheEntitiesNumber - 1;
                mid = 0;
                result = 1;
                
                while (left <= right)
                {
                    mid = (left + right) >> 1;
                    
                    if (RWSQLiteSetterSelectorCacheEntities[mid].class < cls)
                    {
                        result = -1;
                    }
                    
                    else if (RWSQLiteSetterSelectorCacheEntities[mid].class > cls)
                    {
                        result = 1;
                    }
                    
                    else
                    {
                        result = strcmp(RWSQLiteSetterSelectorCacheEntities[mid].parameter, parameter);
                    }
                    
                    if (result < 0)
                    {
                        left = mid + 1;
                    }
                    
                    else if (result > 0)
                    {
                        right = mid - 1;
                    }
                    
                    else
                    {
                        break;
                    }
                }
                
                if (result < 0)
                {
                    mid += 1;
                }
                
                RWSQLiteSelectorCacheEntity *setterSelectorCacheEntities2 = (RWSQLiteSelectorCacheEntity *)malloc(sizeof(RWSQLiteSelectorCacheEntity) * (size_t)(RWSQLiteSetterSelectorCacheEntitiesNumber + 1));
                
                if (!setterSelectorCacheEntities2)
                {
                    NSCAssert(NO, @"Low memory");
                    abort();
                }
                
                size_t parameter2Size = strlen(parameter) + 1;
                char *parameter2 = (char *)malloc(parameter2Size);
                
                if (!parameter2)
                {
                    NSCAssert(NO, @"Low memory");
                    abort();
                }
                
                memcpy(parameter2, parameter, parameter2Size);
                
                memcpy(setterSelectorCacheEntities2, RWSQLiteSetterSelectorCacheEntities, (sizeof(RWSQLiteSelectorCacheEntity) * (size_t)mid));
                setterSelectorCacheEntities2[mid].class = cls;
                setterSelectorCacheEntities2[mid].selector = selector;
                setterSelectorCacheEntities2[mid].parameter = parameter2;
                memcpy((setterSelectorCacheEntities2 + mid + 1), (RWSQLiteSetterSelectorCacheEntities + mid), (sizeof(RWSQLiteSelectorCacheEntity) * (size_t)(RWSQLiteSetterSelectorCacheEntitiesNumber - mid)));
                
                free(RWSQLiteSetterSelectorCacheEntities);
                RWSQLiteSetterSelectorCacheEntities = setterSelectorCacheEntities2;
                
                RWSQLiteSetterSelectorCacheEntitiesNumber++;
                
                OSSpinLockUnlock(&RWSQLiteSetterSelectorCacheLock);
            }
        }
    }
    
    return selector;
}

@implementation NSObject (NSObjectRWSQLiteRow)

+ (SEL)sqliteGetterSelectorForCParameter:(const char *)parameterName
{
    SEL selector = NULL;
    
    if (parameterName)
    {
        if ((parameterName[0] == '$') ||
            (parameterName[0] == '@') ||
            (parameterName[0] == ':'))
        {
            parameterName += 1;
        }
        
        if (strlen(parameterName) > 0)
        {
            Class class = self;
            
            while (class)
            {
                objc_property_t objcProperty = class_getProperty(class, parameterName);
                
                if (objcProperty)
                {
                    char *selectorName = property_copyAttributeValue(objcProperty, "G");
                    
                    if (selectorName)
                    {
                        selector = sel_getUid(selectorName);
                    }
                    
                    else
                    {
                        selector = sel_getUid(parameterName);
                    }
                    
                    free(selectorName);
                    selectorName = NULL;
                    
                    break;
                }
                
                class = class_getSuperclass(class);
            }
            
            if (!class)
            {
                SEL selector2 = sel_getUid(parameterName);
                
                if (selector2)
                {
                    Method objcMethod = class_getInstanceMethod(self, selector2);
                    
                    if (objcMethod)
                    {
                        selector = selector2;
                    }
                }
            }
        }
    }
    
    return selector;
}

+ (SEL)sqliteSetterSelectorForCParameter:(const char *)parameterName
{
    SEL selector = NULL;
    
    if (parameterName)
    {
        size_t parameterNameLength = strlen(parameterName);
        
        if (parameterNameLength > 0)
        {
            Class class = self;
            
            while (class)
            {
                objc_property_t objcProperty = class_getProperty(class, parameterName);
                
                if (objcProperty)
                {
                    char *selectorName = property_copyAttributeValue(objcProperty, "S");
                    
                    if (selectorName)
                    {
                        selector = sel_getUid(selectorName);
                    }
                    
                    else
                    {
                        char selectorName2[3 + parameterNameLength + 2];
                        selectorName2[0] = 's';
                        selectorName2[1] = 'e';
                        selectorName2[2] = 't';
                        memcpy((selectorName2 + 3), parameterName, (sizeof(char) * parameterNameLength));
                        
                        if ((selectorName2[3] >= 'a') && (selectorName2[3] <= 'z'))
                        {
                            selectorName2[3] -= 'a' - 'A';
                        }
                        
                        selectorName2[3 + parameterNameLength] = ':';
                        selectorName2[3 + parameterNameLength + 1] = '\0';
                        
                        selector = sel_getUid(selectorName2);
                    }
                    
                    free(selectorName);
                    selectorName = NULL;
                    
                    break;
                }
                
                class = class_getSuperclass(class);
            }
            
            if (!class)
            {
                char selectorName2[3 + parameterNameLength + 2];
                selectorName2[0] = 's';
                selectorName2[1] = 'e';
                selectorName2[2] = 't';
                memcpy((selectorName2 + 3), parameterName, (sizeof(char) * parameterNameLength));
                
                if ((selectorName2[3] >= 'a') && (selectorName2[3] <= 'z'))
                {
                    selectorName2[3] -= 'a' - 'A';
                }
                
                selectorName2[3 + parameterNameLength] = ':';
                selectorName2[3 + parameterNameLength + 1] = '\0';
                
                SEL selector2 = sel_getUid(selectorName2);
                
                if (selector2)
                {
                    Method objcMethod = class_getInstanceMethod(self, selector2);
                    
                    if (objcMethod)
                    {
                        selector = selector2;
                    }
                }
            }
        }
    }
    
    return selector;
}

@end
