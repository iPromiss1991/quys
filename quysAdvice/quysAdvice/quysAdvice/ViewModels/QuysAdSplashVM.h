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
@interface QuysAdSplashVM : NSObject
@property (nonatomic,strong) NSString *strImgUrl;




- (instancetype)initWithModel:(QuysAdviceModel*)model;

@end

NS_ASSUME_NONNULL_END
