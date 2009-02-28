#import "AppController.h"

@implementation AppController

- (void)dealloc
{
    [prefs release];
	[super dealloc];
}

- (IBAction)showPrefs:(id)sender
{
    if (!prefs) {
        // Determine path to the sample preference panes
        NSString *pathToPanes = [[NSString stringWithFormat:@"%@/Contents/Preference Panes/", [[NSBundle mainBundle] bundlePath]]
            stringByStandardizingPath];
        
        prefs = [[SS_PrefsController alloc] initWithPanesSearchPath:pathToPanes];
        
        // Set which panes are included, and their order.
        [prefs setPanesOrder:[NSArray arrayWithObjects:@"General", @"Updates", @"A Non-Existent Preference Pane", nil]];
		
    }
    
    // Show the preferences window.
    [prefs showPreferencesWindow];
}

- (NSString *)state
{
	NSNumber *state = [[[NSUserDefaultsController sharedUserDefaultsController] values] valueForKey:@"someOption"];
	if(state) {
		return ([state intValue] == NSOnState) ? @"checked" : @"unchecked";
	}
	return nil;
}

@end
