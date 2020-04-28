//
//  QuysAdSplashService.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdBaseService.h"
#import "QuysIncentiveVideoDelegate.h"
NS_ASSUME_NONNULL_BEGIN
/// 激励视频广告服务
@interface QuysIncentiveVideoService : QuysAdBaseService
@property (nonatomic,weak) id <QuysIncentiveVideoDelegate> delegate;//!<  服务代理
@property (nonatomic,strong,nullable) UIWindow *adviceView;//!<  广告



/// 创建弹窗广告
/// @param businessID 业务ID
/// @param bussinessKey 业务Key
/// @param delegate 回调代理
- (instancetype)initWithID:businessID
                       key:bussinessKey
              eventDelegate:(nonnull id<QuysIncentiveVideoDelegate>)delegate;

/// 开始加载视图 & 并展示
- (void)loadAdViewAndShow;

@end

NS_ASSUME_NONNULL_END
