//
//  BGHUDTextFieldCell.m
//  BGHUDAppKit
//
//  Created by BinaryGod on 6/2/08.
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

#import "BGHUDTextFieldCell.h"


@implementation BGHUDTextFieldCell

@synthesize themeKey;

#pragma mark Drawing Functions

- (id)initTextCell:(NSString *)aString {

	self = [super initTextCell: aString];
	
	if(self) {
		
		self.themeKey = @"gradientTheme";
		[self setTextColor: [[[BGThemeManager keyedManager] themeForKey: self.themeKey] textColor]];
		
		if([self drawsBackground]) {
			
			fillsBackground = YES;
		}
		
		[self setDrawsBackground: NO];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *) aDecoder {

	self = [super initWithCoder: aDecoder];
	
	if(self) {
		
		self.themeKey = @"gradientTheme";
		[self setTextColor: [[[BGThemeManager keyedManager] themeForKey: self.themeKey] textColor]];
		
		if([self drawsBackground]) {
			
			fillsBackground = YES;
		}
		
		[self setDrawsBackground: NO];
	}
	
	return self;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
		
	//Adjust Rect
	cellFrame.origin.x += .5;
	cellFrame.origin.y += .5;
	cellFrame.size.width -= 1;
	cellFrame.size.height -= 1;
	
	//Draw Background
	if(fillsBackground) {
		
		[[[[BGThemeManager keyedManager] themeForKey: self.themeKey] textFillColor] set];
		NSRectFill(cellFrame);
	}
	
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect: cellFrame
														 xRadius: 3
														 yRadius: 3];
	
	if([self isBezeled] || [self isBordered]) {
		
		[[[[BGThemeManager keyedManager] themeForKey: self.themeKey] strokeColor] set];
		[path setLineWidth: 1.0];
		[path stroke];
	}
	
	[super drawInteriorWithFrame: cellFrame inView: controlView];
}

#pragma mark -
#pragma mark Helper Methods

-(void)dealloc {
	
	[super dealloc];
}

#pragma mark -

@end
