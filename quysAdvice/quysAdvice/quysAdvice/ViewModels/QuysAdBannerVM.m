//
//  QuysAdSplashVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdBannerVM.h"
#import "QuysAdviceModel.h"
#import "QuysAdBanner.h"
#import "QuysNavigationController.h"
#import "QuysWebViewController.h"
#import "QuysPictureViewController.h"
#import "QuysAppDownUrlApi.h"
#import "QuysDownAddressModel.h"
@interface QuysAdBannerVM()
@property (nonatomic,strong) QuysAdviceModel *adModel;
@property (nonatomic,weak) id <QuysAdSplashDelegate> delegate;
@property (nonatomic,assign) CGRect cgFrame;
@property (nonatomic,strong) UIView *adView;
@property (nonatomic,strong) QuysAdBannerService *service;

@end



@implementation QuysAdBannerVM
- (instancetype)initWithModel:(QuysAdviceModel *)model delegate:(nonnull id<QuysAdSplashDelegate>)delegate frame:(CGRect)cgFrame
{
    if (self = [super init])
    {
        self.delegate = delegate;
        [self packingModel:model frame:cgFrame];
    }
    return self;
}

#pragma mark - PrivateMethod

- (void)packingModel:(QuysAdviceModel*)model frame:(CGRect)cgFrame
{
    self.adModel = model;
    self.cgFrame = cgFrame;
    [self updateReplaceDictionary:kResponeAdWidth value:kStringFormat(@"%ld",_adModel.width)];
    [self updateReplaceDictionary:kResponeAdHeight value:kStringFormat(@"%ld",_adModel.height)];
    [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",cgFrame.size.width)];
    [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",cgFrame.size.height)];
    self.strImgUrl = model.imgUrl;
}



- (void)updateReplaceDictionary:(NSString *)replaceKey value:(NSString *)replaceVlue
{
    [[[QuysAdviceManager shareManager] dicMReplace] setObject:replaceVlue forKey:replaceKey];
}

- (void)uploadServer:(NSArray*)uploadUrlArr
{
    [[QuysUploadApiTaskManager shareManager] addTaskUrls:uploadUrlArr];
}


#pragma mark - QuysAdSplashDelegate

- (UIView *)createAdviceView
{
    kWeakSelf(self)
    //根据数据创建指定的视图（目前插屏广告只有该一种view，so。。。）
    QuysAdBanner *adView = [[QuysAdBanner alloc]initWithFrame:self.cgFrame viewModel:self];
    
    //点击事件
    adView.quysAdviceClickEventBlockItem = ^(CGPoint cp, CGPoint cpRe) {
        [weakself interstitialOnClick:cp cpRe:cpRe];
        if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnClick:relativeClickPoint:service:)])
        {
            [weakself.delegate quys_interstitialOnClick:cp relativeClickPoint:cpRe service:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //关闭事件
    adView.quysAdviceCloseEventBlockItem = ^{
        if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnAdClose:)])
        {
            [weakself.delegate quys_interstitialOnAdClose:(QuysAdBaseService*)weakself.service];
        }
    };
    
    //曝光事件
    adView.quysAdviceStatisticalCallBackBlockItem = ^{
        [weakself interstitialOnExposure];
        if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnExposure:)])
        {
            [weakself.delegate quys_interstitialOnExposure:(QuysAdBaseService*)weakself.service];
        }
    };
    self.adView = adView;
    return adView;
    
}


#pragma mark - Event


- (void)interstitialOnClick:(CGPoint)cpClick cpRe:(CGPoint)cpReClick
{
    kWeakSelf(self)
    if ([self.adView isMemberOfClass:[QuysAdBanner class]])
    {
        switch (self.adModel.ctype) {
            case QuysAdviceActiveTypeHtmlSourceCode:
            {
                QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithHtml:self.adModel.htmStr];
                UIViewController* rootVC = [UIViewController quys_findVisibleViewController:[UIWindow class]] ;
                [rootVC quys_presentViewController:webVC animated:YES completion:^{
                    [weakself updateClickAndUpload:cpClick cpRe:cpReClick];
                }];
            }
                break;
            case QuysAdviceActiveTypeImageUrl:
            {
                //判断后缀是否.ipa==直接下载； 或者加载web
                if ([self.adModel.ldp containsString:@".ipa"])
                {
                     [self openUrl:self.adModel.ldp];
                }else
                {
                    QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithUrl:self.adModel.ldp];
                     UIViewController* rootVC = [UIViewController quys_findVisibleViewController:[UIWindow class]] ;
                     [rootVC quys_presentViewController:webVC animated:YES completion:^{
                     }];
                }
                [self updateClickAndUpload:cpClick cpRe:cpReClick];
            }
                break;
            case QuysAdviceActiveTypeHtmlLink:
            {
                QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithHtml:self.adModel.htmStr];
                UIViewController* rootVC = [UIViewController quys_findVisibleViewController:[UIWindow class]] ;
                [rootVC quys_presentViewController:webVC animated:YES completion:^{
                    [weakself updateClickAndUpload:cpClick cpRe:cpReClick];
                }];
            }
                break;
            case QuysAdviceActiveTypeDownAppAppstore:
            {
                [self openUrl:self.adModel.downUrl];
                [self updateClickAndUpload:cpClick cpRe:cpReClick];
            }
                break;
            case QuysAdviceActiveTypeDownAppAppstoreSecond:
            {
                [self openUrl:self.adModel.downUrl];
                [self updateClickAndUpload:cpClick cpRe:cpReClick];
            }
                break;
            case QuysAdviceActiveTypeDownAppWebUrl:
            {
                [self getRealDownUrl:self.adModel.downUrl point:cpClick cpRe:cpReClick];
            }
                break;
            default:
                break;
        }
    }
}

- (void)openUrl:(NSString*)strUrl
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strUrl]];
    
}

- (void)updateClickAndUpload:(CGPoint)cpClick cpRe:(CGPoint)cpReClick
{
    if (self.adModel.clickeUploadEnable)
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

        self.adModel.statisticsModel.clicked = YES;
        [self uploadServer:self.adModel.clkTracking];
    }
}


- (void)getRealDownUrl:(NSString*)strWebUrl  point:(CGPoint)cpClick cpRe:(CGPoint)cpReClick
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
                [weakself openUrl:model.dstlink];
            }
            if (!kISNullString(model.clickid))
                {
                    [weakself openUrl:model.dstlink];
                    [weakself updateReplaceDictionary:kClickClickID value:model.clickid];
                    [weakself updateClickAndUpload:cpClick cpRe:cpReClick];
                }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

-(void)interstitialOnExposure
{
    if (self.adModel.exposuredUploadEnable)
    {
        [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",self.adView.frame.size.width)];
        [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",self.adView.frame.size.height)];
        [self uploadServer:self.adModel.impTracking];
        self.adModel.statisticsModel.exposured = YES;
    }else
    {
    }
}




#pragma mark - Init

- (NSString *)strImgUrl
{
    if (_strImgUrl == nil)
    {
        _strImgUrl = self.adModel.imgUrl;
    }return _strImgUrl;
}
@end

