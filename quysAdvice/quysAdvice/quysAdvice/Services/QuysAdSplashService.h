//
//  QuysAdSplashService.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved. 
//

#import "QuysAdSplashDelegate.h"
#import "QuysAdBaseService.h"

NS_ASSUME_NONNULL_BEGIN
/// 插屏广告服务
@interface QuysAdSplashService : QuysAdBaseService
@property (nonatomic,weak) id <QuysAdSplashDelegate> delegate;//!<  服务代理
@property (nonatomic,strong) UIView *adviceView;//!<  广告视图



/// 创建弹窗广告
/// @param businessID 业务ID
/// @param bussinessKey 业务Key
/// @param delegate 回调代理
/// @param parentVC 弹窗父视图
- (instancetype)initWithID:businessID
                       key:bussinessKey
             eventDelegate:(id <QuysAdSplashDelegate>)delegate
                parentViewController:(nullable UIViewController*)parentVC;


/// 开始加载视图
- (void)loadAdViewNow;


/// 开始展示视图
- (UIView*)showAdView;
@end

NS_ASSUME_NONNULL_END
