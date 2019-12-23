//
//  QuysAdSplashService.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved. 
//

#import "QuysAdSplashDelegate.h"

NS_ASSUME_NONNULL_BEGIN
/// 插屏广告服务
@interface QuysAdOpenScreenService : NSObject
@property (nonatomic,weak) id <QuysAdSplashDelegate> delegate;
@property (nonatomic,assign,readonly) BOOL loadAdViewEnable;
@property (nonatomic,strong) UIWindow *adviceView;



/// 创建弹窗广告
/// @param businessID 业务ID
/// @param bussinessKey 业务Key
/// @param cgFrame 弹窗frame
/// @param imgReplace 弹窗背景视图
/// @param delegate 回调代理
- (instancetype)initWithID:businessID key:bussinessKey cGrect:(CGRect)cgFrame  backgroundImage:(UIImage*)imgReplace eventDelegate:(nonnull id<QuysAdSplashDelegate>)delegate;


@end

NS_ASSUME_NONNULL_END
