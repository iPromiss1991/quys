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
/// banner广告服务
@interface QuysAdBannerService : QuysAdBaseService
@property (nonatomic,weak) id <QuysAdSplashDelegate> delegate;//!<  服务代理
@property (nonatomic,strong) UIView *adviceView;//!<  广告视图



/// 创建弹窗广告
/// @param businessID 业务ID
/// @param bussinessKey 业务Key
/// @param cgFrame 弹窗frame
/// @param delegate 回调代理
/// @param presentVCiewController 弹窗父视图（展示弹窗的容器视图）
- (instancetype)initWithID:businessID
                       key:bussinessKey
                    cgRect:(CGRect)cgFrame
             eventDelegate:(id <QuysAdSplashDelegate>)delegate
               presentVCiewController:(UIViewController*)presentVCiewController;

/// 开始加载视图 & 并展示
- (void)loadAdViewAndShow;
@end

NS_ASSUME_NONNULL_END
