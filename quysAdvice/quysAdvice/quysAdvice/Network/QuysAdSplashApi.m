//
//  QuysAdSplashApi.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdSplashApi.h"
#import "UIDevice+Hardware.h"
#import "QuysMD5.h"
@implementation QuysAdSplashApi
- (NSString *)baseUrl
{
//    return @"http://adx.quyuansu.com/api/spread/detail";
    return @"http://192.168.1.2/advert/test.php?tid=246";//开屏
//    return @"http://192.168.1.2/advert/test.php?tid=71";//

}

//- (NSString *)requestUrl
//{
//    NSString *strTimestam = [NSDate getNowTimeTimestamp];
//    NSString *strApiToken = [NSString stringWithFormat:@"%@%@%@",self.businessID,self.bussinessKey,strTimestam];
//    NSString *strMd5ApiToken = [QuysMD5 md5EncryptStr:strApiToken bateNum:32 isLowercaseStr:YES];//TODO:位数？大小写
//    NSMutableString *strUrl = [NSMutableString stringWithFormat:@"?id=%@&apiToken=%@&timestamp=%@",self.businessID,strMd5ApiToken,strTimestam];
//    return strUrl;
//}


- (id)requestArgument
{
    UIDevice *device = [[UIDevice alloc] init];
    NSMutableDictionary *dicM = [NSMutableDictionary new];
    [dicM setObject:kBundleID forKey:@"pkgName"];
    [dicM setObject:[device quys_appVersionByFloat] forKey:@"versionName"];
    [dicM setObject:[device quys_appVersionWithoutFloat] forKey:@"versionCode"];

    [dicM setObject:[[QuysAdviceManager shareManager] strIPAddress] forKey:@"ip"];
    [dicM setObject:[device quys_customMacAddress] forKey:@"mac"];
    [dicM setObject:[device quys_customImei] forKey:@"imei"];
    
    [dicM setObject:[device quys_customImsi] forKey:@"imsi"];
    [dicM setObject:[[device quys_platformString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]] forKey:@"Model"];
    [dicM setObject:[device quys_deviceBrand] forKey:@"brand"];
    [dicM setObject:[device quys_deviceManufacturer] forKey:@"manufacturer"];
    
    [dicM setObject:[device systemVersion] forKey:@"osv"];
    [dicM setObject:[device quys_serialno] forKey:@"serialno"];
    [dicM setObject:kStringFormat(@"%lf",kScreenWidth) forKey:@"sw"];
    
    [dicM setObject:kStringFormat(@"%lf",kScreenHeight) forKey:@"sh"];
    [dicM setObject:[device quys_screenOritation] forKey:@"so"];
    [dicM setObject:[device quys_getNetconnType] forKey:@"net"];

    [dicM setObject:[device quys_carrierName] forKey:@"operatorType"];
    [dicM setObject:[[QuysAdviceManager shareManager] strUserAgent] forKey:@"ua"];
    [dicM setObject:[device quys_deviceType] forKey:@"osType"];
    [dicM setObject:[device quys_idFa] forKey:@"idFa"];

    [dicM setObject:[device quys_screenResolution] forKey:@"dpi"];
    [dicM setObject:[device quys_screenResolution] forKey:@"screenResolution"];
    [dicM setObject:[device quys_country] forKey:@"country"];
    
    [dicM setObject:[device quys_preferredLanguage] forKey:@"language"];

    return dicM;
}

@end
