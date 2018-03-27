//
//  RXDeviceManager.h
//  RxLiu
//
//  Created by Ron on 11/2/17.
//  Copyright © 2017 RxLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static CGFloat kNavigationBarHeight = 44.0f;
static CGFloat kTabBarHeight        = 49.0f;

@interface RXDeviceManager : NSObject

+ (BOOL)iPhoneX;

+ (CGFloat)safeContentHeight;

+ (CGFloat)safeContentHeightWithoutNavigationBar;

+ (CGFloat)safeContentHeightWithoutTabBar;

+ (CGFloat)safeContentHeightWithoutNavigationBarAndTabBar;

+ (CGFloat)dangerTopInsetWithNavigationBar;

+ (CGFloat)dangerBottomInsetWithTabbar;

+ (CGFloat)contentHeightWithoutStatusBar;

+ (CGFloat)contentHeightWithoutHomeIndicator;

+ (CGFloat)contentHeightWithoutNavigationBar;

+ (CGFloat)statusBarHeight;

+ (CGFloat)homeIndicatorHeight;

+ (NSString *)deviceModelCode;

+ (NSString *)deviceName;

+ (CGSize)screenSize;

#pragma mark - Version

NSOperatingSystemVersion RRVersionMake(NSInteger majorVersion, NSInteger minorVersion, NSInteger patchVersion);

+ (BOOL)gteVersion:(NSOperatingSystemVersion)matchVersion;

+ (BOOL)lessThanVersion:(NSOperatingSystemVersion)matchVersion;

@end
