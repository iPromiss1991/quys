//
//  QuysAdSplashService.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdviceBaseSevice.h"
#import "QuysAdSplashDelegate.h"
#import "QuysAdSplash.h"

NS_ASSUME_NONNULL_BEGIN
///插屏广告服务
@interface QuysAdSplashService : NSObject
@property (nonatomic,weak) id <QuysAdSplashDelegate> delegate;



- (instancetype)initWithID:businessID key:bussinessKey;
- (QuysAdSplash*)startCreateAdviceView;
@end

NS_ASSUME_NONNULL_END
