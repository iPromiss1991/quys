//
//  QuysAdSplashVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideoVM.h"
#import "QuysIncentiveVideoWindow.h"
#import "QuysFullScreenReplaceView.h"
#import "QuysNavigationController.h"
#import "QuysWebViewController.h"
#import "QuysPictureViewController.h"
#import "QuysAppDownUrlApi.h"
#import "QuysDownAddressModel.h"
@interface QuysIncentiveVideoVM()
@property (nonatomic,strong) QuysIncentiveVideoDataModel *adModel;
@property (nonatomic,weak) id <QuysIncentiveVideoDelegate> delegate;
@property (nonatomic,assign) CGRect cgFrame;
@property (nonatomic,strong) UIView *adView;
@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) QuysIncentiveVideoService *service;

@end



@implementation QuysIncentiveVideoVM
- (instancetype)initWithModel:(QuysIncentiveVideoDataModel*)model delegate:(id<QuysIncentiveVideoDelegate>)delegate frame:(CGRect)cgFrame  window:(UIWindow*)window
{
    if (self = [super init])
    {
        self.delegate = delegate;
        self.window = window;
        [self packingModel:model frame:cgFrame];
    }
    return self;
}


#pragma mark - PrivateMethod

- (void)packingModel:(QuysIncentiveVideoDataModel*)model frame:(CGRect)cgFrame
{
    self.adModel = model;
    self.cgFrame = cgFrame;
    [self updateReplaceDictionary:kResponeAdWidth value:kStringFormat(@"%@",_adModel.videoWidth)];
    [self updateReplaceDictionary:kResponeAdHeight value:kStringFormat(@"%@",_adModel.videoHeight)];
    [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",cgFrame.size.width)];
    [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",cgFrame.size.height)];
    self.strImgUrl = model.icon;
    self.videoUrl = model.videoUrl;
    self.isClickable = model.isClickable;
}



- (void)updateReplaceDictionary:(NSString *)replaceKey value:(NSString *)replaceVlue
{
    [[[QuysAdviceManager shareManager] dicMReplace] setObject:replaceVlue forKey:replaceKey];
}

- (void)uploadServer:(NSArray*)uploadUrlArr
{
    [[QuysUploadApiTaskManager shareManager] addTaskUrls:uploadUrlArr];
}


#pragma mark - QuysIncentiveVideoDelegate

- (UIView *)createAdviceView
{
    kWeakSelf(self)
    QuysIncentiveVideoWindow *adView = [[QuysIncentiveVideoWindow alloc]initWithFrame:self.cgFrame viewModel:self];
    [adView hlj_setTrackTag:kStringFormat(@"%ld",[adView hash]) position:0 trackData:@{}];
    
    //点击事件
    adView.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
        [weakself interstitialOnClick:cp];
        if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnClick:service:)])
        {
            [weakself.delegate quys_interstitialOnClick:cp service:(QuysAdBaseService*)weakself.service];
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
    
    //静音
    adView.quysAdviceMuteCallBackBlockItem = ^{
         
    };
    
    //关闭静音
    adView.quysAdviceCloseMuteCallBackBlockItemItem = ^{
         
    };
    
    //关闭尾帧
    adView.quysAdviceEndViewCloseEventBlockItem = ^{
         
    };
    
    //尾帧点击
    adView.quysAdviceEndViewClickEventBlockItem = ^(CGPoint cp) {
         
    };
    
    
    //视频暂停
    adView.quysAdviceSuspendCallBackBlockItem = ^{
         
    };
    
    //视频再次播放
    adView.quysAdvicePlayagainCallBackBlockItem = ^{
         
    };
    
    //尾帧曝光事件
    adView.quysAdviceEndViewStatisticalCallBackBlockItem = ^{
        [weakself interstitialOnExposureEndView];
        if ([weakself.delegate respondsToSelector:@selector(quys_endViewInterstitialOnExposure:)])
        {
            [weakself.delegate quys_endViewInterstitialOnExposure:(QuysAdBaseService*)weakself.service];
        }
    };

    self.adView = adView;
    return adView;
    
}


