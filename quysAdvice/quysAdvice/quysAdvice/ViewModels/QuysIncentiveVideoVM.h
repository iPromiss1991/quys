//
//  QuysAdSplashVM.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysIncentiveVideoDelegate.h"
#import "QuysIncentiveVideoDataModel.h"

@class QuysIncentiveVideoService;
NS_ASSUME_NONNULL_BEGIN
///插屏广告viewModel
@interface QuysIncentiveVideoVM : NSObject
//输出字段
@property (nonatomic,strong) NSString *strImgUrl;
@property (nonatomic,assign) NSInteger showDuration;

@property (nonatomic,strong) NSString *videoUrl;//!< 视频播放地址
@property (nonatomic,assign) BOOL isClickable;


@property (nonatomic,assign) QuysAdviceVideoEndShowType videoEndShowType;
@property (nonatomic,strong) NSString *videoEndShowValue;
//TODO:删除window属性
- (instancetype)initWithModel:(QuysIncentiveVideoDataModel*)model delegate:(id<QuysIncentiveVideoDelegate>)delegate frame:(CGRect)cgFrame  window:(UIWindow*)window;


- (UIWindow *)createAdviceView;

/// 更新宏替换键&值
/// @param replaceKey key
/// @param replaceVlue value
- (void)updateReplaceDictionary:(NSString*)replaceKey value:(NSString*)replaceVlue;





@end

NS_ASSUME_NONNULL_END
