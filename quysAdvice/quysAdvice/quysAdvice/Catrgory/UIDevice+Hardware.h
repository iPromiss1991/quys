
#import <UIKit/UIKit.h>

@interface UIDevice (Hardware)


/// 机型
- (NSString *)quys_platform;
- (NSString *)quys_platformString;//!< 常用这个方法

/// 系统版本 ：浮点数
- (float)quys_iOSVersion;

- (NSUInteger)cpuFrequency;
- (NSUInteger)busFrequency;
- (NSUInteger)cpuCount;
- (NSUInteger)totalMemory;
- (NSUInteger)userMemory;


/// 磁盘空间
- (NSNumber *)quys_totalDiskSpace;
- (NSNumber *)quys_freeDiskSpace;


/// 地址
- (NSString *)quys_macAddress;
- (NSString *)quys_ipAddresses;


#pragma mark - 广告


/// 获取app版本:eg:3.0.1
- (NSString*)quys_appVersionByFloat;



/// 获取app版本号:eg:301
- (NSString*)quys_appVersionWithoutFloat;




///自定义mac
- (NSString*)quys_customMacAddress;


///自定义Imei
- (NSString*)quys_customImei;


///自定义Imsi
- (NSString*)quys_customImsi;


///手机品牌
- (NSString*)quys_deviceBrand;


///手机厂商
- (NSString*)quys_deviceManufacturer;


///手机序列号
- (NSString*)quys_serialno;


///手机屏幕方向：1 竖屏，2 横屏
- (NSString*)quys_screenOritation;


/// 网络类型
/*
0：没有网络, 1：WIFI，2：2G，3：3G，4：4G，5：未知移动网络
*/
- (NSString *)quys_getNetconnType;



/// 获取运营商
-(NSString*)quys_carrierName;



/// 获取设备类型

- (NSString *)quys_deviceType;


/// 获取设备类型
- (NSString*)quys_osType;

    
/// 获取IDFA
- (NSString*)quys_idFa;

/// 获取IDFV
- (NSString*)quys_idFv;

/// 屏幕分辨率
- (NSString*)quys_screenResolution;


/// 国家，使用ISO-3166-1   Alpha-3
- (NSString*)quys_country;


/// 设备的语言设置,使用   alpha-2/ISO 6391
- (NSString*)quys_preferredLanguage;



/// 获取app名称
- (NSString*)quys_appName;


@end