#pragma mark - Event

#pragma mark - QuysIncentiveVideoWindow

- (void)interstitialOnClick:(CGPoint)cpClick
{
    if ([self.adView isMemberOfClass:[QuysIncentiveVideoWindow class]])
    {
        /*点击事件优先级：
         1\deep:
         2\isDownLoadType？Y：fileUrl：landingPageUrl（判断是否.ipa）。
         */
        if (self.adModel.isDownLoadType)
        {
            //TODO
            if (self.adModel.clickPosition == 1)
            {
                [self getRealDownUrl:self.adModel.fileUrl point:cpClick];
            }else
            {
                NSString *strMacroReplace = [[QuysAdviceManager shareManager] replaceSpecifiedString:self.adModel.fileUrl];
                 [self openUrl:strMacroReplace];
                [self updateClickAndUpload:cpClick];
            }

        }else
        {
            if ([self.adModel.landingPageUrl containsString:@"ipa"])
            {
                NSString *strMacroReplace = [[QuysAdviceManager shareManager] replaceSpecifiedString:self.adModel.fileUrl];
                [self openUrl:strMacroReplace];
                [self updateClickAndUpload:cpClick];
            }else
            {
                QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithUrl:self.adModel.landingPageUrl];
                QuysIncentiveVideoWindow *window = (QuysIncentiveVideoWindow*)self.adView;
                QuysNavigationController *nav= (QuysNavigationController*)window.rootViewController;
                [nav pushViewController:webVC animated:YES];
                [self updateClickAndUpload:cpClick];
            }
        }
    }
}


- (void)openUrl:(NSString*)strUrl
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strUrl]];
    
}

- (void)updateClickAndUpload:(CGPoint)cpClick
{
    if (self.adModel.clickeUploadEnable)
    {
    NSString *strCpX = kStringFormat(@"%f",cpClick.x);
    NSString *strCpY = kStringFormat(@"%f",cpClick.y);
    //更新点击坐标
    [self updateReplaceDictionary:kClickInsideDownX value:strCpX];
    [self updateReplaceDictionary:kClickInsideDownY value:strCpY];
    
    [self updateReplaceDictionary:kClickUPX value:strCpX];
    [self updateReplaceDictionary:kClickUPY value:strCpY];
    self.adModel.statisticsModel.clicked = YES;
    [self uploadServer:self.adModel.reportVideoClickUrl];
    }
}


- (void)getRealDownUrl:(NSString*)strWebUrl  point:(CGPoint)cpClick
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
                    [weakself updateClickAndUpload:cpClick];
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
        [self uploadServer:self.adModel.reportVideoShowUrl];
        self.adModel.statisticsModel.exposured = YES;
    }else
    {
    }
}


-(void)interstitialOnExposureEndView
{
    if (self.adModel.exposuredUploadEnableEndView)
    {
        [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",self.adView.frame.size.width)];
        [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",self.adView.frame.size.height)];
        [self uploadServer:self.adModel.reportLandingPageShowUrl];
        self.adModel.statisticsModelEndView.exposured = YES;
    }else
    {
    }
}


- (void)removeBackgroundImageView
{
    for (id  subObj in [UIApplication sharedApplication].delegate.window.subviews)
    {
        if ([subObj isKindOfClass:[QuysFullScreenReplaceView class]])
        {
            [subObj removeFromSuperview];
        }
    }
}

- (void)validateWindow
{
    self.adView.hidden = YES;
    self.adView = nil;
}

- (NSInteger)showDuration
{
    return [self.adModel.videoDuration integerValue] <= 0?10:[self.adModel.videoDuration integerValue];
}



- (void)dealloc
{
    
}


@end

