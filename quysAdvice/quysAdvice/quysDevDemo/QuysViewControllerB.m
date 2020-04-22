//
//  QuysViewControllerB.m
//  quysDevDemo
//
//  Created by quys on 2020/4/10.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysViewControllerB.h"
#import "QuysTengAiTaskGroup.h"
#import <quysAdvice/quysAdvice.h>

@interface QuysViewControllerB ()<QuysTengAiTaskGroupDelegate>
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,strong) UILabel *lblrequestCount;
@property (nonatomic,strong) UILabel *lblrequestlegelCount;
@property (nonatomic,strong) UILabel *lblrequestlegelMul;

@property (nonatomic,strong) UILabel *lblEveryHours;
@property (nonatomic,strong) UILabel *lblRealRequestForData;


@property (nonatomic,strong) UILabel *lblCountForHour;

@property (nonatomic,strong) NSDate *currentDate;
@property (atomic,assign) BOOL isAddValidTag;

//
@property (nonatomic, strong) QuysTengAiTaskGroup *tengAi_Open_kp_tengai_ios;//!< <#Explement #>
@property (nonatomic, strong) QuysTengAiTaskGroup *tengAi_Open_kp_tengai_ios3;//!< <#Explement #>
@property (nonatomic, strong) QuysTengAiTaskGroup *tengAi_Open_kp_tengai_ios4;//!< <#Explement #>


@end

@implementation QuysViewControllerB

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //TODO:开始任务
    self.tengAi_Open_kp_tengai_ios = [self createTaskGroup:@"kp_tengai_ios2" key:@"46E3AAE0C42B26D667975A8DED3414E0" count:50000 exposure:.8 click:.12 deeplink:.3];
    self.tengAi_Open_kp_tengai_ios.delegate = self;
    [self.tengAi_Open_kp_tengai_ios run];

    self.tengAi_Open_kp_tengai_ios3 = [self createTaskGroup:@"kp_tengai_ios3" key:@"A13C312503640AB253C20C6FE8D6B0C8" count:50000*0.5 exposure:.8 click:.15 deeplink:.3];
//    self.tengAi_Open_kp_tengai_ios3.delegate = self;
    [self.tengAi_Open_kp_tengai_ios3 run];
//

    self.tengAi_Open_kp_tengai_ios4 = [self createTaskGroup:@"kp_tengai_iOS4" key:@"3BCA86C7FA0E9F84E21987802DAC15E0" count:50000*0.5 exposure:.8 click:.15 deeplink:.3];
//    self.tengAi_Open_kp_tengai_ios4.delegate = self;
    [self.tengAi_Open_kp_tengai_ios4 run];

