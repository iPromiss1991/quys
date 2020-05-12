//
//  QuysAdSplashVM.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QuysAdviceModel,QuysAdSplashService;
NS_ASSUME_NONNULL_BEGIN
///插屏广告viewModel
@interface QuysAdSplashVM : NSObject<QuysAdSplashDelegate>
//输出字段
@property (nonatomic,strong) NSString *strImgUrl;
@property (nonatomic,strong) UIViewController *presentVC; 





- (instancetype)initWithModel:(QuysAdviceModel*)model delegate:(id<QuysAdSplashDelegate>)delegate  ;


- (UIView *)createAdviceView;




@end

NS_ASSUME_NONNULL_END
