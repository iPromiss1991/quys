//
//  QuysAdSplashService.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdSplashService.h"
#import "QuysAdSplashApi.h"

@interface QuysAdSplashService()<YTKRequestDelegate>
@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) NSString *bussinessKey;

@property (nonatomic,strong) QuysAdSplashApi *api;
@property (nonatomic,strong) QuysAdSplash *splashview;


@end


@implementation QuysAdSplashService
- (instancetype)initWithID:businessID key:bussinessKey
{
    if (self == [super init])
    {
        self.businessID = businessID;
        self.bussinessKey = bussinessKey;
        [self config];
    }return self;
}

#pragma mark - PrivateMethod

- (void)config
{
    //TODO:配置api 并请求数据（使用类别）
    QuysAdSplashApi *api = [[QuysAdSplashApi alloc]init];
    api.delegate = self;
    self.api = api;
    
}


- (QuysAdSplash*)startCreateAdviceView
{
    QuysAdSplash *splashview = [[QuysAdSplash alloc]init];
    self.splashview = splashview;
    return splashview;
}


#pragma mark - YTKRequestDelegate

-(void)requestFinished:(__kindof YTKBaseRequest *)request
{
    
}


- (void)requestFailed:(__kindof YTKBaseRequest *)request
{
    
}

@end
