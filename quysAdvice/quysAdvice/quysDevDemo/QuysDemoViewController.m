//
//  QuysDemoViewController.m
//  quysDevDemo
//
//  Created by quys on 2020/1/7.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysDemoViewController.h"
#import <Masonry/Masonry.h>

@interface QuysDemoViewController ()
@property (nonatomic,strong) QuysAdBaseService *service;
@property (nonatomic, strong) UIView *viewContain;//!< <#Explement #>
@property (nonatomic, strong) UIView *viewContainBottom;//!< <#Explement #>
@property (nonatomic, strong) UIView *adviceView;//!< <#Explement #>
@end

@implementation QuysDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TODO：广告的类型，以及输入不同参数（举例：信息流就有三种），是否需要把全部情况都list
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
     UIView *viewContain = [[UIView alloc]init];
    viewContain.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewContain];
    self.viewContain=  viewContain;
    
    UIView *viewContainBottom = [[UIView alloc]init];
    viewContainBottom.backgroundColor = [UIColor purpleColor];
    [self.viewContain addSubview:viewContainBottom];
    self.viewContainBottom =  viewContainBottom;
    NSString *strService = self.title;
//    //
//    if ([strService isEqualToString:@"banner"])
//    {
//        self.service = [[QuysAdBannerService alloc ]initWithID:@"yisoukuaidu_kp" key:@"64153C0313FCC0295167FB7A53976B42" cGrect:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , 200) eventDelegate:self parentView:viewContain];
//    }
//
//    if ([strService isEqualToString:@"信息流"])
//    {
//        self.service =  [[QuysInformationFlowService alloc ]initWithID:@"quystest-xx" key:@"quystest-xx" cGrect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) eventDelegate:self parentView:viewContain];
//    }
//
//    if ([strService isEqualToString:@"插屏"])
//    {
//        self.service = [[QuysAdSplashService alloc ]initWithID:@"quystest-cp" key:@"quystest-cp" cGrect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 200) eventDelegate:self parentView:viewContain];
//    }
//
//    if ([strService isEqualToString:@"激励视频"])
//    {
//        [viewContain removeFromSuperview];
//        self.service = [[QuysIncentiveVideoService alloc]initWithID:@"jmtest" key:@"jmtest" cGrect:[UIScreen mainScreen].bounds backgroundImage:[UIImage imageNamed:@"Default-568h@2x"] eventDelegate:self window:[UIApplication sharedApplication].delegate.window];
//    }
//
//    if ([self.service isKindOfClass:[QuysIncentiveVideoService class]])
//    {
//
//    }else
//    {
//        [self.service performSelector:@selector(loadAdViewNow)];
//
//    }
//TODO：正式环境测试数据
    //
    if ([strService isEqualToString:@"banner"])
    {
        self.service = [[QuysAdBannerService alloc ]initWithID:@"ziyanapp_banner" key:@"DF6CB421D36AE5B518700B40A77105A7" cGrect:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , 200) eventDelegate:self parentView:viewContain];
    }
    
    if ([strService isEqualToString:@"信息流"])
    {
        self.service =  [[QuysInformationFlowService alloc ]initWithID:@"ziyanapp_feed" key:@"3A6511273E535FA02C15F37D17D22A95" cGrect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) eventDelegate:self parentView:viewContain];
    }
    
    if ([strService isEqualToString:@"插屏"])
    {
        self.service = [[QuysAdSplashService alloc ]initWithID:@"ziyanapp_cp" key:@"8EB8AC0B397CA55C2D78DE88DF8587C2" cGrect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 200) eventDelegate:self parentView:viewContain];
    }
    
    if ([strService isEqualToString:@"激励视频"])
    {
        [viewContain removeFromSuperview];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.service = [[QuysIncentiveVideoService alloc]initWithID:@"jlAdziyanapp" key:@"1262DF2885ACB4EEC8FF0486502E7A6D" cGrect:[UIScreen mainScreen].bounds backgroundImage:[UIImage imageNamed:@"Default-568h@2x"] eventDelegate:self window:[UIApplication sharedApplication].delegate.window];
            
            UITextField *txtF = [[UITextField alloc] initWithFrame:CGRectMake(0, 200, 200, 60)];
            txtF.backgroundColor = [UIColor redColor];
            txtF.placeholder = @"ce";;
            [self.view addSubview:txtF];
        });
    }
    
    if ([self.service isKindOfClass:[QuysIncentiveVideoService class]])
    {
        
    }else
    {
        [self.service performSelector:@selector(loadAdViewNow)];
        
    }

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)updateViewConstraints
{
    
    if (![self.title  isEqualToString:@"激励视频"])
    {
        [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).mas_offset(200);
            make.left.right.mas_equalTo(self.view);
            make.bottom.mas_lessThanOrEqualTo(self.view);
            make.height.mas_greaterThanOrEqualTo(400);
        }];
        
        [self.viewContainBottom mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.adviceView.mas_bottom);
            make.left.right.mas_equalTo(self.viewContain);
            make.bottom.mas_equalTo(self.viewContain);
            make.height.mas_greaterThanOrEqualTo(100);
        }];
    }
    
    [super updateViewConstraints];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)quys_requestStart:(QuysAdBaseService*)service
{
    
}

- (void)quys_requestSuccess:(QuysAdBaseService*)service
{
    if ([self.service isKindOfClass:[QuysIncentiveVideoService class]]) {
        self.adviceView = [self.service valueForKey:@"adviceView"];

     }else
    {
        [self.service performSelector:@selector(showAdView)];
       self.adviceView = [self.service valueForKey:@"adviceView"];

    }
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];

}
- (void)quys_requestFial:(QuysAdBaseService*)service error:(NSError*)error{
    
}

- (void)quys_interstitialOnExposure:(QuysAdBaseService*)service{
    
}
- (void)quys_interstitialOnClick:(CGPoint)cpClick service:(QuysAdBaseService*)service{
    
}
- (void)quys_interstitialOnAdClose:(QuysAdBaseService*)service{

}

//尾帧
- (void)quys_endViewInterstitialOnExposure:(QuysAdBaseService*)service{
    
}
- (void)quys_endViewInterstitialOnClick:(CGPoint)cpClick service:(QuysAdBaseService*)service{
    
}

- (void)quys_endViewInterstitialOnAdClose:(QuysAdBaseService*)service{
    
}


@end
