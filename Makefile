export THEOS_PACKAGE_SCHEME=rootless
export TARGET = iphone:clang:13.7:13.0

PACKAGE_VERSION=$(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS)/makefiles/common.mk

export ARCHS = arm64 arm64e

TWEAK_NAME = ColorMyBattery
ColorMyBattery_FILES = Tweak.xm
ColorMyBattery_FRAMEWORKS = UIKit
ColorMyBattery_LIBRARIES = colorpicker
ColorMyBattery_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
after-install::
	install.exec "cd /var/mobile/Library/Caches/com.apple.UIStatusBar; rm -R -f images; rm -f version; killall -9 SpringBoard"
SUBPROJECTS += Prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
