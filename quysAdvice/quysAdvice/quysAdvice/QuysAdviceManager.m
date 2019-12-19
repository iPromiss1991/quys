//
//  QuysAdviceManager.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import "QuysAdviceManager.h"
#import "QuysAdviceConfigModel.h"

static  NSString *kNetworkIp = @"quys_kNetworkIp";
static  NSString *kUserAgent = @"quys_kUserAgent";

@interface QuysAdviceManager()

@property (nonatomic,strong) NSMapTable *mapTable;
@property (nonatomic,strong) UIView *webViewTarget;


@end


@implementation QuysAdviceManager

+ (instancetype)shareManager
{
    static QuysAdviceManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    return manager;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [QuysAdviceManager shareManager] ;
}
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [QuysAdviceManager shareManager] ;
}





#pragma mark - PrivateMethod



/// 每次启动App需要做的配置事件
- (void)configSettings
{
    [self quys_UserAgent];
    self.strIPAddress =  [self quys_getIPAdderss];

}


/// 获取userAgent并保存本地
- (void)quys_UserAgent
{
    kWeakSelf(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *strUserAgent = @"";
        [[QuysFileManager shareManager] getFormUserdefaultWithKey:kUserAgent];
        if (!strUserAgent.length) {
            weakself.strUserAgent = strUserAgent;
            [weakself configUserAgent];
        }else
        {
            [weakself configUserAgent];
        }
    });
}


- (void)configUserAgent
{
    kWeakSelf(self)
    if (kIOS8Later)
    {
        WKWebView *wkWebview = [[WKWebView alloc] initWithFrame:CGRectZero configuration:[[WKWebViewConfiguration alloc]init]];
        [wkWebview evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError * _Nullable error) {
            [[QuysFileManager shareManager] saveToUserdefault:kUserAgent contents:result];
            weakself.strUserAgent = result;
        }];
        self.webViewTarget = wkWebview;
    }else
    {
        UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectZero];
        weakself.strUserAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        weakself.webViewTarget = webView;
        [[QuysFileManager shareManager] saveToUserdefault:kUserAgent contents:weakself.strUserAgent];
    }
}


- (NSMutableDictionary*)combineReplaceKeyAndValues
{
    
    NSMutableDictionary *dicM = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                 kResponeAdWidth,@"",
                                 kResponeAdHeight,@"",
                                 kRealAdWidth,@"",
                                 kRealAdHeight,@"",
                                 kClickInsideDownX,@"",
                                 kClickInsideDownY,@"",
                                 kClickUPX,@"",
                                 kClickUPY,@"",
                                 nil];
    return dicM;
}


/// 网络ip地址
- (NSString*)quys_getIPAdderss
{
    __block  NSString *strIPAddress = [[QuysFileManager shareManager] getFormUserdefaultWithKey:kNetworkIp];
    if (strIPAddress)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
             strIPAddress = [[self quys_deviceWANIPAdress] valueForKey:@"ip"];
             if (strIPAddress.length)
             {
                 [[QuysFileManager shareManager] saveToUserdefault:kNetworkIp contents:strIPAddress ];
             };
        });
        return  strIPAddress;
    }else
    {
        strIPAddress = [[self quys_deviceWANIPAdress] valueForKey:@"ip"];
        if (strIPAddress.length)
        {
            [[QuysFileManager shareManager] saveToUserdefault:kNetworkIp contents:strIPAddress ];
        };
        return strIPAddress;
    }
}


/// 获取网络信息
/*返回字段如下：{
    area = "";
    "area_id" = "";
    city = "\U53a6\U95e8";
    "city_id" = 350200;
    country = "\U4e2d\U56fd";
    "country_id" = CN;
    county = XX;
    "county_id" = xx;
    ip = "183.250.89.75";
    isp = "\U79fb\U52a8";
    "isp_id" = 100025;
    region = "\U798f\U5efa";
    "region_id" = 350000;
}*/
-(NSDictionary *)quys_deviceWANIPAdress
{
   __block NSDictionary *ipDic ;
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
         NSURL *ipURL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo2.php?ip=myip"];
           NSData *data = [NSData dataWithContentsOfURL:ipURL];
           if (data)
           {
                ipDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil][@"data"];
           }else
           {
                ipDic = @{@"ip":@""};
           }
    });
    return ipDic;
}


#pragma mark - Init


- (NSMapTable *)mapTable
{
    if (_mapTable == nil) {
        _mapTable = [[NSMapTable alloc] initWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableStrongMemory capacity:6];
    }
    return _mapTable;
}


-(NSMutableDictionary *)dicMReplace
{
    if (_dicMReplace == nil)
    {
      _dicMReplace = [self combineReplaceKeyAndValues];
    }
    return _dicMReplace;
}

- (NSString *)strUserAgent
{
    if (_strUserAgent == nil) {
        _strUserAgent = [[QuysFileManager shareManager] getFormUserdefaultWithKey:kUserAgent];//获取本地存储的
    }
    return _strUserAgent;
}

-(NSString *)strIPAddress

{
    if (_strIPAddress == nil) {
        _strIPAddress = [[QuysFileManager shareManager] getFormUserdefaultWithKey:kNetworkIp];//获取本地存储的
    }
    return _strIPAddress;
}
@end
