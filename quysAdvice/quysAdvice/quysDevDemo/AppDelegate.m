//
//  AppDelegate.m
//  quysDevDemo
//
//  Created by quys on 2019/12/26.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking.h>
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
    [[QuysAdviceManager shareManager] configSettings] ;

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    QuysServiceListTableViewController *rootVC = [[QuysServiceListTableViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController :rootVC];
    [self.window makeKeyAndVisible];

    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchIamge"];
    QuysAdOpenScreenService *service = [[QuysAdOpenScreenService alloc]
                                        initWithID:@"kp_ios_qys_test"
                                        key:@"206063F608B0A590F7ACCB7725207D37"
                                        launchScreenVC:viewController
                                        eventDelegate:self ];
    service.bgShowDuration = 2;
    [service loadAdViewAndShow];
    self.service = service;//需强引用该服务
    return YES;
}



- (void)quys_requestStart:(QuysAdBaseService*)service
{
    
}

- (void)quys_requestSuccess:(QuysAdBaseService*)service{

    
}
- (void)quys_requestFial:(QuysAdBaseService*)service error:(NSError*)error{
    
}

- (void)quys_interstitialOnExposure:(QuysAdBaseService*)service{

}
- (void)quys_interstitialOnClick:(CGPoint)cpClick service:(QuysAdBaseService*)service{
    
}
- (void)quys_interstitialOnAdClose:(QuysAdBaseService*)service{

}

 
@end
