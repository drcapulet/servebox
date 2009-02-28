/* SS_PrefsController */

#import <Cocoa/Cocoa.h>

@interface SS_PrefsController : NSObject
{
    NSWindow *prefsWindow;
    NSMutableDictionary *preferencePanes;
    NSMutableArray *panesOrder;
    NSString *bundleExtension;
    NSString *searchPath;
    NSToolbar *prefsToolbar;
    NSMutableDictionary *prefsToolbarItems;
    NSToolbarDisplayMode toolbarDisplayMode;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
    NSToolbarSizeMode toolbarSizeMode;
#endif
    BOOL usesTexturedWindow;
    BOOL alwaysShowsToolbar;
    BOOL alwaysOpensCentered;
    BOOL debug;
}

// Convenience constructors
+ (id)preferencesWithPanesSearchPath:(NSString*)path bundleExtension:(NSString *)ext;
+ (id)preferencesWithBundleExtension:(NSString *)ext;
+ (id)preferencesWithPanesSearchPath:(NSString*)path;
+ (id)preferences;
// Designated initializer
- (id)initWithPanesSearchPath:(NSString*)path bundleExtension:(NSString *)ext;
// Other initializers
- (id)initWithBundleExtension:(NSString *)ext;
- (id)initWithPanesSearchPath:(NSString*)path;

	// Create and show preferences window
- (void)createPreferencesWindow; // create and don't show
- (void)showPreferencesWindow; // create and show

	// Manual destroy
- (void)destroyPreferencesWindow; // should not need to call

	// Explicitly loading a specific preference pane
- (BOOL)loadPreferencePaneNamed:(NSString *)name;

	// Accessing the Preferences window directly
- (NSWindow *)preferencesWindow;

	// Accessing properties related to preference pane bundles
- (NSString *)bundleExtension;
- (NSString *)searchPath;
- (NSArray *)loadedPanes;

// Behaviour
- (void)setAlwaysShowsToolbar:(BOOL)newAlwaysShowsToolbar;
- (BOOL)alwaysShowsToolbar;
- (void)setAlwaysOpensCentered:(BOOL)newAlwaysOpensCentered;
- (BOOL)alwaysOpensCentered;
- (void)setDebug:(BOOL)newDebug;
- (BOOL)debug;

// Display characteristics
- (void)setPanesOrder:(NSArray *)newPanesOrder;
- (NSArray *)panesOrder;
- (void)setToolbarDisplayMode:(NSToolbarDisplayMode)displayMode;
- (NSToolbarDisplayMode)toolbarDisplayMode;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (NSToolbarSizeMode)toolbarSizeMode;
- (void)setToolbarSizeMode:(NSToolbarSizeMode)sizeMode;
#endif
- (void)setUsesTexturedWindow:(BOOL)newUsesTexturedWindow;
- (BOOL)usesTexturedWindow;

@end
