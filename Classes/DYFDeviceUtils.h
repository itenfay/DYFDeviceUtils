//
//  DYFDeviceUtils.h
//
//  Created by dyf on 14/10/21.
//  Copyright (c) 2014 dyf. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Allows idfa. Default 0.
#ifndef DYF_IDFA_ALLOWED
    #define DYF_IDFA_ALLOWED            0
#endif

// Deletes the item of keychain for device identifier. Default 0.
#ifndef DYF_DELETE_KEYC_ITEM
    #define DYF_DELETE_KEYC_ITEM        0
#endif

// Imports AdSupport
#if DYF_IDFA_ALLOWED
#import <AdSupport/AdSupport.h>
#endif

#import "SFHFKeychainUtils.h"

// System version comparing, v likes this: @"11.0"
#define DYF_SYSTEM_VERSION_EQUAL_TO(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define DYF_SYSTEM_VERSION_GREATER_THAN(v)             ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define DYF_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define DYF_SYSTEM_VERSION_LESS_THAN(v)                ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define DYF_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface DYFDeviceUtils : NSObject

/**
 *	Gets universal unique identifier.
 */
+ (nullable NSString *)getUUID;

/**
 *  Whether enable advertising tracking or not. Return YES or NO.
 */
+ (BOOL)isAdvertisingTrackingEnabled;

/**
 *  Gets advertising identifier.
 */
+ (nullable NSString *)getAdvertisingIdentifier;

/**
 *	Gets system hardware model.
 */
+ (nullable NSString *)getModel;

/**
 *	Gets system hardware machine identifier.
 */
+ (nullable NSString *)getMachine;

/**
 *	Gets country code.
 */
+ (nullable NSString *)getCountryCode;

/**
 *	Gets preferred language.
 */
+ (nullable NSString *)getPreferredLanguage;

/**
 *  Gets vendor identifier.
 */
+ (nullable NSString *)getVendorIdentifier;

/**
 *	Gets system version.
 */
+ (nullable NSString *)getSystemVersion;

/**
 *	Gets device name. e.g.:"Jhon's iPhoneX"
 */
+ (nullable NSString *)getDeviceName;

/**
 *	Gets battery state.
 */
+ (UIDeviceBatteryState)getBatteryState;

/**
 *	Gets battery level. e.g.: 0.86
 */
+ (float)getBatteryLevel;

/**
 *	Gets user interface idiom.
 */
+ (UIUserInterfaceIdiom)getUserInterfaceIdiom;

/**
 *	Whether support multitasking or not. Return YES or NO.
 */
+ (BOOL)isMultitaskingSupported;

@end
