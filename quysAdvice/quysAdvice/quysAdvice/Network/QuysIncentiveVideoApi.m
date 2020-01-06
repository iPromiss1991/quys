//
//  QuysIncentiveVideoApi.m
//  quysAdvice
//
//  Created by quys on 2019/12/30.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideoApi.h"
#import "NSDate+QuysTimestamp.h"
#import "UIDevice+Hardware.h"
#import "QuysMD5.h"
@implementation QuysIncentiveVideoApi

- (NSString *)baseUrl
{
//    return @"http://jl.quyuansu.com/pull/list";
//    return @"http://192.168.1.7/advert/test.php?tid=246";//开屏
    return @"http://192.168.1.2/advert/test.php?tid=269";//

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
    //TODO:
    /*
     1、组建请求参数:done
     2、创建数据响应模型:done
     3、创建上报事件回调delegate:done
     4、实现业务逻辑
     5、布局“激励视频”
*/
    UIDevice *device = [[UIDevice alloc] init];
    NSMutableDictionary *dicM = [NSMutableDictionary new];
    
    [dicM setObject:[device quys_customImei] forKey:@"imei"];
    [dicM setObject:[device quys_customMacAddress] forKey:@"mac"];
    [dicM setObject:[[QuysAdviceManager shareManager] strIPAddress] forKey:@"ip"];
    
    [dicM setObject:[[device quys_platformString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]] forKey:@"Model"];
    [dicM setObject:[device quys_deviceBrand] forKey:@"Brand"];
    [dicM setObject:[device quys_deviceManufacturer] forKey:@"Manufacturer"];

    [dicM setObject:[device quys_idFa] forKey:@"Idfa"];
    [dicM setObject:[device quys_idFv] forKey:@"Idfv"];
    [dicM setObject:[[QuysAdviceManager shareManager] strUserAgent] forKey:@"ua"];

    [dicM setObject:kStringFormat(@"%@",[device systemVersion]) forKey:@"OsVersionMajor"];
    [dicM setObject:[device quys_deviceType] forKey:@"DeviceType"];
    [dicM setObject:[device quys_getNetconnTypeForIncentiveVideo] forKey:@"NetworkType"];

    [dicM setObject:[device quys_carrierName] forKey:@"OperatorType"];
    [dicM setObject:@"2" forKey:@"OsType"];//安卓= 1,            IOS = 2,          WinPhone = 3,          塞班= 4,          黑莓 = 5,          其他 = 100

    [dicM setObject:kStringFormat(@"%lf",kScreenHeight) forKey:@"AdslotHeight"];
    [dicM setObject:kStringFormat(@"%lf",kScreenWidth) forKey:@"AdslotWidth"];
    [dicM setObject:[device quys_appVersionByFloat] forKey:@"AppVersionMajor"];
    
    [dicM setObject:kStringFormat(@"%lf",kScreenHeight) forKey:@"ScreenHeight"];
    [dicM setObject:kStringFormat(@"%lf",kScreenWidth) forKey:@"ScreenWidth"];
    [dicM setObject:[device quys_screenOritation] forKey:@"ScreenOrientation"];

    [dicM setObject:[device quys_screenPixelDensity] forKey:@"ScreenPixelDensity"];
    [dicM setObject:[device quys_screenResolution] forKey:@"ScreenResolution"];
    
    [dicM setObject:[device quys_country] forKey:@"Country"];
    [dicM setObject:[device quys_preferredLanguage] forKey:@"Language"];
    [dicM setObject:[device quys_customImsi] forKey:@"imsi"];

    [dicM setObject:[device quys_screenDensity] forKey:@"dpi"];
    return dicM;
}

@end
