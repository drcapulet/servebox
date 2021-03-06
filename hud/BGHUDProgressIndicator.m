//
//  BGHUDProgressIndicator.m
//  BGHUDAppKit
//
//  Created by BinaryGod on 6/6/08.
//
//  Copyright (c) 2008, Tim Davis (BinaryMethod.com, binary.god@gmail.com)
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//
//		Redistributions of source code must retain the above copyright notice, this
//	list of conditions and the following disclaimer.
//
//		Redistributions in binary form must reproduce the above copyright notice,
//	this list of conditions and the following disclaimer in the documentation and/or
//	other materials provided with the distribution.
//
//		Neither the name of the BinaryMethod.com nor the names of its contributors
//	may be used to endorse or promote products derived from this software without
//	specific prior written permission.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS AS IS AND
//	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//	IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//	INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
//	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
//	OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//	WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
//	POSSIBILITY OF SUCH DAMAGE.

#import "BGHUDProgressIndicator.h"

struct NSProgressIndicator_t {
    @defs(NSProgressIndicator)
};

@implementation BGHUDProgressIndicator

#pragma mark Drawing Functions

-(id)initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder: aDecoder];
	
	if(self) {
		
		themeManager = [[BGGradientTheme alloc] init];
	}
	
	return self;
}

- (void)_drawThemeBackground {
	
	if(themeManager) {
		
		NSRect frame = [self bounds];
		
		//Adjust rect based on size
		switch ([self controlSize]) {
				
			case NSRegularControlSize:
				
				frame.origin.x += 2.5;
				frame.origin.y += .5;
				frame.size.width -= 5;
				frame.size.height -= 5;
				break;
			case NSSmallControlSize:
				
				
				break;
			case NSMiniControlSize:
				
				
				break;
		}
		
		
		NSBezierPath *path = [NSBezierPath bezierPathWithRect: frame];
		
		//Draw border
		[NSGraphicsContext saveGraphicsState];
		[[themeManager dropShadow] set];
		[[themeManager darkStrokeColor] set];
		[path stroke];
		[NSGraphicsContext restoreGraphicsState];
		
		//Draw Fill
		[[themeManager progressTrackGradient] drawInRect: NSInsetRect(frame, 0, 0) angle: 90];
		[[themeManager strokeColor] set];
		[path stroke];
		
		if(![self isIndeterminate]) {
			
			frame.size.width = ((frame.size.width / ([self maxValue] - [self minValue])) * ([self doubleValue] - [self minValue]));
			[[themeManager highlightGradient] drawInRect: frame angle: 90];
			
		} else {
			
			//Setup Our Complex Path
			//Adjust Frame width
			frame.origin.x -= 40;
			frame.size.width += 80;
			
			NSPoint position = NSMakePoint(frame.origin.x, frame.origin.y);
			
			if(progressPath) {[progressPath release];}
			progressPath = [[NSBezierPath alloc] init];
			
			while(position.x <= (frame.origin.x + frame.size.width)) {
				
				[progressPath moveToPoint: NSMakePoint(position.x, position.y)];
				[progressPath lineToPoint: NSMakePoint(position.x + frame.size.height, position.y)];
				[progressPath lineToPoint: NSMakePoint(position.x + ((frame.size.height *2)), position.y + frame.size.height)];
				[progressPath lineToPoint: NSMakePoint(position.x + (frame.size.height), position.y + frame.size.height)];
				[progressPath closePath];
				
				position.x += ((frame.size.height *2));
			}
		}
	} else {
		
		[super _drawThemeBackground];
	}
}

- (void)_drawThemeProgressArea:(BOOL)flag {
	
	if(themeManager) {
		
		NSRect frame = [self bounds];
		
		//Adjust rect based on size
		switch ([self controlSize]) {
				
			case NSRegularControlSize:
				
				frame.origin.x += 2.5;
				frame.origin.y += .5;
				frame.size.width -= 5;
				frame.size.height -= 5;
				break;
			case NSSmallControlSize:
				
				
				break;
			case NSMiniControlSize:
				
				
				break;
		}
		
		if([self isIndeterminate]) {
			
			//Setup Cliping Rect
			[NSBezierPath clipRect: NSInsetRect(frame, 1, 1)];
			
			//Fill Background
			[[themeManager normalGradient] drawInRect: frame angle: 90];
			
			//Create XFormation
			NSAffineTransform *trans = [NSAffineTransform transform];
			[trans translateXBy: (-37 + ((struct NSProgressIndicator_t*)self)->_animationIndex) yBy: 0];
			
			//Apply XForm to path
			NSBezierPath *newPath = [trans transformBezierPath: progressPath];
			
			[[themeManager highlightGradient] drawInBezierPath: newPath angle: 90];
			
		} else {
			
			
		}
	} else {
		
		[super _drawThemeProgressArea: flag];
	}
}

#pragma mark -
#pragma mark Helper Methods

-(void)setThemeManager:(BGThemeManager *)manager {
	
	themeManager = [manager retain];
}

-(void)dealloc {
	
	[themeManager release];
	[progressPath release];
	[super dealloc];
}

#pragma mark -

@end
