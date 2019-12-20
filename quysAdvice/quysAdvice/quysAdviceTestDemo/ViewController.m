//
//  ViewController.m
//  AdviceTest
//
//  Created by quys on 2019/12/6.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "ViewController.h"
#import <quysAdvice/quysAdvice.h>
#import <Masonry/Masonry.h>
#import "QuysViewController.h"
#import <objc/runtime.h>

@interface ViewController ()<QuysAdSplashDelegate>
@property (nonatomic,strong) QuysAdSplashService *service;
//@property (nonatomic,strong) QuysInformationFlowService *service;
//@property (nonatomic,strong) QuysAdBannerService *service;
//@property (nonatomic,strong) QuysAdOpenScreenService *service;
@property (nonatomic,strong) QuysAdOpenScreenService *serviceScreen;


@property (nonatomic,strong) UIView *adView;

@property (nonatomic,strong) UIWindow *wid;

@end
//TODO：
/*
 1、重新设计开屏广告的实现逻辑
 2、优化所有广告回调准确性问题（同一类广告多个实类回调）
 3、封住并实现行为逻辑
 */
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    UIWindow *wid = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    wid.rootViewController = [QuysViewController new];
    wid.rootViewController.view.backgroundColor = [UIColor redColor];

    wid.windowLevel = UIWindowLevelAlert + 1;
    wid.hidden = NO;
    wid.alpha = 1;
    wid.backgroundColor = [UIColor blueColor];
    self.wid = wid;
    NSLog(@"click:%@",self.wid);
    
//    QuysAdSplashService *service = [[QuysAdSplashService alloc ]initWithID:@"quystest-cp" key:@"quystest-cp" cGrect:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) eventDelegate:self parentView:self.view];
//    [service loadAdViewNow];
//    self.service = service;
  
//    QuysInformationFlowService *service = [[QuysInformationFlowService alloc ]initWithID:@"quystest-xx" key:@"quystest-xx" cGrect:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 600) eventDelegate:self parentView:self.view];
//    [service loadAdViewNow];
//    self.service = service;
    
//    QuysAdBannerService *service = [[QuysAdBannerService alloc ]initWithID:@"yisoukuaidu_kp" key:@"64153C0313FCC0295167FB7A53976B42" cGrect:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 600) eventDelegate:self parentView:self.view];
//    [service loadAdViewNow];
//    self.service = service;
//        QuysAdOpenScreenService *service = [[QuysAdOpenScreenService alloc ]initWithID:@"qystest_kp" key:@"52E7FFCB4DE9EC44CF96CF16E1BD8ED5" cGrect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) eventDelegate:self ];
//        self.service = service;
    

    // Do any additional setup after loading the view.
    
}

-(void)updateViewConstraints
{
//    [self.adView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).offset(200);
//        make.left.right.mas_equalTo(self.view);
//        make.height.mas_equalTo(self.adView.mas_width).multipliedBy(.5);
////    }];
//    [self.adView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
//    }];
    
    [super updateViewConstraints];
}
-(void)quys_requestStart
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
-(void)quys_requestSuccess
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [self.service showAdView];

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
//    QuysAdOpenScreenService *service = [[QuysAdOpenScreenService alloc ]initWithID:@"qystest_kp" key:@"52E7FFCB4DE9EC44CF96CF16E1BD8ED5" cGrect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) eventDelegate:self ];
//    self.serviceScreen = service;
    
    UIWindow *wid = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    wid.rootViewController = [UIViewController new];
    wid.rootViewController.view.backgroundColor = [UIColor redColor];

    wid.windowLevel = UIWindowLevelAlert + 1;
    wid.hidden = NO;
    wid.alpha = 1;
    wid.backgroundColor = [UIColor blueColor];
    self.wid = wid;
    NSLog(@"click:%@",self.wid);
    
}
-(void)quys_interstitialOnAdClose
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}


@end
