//
//  RXDeviceManager.m
//  RxLiu
//
//  Created by Ron on 11/2/17.
//  Copyright © 2017 RxLiu. All rights reserved.
//

#import "RXDeviceManager.h"
#import <sys/utsname.h>

static CGFloat iPhoneXStatusBarHeight = 44.0f;
static CGFloat iPhoneXHomeIndicator   = 34.0f;

NSOperatingSystemVersion RRVersionMake(NSInteger majorVersion, NSInteger minorVersion, NSInteger patchVersion) {
    NSOperatingSystemVersion rrVersion;
    rrVersion.majorVersion = majorVersion;
    rrVersion.minorVersion = minorVersion;
    rrVersion.patchVersion = patchVersion;
    return rrVersion;
}

@implementation RXDeviceManager

+ (BOOL)iPhoneX {
    NSString *device = [self deviceName];
    if ([device isEqualToString:@"iPhone X"]) {
        return YES;
    }
    if ([device isEqualToString:@"Simulator"]) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        return CGSizeEqualToSize(screenSize, CGSizeMake(375, 812));
    }
    return NO;
}

+ (CGFloat)safeContentHeight {
    return [self screenHeight] - [self statusBarHeight] - [self homeIndicatorHeight];
}

+ (CGFloat)safeContentHeightWithoutTabBar {
    return [self safeContentHeight] - kTabBarHeight;
}

+ (CGFloat)safeContentHeightWithoutNavigationBar {
    return [self safeContentHeight] - kNavigationBarHeight;
}

+ (CGFloat)safeContentHeightWithoutNavigationBarAndTabBar {
    return [self safeContentHeight] - kNavigationBarHeight - kTabBarHeight;
}

+ (CGFloat)dangerTopInsetWithNavigationBar {
    return [self statusBarHeight] + kNavigationBarHeight;
}

+ (CGFloat)dangerBottomInsetWithTabbar {
    return [self homeIndicatorHeight] + kTabBarHeight;
}

+ (CGFloat)contentHeightWithoutStatusBar {
    return [self screenHeight] - [self statusBarHeight];
}

+ (CGFloat)contentHeightWithoutHomeIndicator {
    return [self screenHeight] - [self homeIndicatorHeight];
}

+ (CGFloat)contentHeightWithoutNavigationBar {
    return [self screenHeight] - [self dangerTopInsetWithNavigationBar];
}

+ (CGFloat)statusBarHeight {
    return [self iPhoneX] ? iPhoneXStatusBarHeight : 20;
}

+ (CGFloat)homeIndicatorHeight {
    return [self iPhoneX] ? iPhoneXHomeIndicator : 0;
}

#pragma mark - <Screen>

+ (CGSize)screenSize {
    return [UIScreen mainScreen].bounds.size;
}

+ (CGFloat)screenHeight {
    return [self screenSize].height;
}

+ (CGFloat)screenWidth {
    return [self screenSize].width;
}

#pragma mark - <Device info>
+ (NSString *)deviceModelCode {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return code ? : @"Unknown";
}

