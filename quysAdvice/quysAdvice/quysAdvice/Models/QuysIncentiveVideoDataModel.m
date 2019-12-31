//
//  QuysIncentiveVideoDataModel.m
//  quysAdvice
//
//  Created by quys on 2019/12/31.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideoDataModel.h"

@implementation QuysIncentiveVideoDataModel
////替换字符：
+ (NSDictionary *)modelCustomPropertyMapper {
    return
  @{
        @"desc" : @"description"
    };
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"statisticsModel":[QuysUploadStatisticsModel class]};
}

-(QuysUploadStatisticsModel *)statisticsModel
{
    if (_statisticsModel == nil) {
        _statisticsModel = [QuysUploadStatisticsModel new];
    }return _statisticsModel;
}


-(BOOL)clickeUploadEnable
{
    if (self.statisticsModel.clicked)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}

-(BOOL)exposuredUploadEnable
{
    if (self.statisticsModel.exposured)
    {
        if (self.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}


@end
