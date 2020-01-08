//
//  AppDelegate.m
//  quysDevDemo
//
//  Created by quys on 2019/12/26.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "AppDelegate.h"
 #import "QuysServiceListTableViewController.h"
#import <quysAdvice/quysAdvice.h>
@interface AppDelegate ()<QuysAdviceOpeenScreenDelegate>
@property (nonatomic,strong) QuysAdOpenScreenService *service;


@end

@implementation AppDelegate


-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions
{

    return YES;

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    QuysServiceListTableViewController *rootVC = [[QuysServiceListTableViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:rootVC];
    [self.window makeKeyAndVisible];
    //TODO:
    [[QuysAdviceManager shareManager] configSettings] ;
    

    
 
    return YES;
}



- (void)quys_requestStart:(QuysAdBaseService*)service
{
    
}

- (void)quys_requestSuccess:(QuysAdBaseService*)service{
    [self.service performSelector:@selector(showAdView)];
}
- (void)quys_requestFial:(QuysAdBaseService*)service error:(NSError*)error{
    
}

- (void)quys_interstitialOnExposure:(QuysAdBaseService*)service{
    
}
- (void)quys_interstitialOnClick:(CGPoint)cpClick service:(QuysAdBaseService*)service{
    
}
- (void)quys_interstitialOnAdClose:(QuysAdBaseService*)service{
    
}

/// 视频播放开始
/// @param service 广告服务对象
- (void)quys_videoPlaystart:(QuysAdBaseService*)service
{
    
}

/// 视频播放结束
/// @param service 广告服务对象
- (void)quys_videoPlayEnd:(QuysAdBaseService*)service;
{
    
}
@end
