//
//  REUIContext.m
//  REUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.06.03.
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
#import "REUIContext.h"

// Importing the system headers.
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *NSStringFromCGBlendMode(CGBlendMode blendMode)
{
    switch (blendMode)
    {
        default:
        case kCGBlendModeNormal:
            return @"CGBlendModeNormal";
            
        case kCGBlendModeMultiply:
            return @"CGBlendModeMultiply";
            
        case kCGBlendModeScreen:
            return @"CGBlendModeScreen";
            
        case kCGBlendModeOverlay:
            return @"CGBlendModeOverlay";
            
        case kCGBlendModeDarken:
            return @"CGBlendModeDarken";
            
        case kCGBlendModeLighten:
            return @"CGBlendModeLighten";
            
        case kCGBlendModeColorDodge:
            return @"CGBlendModeColorDodge";
            
        case kCGBlendModeColorBurn:
            return @"CGBlendModeColorBurn";
            
        case kCGBlendModeSoftLight:
            return @"CGBlendModeSoftLight";
            
        case kCGBlendModeHardLight:
            return @"CGBlendModeHardLight";
            
        case kCGBlendModeDifference:
            return @"CGBlendModeDifference";
            
        case kCGBlendModeExclusion:
            return @"CGBlendModeExclusion";
            
        case kCGBlendModeHue:
            return @"CGBlendModeHue";
            
        case kCGBlendModeSaturation:
            return @"CGBlendModeSaturation";
            
        case kCGBlendModeColor:
            return @"CGBlendModeColor";
            
        case kCGBlendModeLuminosity:
            return @"CGBlendModeLuminosity";
            
        case kCGBlendModeClear:
            return @"CGBlendModeClear";
            
        case kCGBlendModeCopy:
            return @"CGBlendModeCopy";
            
        case kCGBlendModeSourceIn:
            return @"CGBlendModeSourceIn";
            
        case kCGBlendModeSourceOut:
            return @"CGBlendModeSourceOut";
            
        case kCGBlendModeSourceAtop:
            return @"CGBlendModeSourceAtop";
            
        case kCGBlendModeDestinationOver:
            return @"CGBlendModeDestinationOver";
            
        case kCGBlendModeDestinationIn:
            return @"CGBlendModeDestinationIn";
            
        case kCGBlendModeDestinationOut:
            return @"CGBlendModeDestinationOut";
            
        case kCGBlendModeDestinationAtop:
            return @"CGBlendModeDestinationAtop";
            
        case kCGBlendModeXOR:
            return @"CGBlendModeXOR";
            
        case kCGBlendModePlusDarker:
            return @"CGBlendModePlusDarker";
            
        case kCGBlendModePlusLighter:
            return @"CGBlendModePlusLighter";
    }
}

UIKIT_EXTERN CGBlendMode CGBlendModeFromNSString(NSString *string)
{
    if ([string isEqual:@"CGBlendModeNormal"])
    {
        return kCGBlendModeNormal;
    }
    
    else if ([string isEqual:@"CGBlendModeMultiply"])
    {
        return kCGBlendModeMultiply;
    }
    
    else if ([string isEqual:@"CGBlendModeScreen"])
    {
        return kCGBlendModeScreen;
    }
    
    else if ([string isEqual:@"CGBlendModeOverlay"])
    {
        return kCGBlendModeOverlay;
    }
    
    else if ([string isEqual:@"CGBlendModeDarken"])
    {
        return kCGBlendModeDarken;
    }
    
    else if ([string isEqual:@"CGBlendModeLighten"])
    {
        return kCGBlendModeLighten;
    }
    
    else if ([string isEqual:@"CGBlendModeColorDodge"])
    {
        return kCGBlendModeColorDodge;
    }
    
    else if ([string isEqual:@"CGBlendModeColorBurn"])
    {
        return kCGBlendModeColorBurn;
    }
    
    else if ([string isEqual:@"CGBlendModeSoftLight"])
    {
        return kCGBlendModeSoftLight;
    }
    
    else if ([string isEqual:@"CGBlendModeHardLight"])
    {
        return kCGBlendModeHardLight;
    }
    
    else if ([string isEqual:@"CGBlendModeDifference"])
    {
        return kCGBlendModeDifference;
    }
    
    else if ([string isEqual:@"CGBlendModeExclusion"])
    {
        return kCGBlendModeExclusion;
    }
    
    else if ([string isEqual:@"CGBlendModeHue"])
    {
        return kCGBlendModeHue;
    }
    
    else if ([string isEqual:@"CGBlendModeSaturation"])
    {
        return kCGBlendModeSaturation;
    }
    
    else if ([string isEqual:@"CGBlendModeColor"])
    {
        return kCGBlendModeColor;
    }
    
    else if ([string isEqual:@"CGBlendModeLuminosity"])
    {
        return kCGBlendModeLuminosity;
    }
    
    else if ([string isEqual:@"CGBlendModeClear"])
    {
        return kCGBlendModeClear;
    }
    
    else if ([string isEqual:@"CGBlendModeCopy"])
    {
        return kCGBlendModeCopy;
    }
    
    else if ([string isEqual:@"CGBlendModeSourceIn"])
    {
        return kCGBlendModeSourceIn;
    }
    
    else if ([string isEqual:@"CGBlendModeSourceOut"])
    {
        return kCGBlendModeSourceOut;
    }
    
    else if ([string isEqual:@"CGBlendModeSourceAtop"])
    {
        return kCGBlendModeSourceAtop;
    }
    
    else if ([string isEqual:@"CGBlendModeDestinationOver"])
    {
        return kCGBlendModeDestinationOver;
    }
    
    else if ([string isEqual:@"CGBlendModeDestinationIn"])
    {
        return kCGBlendModeDestinationIn;
    }
    
    else if ([string isEqual:@"CGBlendModeDestinationOut"])
    {
        return kCGBlendModeDestinationOut;
    }
    
    else if ([string isEqual:@"CGBlendModeDestinationAtop"])
    {
        return kCGBlendModeDestinationAtop;
    }
    
    else if ([string isEqual:@"CGBlendModeXOR"])
    {
        return kCGBlendModeXOR;
    }
    
    else if ([string isEqual:@"CGBlendModePlusDarker"])
    {
        return kCGBlendModePlusDarker;
    }
    
    else if ([string isEqual:@"CGBlendModePlusLighter"])
    {
        return kCGBlendModePlusLighter;
    }
    
    else
    {
        return kCGBlendModeNormal;
    }
}
