//
//  AppDelegate.m
//  quysAdviceTestDemo
//
//  Created by quys on 2019/12/11.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "AppDelegate.h"
#import <quysAdvice/quysAdvice.h>
#import "ViewController.h"
@interface AppDelegate ()<QuysAdSplashDelegate>
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
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];

    [[QuysAdviceManager shareManager] configSettings] ;
    QuysAdOpenScreenService *service = [[QuysAdOpenScreenService alloc ]initWithID:@"qystest_kp" key:@"52E7FFCB4DE9EC44CF96CF16E1BD8ED5" cGrect:[UIScreen mainScreen].bounds backgroundImage:[UIImage imageNamed:@"Default-568h@2x"] eventDelegate:self window:self.window];
    self.service = service;
    return YES;
}


-(void)quys_requestStart
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
-(void)quys_requestSuccess
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
//    [self.service showAdView];

}
-(void)quys_requestFial:(NSError *)error
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}
-(void)quys_interstitialOnExposure
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}
-(void)quys_interstitialOnClick:(CGPoint)cpClick
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
-(void)quys_interstitialOnAdClose
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}

@end
