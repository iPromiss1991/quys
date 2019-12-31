//
//  QuysWindowViewController.h
//  quysAdviceTestDemo
//
//  Created by quys on 2019/12/20.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuysIncentiveVideoVM.h"
#import "QuysIncentiveVideo.h"

NS_ASSUME_NONNULL_BEGIN
///开屏广告rootVC

@interface QuysIncentiveVideoWindowVC : UIViewController
- (instancetype)initWithVM:(QuysIncentiveVideoVM*)vm;

@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;

@end

NS_ASSUME_NONNULL_END
