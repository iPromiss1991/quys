//
//  QuysTengAiCountManager.h
//  quysAdvice
//
//  Created by quys on 2020/4/14.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuysTengAiCountManager : NSObject
@property (nonatomic,assign) CGFloat exposureRate;
@property (nonatomic,assign) CGFloat clickRate;
@property (nonatomic,assign) CGFloat deeplinkRate;


@property (nonatomic,assign) NSInteger requestCount;//!<  每小时请求量

//@property (nonatomic,assign) NSInteger exposureCount;
//@property (nonatomic,assign) NSInteger clickCount;


+ (instancetype)shareManager;

@end

NS_ASSUME_NONNULL_END
