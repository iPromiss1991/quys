//
//  ViewController.m
//  quysDevDemo
//
//  Created by quys on 2019/12/26.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "ViewController.h"
#import <quysAdvice/quysAdvice.h>
#import <Masonry/Masonry.h>
//#import "QuysViewController.h"
#import <objc/runtime.h>
#import "QuysViewController.h"
@interface ViewController ()<QuysAdSplashDelegate>
//@property (nonatomic,strong) QuysAdSplashService *service;
//@property (nonatomic,strong) QuysInformationFlowService *service;
@property (nonatomic,strong) QuysAdBannerService *service;
//@property (nonatomic,strong) QuysAdOpenScreenService *service;
//@property (nonatomic,strong) QuysAdOpenScreenService *service;


@property (nonatomic,strong) UIView *adView;

@property (nonatomic,strong) UIWindow *window;

@end
//TODO：
/*
 1、重新设计开屏广告的实现逻辑
 2、优化所有广告回调准确性问题（同一类广告多个实类回调）
 3、封装并实现行为逻辑
 */
@implementation ViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"首页";
    [self vhl_setNavBarBackgroundColor:[UIColor colorWithRed:(rand() % 100 * 0.01) green:(rand() % 100 * 0.01) blue:0.86 alpha:1.00]];
    [self vhl_setNavigationSwitchStyle:VHLNavigationSwitchStyleFakeNavBar];
    //[self vhl_setNavBarBackgroundImage:[UIImage imageNamed:@"millcolorGrad"]];
    //[self vhl_setNavBarBackgroundAlpha:0.f];
    [self vhl_setStatusBarHidden:NO];
    [self vhl_setNavBarShadowImageHidden:NO];
    [self vhl_setNavBarBackgroundAlpha:1.0f];
    [self vhl_setNavBarHidden:NO];
    self.qus_navBackButton.hidden = YES;
    //    [self vhl_setNavBarTintColor:[UIColor blackColor]];
//    [self vhl_setNavBarTitleColor:[UIColor blackColor]];
//    [self vhl_setStatusBarStyle:UIStatusBarStyleDefault];
//    [self NormalWindow];
//    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
//    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
////    window.windowLevel = UIWindowLevelAlert ;
//    window.hidden = NO;
//    self.window = window;
//
//    UITextField *txt = [[UITextField alloc]initWithFrame:CGRectMake(0, 200, 220, 30)];
//    txt.backgroundColor = [UIColor cyanColor];
//    [window addSubview:txt];
    
//    QuysAdSplashService *service = [[QuysAdSplashService alloc ]initWithID:@"quystest-cp" key:@"quystest-cp" cGrect:CGRectMake(0, 64, 200, 200) eventDelegate:self parentView:self.view];
//    [service loadAdViewNow];
//    self.service = service;
  
//    QuysInformationFlowService *service = [[QuysInformationFlowService alloc ]initWithID:@"quystest-xx" key:@"quystest-xx" cGrect:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 600) eventDelegate:self parentView:self.view];
//    [service loadAdViewNow];
//    self.service = service;
    
    QuysAdBannerService *service = [[QuysAdBannerService alloc ]initWithID:@"yisoukuaidu_kp" key:@"64153C0313FCC0295167FB7A53976B42" cGrect:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300) eventDelegate:self parentView:self.view];
    [service loadAdViewNow];
    self.service = service;
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
//    }];
//
    
//    [self.adView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
//    }];
    
    [super updateViewConstraints];
}

-(void)quys_requestStart:(QuysAdBannerService *)service
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
-(void)quys_requestSuccess:(QuysAdBannerService *)service
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [self.service showAdView];

}
-(void)quys_requestFial:(QuysAdBannerService *)service error:(NSError *)error
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}
-(void)quys_interstitialOnExposure:(QuysAdBannerService *)service
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}
-(void)quys_interstitialOnClick:(CGPoint)cpClick service:(QuysAdBannerService *)service
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
-(void)quys_interstitialOnAdClose:(QuysAdBannerService *)service
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}



// - (void)NormalWindow
//{
//    NSLog(@"newWindowBegin");
//    UIWindow * testWindows  =  [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]; // 以后 默认了 window的大小
//    self.window = testWindows;
//    testWindows.hidden = NO;
//    self.window.backgroundColor = [UIColor yellowColor];
//    UIButton *windowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [windowBtn addTarget:self action:@selector(hideWindow) forControlEvents:UIControlEventTouchUpInside];
//    [windowBtn setTitle:@"创建一个StatusBarwindow" forState:UIControlStateNormal];
//    windowBtn.backgroundColor = [UIColor redColor];
//    windowBtn.frame = CGRectMake(44,44,200,100);;
//    [self.window addSubview:windowBtn];
//    [self.window makeKeyAndVisible];
//    NSLog(@"newWindowEnd");
//
//
//
//    UILabel * label = [[UILabel alloc]init];
//    label.text = [NSString stringWithFormat:@"%s windows =  %@ ---windowLevel= %f",__FUNCTION__,testWindows,testWindows.windowLevel];
//    label.numberOfLines = 0;//表示label可以多行显示
//    label.textColor = [UIColor blackColor];
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
//    CGSize labelSize = [label.text boundingRectWithSize:CGSizeMake(200, 5000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//    label.font = [UIFont systemFontOfSize:14];
//    label.frame = (CGRect){{50,200},labelSize};
//    [testWindows addSubview:label];
//
//    for (UIWindow * wind in [UIApplication sharedApplication].windows) {
//        NSLog(@"%s windows =  %@ ---windowLevel= %f",__FUNCTION__,wind,wind.windowLevel);
//    }
//}
//
//- (void)hideWindow
//{
//        self.window.hidden = YES;
//        self.window = nil;
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"1");
    
//    [[QuysAdviceManager shareManager] configSettings] ;
//    QuysAdOpenScreenService *service = [[QuysAdOpenScreenService alloc ]initWithID:@"qystest_kp" key:@"52E7FFCB4DE9EC44CF96CF16E1BD8ED5" cGrect:[UIScreen mainScreen].bounds backgroundImage:[UIImage imageNamed:@"Default-568h@2x"] eventDelegate:self window:self.window];
//    self.service = service;
    
 }
@end