//    //TODO：测试
//    self.tengAi_Open_kp_tengai_ios = [self createTaskGroup:@"kp_tengai_iOS4" key:@"3BCA86C7FA0E9F84E21987802DAC15E0" count:50000 exposure:.8 click:.12 deeplink:.3];
//      self.tengAi_Open_kp_tengai_ios.delegate = self;
//      [self.tengAi_Open_kp_tengai_ios run];
//
//    ////////
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"enddate=%@",localeDate);
    self.title = [NSString stringWithFormat:@"开始统计%@:",localeDate];
    self.view.backgroundColor = [UIColor purpleColor];
    
    UILabel *lblrequestCountDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 150, 60)];
    lblrequestCountDes.backgroundColor = [UIColor clearColor];
    lblrequestCountDes.text = @"发起请求次数：";
    [self.view addSubview:lblrequestCountDes];
    
    UILabel *lblrequestCount = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblrequestCountDes.frame)+10, 100, 200, 60)];
    lblrequestCount.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblrequestCount];
    self.lblrequestCount = lblrequestCount;
    
    
    UILabel *lblrequestlegelCountDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, 250, 60)];
    lblrequestlegelCountDes.backgroundColor = [UIColor clearColor];
    lblrequestlegelCountDes.text = @"有效请求次数：";
    [self.view addSubview:lblrequestlegelCountDes];
    
    UILabel *lblrequestlegelCount = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblrequestlegelCountDes.frame)+10, 200, 200, 60)];
    lblrequestlegelCount.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblrequestlegelCount];
    self.lblrequestlegelCount = lblrequestlegelCount;
    
    
    
    UILabel *lblrequestlegelMulDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, 100, 60)];
    lblrequestlegelMulDes.backgroundColor = [UIColor clearColor];
    lblrequestlegelMulDes.text = @"曝光次数：";
    [self.view addSubview:lblrequestlegelMulDes];
    
    UILabel *lblrequestlegelMul = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblrequestlegelMulDes.frame)+10, 300, 200, 60)];
    lblrequestlegelMul.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblrequestlegelMul];
    self.lblrequestlegelMul = lblrequestlegelMul;
    
    
    UILabel *lblEveryHoursDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 400, 200, 60)];
    lblEveryHoursDes.backgroundColor = [UIColor clearColor];
    lblEveryHoursDes.text = @"每小时有效请求量：";
    [self.view addSubview:lblEveryHoursDes];
    
    UILabel *lblEveryHours = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblEveryHoursDes.frame)+10, 400, 200, 60)];
    lblEveryHours.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblEveryHours];
    self.lblEveryHours = lblEveryHours;
    
    
    UILabel *lblRealRequestForDataDes = [[UILabel alloc]initWithFrame:CGRectMake(20,  CGRectGetMaxY(lblEveryHoursDes.frame) +10, 150, 60)];
    lblRealRequestForDataDes.backgroundColor = [UIColor clearColor];
    lblRealRequestForDataDes.text = @"实时数据填充率：";
    [self.view addSubview:lblRealRequestForDataDes];
    
    UILabel *lblRealRequestForData = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblRealRequestForDataDes.frame)+10, CGRectGetMaxY(lblEveryHoursDes.frame) +10, 100, 60)];
    lblRealRequestForData.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblRealRequestForData];
    self.lblRealRequestForData = lblRealRequestForData;
    
    
    UILabel *lblCountForHour = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lblRealRequestForDataDes.frame) +10, 300, 60)];
    lblCountForHour.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:lblCountForHour];
    lblCountForHour.textColor = [UIColor redColor];
    self.lblCountForHour = lblCountForHour;
    
    self.currentDate = [NSDate date];
//////

  }




- (QuysTengAiTaskGroup*)createTaskGroup:(NSString*)businessID key:(NSString*)bussinessKey count:(NSInteger)requestCount exposure:(CGFloat)exposureRate click:(CGFloat)clickRate deeplink:(CGFloat)deeplinkRate
{
    QuysTengAiTaskGroup *taskGroup = [QuysTengAiTaskGroup new];
    taskGroup.businessID = businessID;
    taskGroup.bussinessKey = bussinessKey;
    
    taskGroup.requestCount = requestCount;
    
    taskGroup.exposureRate = exposureRate;
    taskGroup.clickRate = clickRate;
    taskGroup.deeplinkRate = deeplinkRate;
    return taskGroup;
}


#pragma mark - Delegate

- (void)QuysTengAiNofifyEventType:(QuysTaskNotifyType)eventType count:(NSInteger)eventCount task:(QuysTengAiTaskGroup *)task
{
    
    switch (eventType)
               {
                       
                   case QuysTaskNotifyType_HasData:
                   {
                       self.lblrequestlegelCount.text = [NSString stringWithFormat:@"%ld",eventCount];
                   }
                       break;
                   case QuysTaskNotifyType_Exposure:
                   {
                       self.lblrequestlegelMul.text = [NSString stringWithFormat:@"%ld",eventCount];
                   }
                       break;
                   case QuysTaskNotifyType_Click:
                   {
 
                   }
                       break;
                   case QuysTaskNotifyType_Deeplink:
                   {
 
                   }
                       break;
                   default:
                       break;
               }

    self.lblrequestCount.text = [NSString stringWithFormat:@"%ld",self.tengAi_Open_kp_tengai_ios.outPutRequestDataCount];
    self.lblRealRequestForData.text = [NSString stringWithFormat:@"%lf",self.self.tengAi_Open_kp_tengai_ios.outPutHasDataCount*1.0/self.tengAi_Open_kp_tengai_ios.outPutRequestDataCount*1.0];
    self.lblCountForHour.text = [NSString stringWithFormat:@"设置的每小时请求量：%ld",self.tengAi_Open_kp_tengai_ios.requestCount];
}


- (void)QuysTengPerHourHasDataRequestCount:(NSInteger)eventCount task:(QuysTengAiTaskGroup *)task
{
    self.lblEveryHours.text = [NSString stringWithFormat:@"%ld",eventCount];

    
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
