//
//  QuysViewController.m
//  quysAdviceTestDemo
//
//  Created by quys on 2019/12/12.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysViewController.h"
#import <quysAdvice/quysAdvice.h>
#import <Masonry/Masonry.h>

@interface QuysViewController ()<QuysAdSplashDelegate>
@property (nonatomic,strong) QuysAdSplashService *service;
@property (nonatomic,strong) UIView *adView;

@end

@implementation QuysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
            QuysAdSplashService *service = [[QuysAdSplashService alloc ]initWithID:@"quystest-cp" key:@"quystest-cp" cGrect:CGRectMake(0, 100, 300, 100) eventDelegate:self parentView:self.view];
        [service loadAdViewNow];
    self.service = service;

}

-(void)updateViewConstraints
{
//    [self.adView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).offset(200);
//        make.left.right.mas_equalTo(self.view);
//        make.height.mas_equalTo(self.adView.mas_width).multipliedBy(.5);
//    }];
    [self.adView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [super updateViewConstraints];
}


-(void)quys_requestStart
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
-(void)quys_requestSuccess
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
   self.adView = [self.service showAdView];


}
-(void)quys_requestFial:(NSError *)error
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}
-(void)quys_interstitialOnExposure
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}
-(void)quys_interstitialOnClick:(CGPoint)cpClick
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [self presentViewController:[QuysViewController new] animated:YES completion:nil];

}
-(void)quys_interstitialOnAdClose
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}
@end
