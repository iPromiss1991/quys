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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    [[QuysAdviceManager shareManager] configSettings] ;

    return YES;
}



@end
