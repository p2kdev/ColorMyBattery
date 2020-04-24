#import <Preferences/Preferences.h>
#import <libcolorpicker.h>

#define powercolorPath @"/User/Library/Preferences/com.imkpatil.colormybattery.plist"

@interface colormybatListController : PSListController
// - (void)visitPaypal;
// - (void)visitTwitter;
- (void)respring;
@end

@implementation colormybatListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"ColorMyBattery" target:self] retain];
	}
	return _specifiers;
}

-(id) readPreferenceValue:(PSSpecifier*)specifier {
    NSDictionary *powercolorSettings = [NSDictionary dictionaryWithContentsOfFile:powercolorPath];
    if (!powercolorSettings[specifier.properties[@"key"]]) {
        return specifier.properties[@"default"];
    }
    return powercolorSettings[specifier.properties[@"key"]];
}

-(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:powercolorPath]];
    [defaults setObject:value forKey:specifier.properties[@"key"]];
    [defaults writeToFile:powercolorPath atomically:YES];
    //  NSDictionary *powercolorSettings = [NSDictionary dictionaryWithContentsOfFile:powercolorPath];
    CFStringRef toPost = (CFStringRef)specifier.properties[@"PostNotification"];
    if(toPost) CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), toPost, NULL, NULL, YES);
}

// - (void)selectBattColor
// {
// 	// NSMutableDictionary *prefsDict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.chikuwa.flashcolor.plist"];
// 	// if (!prefsDict) prefsDict = [NSMutableDictionary dictionary];
// 	// 			NSString *readFromKey = @"someCoolKey";
// 	// 			NSString *fallbackHex = @"#ff0000";  // (You want to load from prefs probably)
// 	//     UIColor *startColor = LCPParseColorString([prefsDict objectForKey:@"Color"], fallbackHex); // this color will be used at startup
// 	//     PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:startColor showAlpha:YES];
// 	//     [alert displayWithCompletion:
// 	//     ^void (UIColor *pickedColor){
// 	// 			NSString *hexString = [UIColor hexFromColor:pickedColor];
// 	// 			[prefsDict setObject:hexString forKey:@"Color"];
// 	// 			[prefsDict writeToFile:@"/var/mobile/Library/Preferences/com.chikuwa.flashcolor.plist" atomically:YES];
// 	//     }];
// }

// - (void)visitPaypal {
// 	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/patilkiran08/5"]];
// }
//
// - (void)visitTwitter {
//   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/imkpatil"]];
// }

- (void)respring {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.imkpatil.colormybattery.respring"), NULL, NULL, YES);
		//[(SpringBoard *)[UIApplication sharedApplication] _relaunchSpringBoardNow];
		// #pragma GCC diagnostic push
		// #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    // system("cd /var/mobile/Library/Caches/com.apple.UIStatusBar; rm -R -f images; rm -f version; killall -9 SpringBoard");  //clears status bar cache + respring.
		// #pragma GCC diagnostic pop
}

@end



// vim:ft=objc
