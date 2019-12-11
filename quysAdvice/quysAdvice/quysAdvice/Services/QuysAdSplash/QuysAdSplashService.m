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
    if (self = [super init])
    {
        self.businessID = businessID;
        self.bussinessKey = bussinessKey;
        [self config];
    }return self;
}

#pragma mark - PrivateMethod


- (void)config
{
    //配置api 并请求数据
    QuysAdSplashApi *api = [[QuysAdSplashApi alloc]init];
    api.businessID = self.businessID;
    api.bussinessKey = self.bussinessKey;
    api.delegate = self;
    self.api = api;
    
}


- (QuysAdSplash*)startCreateAdviceView
{
    kWeakSelf(self)
    QuysAdSplashVM *vm = [[QuysAdSplashVM alloc] init];
    QuysAdSplash *splashview = [[QuysAdSplash alloc]initWithFrame:CGRectZero viewModel:vm];
    self.splashview = splashview;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [weakself.api start];
    });
    
    return splashview;
}


#pragma mark - YTKRequestDelegate

-(void)requestFinished:(__kindof YTKBaseRequest *)request
{
    NSLog(@"%s\n",__PRETTY_FUNCTION__);
    NSLog(@"%@\n",request.responseObject);

    [self.splashview setNeedsUpdateConstraints];
    [self.splashview updateConstraintsIfNeeded];
}


- (void)requestFailed:(__kindof YTKBaseRequest *)request
{
    NSLog(@"%s\n",__PRETTY_FUNCTION__);
    NSLog(@"%@\n",request.responseObject);
    [self.splashview setNeedsUpdateConstraints];
    [self.splashview updateConstraintsIfNeeded];
}

-(void)dealloc
{
    
}
@end
