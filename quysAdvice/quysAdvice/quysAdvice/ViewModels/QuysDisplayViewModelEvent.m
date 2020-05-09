//
//  NSObject+QuysViewModelEvent.m
//  quysAdvice
//
//  Created by quys on 2020/5/9.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysDisplayViewModelEvent.h"


@implementation QuysDisplayViewModelEvent

#pragma mark - 曝光


/// 曝光事件
/// @param frame <#frame description#>
/// @param adModel <#adModel description#>
-(void)interstitialOnExposure:(CGRect)frame  adviceModel:(QuysAdviceModel*)adModel
{
    if (adModel.exposuredUploadEnable)
    {
        [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f", frame.size.width)];
        [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f", frame.size.height)];
        [self uploadServer:adModel.impTracking];
        adModel.statisticsModel.exposured = YES;
    }else
    {
    }
}


/// 点击事件
/// @param cpClick <#cpClick description#>
/// @param cpReClick <#cpReClick description#>
/// @param presentVC <#presentVC description#>
/// @param adModel <#adModel description#>
- (void)interstitialOnClick:(CGPoint)cpClick cpRe:(CGPoint)cpReClick presentViewController:(UIViewController*)presentVC adviceModel:(QuysAdviceModel*)adModel
{
    
    /*点击事件优先级：
     1、deep:deepLink
     2、ctype
    
     */
    kWeakSelf(self)
    NSURLSessionDataTask *dataTask = [[NSURLSessionDataTask alloc]init];
    if (!kISNullString(adModel.deepLink))
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:adModel.deepLink]];
    }else
    {
        switch (adModel.ctype)
           {
                   /*
                    QuysAdviceActiveTypeHtmlSourceCode = 1,
                    QuysAdviceActiveTypeImageUrl = 2,
                    QuysAdviceActiveTypeHtmlLink = 3,
                    QuysAdviceActiveTypeDownAppAppstore = 4,
                    QuysAdviceActiveTypeDownAppAppstoreSecond = 6,
                    QuysAdviceActiveTypeDownAppWebUrl = 8,
                    */
               case QuysAdviceActiveTypeHtmlSourceCode:
               {
                   QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithHtml:adModel.htmStr];
                   [presentVC quys_presentViewController:webVC animated:YES completion:^{
                       [weakself updateClickAndUpload:cpClick cpRe:cpReClick adviceModel:adModel];
                   }];
               }
                   break;
               case QuysAdviceActiveTypeImageUrl:
               {
                   [dataTask redirectToAppStore:adModel.ldp callBack:^(NSString * _Nonnull strAppstoreUrl)
                    {
                       [presentVC openAppWithUrl:strAppstoreUrl];
                       [weakself updateClickAndUpload:cpClick cpRe:cpReClick adviceModel:adModel];
                   }];
               }
                   break;
               case QuysAdviceActiveTypeHtmlLink:
               {
                   QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithHtml:adModel.htmStr];
                   [presentVC quys_presentViewController:webVC animated:YES completion:^{
                       [weakself updateClickAndUpload:cpClick cpRe:cpReClick adviceModel:adModel];
                   }];
               }
                   break;
               case QuysAdviceActiveTypeDownAppAppstore:
               {
                   [dataTask redirectToAppStore:adModel.downUrl callBack:^(NSString * _Nonnull strAppstoreUrl)
                    {
                       [presentVC openAppWithUrl:strAppstoreUrl];
                       [weakself updateClickAndUpload:cpClick cpRe:cpReClick adviceModel:adModel];
                   }];
               }
                   break;
               case QuysAdviceActiveTypeDownAppAppstoreSecond:
               {
                   [dataTask redirectToAppStore:adModel.downUrl callBack:^(NSString * _Nonnull strAppstoreUrl)
                    {
                       [presentVC openAppWithUrl:strAppstoreUrl];
                       [weakself updateClickAndUpload:cpClick cpRe:cpReClick adviceModel:adModel];
                   }];
                   [self updateClickAndUpload:cpClick cpRe:cpReClick adviceModel:adModel];
               }
                   break;
               case QuysAdviceActiveTypeDownAppWebUrl:
               {
                   [self getRealDownUrl:adModel.downUrl point:cpClick cpRe:cpReClick adviceModel:adModel  presentViewController:presentVC];
               }
                   break;
               default:
                   break;
           }
    }
}

- (void)updateClickAndUpload:(CGPoint)cpClick cpRe:(CGPoint)cpReClick adviceModel:(QuysAdviceModel*)adModel
{
    if (adModel.clickeUploadEnable)
    {
        NSString *strCpX = kStringFormat(@"%f",cpClick.x);
        NSString *strCpY = kStringFormat(@"%f",cpClick.y);
        
        NSString *strReCpX = kStringFormat(@"%f",cpReClick.x);
        NSString *strReCpY = kStringFormat(@"%f",cpReClick.y);
        
        //更新点击坐标
        [self updateReplaceDictionary:kClickInsideDownX value:strCpX];
        [self updateReplaceDictionary:kClickInsideDownY value:strCpY];
        
        [self updateReplaceDictionary:kClickUPX value:strCpX];
        [self updateReplaceDictionary:kClickUPY value:strCpY];
        //
        [self updateReplaceDictionary:k_RE_DOWN_X value:strReCpX];
        [self updateReplaceDictionary:k_RE_DOWN_Y value:strReCpY];
        
        [self updateReplaceDictionary:k_RE_UP_X value:strReCpX];
        [self updateReplaceDictionary:k_RE_UP_Y value:strReCpY];
        [self updateReplaceDictionary:kClientTimeStamp value:[NSDate quys_getNowTimeTimestamp]];
        
        adModel.statisticsModel.clicked = YES;
        [self uploadServer:adModel.clkTracking ];
    }
}


- (void)getRealDownUrl:(NSString*)strWebUrl  point:(CGPoint)cpClick cpRe:(CGPoint)cpReClick adviceModel:(QuysAdviceModel*)adModel presentViewController:(UIViewController*)presentVC
{
    kWeakSelf(self)
    strWebUrl = [[QuysAdviceManager shareManager] replaceSpecifiedString:strWebUrl];
    QuysAppDownUrlApi *api = [QuysAppDownUrlApi new];
    api.downUrl = strWebUrl;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request)
     {
        if ( request.responseJSONObject[@"data"])
        {
            QuysDownAddressModel *model = [QuysDownAddressModel yy_modelWithJSON:request.responseJSONObject[@"data"]];
            if (!kISNullString(model.dstlink))
            {
                NSURLSessionDataTask *dataTask = [[NSURLSessionDataTask alloc] init];
                [dataTask redirectToAppStore:model.dstlink callBack:^(NSString * _Nonnull strAppstoreUrl)
                 {
                    [presentVC openAppWithUrl:strAppstoreUrl];
                    [weakself updateClickAndUpload:cpClick cpRe:cpReClick adviceModel:adModel];
                    if (!kISNullString(model.clickid))
                    {
                        [weakself updateReplaceDictionary:kClickClickID value:model.clickid];
                    }
                    [weakself updateClickAndUpload:cpClick cpRe:cpReClick adviceModel:adModel];
                }];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}





- (void)updateReplaceDictionary:(NSString *)replaceKey value:(NSString *)replaceVlue
{
    [[[QuysAdviceManager shareManager] dicMReplace] setObject:replaceVlue forKey:replaceKey];
}

- (void)uploadServer:(NSArray*)uploadUrlArr
{
    [[QuysUploadApiTaskManager shareManager] addTaskUrls:uploadUrlArr];
}



@end
