#import <Preferences/Preferences.h>
#import <libcolorpicker.h>

@interface colormybatListController : PSListController
- (void)respring;
@end

@implementation colormybatListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"ColorMyBattery" target:self];
	}
	return _specifiers;
}

- (void)respring {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.imkpatil.colormybattery.respring"), NULL, NULL, YES);
}

@end