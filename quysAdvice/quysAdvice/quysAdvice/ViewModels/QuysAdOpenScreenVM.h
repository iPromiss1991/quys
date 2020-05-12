//
//  QuysAdSplashVM.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysAdviceOpeenScreenDelegate.h"
#import "QuysAdviceModel.h"
@class QuysAdOpenScreenService;
NS_ASSUME_NONNULL_BEGIN
///插屏广告viewModel
@interface QuysAdOpenScreenVM : NSObject
//输出字段
@property (nonatomic,strong) NSString *strImgUrl;
@property (nonatomic,strong) NSString *iconUrl;

@property (nonatomic,assign) NSInteger showDuration;

@property (nonatomic,strong) NSString *materialUrl;
@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) UIViewController *presentVC; 




- (instancetype)initWithModel:(QuysAdviceModel*)model delegate:(id<QuysAdviceOpeenScreenDelegate>)delegate frame:(CGRect)cgFrame ;


- (UIWindow *)createAdviceView;






@end

NS_ASSUME_NONNULL_END
