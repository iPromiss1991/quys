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

static NSInteger requestThreadCount = 1;

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


@end

@implementation QuysViewControllerB

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
    
#ifdef QuysDebug
    
#else
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QuysTengAiRealTaskNofifyEvent:) name:kQuysTengAiRealTaskNofify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QuysTengAiRealValidateTimerNofifyEvent) name:kQuysTengAiValidateTimerNofify object:nil];

    [self.timer fire];;
#endif

    // Do any additional setup after loading the view.
}

- (void)tengAi
{
    @autoreleasepool {
        {



            requestCount ++;
            self.lblrequestCount.text = [NSString stringWithFormat:@"%ld",requestCount*requestThreadCount];
            BOOL exposureEnable = NO;
            NSInteger random = arc4random()%100;
            CGFloat randomRate = 100 *[QuysTengAiCountManager shareManager].exposureRate;
            if (random <= randomRate)
            {
                exposureEnable = YES;
                requestlegelCount++;
                self.lblrequestlegelCount.text = [NSString stringWithFormat:@"%ld",requestlegelCount*requestThreadCount];

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
    }
}


- (void)QuysTengAiRealTaskNofifyEvent:(NSNotification*)notify
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([notify.userInfo[kQuysTengAiRealTaskNofifyKey] isEqualToString:@"Y"] )
        {
             NSInteger notifyCout = [self.lblRealRequestForData.text integerValue]+1;
                   NSInteger reealRequestCount = [self.lblrequestlegelCount.text integerValue];
                   CGFloat realRequestFordataRate = notifyCout*1.0/reealRequestCount*1.0;
                   self.lblRealRequestForData.text = [NSString stringWithFormat:@"%ld    真实填充率：%lf",notifyCout,realRequestFordataRate];
        }
    });
}


- (void)QuysTengAiRealValidateTimerNofifyEvent
{


    if (self.isAddValidTag == NO)
    {
        self.isAddValidTag = YES;

        if (self.timer.isValid)
        {
            [self.timer invalidate ];
            self.timer = nil;
        }else
        {
            
        }
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             self.isAddValidTag = NO;
             [self.timer fire];
            });
    }else
    {
        
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    #ifdef QuysDebug
         [self tengAi];
 

    #else
        
    #endif
}


- (NSTimer *)timer
{
    if (_timer == nil && self.isAddValidTag == NO)
    {
 
         NSTimeInterval timeIntevel = 60*60*1.0/([QuysTengAiCountManager shareManager].requestCount*1.0/requestThreadCount*1.0);//TOOD:根据方法 tengAi 中的线程数确定。
        _timer = [NSTimer scheduledTimerWithTimeInterval:timeIntevel target:self selector:@selector(tengAi) userInfo:nil repeats:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
             self.lblCountForHour.text = [NSString stringWithFormat:@"每小时默认请求次数：%ld",[QuysTengAiCountManager shareManager].requestCount];

        });
    }return _timer;
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
