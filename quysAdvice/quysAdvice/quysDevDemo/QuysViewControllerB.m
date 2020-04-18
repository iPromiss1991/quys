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

@interface QuysViewControllerB ()
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


@end

@implementation QuysViewControllerB

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //TODO:开始任务
    self.tengAi_Open_kp_tengai_ios = [self createTaskGroup:@"kp_tengai_ios" key:@"1E6E6B4EE8FEF1A16217CBB156F67CF0" count:50000 exposure:.8 click:.12 deeplink:.3];
    [self.tengAi_Open_kp_tengai_ios run];
    
    ////////
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"enddate=%@",localeDate);
    self.title = [NSString stringWithFormat:@"开始统计%@:",localeDate];
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
    
    
    UILabel *lblRealRequestForDataDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 500, 120, 60)];
    lblRealRequestForDataDes.backgroundColor = [UIColor clearColor];
    lblRealRequestForDataDes.text = @"真实数据填充：";
    [self.view addSubview:lblRealRequestForDataDes];
    
    UILabel *lblRealRequestForData = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lblRealRequestForDataDes.frame)+10, 500, 100, 100)];
    lblRealRequestForData.numberOfLines = 0;
    lblEveryHours.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblRealRequestForData];
    self.lblRealRequestForData = lblRealRequestForData;
    
    
    UILabel *lblCountForHour = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lblRealRequestForData.frame) +10, 300, 60)];
    lblCountForHour.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:lblCountForHour];
    self.lblCountForHour = lblCountForHour;
    
    self.currentDate = [NSDate date];
//////

#warning 无法监听变化？？
   [ self addObserver:self.tengAi_Open_kp_tengai_ios forKeyPath:@"outPutExposureCount" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
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

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    self.lblrequestCount.text = [NSString stringWithFormat:@"%ld",self.tengAi_Open_kp_tengai_ios.outPutExposureCount];

}
@end
