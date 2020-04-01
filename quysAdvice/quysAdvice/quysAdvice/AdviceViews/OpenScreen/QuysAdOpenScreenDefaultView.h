//
//  QuysAdSplash.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuysAdOpenScreenVM.h"
NS_ASSUME_NONNULL_BEGIN



@interface QuysAdOpenScreenDefaultView : UIView
- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysAdOpenScreenVM*)viewModel;

@property (nonatomic,strong) QuysAdOpenScreenVM *vm;
@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;

@end

NS_ASSUME_NONNULL_END
