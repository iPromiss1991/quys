
#import <UIKit/UIKit.h>

@interface UIDevice (Hardware)


/// 机型
- (NSString *)platform;
- (NSString *)platformString;//!< 常用这个方法

/// 系统版本 ：浮点数
- (float)iOSVersion;

- (NSUInteger)cpuFrequency;
- (NSUInteger)busFrequency;
- (NSUInteger)cpuCount;
- (NSUInteger)totalMemory;
- (NSUInteger)userMemory;


/// 磁盘空间
- (NSNumber *)totalDiskSpace;
- (NSNumber *)freeDiskSpace;


/// 地址
- (NSString *)macAddress;
- (NSString *)ipAddresses;


#pragma mark - 广告


/// 获取app版本:eg:3.0.1
- (NSString*)appVersionByFloat;



/// 获取app版本号:eg:301
- (NSString*)appVersionWithoutFloat;


/// 网络ip地址
- (NSString*)getIPAdderss;

///自定义mac
- (NSString*)customMacAddress;


///自定义Imei
- (NSString*)customImei;


///自定义Imsi
- (NSString*)customImsi;


///手机品牌
- (NSString*)deviceBrand;


///手机厂商
- (NSString*)deviceManufacturer;


///手机序列号
- (NSString*)serialno;


///手机屏幕方向：1 竖屏，2 横屏
- (NSString*)screenOritation;


/// 网络类型
/*
0：没有网络, 1：WIFI，2：2G，3：3G，4：4G，5：未知移动网络
*/
- (NSString *)getNetconnType;



/// 获取运营商
-(NSString*)carrierName;



/// 获取设备类型

- (NSString *)deviceType;


/// 获取设备类型
- (NSString*)osType;

    
/// 获取设备类型
- (NSString*)idFa;


/// 屏幕分辨率
- (NSString*)screenResolution;


/// 国家，使用ISO-3166-1   Alpha-3
- (NSString*)country;


/// 设备的语言设置,使用   alpha-2/ISO 6391
- (NSString*)preferredLanguage;



/// 获取app名称
- (NSString*)appName;


@end
