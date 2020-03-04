//
//  QuysDemoViewController.m
//  quysDevDemo
//
//  Created by quys on 2020/1/7.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysDemoViewController.h"
#import <Masonry/Masonry.h>
#import "QuysVideoContentView.h"

@interface QuysDemoViewController ()
@property (nonatomic,strong) QuysAdBaseService *service;

@end

@implementation QuysDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TODO：广告的类型，以及输入不同参数（举例：信息流就有三种），是否需要把全部情况都list
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
     UIView *viewContain = [[UIView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width , 200)];
    viewContain.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewContain];
    NSString *strService = self.title;
    //
    if ([strService isEqualToString:@"banner"])
    {
        self.service = [[QuysAdBannerService alloc ]initWithID:@"yisoukuaidu_kp" key:@"64153C0313FCC0295167FB7A53976B42" cGrect:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , 200) eventDelegate:self parentView:viewContain];
    }
    
    if ([strService isEqualToString:@"信息流"])
    {
        self.service =  [[QuysInformationFlowService alloc ]initWithID:@"quystest-xx" key:@"quystest-xx" cGrect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) eventDelegate:self parentView:viewContain];
    }
    
    if ([strService isEqualToString:@"插屏"])
    {
        self.service = [[QuysAdSplashService alloc ]initWithID:@"quystest-cp" key:@"quystest-cp" cGrect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 200) eventDelegate:self parentView:viewContain];
    }
    
    if ([strService isEqualToString:@"激励视频"])
    {
        [viewContain removeFromSuperview];
        self.service = [[QuysIncentiveVideoService alloc]initWithID:@"jmtest" key:@"jmtest" cGrect:[UIScreen mainScreen].bounds backgroundImage:[UIImage imageNamed:@"Default-568h@2x"] eventDelegate:self window:[UIApplication sharedApplication].delegate.window];
    }
    if ([strService isEqualToString:@"测试开屏视频"])
     {
         [viewContain removeFromSuperview];
         self.service = nil;
         QuysVideoContentView *videoView = [[QuysVideoContentView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)- 64)];
         [videoView setQuysPlayUrl:[NSURL URLWithString:@"http://txmov2.a.yximgs.com/upic/2019/10/12/17/BMjAxOTEwMTIxNzU2MjhfMTM1MjQ0NzU5N18xODQ1NDI1MTA5N18wXzM=_b_Bfcd423e5cc1aa07b3c59d43525ec1a87.mp4?tag=1-1573111744-unknown-0-aptoisl6iu-aa4b5ce82a8e490c&type=hot"]];
         [self.view addSubview:videoView];
         
//         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//             [videoView quys_remove];
//             [videoView removeFromSuperview];
//         });
     }
    
   
    if (self.service)
    {
            if ([self.service isKindOfClass:[QuysIncentiveVideoService class]])
        {
            
         }else
        {
            [self.service performSelector:@selector(loadAdViewNow)];

        }
    }else
    {
        
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
