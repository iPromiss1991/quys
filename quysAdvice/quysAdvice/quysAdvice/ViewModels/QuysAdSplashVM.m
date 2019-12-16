//
//  QuysAdSplashVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdSplashVM.h"
#import "QuysAdviceModel.h"
@interface QuysAdSplashVM()
@property (nonatomic,strong) QuysAdviceModel *adModel;


@end


@implementation QuysAdSplashVM
- (instancetype)initWithModel:(QuysAdviceModel *)model
{
    if (self = [super init])
    {
        [self packingModel:model];
    }
    return self;
}

#pragma mark - PrivateMethod

- (void)packingModel:(QuysAdviceModel*)model
{
    self.adModel = model;
    [self updateReplaceDictionary:kResponeAdWidth value:kStringFormat(@"%ld",_adModel.width)];
    [self updateReplaceDictionary:kResponeAdHeight value:kStringFormat(@"%ld",_adModel.height)];

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

- (void)quys_interstitialOnClick:(CGPoint)cpClick
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
        [self uploadServer:self.adModel.clkTracking];
    }else
    {
        self.adModel.statisticsModel.clicked = YES;
    }
}


-(void)quys_interstitialOnExposure
{
    if (!self.adModel.statisticsModel.exposured)
    {
         [self uploadServer:self.adModel.impTracking];
    }else
    {
        self.adModel.statisticsModel.exposured = YES;
    }
}




@end
 
