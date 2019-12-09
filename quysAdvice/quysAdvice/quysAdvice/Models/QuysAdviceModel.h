//
//  QuysAdviceModel.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///广告模型
@interface QuysAdviceModel : NSObject
@property (nonatomic , strong) NSArray <NSString *>              * clkTracking;
@property (nonatomic , strong) NSArray <NSString *>              * impTracking;
@property (nonatomic , strong) NSArray <NSString *>              * downStart;
@property (nonatomic , strong) NSArray <NSString *>              * downSuccess;
@property (nonatomic , strong) NSArray <NSString *>              * installStart;
@property (nonatomic , strong) NSArray <NSString *>              * installSuccess;
@property (nonatomic , strong) NSArray <NSString *>              * appStart;
@property (nonatomic , strong) NSArray <NSString *>              * videoStart;
@property (nonatomic , strong) NSArray <NSString *>              * videoSuccess;
@property (nonatomic , copy) NSString              * downUrl;
@property (nonatomic , assign) NSInteger              width;
@property (nonatomic , assign) NSInteger              height;
@property (nonatomic , copy) NSString              * channel;
@property (nonatomic , assign) NSInteger              channelWeight;
@property (nonatomic , copy) NSString              * iconUrl;
@property (nonatomic , copy) NSString              * intro;
@property (nonatomic , assign) NSInteger              adType;
@property (nonatomic , assign) NSInteger              creativeType;
@property (nonatomic , copy) NSString              * desc;
@property (nonatomic , assign) NSInteger              clickPosition;
@property (nonatomic , strong) NSArray <NSString *>              * reportDeeplinkSuccessUrl;
@property (nonatomic , strong) NSArray <NSString *>              * reportDeeplinkFailUrl;
@property (nonatomic , assign) NSInteger              showDuration;
@property (nonatomic , copy) NSString              * materialUrl;
@property (nonatomic , copy) NSString              * videoCoverUrl;
@property (nonatomic , assign) NSInteger              videoDuration;
@property (nonatomic , copy) NSString              * appName;
@property (nonatomic , assign) NSInteger              ctype;
@property (nonatomic , assign) BOOL              isReportRepeatAble;
@end

NS_ASSUME_NONNULL_END
