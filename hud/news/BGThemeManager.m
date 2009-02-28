//
//  BGThemeManager.m
//  BGHUDAppKit
//
//  Created by BinaryGod on 6/15/08.
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

#import "BGThemeManager.h"


@implementation BGThemeManager

static BGThemeManager *keyedManager = nil;
//static NSMutableDictionary *themes = nil;

+ (BGThemeManager *)keyedManager;
{
    @synchronized(self) {
		
        if (keyedManager == nil) {
			
            [[self alloc] init]; // assignment not done here
        }
    }
    return keyedManager;
}

+ (id)allocWithZone:(NSZone *)zone;
{
    @synchronized(self) {
		
        if (keyedManager == nil) {
			
            keyedManager = [super allocWithZone: zone];
			
			[keyedManager initDefaultThemes];

            return keyedManager;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

-(void)initDefaultThemes {
	
	themes = [[NSMutableDictionary alloc] initWithCapacity: 2];
	[themes setObject: [[BGTheme alloc] init] forKey: @"flatTheme"];
	[themes setObject: [[BGGradientTheme alloc] init] forKey: @"gradientTheme"];
}

- (BGTheme *)themeForKey:(NSString *)key {

	if([themes objectForKey: key]) {
		
		return [themes objectForKey: key];
	} else {
		
		return [themes objectForKey: @"gradientTheme"];
	}
}

- (void)setTheme:(BGTheme *)theme forKey:(NSString *)key {
	
	[themes setObject: theme forKey: key];
}

- (id)copyWithZone:(NSZone *)zone; {
    return self;
}

- (id)retain; {
    return self;
}

- (unsigned)retainCount; {
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release; {
    //do nothing
}

- (id)autorelease; {
    return self;
}

@end
