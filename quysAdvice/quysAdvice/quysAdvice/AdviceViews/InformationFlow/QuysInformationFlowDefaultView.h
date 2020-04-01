//
//  QuysInformationFlowDefault.h
//  quysAdvice
//
//  Created by quys on 2019/12/16.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysInformationFlowVM.h"
NS_ASSUME_NONNULL_BEGIN

///信息流（默认模式：大图）
@interface QuysInformationFlowDefaultView:UIView
- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysInformationFlowVM*)viewModel;

@property (nonatomic,strong) QuysInformationFlowVM *vm;
@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;

@end

NS_ASSUME_NONNULL_END

