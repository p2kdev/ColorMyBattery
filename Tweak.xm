#import <libcolorpicker.h>

@interface FBSystemService : NSObject
  +(id)sharedInstance;
  -(void)exitAndRelaunch:(BOOL)arg1;
@end

@interface UIImage (FlatImageWithColor)
- (UIImage *)_flatImageWithColor:(UIColor *)color;
@end

@interface _UILegibilityImageSet
  @property (nonatomic,retain) UIImage * image;
@end

@interface UIStatusBarBatteryItemView
  @property (assign,nonatomic) int cachedCapacity;
@end

@interface _UIBatteryView : UIView
  @property (assign,nonatomic) double chargePercent;
  @property (assign,nonatomic) BOOL saverModeActive;
  @property (assign,nonatomic) long long chargingState;
  @property (assign,nonatomic) BOOL showsInlineChargingIndicator;
@end

@interface _CDBatterySaver : NSObject
  +(id)sharedInstance;
  +(id)batterySaver;
  -(long long)getPowerMode;
@end

NSDictionary *pref = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.imkpatil.colormybattery.plist"];
static BOOL isEnabled = YES;
//static BOOL isBattPerdisabled = NO;

static UIColor* GetBattColor(int currentLevel)
{
  if( currentLevel > 95)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol1"], @"#53FE31");
  }
  else if( currentLevel > 90 && currentLevel < 96)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol1_1"], @"#53FE31");
  }

  else if( currentLevel > 85 && currentLevel < 91)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol2"], @"#47D9BC");
  }
  else if( currentLevel > 80 && currentLevel < 86)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol2_1"], @"#47D9BC");
  }

  else if( currentLevel > 75 && currentLevel < 81)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol3"], @"#437EE0");
  }
  else if( currentLevel > 70 && currentLevel < 76)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol3_1"], @"#437EE0");
  }

  else if( currentLevel > 65 && currentLevel < 71)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol4"], @"#4C43E0");
  }
  else if( currentLevel > 60 && currentLevel < 66)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol4_1"], @"#4C43E0");
  }

  else if( currentLevel > 55 && currentLevel < 61)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol5"], @"#833AEE");
  }
  else if( currentLevel > 50 && currentLevel < 56)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol5_1"], @"#833AEE");
  }

  else if( currentLevel > 45 && currentLevel < 51)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol6"], @"#E436F4");
  }
  else if( currentLevel > 40 && currentLevel < 46)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol6_1"], @"#E436F4");
  }

  else if( currentLevel > 35 && currentLevel < 41)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol7"], @"#F4EE36");
  }
  else if( currentLevel > 30 && currentLevel < 36)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol7_1"], @"#F4EE36");
  }

  else if( currentLevel > 25 && currentLevel < 31)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol8"], @"#FA8030");
  }
  else if( currentLevel > 20 && currentLevel < 26)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol8_1"], @"#FA8030");
  }

  else if( currentLevel > 15 && currentLevel < 21)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol9"], @"#F14034");
  }
  else if( currentLevel > 10 && currentLevel < 16)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol9_1"], @"#F14034");
  }

  else if( currentLevel > 5 && currentLevel < 11)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol10"], @"#FF4B3D");
  }
  else if( currentLevel > 0 && currentLevel < 6)
  {
      return LCPParseColorString([pref objectForKey:@"CustCol10_1"], @"#FF4B3D");
  }
  else
  {
    return nil;
  }
}

//iOS12 Support for devices with home button
// %hook UIStatusBarBatteryItemView
//
//   -(_UILegibilityImageSet *)cachedImageSet
//   {
//     _UILegibilityImageSet *original = %orig;
//
//     if (isEnabled)
//     {
//       original.image = nil;//[original.image _flatImageWithColor:GetBattColor(self.cachedCapacity)]
//
//       // if (self.saverModeActive)
//       // {
//       //     return LCPParseColorString([pref objectForKey:@"LPMColor"], @"#F4EE36");
//       // }
//       // else if ((self.chargingState) == 1)
//       // {
//       //   return LCPParseColorString([pref objectForKey:@"ChargeColor"], @"#53FE31");
//       // }
//       //
//       // int currentbat = (int)((self.chargePercent) * 100);
//
//     }
//
//     return original;
//   }
//
// %end

