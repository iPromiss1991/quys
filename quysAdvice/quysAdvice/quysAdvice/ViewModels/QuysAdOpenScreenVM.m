//
//  QuysAdSplashVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdOpenScreenVM.h"
#import "QuysAdviceModel.h"
#import "QuysOpenScreenWindow.h"
#import "QuysNavigationController.h"
#import "QuysWebViewController.h"
#import "QuysPictureViewController.h"
#import "QuysAppDownUrlApi.h"
#import "QuysDownAddressModel.h"
#import <AVFoundation/AVFoundation.h>

#import <StoreKit/StoreKit.h>


 @interface QuysAdOpenScreenVM()<SKStoreProductViewControllerDelegate,NSURLSessionTaskDelegate>

@property (nonatomic,strong) QuysAdviceModel *adModel;
@property (nonatomic,weak) id <QuysAdviceOpeenScreenDelegate> delegate;
@property (nonatomic,assign) CGRect cgFrame;
@property (nonatomic,strong) UIView *adView;
@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) QuysAdOpenScreenService *service;
@property (nonatomic,strong) QuysDisplayViewModelEvent *viewModelEvent;//!< 事件处理

@end



@implementation QuysAdOpenScreenVM
- (instancetype)initWithModel:(QuysAdviceModel*)model delegate:(id<QuysAdviceOpeenScreenDelegate>)delegate frame:(CGRect)cgFrame
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
    QuysDisplayViewModelEvent *viewModelEvent = [QuysDisplayViewModelEvent new];
    self.viewModelEvent = viewModelEvent;
    self.adModel = model;
    self.cgFrame = cgFrame;
    [self.viewModelEvent updateReplaceDictionary:kResponeAdWidth value:kStringFormat(@"%ld",(long)_adModel.width)];
    [self.viewModelEvent updateReplaceDictionary:kResponeAdHeight value:kStringFormat(@"%ld",(long)_adModel.height)];
    [self.viewModelEvent updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",cgFrame.size.width)];
    [self.viewModelEvent updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",cgFrame.size.height)];
    self.iconUrl = model.iconUrl;
    self.materialUrl = model.materialUrl;
}

#pragma mark - QuysAdSplashDelegate

- (UIView *)createAdviceView
{
    if (self.adModel.creativeType == QuysAdviceCreativeTypeDefault || self.adModel.creativeType == QuysAdviceCreativeTypeVideo)
    {
        kWeakSelf(self)
        QuysOpenScreenWindow *adView = [[QuysOpenScreenWindow alloc]initWithFrame:self.cgFrame viewModel:self type:self.adModel.creativeType];
        [adView hlj_setTrackTag:kStringFormat(@"%ld",(long)[adView hash]) position:0 trackData:@{}];
        
        //点击事件
        adView.quysAdviceClickEventBlockItem = ^(CGPoint cp, CGPoint cpRe)
        {
            [self.viewModelEvent interstitialOnClick:cp cpRe:cpRe presentViewController:self.presentVC adviceModel:self.adModel];
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
            [self.viewModelEvent interstitialOnExposure:self.adView.frame adviceModel:self.adModel];
            if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnExposure:)])
            {
                [weakself.delegate quys_interstitialOnExposure:(QuysAdBaseService*)weakself.service];
            }
        };
        
        
        self.adView = adView;
        return adView;
        
    }else
    {
        kWeakSelf(self)
        QuysOpenScreenWindow *adView = [[QuysOpenScreenWindow alloc]initWithFrame:self.cgFrame viewModel:self type:QuysAdviceCreativeTypeDefault];//QuysAdviceCreativeTypePictureOnly
        [adView hlj_setTrackTag:kStringFormat(@"%ld",[adView hash]) position:0 trackData:@{}];
        
        //点击事件
        adView.quysAdviceClickEventBlockItem = ^(CGPoint cp, CGPoint cpRe) {
            [self.viewModelEvent interstitialOnClick:cp cpRe:cpRe presentViewController:self.presentVC adviceModel:self.adModel];
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
            [self.viewModelEvent interstitialOnExposure:self.adView.frame adviceModel:self.adModel];
            if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnExposure:)])
            {
                [weakself.delegate quys_interstitialOnExposure:(QuysAdBaseService*)weakself.service];
            }
        };
        self.adView = adView;
        return adView;
        
    }
}


 
- (void)validateWindow
{
    self.adView.hidden = YES;
    self.adView = nil;
}

- (NSString *)title
{
    if (_title == nil) {
        _title = self.adModel.title;
    }return _title;
}
- (NSInteger)showDuration
{
    if (self.adModel.creativeType == QuysAdviceCreativeTypeVideo)
    {
        NSInteger totalSecond = [self getVideoTimeByUrlString:self.adModel.materialUrl];
        return totalSecond <= 15?totalSecond:15;//quys_warning:视屏最长15s?
    }else
    {
        return self.adModel.showDuration <= 0?5:(self.adModel.showDuration <=5?self.adModel.showDuration:5);
    }
}

- (NSInteger)getVideoTimeByUrlString:(NSString*)urlString
{
    //计算视频长度  （秒）
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    NSInteger totalSecond = urlAsset.duration.value / urlAsset.duration.timescale;
    return totalSecond;
}


- (NSString *)strImgUrl
{
    if (_strImgUrl == nil)
    {
        if (!kISNullString(self.adModel.imgUrl))
        {
             _strImgUrl = self.adModel.imgUrl;
        }else
        {

            if (self.adModel.imgUrlList.count)
            {
                 _strImgUrl = self.adModel.imgUrlList[0];
            }else
            {
                _strImgUrl = @"";
            }
        }
    }return _strImgUrl;
}

- (void)dealloc
{
    
}


@end

