//
//  QuysAdSplash.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideoWindow.h"
#import "QuysNavigationController.h"
@interface QuysIncentiveVideoWindow()
@property (nonatomic,strong) QuysIncentiveVideoWindowVC *rootVC;

@end


@implementation QuysIncentiveVideoWindow

- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysIncentiveVideoVM *)viewModel
{
    if (self = [super initWithFrame:frame])
    {
        self.windowLevel = UIWindowLevelAlert+1;
        QuysIncentiveVideoWindowVC *rootVC = [[QuysIncentiveVideoWindowVC alloc] initWithVM:viewModel];
        rootVC.quysAdviceClickEventBlockItem =  self.quysAdviceClickEventBlockItem;
        rootVC.quysAdviceCloseEventBlockItem = self.quysAdviceCloseEventBlockItem;
        rootVC.quysAdviceStatisticalCallBackBlockItem = self.quysAdviceStatisticalCallBackBlockItem;
        QuysNavigationController *nav= [[QuysNavigationController alloc]initWithRootViewController:rootVC];
        nav.hideNavbar = YES;
        self.rootVC = rootVC;
        self.rootViewController = nav;
        self.vm = viewModel;
    }
    return self;
}

- (void)setQuysAdviceClickEventBlockItem:(QuysAdviceClickEventBlock)quysAdviceClickEventBlockItem
{
    _quysAdviceClickEventBlockItem = quysAdviceClickEventBlockItem;
    self.rootVC.quysAdviceClickEventBlockItem = quysAdviceClickEventBlockItem;
}


- (void)setQuysAdviceCloseEventBlockItem:(QuysAdviceCloseEventBlock)quysAdviceCloseEventBlockItem
{
    _quysAdviceCloseEventBlockItem = quysAdviceCloseEventBlockItem;
    self.rootVC.quysAdviceCloseEventBlockItem = quysAdviceCloseEventBlockItem;
}

- (void)setQuysAdviceStatisticalCallBackBlockItem:(QuysAdviceStatisticalCallBackBlock)quysAdviceStatisticalCallBackBlockItem
{
    _quysAdviceStatisticalCallBackBlockItem = quysAdviceStatisticalCallBackBlockItem;
    self.rootVC.quysAdviceStatisticalCallBackBlockItem = quysAdviceStatisticalCallBackBlockItem;
}

- (void)dealloc
{
    
}
@end
