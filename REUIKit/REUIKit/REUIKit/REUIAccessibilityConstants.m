//
//  REUIAccessibilityConstants.m
//  REExtendedFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.06.06.
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
#import "REUIAccessibilityConstants.h"

// Importing the external headers.
#import <REFoundation/REFoundation.h>

// Importing the system headers.
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

volatile BOOL REUIAccessibilityConstants_NeedsInitialize = YES;

NSString              *REUIAccessibilityConstants_UIAccessibilityTraitStrings[8 * sizeof(UIAccessibilityTraits)];
UIAccessibilityTraits  REUIAccessibilityConstants_UIAccessibilityTraits[8 * sizeof(UIAccessibilityTraits)];

void REUIAccessibilityConstants_Initialize(void);

void REUIAccessibilityConstants_Initialize()
{
    // We must inizialize the static variables.
    if (REUIAccessibilityConstants_NeedsInitialize)
    {
        // Getting the Singleton Synchronizer instance.
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        // Locking the critical section.
        @synchronized(singletonSynchronizer)
        {
            // We must inizialize the static variables.
            if (REUIAccessibilityConstants_NeedsInitialize)
            {
                // Setting the default values.
                memset(REUIAccessibilityConstants_UIAccessibilityTraitStrings, 0, (sizeof(NSString *) * 8 * sizeof(UIAccessibilityTraits)));
                
                // We have the UIAccessibilityTraitNone.
                if (&UIAccessibilityTraitNone && (UIAccessibilityTraitNone != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitNone;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitNone";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitButton.
                if (&UIAccessibilityTraitButton && (UIAccessibilityTraitButton != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitButton;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitButton";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitLink.
                if (&UIAccessibilityTraitLink && (UIAccessibilityTraitLink != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitLink;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitLink";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitHeader.
                if (&UIAccessibilityTraitHeader && (UIAccessibilityTraitHeader != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitHeader;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitHeader";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitSearchField.
                if (&UIAccessibilityTraitSearchField && (UIAccessibilityTraitSearchField != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitSearchField;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitSearchField";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitImage.
                if (&UIAccessibilityTraitImage && (UIAccessibilityTraitImage != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitImage;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitImage";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitSelected.
                if (&UIAccessibilityTraitSelected && (UIAccessibilityTraitSelected != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitSelected;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitSelected";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitPlaysSound.
                if (&UIAccessibilityTraitPlaysSound && (UIAccessibilityTraitPlaysSound != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitPlaysSound;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitPlaysSound";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitKeyboardKey.
                if (&UIAccessibilityTraitKeyboardKey && (UIAccessibilityTraitKeyboardKey != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitKeyboardKey;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitKeyboardKey";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitStaticText.
                if (&UIAccessibilityTraitStaticText && (UIAccessibilityTraitStaticText != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitStaticText;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitStaticText";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitSummaryElement.
                if (&UIAccessibilityTraitSummaryElement && (UIAccessibilityTraitSummaryElement != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitSummaryElement;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitSummaryElement";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitNotEnabled.
                if (&UIAccessibilityTraitNotEnabled && (UIAccessibilityTraitNotEnabled != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitNotEnabled;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitNotEnabled";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitUpdatesFrequently.
                if (&UIAccessibilityTraitUpdatesFrequently && (UIAccessibilityTraitUpdatesFrequently != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitUpdatesFrequently;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitUpdatesFrequently";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitStartsMediaSession.
                if (&UIAccessibilityTraitStartsMediaSession && (UIAccessibilityTraitStartsMediaSession != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitStartsMediaSession;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitStartsMediaSession";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitAdjustable.
                if (&UIAccessibilityTraitAdjustable && (UIAccessibilityTraitAdjustable != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitAdjustable;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitAdjustable";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitAllowsDirectInteraction.
                if (&UIAccessibilityTraitAllowsDirectInteraction && (UIAccessibilityTraitAllowsDirectInteraction != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitAllowsDirectInteraction;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitAllowsDirectInteraction";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // We have the UIAccessibilityTraitCausesPageTurn.
                if (&UIAccessibilityTraitCausesPageTurn && (UIAccessibilityTraitCausesPageTurn != 0))
                {
                    // Setting the default values.
                    UIAccessibilityTraits accessibilityTraits = UIAccessibilityTraitCausesPageTurn;
                    
                    // Enumerating all the bits.
                    for (NSInteger indexOfBit = 0; ; indexOfBit++, accessibilityTraits >>= 1)
                    {
                        // We have the set first bit.
                        if ((accessibilityTraits & 1) == 1)
                        {
                            // The accessibility trait is simple.
                            if (accessibilityTraits == 1)
                            {
                                // Saving the name of the accessibility trait.
                                REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] = @"UIAccessibilityTraitCausesPageTurn";
                            }
                            
                            // Breaking enumerating all the bits.
                            break;
                        }
                    }
                }
                
                // Setting the default values.
                UIAccessibilityTraits accessibilityTrait = 1ll;
                
                // Initializing the the REUIAccessibilityConstants_UIAccessibilityTraits static variable.
                for (NSInteger indexOfBit = 0; accessibilityTrait; indexOfBit++, accessibilityTrait <<= 1)
                {
                    REUIAccessibilityConstants_UIAccessibilityTraits[indexOfBit] = accessibilityTrait;
                }
                
                // Resetting the flag to need to initialize the static variables.
                REUIAccessibilityConstants_NeedsInitialize = NO;
            }
        }
    }
}

NSString *NSStringFromUIAccessibilityTraits(UIAccessibilityTraits accessibilityTraits)
{
    // We do not initializing the static variables.
    if (REUIAccessibilityConstants_NeedsInitialize)
    {
        // Initializing the static variables.
        REUIAccessibilityConstants_Initialize();
    }
    
    // Creating the array of representation of accessibility traits
    NSMutableArray *accessibilityTraitStrings = [[NSMutableArray alloc] init];
    
    // Setting the defaul values.
    UIAccessibilityTraits accessibilityTraits2 = 0ll;
    
    // Enumerating all the accessibility traits.
    for (NSInteger indexOfBit = 0; accessibilityTraits; indexOfBit++, accessibilityTraits >>= 1)
    {
        // We have a set bit.
        if ((accessibilityTraits & 1) == 1)
        {
            // Gettign the string representation of the accessibility trait.
            NSString *accessibilityTraitString = REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit];
            
            // We have the string representation of the accessibility trait.
            if (accessibilityTraitString)
            {
                // Saving the string representation of the accessibility trait.
                [accessibilityTraitStrings addObject:accessibilityTraitString];
            }
            
            // We do not have the string representation of the accessibility trait.
            else
            {
                // Saving the accessibility trait which do no have the string representation.
                accessibilityTraits2 |= REUIAccessibilityConstants_UIAccessibilityTraits[indexOfBit];
            }
        }
    }
    
    // We have the accessibility traits which do not have the string representation.
    if (accessibilityTraits2)
    {
        // Creating the string representation of the accessibility traits which do not have the string representation.
        NSString *accessibilityTraitsString = [[NSString alloc] initWithFormat:@"0x%llx", (long long)accessibilityTraits2];
        
        // Saving the string representation.
        [accessibilityTraitStrings addObject:accessibilityTraitsString];
    }
    
    // We do not have any string representation of accessibility trait.
    if (accessibilityTraitStrings.count == 0)
    {
        // Saving the string representation of the default accessibility trait.
        [accessibilityTraitStrings addObject:@"UIAccessibilityTraitNone"];
    }
    
    // Creating the string representation of the accessibility traits.
    NSMutableString *accessibilityTraitsString = [[NSMutableString alloc] init];
    [accessibilityTraitsString appendString:@"{"];
    
    // Appending all the string representations.
    for (NSString *accessibilityTraitString in accessibilityTraitStrings)
    {
        // Appending the string representation.
        [accessibilityTraitsString appendString:accessibilityTraitString];
        [accessibilityTraitsString appendString:@", "];
    }
    
    // Appending the end of a string representation.
    [accessibilityTraitsString trimRightStrings:@",", @" ", nil];
    [accessibilityTraitsString appendString:@"}"];
    
    // Returning the string representation of the accessibility traits.
    return accessibilityTraitsString;
}

UIKIT_EXTERN UIAccessibilityTraits UIAccessibilityTraitsFromNSString(NSString *string)
{
    NSMutableString *accessibilityTraitsString = [string mutableCopy];
    
    UIAccessibilityTraits accessibilityTraits = 0;
    
    if (accessibilityTraitsString)
    {
        NSRange range = [accessibilityTraitsString rangeOfString:(@"^"
                                                                  @"[^\\[\\{]*"
                                                                  @"[\\[\\{]"
                                                                  @"([^,\\]\\}]+,)*"
                                                                  @"([^,\\]\\}]+)?"
                                                                  @"[\\]\\}]?")
                                                         options:NSRegularExpressionSearch
                                                           range:accessibilityTraitsString.range];
        
        if (!NSRangeIsNotFound(range))
        {
            [accessibilityTraitsString replaceOccurrencesOfString:(@"^"
                                                                   @"[^\\[\\{]*"
                                                                   @"[\\[\\{]")
                                                       withString:@""
                                                          options:NSRegularExpressionSearch
                                                            range:accessibilityTraitsString.range];
            
            NSRange accessibilityTraitsStringRange = [accessibilityTraitsString rangeOfString:(@"^"
                                                                                               @"([^,\\]\\}]+,)*"
                                                                                               @"([^,\\]\\}]+)?")
                                                                                      options:NSRegularExpressionSearch
                                                                                        range:accessibilityTraitsString.range];
            
            NSCAssert(!NSRangeIsNotFound(accessibilityTraitsStringRange), @"The method has a logical error.");
            
            NSRange deleteRange;
            deleteRange.location = NSMaxRange(accessibilityTraitsStringRange);
            deleteRange.length = accessibilityTraitsString.length - deleteRange.location;
            
            [accessibilityTraitsString deleteCharactersInRange:deleteRange];
            
            NSArray *accessibilityTraitStrings = [accessibilityTraitsString componentsSeparatedByString:@","];
            
            NSCharacterSet *whitespaceAndNewlineCharacterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            
            for (NSString *accessibilityTraitString in accessibilityTraitStrings)
            {
                if (accessibilityTraitString.length > 0)
                {
                    NSMutableString *accessibilityTraitString2 = [accessibilityTraitString mutableCopy];
                    [accessibilityTraitString2 trimCharactersInSet:whitespaceAndNewlineCharacterSet];
                    
                    BOOL needsConvertAccessibilityTraitString = YES;
                    
                    if (needsConvertAccessibilityTraitString)
                    {
                        for (NSInteger indexOfBit = 0; indexOfBit < (NSInteger)(8 * sizeof(UIAccessibilityTraits)); indexOfBit++)
                        {
                            if ([REUIAccessibilityConstants_UIAccessibilityTraitStrings[indexOfBit] isEqual:accessibilityTraitString2])
                            {
                                needsConvertAccessibilityTraitString = NO;
                                
                                accessibilityTraits |= REUIAccessibilityConstants_UIAccessibilityTraits[indexOfBit];
                                
                                break;
                            }
                        }
                    }
                    
                    if (needsConvertAccessibilityTraitString)
                    {
                        NSScanner *scanner = [[NSScanner alloc] initWithString:accessibilityTraitString2];
                        
                        unsigned long long accessibilityTraits2 = 0ll;
                        
                        BOOL result = [scanner scanHexLongLong:&accessibilityTraits2];
                        
                        if (result)
                        {
                            needsConvertAccessibilityTraitString = NO;
                            
                            accessibilityTraits |= (UIAccessibilityTraits)accessibilityTraits2;
                        }
                    }
                    
                    if (needsConvertAccessibilityTraitString)
                    {
                        NSScanner *scanner = [[NSScanner alloc] initWithString:accessibilityTraitString2];
                        
                        long long accessibilityTraits2 = 0ll;
                        
                        BOOL result = [scanner scanLongLong:&accessibilityTraits2];
                        
                        if (result)
                        {
                            needsConvertAccessibilityTraitString = NO;
                            
                            accessibilityTraits |= (UIAccessibilityTraits)accessibilityTraits2;
                        }
                    }
                    
                    // Deceiving the static analyzer.
                    needsConvertAccessibilityTraitString = needsConvertAccessibilityTraitString;
                }
            }
            
            if (accessibilityTraits == 0ll)
            {
                accessibilityTraits = UIAccessibilityTraitNone;
            }
        }
    }
    
    return accessibilityTraits;
}
