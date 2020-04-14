//
//  QuysViewControllerB.m
//  quysDevDemo
//
//  Created by quys on 2020/4/10.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysViewControllerB.h"
#import "QuysTengAiCountManager.h"
#import <quysAdvice/quysAdvice.h>
static NSInteger requestCount = 0;
static NSInteger requestlegelCount = 0;

@interface QuysViewControllerB ()
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,strong) UILabel *lblrequestCount;
@property (nonatomic,strong) UILabel *lblrequestlegelCount;
@property (nonatomic,strong) UILabel *lblrequestlegelMul;

@property (nonatomic,strong) UILabel *lblEveryHours;

@property (nonatomic,strong) NSDate *currentDate;
 


@end

@implementation QuysViewControllerB

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"正在运行。。。";
    self.view.backgroundColor = [UIColor purpleColor];
    
    UILabel *lblrequestCountDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 100, 60)];
    lblrequestCountDes.backgroundColor = [UIColor clearColor];
    lblrequestCountDes.text = @"请求次数：";
    [self.view addSubview:lblrequestCountDes];
    
    UILabel *lblrequestCount = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblrequestCountDes.frame)+10, 100, 200, 60)];
    lblrequestCount.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblrequestCount];
    self.lblrequestCount = lblrequestCount;
    
    
    UILabel *lblrequestlegelCountDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, 250, 60)];
    lblrequestlegelCountDes.backgroundColor = [UIColor clearColor];
    lblrequestlegelCountDes.text = @"有效请求（曝光）次数：";
    [self.view addSubview:lblrequestlegelCountDes];
    
    UILabel *lblrequestlegelCount = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblrequestlegelCountDes.frame)+10, 200, 200, 60)];
    lblrequestlegelCount.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblrequestlegelCount];
    self.lblrequestlegelCount = lblrequestlegelCount;
    
    
    
    UILabel *lblrequestlegelMulDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, 100, 60)];
    lblrequestlegelMulDes.backgroundColor = [UIColor clearColor];
    lblrequestlegelMulDes.text = @"实时填充率：";
    [self.view addSubview:lblrequestlegelMulDes];
    
    UILabel *lblrequestlegelMul = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblrequestlegelMulDes.frame)+10, 300, 200, 60)];
    lblrequestlegelMul.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblrequestlegelMul];
    self.lblrequestlegelMul = lblrequestlegelMul;
    
    
    UILabel *lblEveryHoursDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 400, 200, 60)];
    lblEveryHoursDes.backgroundColor = [UIColor clearColor];
    lblEveryHoursDes.text = @"每小时填充率：";
    [self.view addSubview:lblEveryHoursDes];
    
    UILabel *lblEveryHours = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblEveryHoursDes.frame)+10, 400, 200, 60)];
    lblEveryHours.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblEveryHours];
    self.lblEveryHours = lblEveryHours;
    
    self.currentDate = [NSDate date];
    
    NSTimeInterval timeIntevel = 60*60*1.0/([QuysTengAiCountManager shareManager].requestCount*1.0/4.0);
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeIntevel target:self selector:@selector(tengAi) userInfo:nil repeats:YES];
//    self.timer = timer;
    // Do any additional setup after loading the view.
}

- (void)tengAi
{
    
    
    
    requestCount ++;
    self.lblrequestCount.text = [NSString stringWithFormat:@"%ld",requestCount];
    BOOL exposureEnable = NO;
    NSInteger random = arc4random()%100;
    CGFloat randomRate = 100 *[QuysTengAiCountManager shareManager].exposureRate;
    if (random <= randomRate)
    {
        exposureEnable = YES;
        requestlegelCount++;
        self.lblrequestlegelCount.text = [NSString stringWithFormat:@"%ld",requestlegelCount];
        
    }
    
    self.lblrequestlegelMul.text = [NSString stringWithFormat:@"%lf",requestlegelCount*1.0/requestCount*1.0];
    NSDate *date =  [NSDate date];
    NSTimeInterval  intevel =   [date timeIntervalSinceDate:self.currentDate];
    if (intevel >= 60*60)
    {
        self.lblEveryHours.text = [NSString stringWithFormat:@"%lf",requestlegelCount*1.0/requestCount*1.0];
        self.currentDate = date;
    }
    
    
    
    {
        //开屏
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            QuysTengAiTask *taskBanner= [QuysTengAiTask new];
            taskBanner.businessID = @"kp_tengai_ios";
            taskBanner.bussinessKey = @"1E6E6B4EE8FEF1A16217CBB156F67CF0";
            taskBanner.exposureEnable = exposureEnable;
            [taskBanner start];
            dispatch_async(dispatch_get_main_queue(), ^{
                //                         self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];//必须浮点型
                
            });
        });
        
//        //banner
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            QuysTengAiTask *taskBanner= [QuysTengAiTask new];
//            taskBanner.businessID = @"br_tengai_ios";
//            taskBanner.bussinessKey = @"1F7F6D5688BBA066A07816FE3C9292FA";
//            taskBanner.exposureEnable = exposureEnable;
//            [taskBanner start];
//        });
//        
//        //信息流
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            QuysTengAiTask *taskBanner= [QuysTengAiTask new];
//            taskBanner.businessID = @"xxl_tengai_ios";
//            taskBanner.bussinessKey = @"38DDAF519B18A1A47093D5F4B614FFFD";
//            taskBanner.exposureEnable = exposureEnable;
//            [taskBanner start];
//        });
//        
//        //插屏
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            QuysTengAiTask *taskBanner= [QuysTengAiTask new];
//            taskBanner.businessID = @"cp_tengai_ios";
//            taskBanner.bussinessKey = @"33E40C2E582024717BF1C21571CF24AD";
//            taskBanner.exposureEnable = exposureEnable;
//            [taskBanner start];
//        });
//        
    }
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self tengAi];
}


/*iOS

开屏
kp_tengai_ios
1E6E6B4EE8FEF1A16217CBB156F67CF0

插屏
cp_tengai_ios
33E40C2E582024717BF1C21571CF24AD

信息流
xxl_tengai_ios
38DDAF519B18A1A47093D5F4B614FFFD

banner
br_tengai_ios
1F7F6D5688BBA066A07816FE3C9292FA
 */

@end
