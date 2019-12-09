//
//  QuysAdviceManager.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "QuysAdviceManager.h"
#import "QuysAdviceConfigModel.h"
#import "QuysAdSplashService.h"

@interface QuysAdviceManager()
@property (nonatomic,strong) QuysAdviceConfigModel *splashBusinessModel;//!< 插屏广告
@property (nonatomic,strong) QuysAdviceConfigModel *spreadScreenBusinessModel;//!< 开屏广告
@property (nonatomic,strong) QuysAdviceConfigModel *bannerBusinessModel;//!< banner广告

@property (nonatomic,strong) QuysAdviceConfigModel *incentivevideoBusinessModel;//!< 激励视屏广告
@property (nonatomic,strong) QuysAdviceConfigModel *informationflowBusinessModel;//!< 信息流广告
@property (nonatomic,strong) QuysAdviceConfigModel *applicationBusinessModel;//!< 应用类型广告


@end


@implementation QuysAdviceManager

+ (instancetype)shareManager
{
    static QuysAdviceManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    return manager;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [QuysAdviceManager shareManager] ;
}
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [QuysAdviceManager shareManager] ;
}



- (void)configSplashAdvice:(NSString*)businessID :(NSString*)businessKey
{
    QuysAdviceConfigModel *model = [[QuysAdviceConfigModel alloc]initWithID:businessID key:businessKey];
    self.splashBusinessModel = model;
}

- (QuysAdSplash*)createSplashAdvice:(id <QuysAdSplashDelegate>)deleagte;
{
    QuysAdSplashService *service = [[QuysAdSplashService alloc]initWithID:self.splashBusinessModel.businessID key:self.splashBusinessModel.businessKey];
    service.delegate = deleagte;
    return   [service startCreateAdviceView];
    
}

@end
