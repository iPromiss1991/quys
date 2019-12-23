//
//  QuysAdSplashVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdOpenScreenVM.h"
#import "QuysAdviceModel.h"
#import "QuysAdOpenScreen.h"
#import "QuysFullScreenReplaceView.h"
@interface QuysAdOpenScreenVM()
@property (nonatomic,strong) QuysAdviceModel *adModel;
@property (nonatomic,weak) id <QuysAdSplashDelegate> delegate;
@property (nonatomic,assign) CGRect cgFrame;
@property (nonatomic,strong) UIView *adView;

@end



@implementation QuysAdOpenScreenVM
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

- (UIWindow *)createAdviceView
{
    switch (self.adModel.creativeType) {
        case QuysAdviceCreativeTypeDefault:
        {
            kWeakSelf(self)
            QuysAdOpenScreen *adView = [[QuysAdOpenScreen alloc]initWithFrame:self.cgFrame viewModel:self];
            [adView hlj_setTrackTag:kStringFormat(@"%ld",[adView hash]) position:0 trackData:@{}];
            
            //点击事件
            adView.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
                [weakself interstitialOnClick:cp];
                if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnClick:)])
                {
                    [weakself.delegate quys_interstitialOnClick:cp];
                }
            };
            
            //关闭事件
            adView.quysAdviceCloseEventBlockItem = ^{
                [weakself removeBackgroundImageView];
                if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnAdClose)])
                {
                    [weakself.delegate quys_interstitialOnAdClose];
                }
            };
            
            //曝光事件
            adView.quysAdviceStatisticalCallBackBlockItem = ^{
                [weakself interstitialOnExposure];
                if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnExposure)])
                {
                    [weakself.delegate quys_interstitialOnExposure];
                }
            };
            self.adView = adView;
            return adView;
            
        }
        default:
            return nil;
            break;
    }
}


#pragma mark - Event

- (void)interstitialOnClick:(CGPoint)cpClick
{
    if (!self.adModel.statisticsModel.clicked)
    {
        NSString *strCpX = kStringFormat(@"%f",cpClick.x);
        NSString *strCpY = kStringFormat(@"%f",cpClick.y);
        //更新点击坐标
        [self updateReplaceDictionary:kClickInsideDownX value:strCpX];
        [self updateReplaceDictionary:kClickInsideDownY value:strCpY];
        
        [self updateReplaceDictionary:kClickUPX value:strCpX];
        [self updateReplaceDictionary:kClickUPY value:strCpY];
        self.adModel.statisticsModel.clicked = YES;
        [self uploadServer:self.adModel.clkTracking];
    }else
    {
    }
}


-(void)interstitialOnExposure
{
    if (!self.adModel.statisticsModel.exposured)
    {
        [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",self.adView.frame.size.width)];
        [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",self.adView.frame.size.height)];
        [self uploadServer:self.adModel.impTracking];
        self.adModel.statisticsModel.exposured = YES;
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

@end
 
