[If this project can help you, please give it a star. Thanks!](https://github.com/chenxing640/DYFDeviceUtils)

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)&nbsp;

## DYFDeviceUtils

A small utility tool for getting the basic information about iOS device.

## Group (ID:614799921)

<div align=left>
&emsp; <img src="https://github.com/chenxing640/DYFDeviceUtils/raw/master/images/g614799921.jpg" width="30%" />
</div>

## Usage

1. Depends on SFHFKeychainUtils.

```
pod 'SFHFKeychainUtils', '~> 1.0.0'
```

2. If you join up advertising tracking, set DYF_IDFA_ALLOWED to 1.

```
// Allows idfa. Default 0.
#ifndef DYF_IDFA_ALLOWED
    #define DYF_IDFA_ALLOWED            0
#endif
```

3. If you delete the item of keychain for device identifier, set DYF_DELETE_KEYC_ITEM to 1.

```
// Deletes the item of keychain for device identifier. Default 0.
#ifndef DYF_DELETE_KEYC_ITEM
    #define DYF_DELETE_KEYC_ITEM        0
#endif
```

4. Get and print the basic information.

```
// Gets device identifier.
NSString *deviceID = DYFDeviceUtils.getUUID;
NSLog(@"device identifier: %@", deviceID);

// Gets device name.
NSString *deviceName = DYFDeviceUtils.getDeviceName;
NSLog(@"device name: %@", deviceName);

// Whether enable advertising tracking or not.
BOOL adTrackingEnabled = DYFDeviceUtils.isAdvertisingTrackingEnabled;
NSLog(@"ad tracking enabled: %d", adTrackingEnabled);

// Gets idfa.
NSString *idfa = DYFDeviceUtils.getAdvertisingIdentifier;
NSLog(@"idfa: %@", idfa);

// Gets idfv.
NSString *idfv = DYFDeviceUtils.getVendorIdentifier;
NSLog(@"idfv: %@", idfv);

// Gets system hardware model.
NSString *hwModel = DYFDeviceUtils.getModel;
NSLog(@"hardware model: %@", hwModel);

// Gets system hardware machine identifier.
NSString *hwMachine = DYFDeviceUtils.getMachine;
NSLog(@"hardware machine: %@", hwMachine);

// Gets country code.
NSString *countryCode = DYFDeviceUtils.getCountryCode;
NSLog(@"country code: %@", countryCode);

// Gets preferred language.
NSString *preferredLanguage = DYFDeviceUtils.getPreferredLanguage;
NSLog(@"preferred language: %@", preferredLanguage);

// Gets system version.
NSString *sysVersion = DYFDeviceUtils.getSystemVersion;
NSLog(@"system version: %@", sysVersion);

// Gets user interface idiom.
UIUserInterfaceIdiom uiIfIdiom = DYFDeviceUtils.getUserInterfaceIdiom;
NSLog(@"user interface idiom: %zi", uiIfIdiom);

// Gets battery state.
// UIDeviceBatteryStateUnknown,
// UIDeviceBatteryStateUnplugged,   // on battery, discharging
// UIDeviceBatteryStateCharging,    // plugged in, less than 100%
// UIDeviceBatteryStateFull,        // plugged in, at 100%
UIDeviceBatteryState batteryState = DYFDeviceUtils.getBatteryState;
NSLog(@"battery state.: %zi", batteryState);

// Gets battery level.
CGFloat batteryLevel = DYFDeviceUtils.getBatteryLevel;
NSLog(@"battery level: %.2f", batteryLevel);

// Whether support multitasking or not.
BOOL multitaskingSupported = DYFDeviceUtils.isMultitaskingSupported;
NSLog(@"multitasking supported: %d", multitaskingSupported);
```

## Logs

```
DYFDeviceUtils[3706:666709] device identifier: DB5D6298-73C9-459E-B279-93CF0E97866C
DYFDeviceUtils[3706:666709] device name: Hanson lee
DYFDeviceUtils[3706:666709] ad tracking enabled: 0
DYFDeviceUtils[3706:666709] idfa: CF0E9786-9EA6-1A8C-D342-C90E26C889A0
DYFDeviceUtils[3706:666709] idfv: DB5D6298-73C9-459E-B279-93CF0E97866C
DYFDeviceUtils[3706:666709] hardware model: D21AP
DYFDeviceUtils[3706:666709] hardware machine: iPhone10,2
DYFDeviceUtils[3706:666709] country code: CN
DYFDeviceUtils[3706:666709] preferred language: zh-Hans
DYFDeviceUtils[3706:666709] system version: 12.3.1
DYFDeviceUtils[3706:666709] user interface idiom: 0
DYFDeviceUtils[3706:666709] battery state.: 0
DYFDeviceUtils[3706:666709] battery level: -1.00
DYFDeviceUtils[3706:666709] multitasking supported: 1
```
