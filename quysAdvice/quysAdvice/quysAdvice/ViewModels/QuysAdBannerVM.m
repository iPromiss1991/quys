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
@property (nonatomic,strong) QuysDisplayViewModelEvent *viewModelEvent;//!< 事件处理

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
    QuysDisplayViewModelEvent *viewModelEvent = [QuysDisplayViewModelEvent new];
    self.viewModelEvent = viewModelEvent;
    self.adModel = model;
    self.cgFrame = cgFrame;
    [self.viewModelEvent updateReplaceDictionary:kResponeAdWidth value:kStringFormat(@"%ld",_adModel.width)];
    [self.viewModelEvent updateReplaceDictionary:kResponeAdHeight value:kStringFormat(@"%ld",_adModel.height)];
    [self.viewModelEvent updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",cgFrame.size.width)];
    [self.viewModelEvent updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",cgFrame.size.height)];
    self.strImgUrl = model.imgUrl;
}


#pragma mark - QuysAdSplashDelegate

- (UIView *)createAdviceView
{
    kWeakSelf(self)
    //根据数据创建指定的视图（目前插屏广告只有该一种view，so。。。）
    QuysAdBanner *adView = [[QuysAdBanner alloc]initWithFrame:self.cgFrame viewModel:self];
    
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





#pragma mark - Init

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
@end