%hook _UIBatteryView

//iOS12 Support for devices with no home button
-(UIColor *)fillColor
{
  if (isEnabled)
  {
    //NSLog(@"[ColorMyBattery] ChargingState - %d",(int)self.chargingState);

    if (self.saverModeActive)
    {
        return LCPParseColorString([pref objectForKey:@"LPMColor"], @"#F4EE36");
    }
    else if ((self.chargingState) == 1)
    {
      return LCPParseColorString([pref objectForKey:@"ChargeColor"], @"#53FE31");
    }

    int currentbat = (int)((self.chargePercent) * 100);
    return GetBattColor(currentbat);

  }
  else
  {
    return %orig;
  }
}

- (UIColor *)_batteryColor
{
    if (isEnabled)
    {
      //NSLog(@"[ColorMyBattery] ChargingState - %d",(int)self.chargingState);

      if (self.saverModeActive)
      {
          return LCPParseColorString([pref objectForKey:@"LPMColor"], @"#F4EE36");
      }
      else if ((self.chargingState) == 1)
      {
        return LCPParseColorString([pref objectForKey:@"ChargeColor"], @"#53FE31");
      }

      int currentbat = (int)((self.chargePercent) * 100);
      return GetBattColor(currentbat);

    }
    else
    {
      return %orig;
    }
}

%end

%hook UIStatusBarForegroundStyleAttributes
-(id) _batteryColorForCapacity:(int)arg1 lowCapacity:(int)arg2 style:(unsigned long long)arg3 usingTintColor:(BOOL)arg4
{
  if (isEnabled)
  {
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];

    if ([[NSProcessInfo processInfo] isLowPowerModeEnabled])
    {
      return LCPParseColorString([pref objectForKey:@"LPMColor"], @"#F4EE36");
    }
    else if (([UIDevice currentDevice].batteryState == UIDeviceBatteryStateCharging) || ([UIDevice currentDevice].batteryState == UIDeviceBatteryStateFull))
    {
      return LCPParseColorString([pref objectForKey:@"ChargeColor"], @"#53FE31");
    }

    UIDevice *myDevice = [UIDevice currentDevice];
    int currentbat = (int)([myDevice batteryLevel] * 100);
    return GetBattColor(currentbat);
  }
  else
  {
    return %orig;
  }

}

%end

// %hook SBStatusBarStateAggregator
//
//   -(BOOL)_setItem:(int)arg1 enabled:(BOOL)arg2
//   {
//     if (arg1==9 && isBattPerdisabled)
//     {
//       return NO;
//     }
//
//     return %orig;
//   }
//
// %end

static void reloadSettings(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

  NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.imkpatil.colormybattery.plist"];
  if(prefs)
  {
      isEnabled = [prefs objectForKey:@"TwkEnabled"] ? [[prefs objectForKey:@"TwkEnabled"] boolValue] : isEnabled;
      //isBattPerdisabled = [prefs objectForKey:@"HideBattPer"] ? [[prefs objectForKey:@"HideBattPer"] boolValue] : isBattPerdisabled;
  }
  [prefs release];}

static void respring(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  [[%c(FBSystemService) sharedInstance] exitAndRelaunch:YES];
}

%ctor
{
  if ([[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.apple.springboard"]) {
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, reloadSettings, CFSTR("com.imkpatil.colormybattery.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        reloadSettings(nil, nil, nil, nil, nil);
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, respring, CFSTR("com.imkpatil.colormybattery.respring"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    }

}
