
//
//  QuysTengAiCountManager.m
//  quysAdvice
//
//  Created by quys on 2020/4/14.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysTengAiCountManager.h"
#import "QuysTengAiTask.h"
 
static const NSInteger kRequestDefaultCount = 50000;//TODO：默认请求数

@interface QuysTengAiCountManager()
@property (nonatomic,strong) NSDate *recentRequestDate;
@property (nonatomic,assign) NSInteger requestDefaultCount;
@property (nonatomic,strong) NSTimer *timer;

@end



@implementation QuysTengAiCountManager

+ (instancetype)shareManager
{
    static QuysTengAiCountManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
        manager.requestDefaultCount = kRequestDefaultCount;
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(QuysTengAiRealTaskNofifyEvent:) name:kQuysTengAiRealTaskNofify object:nil];

    });
    return manager;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [QuysTengAiCountManager shareManager] ;
}


-(id) copyWithZone:(struct _NSZone *)zone
{
    return [QuysTengAiCountManager shareManager] ;
}


#pragma mark - Method

- (void)QuysTengAiRealTaskNofifyEvent:(NSNotification*)notify
{
    if ([notify.object[kQuysTengAiRealTaskNofifyKey] isEqualToString:@"Y"])

    {
 
            self.recentRequestDate = [NSDate date];//TODO
    }else
    {
        NSDate  *currentDate = [NSDate date ];
        NSTimeInterval interval = [currentDate timeIntervalSinceDate:self.recentRequestDate];
        if (fabs(interval) > 60*30)//TODO：
        {
            NSArray *requetCountArr = @[@(kRequestDefaultCount/10),@(kRequestDefaultCount/5),@(kRequestDefaultCount/3),@(kRequestDefaultCount/2),@(kRequestDefaultCount)];
            NSNumber *num = requetCountArr[arc4random()%requetCountArr.count ];
            self.requestDefaultCount = [num intValue];
            self.recentRequestDate = [NSDate date];//更新最后一次获取数据的时  为 当前时间点
            [[NSNotificationCenter defaultCenter] postNotificationName:kQuysTengAiValidateTimerNofify object:nil];
        }
    }
}



 
#pragma mark - init

-(NSInteger)requestCount
{
    return self.requestDefaultCount;
}

-(CGFloat)exposureRate
{
    return 0.8;
}


-(CGFloat)clickRate
{
    return 0.12;
}

- (CGFloat)deeplinkRate
{
    return 0.3;
}


-(NSDate *)recentRequestDate
{
    if (_recentRequestDate ==nil) {
        _recentRequestDate = [NSDate date];
    }return _recentRequestDate;
}

@end
