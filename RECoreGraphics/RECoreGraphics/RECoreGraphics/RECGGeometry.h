//
//  RECGGeometry.h
//  RECoreGraphics
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.12.20.
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

// Importing the project headers.
#import "RECGMath.h"

// Importing the system headers.
#import <CoreGraphics/CGBase.h>
#import <CoreGraphics/CGGeometry.h>

CG_EXTERN const CGSize CGSizeOne;

CG_INLINE bool CGPointIsZero(CGPoint point)
{
    bool result = ((point.x == 0.0f) && (point.y == 0.0f));
    return result;
}

CG_INLINE bool CGPointIsOne(CGPoint point)
{
    bool result = ((point.x == 1.0f) && (point.y == 1.0f));
    return result;
}

CG_INLINE CGPoint CGPointIntersection(CGPoint point1, CGPoint point2)
{
    CGPoint intersectedPoint;
    intersectedPoint.x = ((point1.x < point2.x) ? point1.x : point2.x);
    intersectedPoint.y = ((point1.y < point2.y) ? point1.y : point2.y);
    return intersectedPoint;
}

CG_INLINE CGPoint CGPointUnion(CGPoint point1, CGPoint point2)
{
    CGPoint unitedPoint;
    unitedPoint.x = ((point1.x > point2.x) ? point1.x : point2.x);
    unitedPoint.y = ((point1.y > point2.y) ? point1.y : point2.y);
    return unitedPoint;
}

CG_INLINE CGPoint CGPointAbs(CGPoint point)
{
    CGPoint absPoint;
    absPoint.x = cg_fabs(point.x);
    absPoint.y = cg_fabs(point.y);
    return absPoint;
}

CG_INLINE CGPoint CGPointAdd(CGPoint point1, CGPoint point2)
{
    CGPoint dividedPoint;
    dividedPoint.x = point1.x + point2.x;
    dividedPoint.y = point1.y + point2.y;
    return dividedPoint;
}

CG_INLINE CGPoint CGPointDiv(CGPoint point1, CGPoint point2)
{
    CGPoint addedPoint;
    addedPoint.x = point1.x / point2.x;
    addedPoint.y = point1.y / point2.y;
    return addedPoint;
}

CG_INLINE CGPoint CGPointMod(CGPoint point1, CGPoint point2)
{
    CGPoint remainderPoint;
    remainderPoint.x = cg_fmod(point1.x, point2.x);
    remainderPoint.y = cg_fmod(point1.y, point2.y);
    return remainderPoint;
}

CG_INLINE CGPoint CGPointModf(CGPoint point, CGPoint *pIntegralPoint)
{
    CGPoint fractionalPoint;
    fractionalPoint.x = cg_modf(point.x, (pIntegralPoint ? &pIntegralPoint->x : NULL));
    fractionalPoint.y = cg_modf(point.y, (pIntegralPoint ? &pIntegralPoint->y : NULL));
    return fractionalPoint;
}

CG_INLINE CGPoint CGPointSub(CGPoint point1, CGPoint point2)
{
    CGPoint addedPoint;
    addedPoint.x = point1.x - point2.x;
    addedPoint.y = point1.y - point2.y;
    return addedPoint;
}

CG_INLINE bool CGSizeIsZero(CGSize size)
{
    bool result = ((size.width == 0.0f) && (size.height == 0.0f));
    return result;
}

CG_INLINE CGSize CGSizeIntersection(CGSize size1, CGSize size2)
{
    CGSize intersectedSize;
    intersectedSize.width = ((size1.width < size2.width) ? size1.width : size2.width);
    intersectedSize.height = ((size1.height < size2.height) ? size1.height : size2.height);
    return intersectedSize;
}

CG_INLINE CGFloat CGSizeIntersectionSides(CGSize size)
{
    CGFloat intersectedSides = ((size.width < size.height) ? size.width : size.height);
    return intersectedSides;
}

CG_INLINE CGSize CGSizeUnion(CGSize size1, CGSize size2)
{
    CGSize unitedSize;
    unitedSize.width = ((size1.width > size2.width) ? size1.width : size2.width);
    unitedSize.height = ((size1.height > size2.height) ? size1.height : size2.height);
    return unitedSize;
}

CG_INLINE CGFloat CGSizeUnionSides(CGSize size)
{
    CGFloat unitedSides = ((size.width > size.height) ? size.width : size.height);
    return unitedSides;
}

CG_INLINE bool CGRectIsZero(CGRect rect)
{
    bool result = ((rect.origin.x == 0.0f) &&
                   (rect.origin.y == 0.0f) &&
                   (rect.size.width == 0.0f) &&
                   (rect.size.height == 0.0f));
    return result;
}

CG_INLINE CGSize CGSizeAbs(CGSize size)
{
    CGSize absSize;
    absSize.width = cg_fabs(size.width);
    absSize.height = cg_fabs(size.height);
    return absSize;
}

CG_INLINE CGSize CGSizeAdd(CGSize size1, CGSize size2)
{
    CGSize addedSize;
    addedSize.width = size1.width + size2.width;
    addedSize.height = size1.height + size2.height;
    return addedSize;
}

CG_INLINE CGSize CGSizeDiv(CGSize size1, CGSize size2)
{
    CGSize dividedSize;
    dividedSize.width = size1.width / size2.width;
    dividedSize.height = size1.height / size2.height;
    return dividedSize;
}

CG_INLINE CGSize CGSizeMod(CGSize size1, CGSize size2)
{
    CGSize remainderSize;
    remainderSize.width = cg_fmod(size1.width, size2.width);
    remainderSize.height = cg_fmod(size1.height, size2.height);
    return remainderSize;
}

CG_INLINE CGSize CGSizeModf(CGSize size, CGSize *pIntegralSize)
{
    CGSize fractionalSize;
    fractionalSize.width = cg_modf(size.width, (pIntegralSize ? &pIntegralSize->width : NULL));
    fractionalSize.height = cg_modf(size.height, (pIntegralSize ? &pIntegralSize->height : NULL));
    return fractionalSize;
}

CG_INLINE CGSize CGSizeSub(CGSize size1, CGSize size2)
{
    CGSize addedSize;
    addedSize.width = size1.width - size2.width;
    addedSize.height = size1.height - size2.height;
    return addedSize;
}
