//
//  QuysTengAiTaskGroup.h
//  quysAdvice
//
//  Created by wxhmbp on 2020/4/18.
//  Copyright © 2020年 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysTaskNotifyModel.h"
@class QuysTengAiTaskGroup;
@protocol QuysTengAiTaskGroupDelegate <NSObject>

- (void)QuysTengAiNofifyEventType:(QuysTaskNotifyType)eventType count:(NSInteger)eventCount  ;

- (void)QuysTengPerHourHasDataRequestCount:(NSInteger)eventCount  ;
@end

NS_ASSUME_NONNULL_BEGIN

@interface QuysTengAiTaskGroup : NSObject
//输入
@property (nonatomic,assign) NSInteger requestCount;//!<  每小时请求量

@property (nonatomic,assign) CGFloat exposureRate;
@property (nonatomic,assign) CGFloat clickRate;
@property (nonatomic,assign) CGFloat deeplinkRate;


@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) NSString *bussinessKey;

//输出
@property (nonatomic, assign) NSInteger  outPutRequestDataCount;//!< 截止此刻发起请求的次数
@property (nonatomic, assign) NSInteger  outPutHasDataCount;//!< <#Explement #>
@property (nonatomic, assign) NSInteger  outPutExposureCount;//!< <#Explement #>
@property (nonatomic, assign) NSInteger  outPutClickCount;//!< <#Explement #>
@property (nonatomic, assign) NSInteger  outPutDeeplinkCunt;//!< <#Explement #>


@property (nonatomic,assign) id <QuysTengAiTaskGroupDelegate> delegate;

- (void)run;
@end

NS_ASSUME_NONNULL_END
