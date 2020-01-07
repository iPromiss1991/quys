//
//  AppDelegate.m
//  quysDevDemo
//
//  Created by quys on 2019/12/26.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <quysAdvice/quysAdvice.h>
@interface AppDelegate ()<QuysAdSplashDelegate,QuysAdviceOpeenScreenDelegate>
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
    UIViewController *rootVC = [[ViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:rootVC];
//
//    UITabBarController *tabBarVC = [[UITabBarController alloc]init];
//    [tabBarVC addChildViewController:rootVC];
//    self.window.rootViewController = tabBarVC;

    [self.window makeKeyAndVisible];
//
    [[QuysAdviceManager shareManager] configSettings] ;
    
    
//    QuysAdOpenScreenService *service = [[QuysAdOpenScreenService alloc ]initWithID:@"qystest_kp" key:@"52E7FFCB4DE9EC44CF96CF16E1BD8ED5" cGrect:[UIScreen mainScreen].bounds backgroundImage:[UIImage imageNamed:@"Default-568h@2x"] eventDelegate:self window:self.window];
//    self.service = service;
    
 
    return YES;
}


- (void)quys_requestStart:(QuysAdBaseService *)service
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}
@end
