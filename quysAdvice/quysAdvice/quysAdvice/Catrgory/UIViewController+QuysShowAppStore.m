
//
//  UIViewController+QuysShowAppStore.m
//  quysAdvice
//
//  Created by quys on 2020/5/9.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "UIViewController+QuysShowAppStore.h"
#import <StoreKit/StoreKit.h>
@interface UIViewController() <SKStoreProductViewControllerDelegate>

@end

@implementation UIViewController (QuysShowAppStore)

- (void)openAppWithUrl:(NSString*)appIdUrl
{
    
    NSString *strAppID = [self getStoreAppID:appIdUrl];
    dispatch_async(dispatch_get_main_queue(), ^{
         if (!kISNullString(strAppID))
            {
                [self openAppWithIdentifier:strAppID];
            }else
            {
                QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithUrl:appIdUrl];
                [self quys_presentViewController:webVC animated:YES completion:^{
                    
                }];
            }
            
    });
}



- (void)openAppWithIdentifier:(NSString*)appId
{
    SKStoreProductViewController* storeProductVC =  [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    NSDictionary* dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result,NSError*error)
     {
        if(result)
        {
            [self presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
    
}


/// 获取AppStore 上的APPID
/// @param appIdUrl app 网址
- (NSString*)getStoreAppID:(NSString*)appIdUrl
{
   __block NSString *strAppID = @"";

        
    if ([appIdUrl containsString:@"itms-apps://"] ||[appIdUrl containsString:@"itms-appss://"]|| [appIdUrl containsString:@"itms://"]||([appIdUrl containsString:@"https://apps.apple.com"] && [appIdUrl containsString:@"/id"]))
    {
        //2、跳转到AppStore || 跳转到 iTunes Store
        NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"/&?"];
        NSArray <NSString*>* arrCharacters = [appIdUrl componentsSeparatedByCharactersInSet:charSet];
        [arrCharacters enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ( [obj hasPrefix:@"id="])
            {
                strAppID = [obj substringFromIndex:3];
                *stop = YES;
            }else if ([obj hasPrefix:@"id"])
            {
                strAppID = [obj substringFromIndex:2];
                *stop = YES;
            }
        }];
    }else if ([appIdUrl containsString:@"https://"])
    {
        //1、在Safari浏览器打开链接

    }
    
    //https://apps.apple.com====https://

    return strAppID;
}



#pragma mark -协议方法

- (void)productViewControllerDidFinish:(SKStoreProductViewController*)viewController
{
    
    NSLog(@"关闭界面");//关闭事件
    [viewController dismissViewControllerAnimated:YES completion:nil];
    
}



@end
