//
//  REMKGeometry.h
//  REMapKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.08.02.
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

// Importing the external headers.
#import <RECoreLocation/RECLLocation.h>

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>
#import <MapKit/MKGeometry.h>

FOUNDATION_EXTERN MKMapPoint MKMapPointZero;
FOUNDATION_EXTERN MKMapSize  MKMapSizeZero;
FOUNDATION_EXTERN MKMapRect  MKMapRectZero;

NS_INLINE bool MKCoordinateSpanEqualToSpan(MKCoordinateSpan span1, MKCoordinateSpan span2)
{
    bool result = ((span1.latitudeDelta == span2.latitudeDelta) && (span1.longitudeDelta == span2.longitudeDelta));
    return result;
}

NS_INLINE bool MKCoordinateRegionEqualToRegion(MKCoordinateRegion region1, MKCoordinateRegion region2)
{
    bool result = CLLocationCoordinate2DEqualToCoordinate(region1.center, region2.center);
    return result;
}

NS_INLINE MKMapRect MKMapRectUnionPoint(MKMapRect rect, MKMapPoint point)
{
    MKMapRect unitedRect;
    unitedRect.origin.x = ((rect.origin.x < point.x) ? rect.origin.x : point.x);
    unitedRect.origin.y = ((rect.origin.y < point.y) ? rect.origin.y : point.y);
    unitedRect.size.width = (((rect.origin.x + rect.size.width) > point.x) ? (rect.origin.x + rect.size.width) : point.x) - unitedRect.origin.x;
    unitedRect.size.height = (((rect.origin.y + rect.size.height) > point.y) ? (rect.origin.y + rect.size.height) : point.y) - unitedRect.origin.y;
    return unitedRect;
}

NS_INLINE NSString *MKStringFromCoordinateSpan(MKCoordinateSpan span)
{
    // Creating a string which represents the span.
    NSString *string = [[NSString alloc] initWithFormat:@"{%g, %g}", span.latitudeDelta, span.longitudeDelta];
    
    // Returning the string.
    return string;
}

NS_INLINE NSString *MKStringFromCoordinateRegion(MKCoordinateRegion region)
{
    // Creating a string which represents the region.
    NSString *string = [[NSString alloc] initWithFormat:@"{{%g, %g}, {%g, %g}}", region.center.latitude, region.center.longitude, region.span.latitudeDelta, region.span.longitudeDelta];
    
    // Returning the string.
    return string;
}
