//
//  DYFDeviceUtils.m
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

#import "DYFDeviceUtils.h"
#import <sys/sysctl.h>

// Key
static NSString *const mUsername    = @"myapp.uuid";
static NSString *const mServiceName = @"myapp.uuid.svc";

// Idetifier
static const char *hw_model   = "hw.model";
static const char *hw_machine = "hw.machine";

CG_INLINE NSString *DYFGetSystemHardwareByName(const char *typeSpecifier) {
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    NSString *results = [NSString stringWithUTF8String:answer];
    free(answer);
    
    return results;
}

CG_INLINE BOOL DYFAdvertisingTrackingEnabled() {
#if DYF_IDFA_ALLOWED
    return [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
#else
    return NO;
#endif
}

CG_INLINE NSString *DYFAdvertisingIdentifierUUIDString() {
#if DYF_IDFA_ALLOWED
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
#else
    return nil;
#endif
}

@implementation DYFDeviceUtils

+ (void)deleteItemForUsername:(NSString *)username serviceName:(NSString *)serviceName {
    [SFHFKeychainUtils deleteItemForUsername:username andServiceName:serviceName error:nil withAccessible:YES];
}

+ (NSString *)generateUUID {
    NSString *uuid = nil;
    if (DYF_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        if (DYFAdvertisingTrackingEnabled()) {
            uuid = DYFAdvertisingIdentifierUUIDString();
        } else {
            uuid = [self getVendorIdentifier];
        }
    } else {
#if DYF_IDFA_ALLOWED
        uuid = DYFAdvertisingIdentifierUUIDString();
#else
        uuid = [self getVendorIdentifier];
#endif
    }
    return uuid;
}

+ (NSString *)getUUID {
#if DYF_DELETE_KEYC_ITEM
    [self deleteItemForUsername:mUsername serviceName:mServiceName]; return nil;
#else
    NSString *identifier = [SFHFKeychainUtils getPasswordForUsernameV2:mUsername andServiceName:mServiceName error:nil];
    if (!identifier) {
        identifier = [self generateUUID];
        [SFHFKeychainUtils storeUsername:mUsername andPassword:identifier forServiceName:mServiceName updateExisting:YES error:nil];
    }
    return identifier;
#endif
}

+ (BOOL)isAdvertisingTrackingEnabled {
    return DYFAdvertisingTrackingEnabled();
}

+ (NSString *)getAdvertisingIdentifier {
    return DYFAdvertisingIdentifierUUIDString();
}

+ (NSString *)getModel {
    return DYFGetSystemHardwareByName(hw_model);
}

+ (NSString *)getMachine {
    return DYFGetSystemHardwareByName(hw_machine);
}

+ (NSString *)getCountryCode {
    return [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
}

+ (NSString *)getPreferredLanguage {
    NSString *lang = nil;
    
    if ([[NSLocale preferredLanguages] count] > 0) {
        lang = [[NSLocale preferredLanguages] objectAtIndex:0];
    } else {
        lang = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    }
    
    NSString *occurs = [@"-" stringByAppendingString:[self getCountryCode]];
    
    return [lang stringByReplacingOccurrencesOfString:occurs withString:@""];
}

+ (NSString *)getVendorIdentifier {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)getSystemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)getDeviceName {
    return [[UIDevice currentDevice] name];
}

+ (UIDeviceBatteryState)getBatteryState {
    return [[UIDevice currentDevice] batteryState];
}

+ (float)getBatteryLevel {
    return [[UIDevice currentDevice] batteryLevel];
}

+ (UIUserInterfaceIdiom)getUserInterfaceIdiom {
    return [[UIDevice currentDevice] userInterfaceIdiom];
}

+ (BOOL)isMultitaskingSupported {
    return [[UIDevice currentDevice] isMultitaskingSupported];
}

@end
