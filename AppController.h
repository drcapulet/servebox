/* AppController */

#import <Cocoa/Cocoa.h>

#import "SS_PrefsController/SS_PrefsController.h"

@interface AppController : NSObject
{
    SS_PrefsController *prefs;
	IBOutlet NSTextField *msg;
}

- (IBAction)showPrefs:(id)sender;
- (NSString *)state; // Return state of 'someOption' as 'checked' or 'unchecked'
@end
