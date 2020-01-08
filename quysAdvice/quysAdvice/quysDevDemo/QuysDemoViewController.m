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

@end

@implementation QuysDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TODO：广告的类型，以及输入不同参数（举例：信息流就有三种），是否需要把全部情况都list
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   NSString *strService = self.title;
    //
    if ([strService isEqualToString:@"banner"])
    {
        self.service = [[QuysAdBannerService alloc ]initWithID:@"yisoukuaidu_kp" key:@"64153C0313FCC0295167FB7A53976B42" cGrect:CGRectMake(0, 100,200, 200) eventDelegate:self parentView:self.view];
    }
    
    if ([strService isEqualToString:@"信息流"])
    {
        self.service =  [[QuysInformationFlowService alloc ]initWithID:@"quystest-xx" key:@"quystest-xx" cGrect:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 600) eventDelegate:self parentView:self.view];
    }
    
    if ([strService isEqualToString:@"插屏"])
    {
        self.service = [[QuysAdSplashService alloc ]initWithID:@"quystest-cp" key:@"quystest-cp" cGrect:CGRectMake(0, 100, 200, 200) eventDelegate:self parentView:self.view];
    }
    
    if ([strService isEqualToString:@"激励视频"])
    {
        self.service = [[QuysIncentiveVideoService alloc]initWithID:@"jlAdziyanapp" key:@"1262DF2885ACB4EEC8FF0486502E7A6D" cGrect:[UIScreen mainScreen].bounds backgroundImage:[UIImage imageNamed:@"Default-568h@2x"] eventDelegate:self window:[UIApplication sharedApplication].delegate.window];
    }
    
    if ([self.service isKindOfClass:[QuysIncentiveVideoService class]]) {
     }else
    {
        [self.service performSelector:@selector(loadAdViewNow)];

    }
 }

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

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
     }else
    {
        [self.service performSelector:@selector(showAdView)];

    }

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
