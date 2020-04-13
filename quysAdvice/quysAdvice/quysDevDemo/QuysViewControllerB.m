//
//  QuysViewControllerB.m
//  quysDevDemo
//
//  Created by quys on 2020/4/10.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysViewControllerB.h"
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
    
    
    UILabel *lblrequestlegelCountDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, 150, 60)];
    lblrequestlegelCountDes.backgroundColor = [UIColor clearColor];
    lblrequestlegelCountDes.text = @"有效请求次数：";
    [self.view addSubview:lblrequestlegelCountDes];
    
    UILabel *lblrequestlegelCount = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblrequestCountDes.frame)+10, 200, 200, 60)];
    lblrequestlegelCount.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblrequestlegelCount];
    self.lblrequestlegelCount = lblrequestlegelCount;
    
    
    
    UILabel *lblrequestlegelMulDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, 100, 60)];
    lblrequestlegelMulDes.backgroundColor = [UIColor clearColor];
    lblrequestlegelMulDes.text = @"实时填充率：";
    [self.view addSubview:lblrequestlegelMulDes];
    
    UILabel *lblrequestlegelMul = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblrequestCountDes.frame)+10, 300, 200, 60)];
    lblrequestlegelMul.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblrequestlegelMul];
    self.lblrequestlegelMul = lblrequestlegelMul;
    
    
    UILabel *lblEveryHoursDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 400, 200, 60)];
    lblEveryHoursDes.backgroundColor = [UIColor clearColor];
    lblEveryHoursDes.text = @"每小时填充率：";
    [self.view addSubview:lblEveryHoursDes];
    
    UILabel *lblEveryHours = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblrequestCountDes.frame)+10, 400, 200, 60)];
    lblEveryHours.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblEveryHours];
    self.lblEveryHours = lblEveryHours;
    
    self.currentDate = [NSDate date];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.3 target:self selector:@selector(tengAi) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}

- (void)tengAi
{
    
    
    
    requestCount ++;
    self.lblrequestCount.text = [NSString stringWithFormat:@"%ld",requestCount];
    BOOL uploadEnable = NO;
    NSInteger random = arc4random()%100000;
    if (random <= 10000)
    {
        uploadEnable = YES;
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
            taskBanner.uploadEnable = uploadEnable;
            [taskBanner start];
            dispatch_async(dispatch_get_main_queue(), ^{
                //                         self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];//必须浮点型
                
            });
        });
        
        //banner
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            QuysTengAiTask *taskBanner= [QuysTengAiTask new];
            taskBanner.businessID = @"br_tengai_ios";
            taskBanner.bussinessKey = @"1F7F6D5688BBA066A07816FE3C9292FA";
            taskBanner.uploadEnable = uploadEnable;
            [taskBanner start];
        });
        
        //信息流
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            QuysTengAiTask *taskBanner= [QuysTengAiTask new];
            taskBanner.businessID = @"xxl_tengai_ios";
            taskBanner.bussinessKey = @"38DDAF519B18A1A47093D5F4B614FFFD";
            taskBanner.uploadEnable = uploadEnable;
            [taskBanner start];
        });
        
        //插屏
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            QuysTengAiTask *taskBanner= [QuysTengAiTask new];
            taskBanner.businessID = @"cp_tengai_ios";
            taskBanner.bussinessKey = @"33E40C2E582024717BF1C21571CF24AD";
            taskBanner.uploadEnable = uploadEnable;
            [taskBanner start];
        });
        
    }
    
    
}




@end
