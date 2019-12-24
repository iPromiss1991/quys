//
//  QuysAdSplashVM.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuysAdviceModel;
NS_ASSUME_NONNULL_BEGIN
///插屏广告viewModel
@interface QuysAdOpenScreenVM : NSObject<QuysAdSplashDelegate>
//输出字段
@property (nonatomic,strong) NSString *strImgUrl;
@property (nonatomic,assign) NSInteger showDuration;

@property (nonatomic,assign) BOOL clickedAdvice;//!< 是否触发点击事件
@property (nonatomic,assign) BOOL exposuredAdvice;




- (instancetype)initWithModel:(QuysAdviceModel*)model delegate:(id<QuysAdSplashDelegate>)delegate frame:(CGRect)cgFrame  window:(UIWindow*)window;


- (UIWindow *)createAdviceView;

/// 更新宏替换键&值
/// @param replaceKey key
/// @param replaceVlue value
- (void)updateReplaceDictionary:(NSString*)replaceKey value:(NSString*)replaceVlue;





@end

NS_ASSUME_NONNULL_END
