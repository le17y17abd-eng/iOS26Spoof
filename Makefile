ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:15.0

THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = iOS26Spoof
iOS26Spoof_FILES = Tweak.x
iOS26Spoof_CFLAGS = -fobjc-arc

BUNDLE_NAME = iOS26SpoofPrefs
iOS26SpoofPrefs_FILES = iOS26SpoofPrefs/RootListController.m
iOS26SpoofPrefs_FRAMEWORKS = UIKit
iOS26SpoofPrefs_PRIVATE_FRAMEWORKS = Preferences
iOS26SpoofPrefs_INSTALL_PATH = /Library/PreferenceBundles
iOS26SpoofPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk
