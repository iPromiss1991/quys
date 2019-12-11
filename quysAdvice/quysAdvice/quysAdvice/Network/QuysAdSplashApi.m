//
//  QuysAdSplashApi.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdSplashApi.h"
#import "NSDate+QuysTimestamp.h"
#import "UIDevice+Hardware.h"
#import "QuysMD5.h"
@implementation QuysAdSplashApi
- (NSString *)baseUrl
{
//    return @"http://adx.quyuansu.com/api/spread/detail";
    return @"http://192.168.1.7/advert/test.php?tid=245";
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
    [dicM setObject:[device appVersionByFloat] forKey:@"versionName"];
    [dicM setObject:[device appVersionWithoutFloat] forKey:@"versionCode"];

    [dicM setObject:[device getIPAdderss] forKey:@"ip"];
    [dicM setObject:[device customMacAddress] forKey:@"mac"];
    [dicM setObject:[device customImei] forKey:@"imei"];
    
    [dicM setObject:[device customImsi] forKey:@"imsi"];
    [dicM setObject:[device deviceBrand] forKey:@"brand"];
    [dicM setObject:[device deviceManufacturer] forKey:@"manufacturer"];
    
    [dicM setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%lf",[device iOSVersion]]] forKey:@"osv"];
    [dicM setObject:[device serialno] forKey:@"serialno"];
    [dicM setObject:kStringFormat(@"%lf",kScreenWidth) forKey:@"sw"];
    
    [dicM setObject:kStringFormat(@"%lf",kScreenHeight) forKey:@"sh"];
    [dicM setObject:[device screenOritation] forKey:@"so"];
    [dicM setObject:[device getNetconnType] forKey:@"net"];

    [dicM setObject:[device carrierName] forKey:@"operatorType"];
    [dicM setObject:[device deviceType] forKey:@"osType"];
    [dicM setObject:[device idFa] forKey:@"idFa"];

    [dicM setObject:[device screenResolution] forKey:@"dpi"];
    [dicM setObject:[device screenResolution] forKey:@"screenResolution"];
    [dicM setObject:[device country] forKey:@"country"];
    
    [dicM setObject:[device preferredLanguage] forKey:@"language"];

    return dicM;
}


@end
