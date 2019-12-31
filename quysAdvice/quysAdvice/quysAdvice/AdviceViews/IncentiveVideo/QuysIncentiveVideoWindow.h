//
//  QuysOpenScreenWindow.h
//  quysAdvice
//
//  Created by quys on 2019/12/24.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuysIncentiveVideoVM.h"
#import "QuysIncentiveVideoWindowVC.h"

NS_ASSUME_NONNULL_BEGIN


@interface QuysIncentiveVideoWindow : UIWindow
- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysIncentiveVideoVM*)viewModel;

@property (nonatomic,strong) QuysIncentiveVideoVM *vm;
@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;

@end

NS_ASSUME_NONNULL_END
