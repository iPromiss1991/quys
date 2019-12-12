//
//  QuysAdSplashService.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//
#define kQuysAdServiceFinish @"kQuysAdServiceFinish"

#import "QuysAdviceBaseSevice.h"
#import "QuysAdSplashDelegate.h"
#import "QuysAdSplash.h"

NS_ASSUME_NONNULL_BEGIN
/// 插屏广告服务
@interface QuysAdSplashService : NSObject
@property (nonatomic,weak) id <QuysAdSplashDelegate> delegate;
@property (nonatomic,assign,readonly) BOOL loadAdViewEnable;



- (instancetype)initWithID:businessID key:bussinessKey cGrect:(CGRect)frame eventDelegate:(id <QuysAdSplashDelegate>)delegate parentView:(UIView*)parentView;

/// 开始加载视图
- (void)loadAdViewNow;

/// 开始展示视图
- (void)showAdView;

@end

NS_ASSUME_NONNULL_END
