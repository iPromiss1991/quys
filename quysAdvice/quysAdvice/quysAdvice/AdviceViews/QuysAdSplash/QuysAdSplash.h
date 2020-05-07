//
//  QuysAdSplash.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuysAdSplashVM.h"
NS_ASSUME_NONNULL_BEGIN


@interface QuysAdSplash : UIView
- (instancetype)initWithViewModel:(QuysAdSplashVM*)viewModel;

@property (nonatomic,strong) QuysAdSplashVM *vm;
@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;

@end

NS_ASSUME_NONNULL_END
