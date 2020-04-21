//
//  QuysTengAiTaskGroup.m
//  quysAdvice
//
//  Created by wxhmbp on 2020/4/18.
//  Copyright © 2020年 Quys. All rights reserved.
//

#import "QuysTengAiTaskGroup.h"
#import "QuysTengAiTask.h"
#import "QuysTaskNotifyModel.h"

static NSInteger timerIntervalUnit = 60 * 30;

@interface QuysTengAiTaskGroup()
@property (nonatomic, strong) NSTimer *timer;//!< <#Explement #>
@property (nonatomic, assign) BOOL isAddValidTag;//!< <#Explement #>
@property (nonatomic, assign) NSUInteger threadCount;//!< <#Explement #>

@property (nonatomic, strong) NSDate *runStartDate;//!<  初始化时间
@property (nonatomic, strong) NSDate *lastReturnDataDate;//!<   上一次数据返回时间
@property (nonatomic, strong) NSString *strUniqueNotifyName;//!< 有数据返回的通知名称

@property (nonatomic, assign) NSUInteger lastHourRequestCount;//!< 前一小时截止的请求量
@property (nonatomic, assign) NSUInteger requestTimeInterval;//!< 多长时间没数据时，就去更改请求数量。eg：默认30分钟
@end
@implementation QuysTengAiTaskGroup


- (instancetype)init
{
    if (self == [super init]) {
        [self config];
    }return self;
}

- (void)config
{
    self.runStartDate = [NSDate buildDate:[NSDate date]];
#warning 可以在此处设置默认参数
    //    self.requestTimeInterval = 3;
    
    
}

- (void)run
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QuysTengAiRealTaskNofifyEvent:) name:self.strUniqueNotifyName object:nil];
        [self.timer fire];
    });
    
}



- (void)startTasks
{
    for (int i = 0 ; i <self.threadCount; i++)
    {
        [self runTask];
    }
}

- (void)runTask
{
    @autoreleasepool {
        self.outPutRequestDataCount ++;
        QuysTengAiTask *api = [QuysTengAiTask new];
        api.businessID = self.businessID;
        api.bussinessKey = self.bussinessKey;
        api.exposureRate = self.exposureRate;
        api.clickRate = self.clickRate;
        api.deeplinkRate = self.deeplinkRate;
        api.postNotifyName = self.strUniqueNotifyName;
        [api start];
    }
    
    
}


- (void)QuysTengAiRealTaskNofifyEvent:(NSNotification*)notify
{
    dispatch_async(dispatch_get_main_queue(), ^{
        QuysTaskNotifyModel *model = notify.object;
        if (model.requestStatus )
        {
            // 更新UI
            switch (model.taskType)
            {
                    
                case QuysTaskNotifyType_HasData:
                {
                    self.outPutHasDataCount++;
                    if ([self.delegate performSelector:@selector(QuysTengAiNofifyEventType:count: )])
                    {
                        [self.delegate QuysTengAiNofifyEventType:model.taskType count:self.outPutHasDataCount];
                    }
                    //TODO
                }
                    break;
                case QuysTaskNotifyType_Exposure:
                {
                    self.outPutExposureCount++;
                    if ([self.delegate performSelector:@selector(QuysTengAiNofifyEventType:count: )])
                    {
                        [self.delegate QuysTengAiNofifyEventType:model.taskType count:self.outPutExposureCount];
                    }
                }
                    break;
                case QuysTaskNotifyType_Click:
                {
                    self.outPutClickCount++;
                    if ([self.delegate performSelector:@selector(QuysTengAiNofifyEventType:count: )])
                    {
                        [self.delegate QuysTengAiNofifyEventType:model.taskType count:self.outPutClickCount];
                    }
                }
                    break;
                case QuysTaskNotifyType_Deeplink:
                {
                    self.outPutDeeplinkCunt++;
                    if ([self.delegate performSelector:@selector(QuysTengAiNofifyEventType:count: )])
                    {
                        [self.delegate QuysTengAiNofifyEventType:model.taskType count:self.outPutDeeplinkCunt];
                    }
                }
                    break;
                default:
                    break;
            }
            self.lastReturnDataDate = [NSDate buildDate:[NSDate date]];// 更新最后一次数据返回的时间戳
        }else
        {
            [self QuysTengAiRealValidateTimerNofifyEvent:model.currentDate];
        }
#warning 此处监听值变化
        //每间隔 timerIntervalUnit 秒，输出一次数据
        NSTimeInterval interval = [model.currentDate timeIntervalSinceDate:self.runStartDate];
        NSInteger interInterval = [[NSString stringWithFormat:@"%0lf",interval] integerValue];
        if (!(interInterval % timerIntervalUnit))
        {
            //取余为0
            //TODO：
            
            if ([self.delegate performSelector:@selector(QuysTengPerHourHasDataRequestCount:)])
            {
                [self.delegate QuysTengPerHourHasDataRequestCount:(self.outPutHasDataCount - self.lastHourRequestCount) ];
            }
            self.lastHourRequestCount = self.outPutHasDataCount;
        }
    });
}


/**
 长时间无数据返回，则准备停止定时器
 */
- (void)QuysTengAiRealValidateTimerNofifyEvent:(NSDate*)recentlyDate
{
    NSTimeInterval intevel = [recentlyDate timeIntervalSinceDate:self.lastReturnDataDate];
    if (intevel >= self.requestTimeInterval)
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
                //TODO:重置属性数据
                self.lastReturnDataDate = nil;
                self.isAddValidTag = NO;
                NSMutableArray *requestCountArr = [NSMutableArray new];
                for (int i = 1; i<= 9; i++)
                {
                    NSNumber *num = @(i*0.1*self.requestCount);
                    [requestCountArr addObject:num];
                }
                self.requestCount = [requestCountArr[arc4random()%requestCountArr.count] integerValue];
                [self.timer fire];
            });
        }else
        {
            
        }
        
    }
}



- (NSTimer *)timer
{
    if (_timer == nil && self.isAddValidTag == NO)
    {
        
        NSTimeInterval timeIntevel = 60*60*1.0/(self.requestCount*1.0/self.threadCount*1.0);//TOOD:根据方法 tengAi 中的线程数确定。
        _timer = [NSTimer scheduledTimerWithTimeInterval:timeIntevel target:self selector:@selector(startTasks) userInfo:nil repeats:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"\n更新数据\n");
            //            self.lblCountForHour.text = [NSString stringWithFormat:@"每小时默认请求次数：%ld",[QuysTengAiCountManager shareManager].requestCount];
            
        });
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];//
        [[NSRunLoop currentRunLoop] run];
    }return _timer;
}

- (NSString *)strUniqueNotifyName
{
    if (_strUniqueNotifyName == nil) {
        _strUniqueNotifyName = [NSString stringWithFormat:@"%@",[NSUUID new]];
    }return _strUniqueNotifyName;
}


- (NSDate *)lastReturnDataDate
{
    if (_lastReturnDataDate == nil)
    {
        NSDate *date = [NSDate date];
        _lastReturnDataDate = [NSDate buildDate:date];
    }return _lastReturnDataDate;
}

-(NSUInteger)requestTimeInterval
{
    if (_requestTimeInterval <= 0)
    {
        _requestTimeInterval = 60*30;
    }return _requestTimeInterval;
}

-(NSUInteger)threadCount
{
    if (_threadCount <= 0) {
        _threadCount = 1;
    }return _threadCount;
}
@end
