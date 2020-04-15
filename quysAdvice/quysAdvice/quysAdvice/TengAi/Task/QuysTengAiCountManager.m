
//
//  QuysTengAiCountManager.m
//  quysAdvice
//
//  Created by quys on 2020/4/14.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysTengAiCountManager.h"

@implementation QuysTengAiCountManager

+ (instancetype)shareManager
{
    static QuysTengAiCountManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
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


#pragma mark - init

-(NSInteger)requestCount
{
    return 10000;
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


@end
