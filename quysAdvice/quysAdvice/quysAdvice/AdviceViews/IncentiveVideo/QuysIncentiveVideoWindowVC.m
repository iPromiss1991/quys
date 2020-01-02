
//
//  QuysWindowViewController.m
//  quysAdviceTestDemo
//
//  Created by quys on 2019/12/20.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideoWindowVC.h"
@interface QuysIncentiveVideoWindowVC ()
@property (nonatomic,strong) QuysIncentiveVideoVM *vm;

@end

@implementation QuysIncentiveVideoWindowVC

-(instancetype)initWithVM:(QuysIncentiveVideoVM *)vm
{
    if (self == [super init])
    {
        self.vm = vm;
    }
    return self;
}
- (void)loadView
{
   QuysIncentiveVideo *view = [[QuysIncentiveVideo alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight -100) viewModel:self.vm];
    self.view = view;
    view.quysAdviceClickEventBlockItem = self.quysAdviceClickEventBlockItem;
    view.quysAdviceCloseEventBlockItem = self.quysAdviceCloseEventBlockItem;
    view.quysAdviceStatisticalCallBackBlockItem = self.quysAdviceStatisticalCallBackBlockItem;
    
    //TODO:视频尾帧view在此回调加载
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
//    self.navigationController.navigationBarHidden = YES;
    [self vhl_setStatusBarHidden:YES];
    [self vhl_setNavBarShadowImageHidden:YES];
    [self vhl_setNavBarHidden:YES];

    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    self.view.frame = CGRectMake(0, 0, 0, 330);

    
}

@end
