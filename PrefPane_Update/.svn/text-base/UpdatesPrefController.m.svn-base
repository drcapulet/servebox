#import "UpdatesPrefController.h"

@implementation UpdatesPrefController


- (IBAction)buttonClicked:(id)sender
{
    NSBeginInformationalAlertSheet(@"This is just a demo",
                                   @"OK",
                                   nil, nil, [prefsView window], self, nil, nil, nil,
                                   @"The button doesn't really do anything.");
}


// Protocol methods

+ (NSArray *)preferencePanes
{
    return [NSArray arrayWithObjects:[[[UpdatesPrefController alloc] init] autorelease], nil];
}


- (NSView *)paneView
{
    BOOL loaded = YES;
    
    if (!prefsView) {
        loaded = [NSBundle loadNibNamed:@"UpdatesPrefPaneView" owner:self];
    }
    
    if (loaded) {
        return prefsView;
    }
    
    return nil;
}


- (NSString *)paneName
{
    return @"Updates";
}


- (NSImage *)paneIcon
{
    return [[[NSImage alloc] initWithContentsOfFile:
        [[NSBundle bundleForClass:[self class]] pathForImageResource:@"Update_Prefs"]
        ] autorelease];
}


- (NSString *)paneToolTip
{
    return @"Update Preferences";
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
