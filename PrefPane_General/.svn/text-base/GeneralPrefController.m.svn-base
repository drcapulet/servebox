#import "GeneralPrefController.h"

@implementation GeneralPrefController


+ (NSArray *)preferencePanes
{
    return [NSArray arrayWithObjects:[[[GeneralPrefController alloc] init] autorelease], nil];
}


- (NSView *)paneView
{
    BOOL loaded = YES;
    
    if (!prefsView) {
        loaded = [NSBundle loadNibNamed:@"GeneralPrefPaneView" owner:self];
    }
    
    if (loaded) {
        return prefsView;
    }
    
    return nil;
}


- (NSString *)paneName
{
    return @"General";
}


- (NSImage *)paneIcon
{
    return [[[NSImage alloc] initWithContentsOfFile:
        [[NSBundle bundleForClass:[self class]] pathForImageResource:@"General_Prefs"]
        ] autorelease];
}


- (NSString *)paneToolTip
{
    return @"General Preferences";
}


- (BOOL)allowsHorizontalResizing
{
    return NO;
}


- (BOOL)allowsVerticalResizing
{
    return NO;
}

 - (BOOL)alwaysOpensCentered 
 {
	return YES;
}

@end
