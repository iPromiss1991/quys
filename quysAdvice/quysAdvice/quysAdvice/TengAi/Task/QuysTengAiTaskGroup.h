//
//  QuysTengAiTaskGroup.h
//  quysAdvice
//
//  Created by wxhmbp on 2020/4/18.
//  Copyright © 2020年 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@property (nonatomic, assign) NSInteger  outPutExposureCount;//!< <#Explement #>
@property (nonatomic, assign) NSInteger  outPutClickCount;//!< <#Explement #>
@property (nonatomic, assign) NSInteger  outPutDeeplinkCunt;//!< <#Explement #>



- (void)run;
@end

NS_ASSUME_NONNULL_END