+ (NSString *)deviceName {
    static NSDictionary *deviceNamesByCode = nil;
    if (!deviceNamesByCode) {
        deviceNamesByCode = @{
                              @"i386"      : @"Simulator",
                              @"x86_64"    : @"Simulator",
                              
                              @"iPod1,1"   : @"iPod Touch",        // Original
                              @"iPod2,1"   : @"iPod Touch",        // Second Generation
                              @"iPod3,1"   : @"iPod Touch",        // Third Generation
                              @"iPod4,1"   : @"iPod Touch",        // Fourth Generation
                              @"iPod7,1"   : @"iPod Touch",        // 6th Generation
                              
                              @"iPhone1,1" : @"iPhone",            // Original
                              @"iPhone1,2" : @"iPhone 3G",         // 3G
                              @"iPhone2,1" : @"iPhone 3GS",        // 3GS
                              @"iPhone3,1" : @"iPhone 4",          // GSM
                              @"iPhone3,3" : @"iPhone 4",          // CDMA
                              @"iPhone4,1" : @"iPhone 4S",         //
                              @"iPhone5,1" : @"iPhone 5",          //
                              @"iPhone5,2" : @"iPhone 5",          //
                              @"iPhone5,3" : @"iPhone 5c",         //
                              @"iPhone5,4" : @"iPhone 5c",         //
                              @"iPhone6,1" : @"iPhone 5s",         //
                              @"iPhone6,2" : @"iPhone 5s",         //
                              @"iPhone7,1" : @"iPhone 6 Plus",     //
                              @"iPhone7,2" : @"iPhone 6",          //
                              @"iPhone8,1" : @"iPhone 6S",         //
                              @"iPhone8,2" : @"iPhone 6S Plus",    //
                              @"iPhone8,4" : @"iPhone SE",         //
                              @"iPhone9,1" : @"iPhone 7",          //
                              @"iPhone9,3" : @"iPhone 7",          //
                              @"iPhone9,2" : @"iPhone 7 Plus",     //
                              @"iPhone9,4" : @"iPhone 7 Plus",     //
                              @"iPhone10,1": @"iPhone 8",          // CDMA
                              @"iPhone10,4": @"iPhone 8",          // GSM
                              @"iPhone10,2": @"iPhone 8 Plus",     // CDMA
                              @"iPhone10,5": @"iPhone 8 Plus",     // GSM
                              @"iPhone10,3": @"iPhone X",          // CDMA
                              @"iPhone10,6": @"iPhone X",          // GSM
                              
                              @"iPad1,1"   : @"iPad",              // Original
                              @"iPad2,1"   : @"iPad 2",            // Wi-Fi
                              @"iPad2,2"   : @"iPad 2",            // GSM
                              @"iPad2,3"   : @"iPad 2",            // 3G
                              @"iPad2,4"   : @"iPad 2",            // Wi-Fi
                              @"iPad2,5"   : @"iPad Mini",         // Wi-Fi
                              @"iPad2,6"   : @"iPad Mini",         // Wi-Fi + Cellular
                              @"iPad2,7"   : @"iPad Mini",         // Wi-Fi + Cellular
                              @"iPad3,1"   : @"iPad 3",            // 3rd Generation iPad
                              @"iPad3,2"   : @"iPad 3",            // Wi-Fi + Cellular
                              @"iPad3,3"   : @"iPad 3",            // Wi-Fi + Cellular
                              @"iPad3,4"   : @"iPad 4",            // 4th Generation iPad
                              @"iPad3,5"   : @"iPad 4",            // 4th Generation iPad - Wi-Fi + Cellular
                              @"iPad3,6"   : @"iPad 4",            // 4th Generation iPad - Wi-Fi + Cellular
                              @"iPad4,1"   : @"iPad Air",          // iPad Air - Wifi
                              @"iPad4,2"   : @"iPad Air",          // iPad Air - Cellular
                              @"iPad4,3"   : @"iPad Air",          // iPad Air - Cellular
                              @"iPad4,4"   : @"iPad Mini 2",       // 2nd Generation iPad Mini - Wifi
                              @"iPad4,5"   : @"iPad Mini 2",       // 2nd Generation iPad Mini - Cellular
                              @"iPad4,6"   : @"iPad Mini 2",       // 2nd Generation iPad Mini - Cellular
                              @"iPad4,7"   : @"iPad Mini 3",       // 3rd Generation iPad Mini - Wifi (model A1599))
                              @"iPad4,8"   : @"iPad Mini 3",       // 3rd Generation iPad Mini - Wifi + Cellular
                              @"iPad4,9"   : @"iPad Mini 3",       // 3rd Generation iPad Mini - Wifi + Cellular
                              @"iPad5,1"   : @"iPad Mini 4",       // 4th Generation iPad Mini - Wifi
                              @"iPad5,2"   : @"iPad Mini 4",       // 4th Generation iPad Mini - Wifi + Cellular
                              @"iPad5,3"   : @"iPad Air 2",        // iPad Air - Wifi
                              @"iPad5,4"   : @"iPad Air 2",        // iPad Air - Wifi + Cellular
                              @"iPad6,3"   : @"iPad Pro (9.7\")",       // iPad Pro 9.7 inches
                              @"iPad6,4"   : @"iPad Pro (9.7\")",       // iPad Pro 9.7 inches
                              @"iPad6,7"   : @"iPad Pro (12.9\")",      // iPad Pro 12.9 inches
                              @"iPad6,8"   : @"iPad Pro (12.9\")",      // iPad Pro 12.9 inches
                              @"iPad6,11"  : @"iPad Pro (12.9\")",      // 5th Generation iPad - Wifi
                              @"iPad6,12"  : @"iPad Pro (12.9\")",      // 5th Generation iPad - Wifi + Cellular
                              @"iPad7,1"   : @"iPad Pro 2 (12.9\")",    // 2nd Generation iPad Pro 12.9 inches
                              @"iPad7,2"   : @"iPad Pro 2 (12.9\")",    // 2nd Generation iPad Pro 12.9 inches - Wifi + Cellular
                              @"iPad7,3"   : @"iPad Pro (10.5\")",      // iPad Pro 10.5 inches
                              @"iPad7,4"   : @"iPad Pro (10.5\")",      // iPad Pro 10.5 inches - Wifi + Cellular
                              };
    }
    NSString *code = [self deviceModelCode];
    NSString *deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        } else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        } else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        } else {
            deviceName = @"Unknown";
        }
    }
    return deviceName;
}

#pragma mark - <SystemInfo>

/// current system version < matchVersion ?.
+ (BOOL)lessThanVersion:(NSOperatingSystemVersion)matchVersion {
    return ![self gteVersion:matchVersion];
}

/// current system version ≥ matchVersion ?. | gte (greater than or equal to) |
+ (BOOL)gteVersion:(NSOperatingSystemVersion)matchVersion {
    return [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:matchVersion];
}

@end
