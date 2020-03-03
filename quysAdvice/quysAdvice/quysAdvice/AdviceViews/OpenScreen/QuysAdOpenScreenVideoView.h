//
//  QuysAdOpenScreenVideoView.h
//  quysAdvice
//
//  Created by wxhmbp on 2020/3/3.
//  Copyright © 2020年 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuysAdOpenScreenVM.h"

NS_ASSUME_NONNULL_BEGIN
///开屏视频
@interface QuysAdOpenScreenVideoView : UIView
@property (nonatomic,strong) QuysAdOpenScreenVM *vm;
@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;


- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysAdOpenScreenVM *)viewModel;

@end

NS_ASSUME_NONNULL_END
