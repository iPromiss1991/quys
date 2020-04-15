//
//  QuysTengAiNetworkApi.m
//  quysAdvice
//
//  Created by quys on 2020/4/10.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysTengAiNetworkApi.h"

#import "UIDevice+Hardware.h"
#import "QuysMD5.h"

@interface QuysTengAiNetworkApi()
@property (nonatomic,strong) NSString *osv;
@property (nonatomic,strong) NSString *userAgent;


@end


@implementation QuysTengAiNetworkApi


- (NSString *)requestUrl
{
    //标准测试
#warning 调试、发布前，请在buildSettting preprocessor macros 中设置字段：QuysDebug
#ifdef QuysDebug
    {
        NSString *strRequestUrl = @"http://192.168.1.11/advert/sdktest.php";//http://192.168.1.11/advert/main.html
        NSString *strTimestam = [NSDate quys_getNowTimeTimestamp];
        NSString *strApiToken = [NSString stringWithFormat:@"%@%@%@",self.businessID,self.bussinessKey,strTimestam];
        NSString *strMd5ApiToken = [QuysMD5 md5EncryptStr:strApiToken bateNum:32 isLowercaseStr:YES];
        NSMutableString *strUrl = [NSMutableString stringWithFormat:@"%@?id=%@&apiToken=%@&timestamp=%@",strRequestUrl,self.businessID,strMd5ApiToken,strTimestam];
        return strUrl;
    }
#else
    // NSString *strRequestUrl = @"http://192.168.1.15:8084/api/spread/detail";//红日地址//
    NSString *strRequestUrl = @"http://adx.quyuansu.com/api/spread/detail";
    NSString *strTimestam = [NSDate quys_getNowTimeTimestamp];
    NSString *strApiToken = [NSString stringWithFormat:@"%@%@%@",self.businessID,self.bussinessKey,strTimestam];
    NSString *strMd5ApiToken = [QuysMD5 md5EncryptStr:strApiToken bateNum:32 isLowercaseStr:YES];
    NSMutableString *strUrl = [NSMutableString stringWithFormat:@"%@?id=%@&apiToken=%@&timestamp=%@",strRequestUrl,self.businessID,strMd5ApiToken,strTimestam];
    return strUrl;
    
#endif
   
    
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}




- (id)requestArgument
{
    UIDevice *device = [[UIDevice alloc] init];
    NSMutableDictionary *dicM = [NSMutableDictionary new];
    [dicM setObject:kBundleID forKey:@"pkgName"];
    [dicM setObject:[device quys_appVersionByFloat] forKey:@"versionName"];
    [dicM setObject:@([[device quys_appVersionWithoutFloat] integerValue]) forKey:@"versionCode"];
    
    [dicM setObject:[device quys_forgeIP] forKey:@"ip"];
//    [dicM setObject:[device quys_customMacAddress] forKey:@"mac"];
//    [dicM setObject:[device quys_customImei] forKey:@"imei"];
//
//    [dicM setObject:[device quys_customImsi] forKey:@"imsi"];
    [dicM setObject:[[device quys_forgeiPhonePlatform] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]] forKey:@"Model"];
    [dicM setObject:[device quys_deviceBrand] forKey:@"brand"];
    [dicM setObject:[device quys_deviceManufacturer] forKey:@"manufacturer"];
    
    [dicM setObject:self.osv forKey:@"osv"];
//    [dicM setObject:[device quys_serialno] forKey:@"serialno"];
    [dicM setObject:@([kStringFormat(@"%lf",kScreenWidth) integerValue]) forKey:@"sw"];

    [dicM setObject:[device quys_screenPixelDensity] forKey:@"dip"];

    [dicM setObject:@([kStringFormat(@"%lf",kScreenHeight) integerValue]) forKey:@"sh"];
    [dicM setObject:@([[device quys_screenOritation] integerValue]) forKey:@"so"];
    [dicM setObject:@([ [device quys_getNetconnType] integerValue]) forKey:@"net"];
    
    [dicM setObject:@([[device quys_forgecarrierName] integerValue]) forKey:@"operatorType"];
    [dicM setObject:self.userAgent forKey:@"ua"];
    [dicM setObject:@([[device quys_deviceType] integerValue]) forKey:@"deviceType"];
    [dicM setObject:@([[device quys_osType] integerValue]) forKey:@"osType"];
    [dicM setObject:[device quys_forgeidFa] forKey:@"idFa"];
    NSLog(@"\nidfa<<<<<<<<<<:\n%@\n",dicM[@"idFa"]);
    [dicM setObject:@([[device quys_screenDensity] integerValue]) forKey:@"dpi"];
    [dicM setObject:[device quys_screenResolution] forKey:@"screenResolution"];
    [dicM setObject:[device quys_country] forKey:@"country"];
    
    [dicM setObject:[device quys_preferredLanguage] forKey:@"language"];
    
    return dicM;
}

#pragma mark - init
- (NSString *)userAgent
{
    if (_userAgent == nil) {
        UIDevice *device = [[UIDevice alloc] init];
        _userAgent = [device quys_forgeUserAgent:self.osv];
    }return _userAgent;
}


-(NSString *)osv
{
    if (_osv == nil) {
        UIDevice *device = [[UIDevice alloc] init];
        _osv = [device quys_forgeiOSVersion];
    }return _osv;
}

-(void)dealloc
{
//    NSLog(@"\n%@-%s\n",[self description],__PRETTY_FUNCTION__);
}


@end
