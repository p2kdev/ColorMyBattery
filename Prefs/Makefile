export THEOS_PACKAGE_SCHEME=rootless
export TARGET = iphone:clang:13.7:13.0

include $(THEOS)/makefiles/common.mk

export ARCHS = arm64 arm64e

BUNDLE_NAME = ColorMyBattery
ColorMyBattery_FILES = ColorMyBattery.m
ColorMyBattery_INSTALL_PATH = /var/jb/Library/PreferenceBundles
ColorMyBattery_FRAMEWORKS = UIKit CoreGraphics QuartzCore
ColorMyBattery_PRIVATE_FRAMEWORKS = Preferences
ColorMyBattery_LIBRARIES = colorpicker
ColorMyBattery_CFLAGS = -fobjc-arc
include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ColorMyBattery.plist$(ECHO_END)
