//
//  QuysAdSplashVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdSplashVM.h"
#import "QuysAdviceModel.h"
#import "QuysAdSplash.h"
#import "QuysDownAddressModel.h"
#import "QuysNavigationController.h"
#import "QuysWebViewController.h"
#import "QuysPictureViewController.h"
#import "QuysAppDownUrlApi.h"
@interface QuysAdSplashVM()
@property (nonatomic,strong) QuysAdviceModel *adModel;
@property (nonatomic,weak) id <QuysAdSplashDelegate> delegate;
@property (nonatomic,strong) UIView *adView;
@property (nonatomic,strong) QuysAdSplashService *service;
@property (nonatomic,strong) QuysDisplayViewModelEvent *viewModelEvent;//!< 事件处理

@end



@implementation QuysAdSplashVM
- (instancetype)initWithModel:(QuysAdviceModel *)model delegate:(nonnull id<QuysAdSplashDelegate>)delegate
{
    if (self = [super init])
    {
        self.delegate = delegate;
        [self packingModel:model  ];
    }
    return self;
}

#pragma mark - PrivateMethod

- (void)packingModel:(QuysAdviceModel*)model
{
    QuysDisplayViewModelEvent *viewModelEvent = [QuysDisplayViewModelEvent new];
    self.viewModelEvent = viewModelEvent;
    self.adModel = model;
    [self.viewModelEvent updateReplaceDictionary:kResponeAdWidth value:kStringFormat(@"%ld",(long)_adModel.width)];
    [self.viewModelEvent updateReplaceDictionary:kResponeAdHeight value:kStringFormat(@"%ld",(long)_adModel.height)];
    self.strImgUrl = model.imgUrl;
}


 
#pragma mark - QuysAdSplashDelegate

- (UIView *)createAdviceView
{
    kWeakSelf(self)
    //根据数据创建指定的视图（目前插屏广告只有该一种view，so。。。）
    QuysAdSplash *adView = [[QuysAdSplash alloc]initWithViewModel:self];
    [adView hlj_setTrackTag:kStringFormat(@"%ld",(long)[adView hash]) position:0 trackData:@{}];
    
   
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

