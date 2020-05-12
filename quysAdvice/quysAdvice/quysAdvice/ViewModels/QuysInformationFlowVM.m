//
//  QuysInformationFlowVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/16.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysInformationFlowVM.h"
#import "QuysAdviceModel.h"

#import "QuysInformationFlowDefaultView.h"
#import "QuysInformationFlowMorePictureView.h"
#import "QuysInformationFlowSmallPictureView.h"

#import "QuysNavigationController.h"
#import "QuysWebViewController.h"
#import "QuysPictureViewController.h"
#import "QuysAppDownUrlApi.h"
#import "QuysDownAddressModel.h"
@interface QuysInformationFlowVM()
@property (nonatomic,strong) QuysAdviceModel *adModel;
@property (nonatomic,weak) id <QuysAdSplashDelegate> delegate;
@property (nonatomic,assign) CGRect cgFrame;
@property (nonatomic,strong) UIView *adView;
@property (nonatomic,strong) QuysInformationFlowService *service;
@property (nonatomic,strong) QuysDisplayViewModelEvent *viewModelEvent;//!< 事件处理

@end



@implementation QuysInformationFlowVM
- (instancetype)initWithModel:(QuysAdviceModel *)model delegate:( id<QuysAdSplashDelegate>)delegate frame:(CGRect)cgFrame service:(QuysInformationFlowService*)service
{
    if (self = [super init])
    {
        self.delegate = delegate;
        self.service = service;
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
    self.strImgUrl = model.imgUrl;
}




- (UIView *)createAdviceView
{
    switch (self.adModel.creativeType) {
        case QuysAdviceCreativeTypeBigPicture:
        {
            kWeakSelf(self)
            QuysInformationFlowDefaultView *adView = [[QuysInformationFlowDefaultView alloc]initWithFrame:self.cgFrame viewModel:self];
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
            break;
        case QuysAdviceCreativeTypeSmallPicture:
        {
            kWeakSelf(self)
            QuysInformationFlowSmallPictureView *adView = [[QuysInformationFlowSmallPictureView alloc]initWithFrame:self.cgFrame viewModel:self];
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
            break;
        case QuysAdviceCreativeTypeMultiPicture:
        {
            kWeakSelf(self)
            QuysInformationFlowMorePictureView *adView = [[QuysInformationFlowMorePictureView alloc]initWithFrame:self.cgFrame viewModel:self];
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
            
            break;
            
        default:
        {
            kWeakSelf(self)
            QuysInformationFlowDefaultView *adView = [[QuysInformationFlowDefaultView alloc]initWithFrame:self.cgFrame viewModel:self];
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
            break;
    }
}


#pragma mark - Init

-(NSString *)strTitle
{
    if (_strTitle == nil)
    {
        _strTitle = self.adModel.title;
    }return _strTitle;
}

- (NSString *)strImgUrl
{
    if (_strImgUrl == nil)
    {
        _strImgUrl = self.adModel.imgUrl;
    }return _strImgUrl;
}


- (NSArray *)arrImgUrl
{
    if (_arrImgUrl == nil)
    {
        _arrImgUrl = [NSArray array];
        if (self.adModel.imgUrlList.count == 1)
        {
            for (int i=0; i<3; i++)
            {
                _arrImgUrl =  [_arrImgUrl arrayByAddingObject:self.adModel.imgUrlList[0]];
            }
        }else if (self.adModel.imgUrlList.count == 2)
        {
            for (int i=0; i<2; i++)
            {
                _arrImgUrl =  [_arrImgUrl arrayByAddingObject:self.adModel.imgUrlList[i]];
            }
            _arrImgUrl =  [_arrImgUrl arrayByAddingObject:self.adModel.imgUrlList[arc4random()%1]];
        }else  if (self.adModel.imgUrlList.count >= 3)
        {
            for (int i=0; i<3; i++)
            {
                _arrImgUrl =  [_arrImgUrl arrayByAddingObject:self.adModel.imgUrlList[i]];
            }
        }
    }    return _arrImgUrl;
}



@end

