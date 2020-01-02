//
//  QuysViewController.m
//  quysDevDemo
//
//  Created by quys on 2019/12/26.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysViewController.h"
#import <quysAdvice/quysAdvice.h>

@interface QuysViewController ()
@property (nonatomic,strong) QuysIncentiveVideoService *service;

@end

@implementation QuysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vhl_setNavBarBackgroundColor:[UIColor colorWithRed:(rand() % 100 * 0.01) green:(rand() % 100 * 0.01) blue:0.86 alpha:1.00]];
    [self vhl_setNavigationSwitchStyle:VHLNavigationSwitchStyleFakeNavBar];
    //[self vhl_setNavBarBackgroundImage:[UIImage imageNamed:@"millcolorGrad"]];
    //[self vhl_setNavBarBackgroundAlpha:0.f];
    [self vhl_setStatusBarHidden:YES];
    [self vhl_setNavBarShadowImageHidden:YES];
    [self vhl_setNavBarBackgroundAlpha:1.0f];
//    [self vhl_setNavBarHidden:YES];
    [self setQus_navBackButtonTitle:@"测试2"];
    self.view.backgroundColor = [UIColor cyanColor];
    
    QuysIncentiveVideoService *service = [[QuysIncentiveVideoService alloc]initWithID:@"jlAdziyanapp" key:@"1262DF2885ACB4EEC8FF0486502E7A6D" cGrect:[UIScreen mainScreen].bounds backgroundImage:[UIImage imageNamed:@"Default-568h@2x"] eventDelegate:self window:[UIApplication sharedApplication].delegate.window];
        self.service = service;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc
{
    
}


@end
