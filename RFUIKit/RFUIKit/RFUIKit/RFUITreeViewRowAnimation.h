//
//  RFUITreeViewRowAnimation.h
//  RFUIKit
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.08.01.
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

typedef NS_OPTIONS(NSUInteger, RFUITreeViewRowAnimation)
{
    RFUITreeViewRowAnimationNone      = 0,      // No animation is performed. The new cell value appears as if the cell had just been reloaded.
    RFUITreeViewRowAnimationFade      = 1 << 0, // The inserted or deleted row or rows fades into or out of the table view.
    RFUITreeViewRowAnimationRight     = 1 << 1, // The inserted row or rows slides in from the right; the deleted row or rows slides out to the right.
    RFUITreeViewRowAnimationLeft      = 1 << 2, // The inserted row or rows slides in from the left; the deleted row or rows slides out to the left.
    RFUITreeViewRowAnimationTop       = 1 << 3, // The inserted row or rows slides in from the top; the deleted row or rows slides out toward the top.
    RFUITreeViewRowAnimationBottom    = 1 << 4, // The inserted row or rows slides in from the bottom; the deleted row or rows slides out toward the bottom.
    RFUITreeViewRowAnimationMiddle    = 1 << 5, // The tree view attempts to keep the old and new cells centered in the space they did or will occupy.
    RFUITreeViewRowAnimationAutomatic = 1 << 6, // The tree view chooses an appropriate animation style for you.
};

NS_INLINE RFUITreeViewRowAnimation RFUITreeViewRowAnimationCorrectDeletingAnimation(RFUITreeViewRowAnimation treeViewRowAnimation)
{
    if ((treeViewRowAnimation & RFUITreeViewRowAnimationAutomatic) == RFUITreeViewRowAnimationAutomatic)
    {
        treeViewRowAnimation = RFUITreeViewRowAnimationFade;
    }
    
    if ((treeViewRowAnimation & (RFUITreeViewRowAnimationLeft | RFUITreeViewRowAnimationRight)) == (RFUITreeViewRowAnimationLeft | RFUITreeViewRowAnimationRight))
    {
        treeViewRowAnimation &= ~(RFUITreeViewRowAnimationLeft | RFUITreeViewRowAnimationRight);
    }
    
    if ((treeViewRowAnimation & (RFUITreeViewRowAnimationTop | RFUITreeViewRowAnimationBottom)) == (RFUITreeViewRowAnimationTop | RFUITreeViewRowAnimationBottom))
    {
        treeViewRowAnimation &= ~(RFUITreeViewRowAnimationTop | RFUITreeViewRowAnimationBottom);
    }
    
    return treeViewRowAnimation;
}
