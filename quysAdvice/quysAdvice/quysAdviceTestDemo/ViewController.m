//
//  ViewController.m
//  AdviceTest
//
//  Created by quys on 2019/12/6.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "ViewController.h"
#import <quysAdvice/QuysAdviceManager.h>
#import <Masonry/Masonry.h>
@interface ViewController ()<QuysAdSplashDelegate>
@property (nonatomic,strong) QuysAdSplash *SplashView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    [[QuysAdviceManager shareManager] configSplashAdvice:@"quystest-cp" key:@"quystest-cp"];
    QuysAdSplash*SplashView=  [[QuysAdviceManager shareManager] createSplashAdvice:self];
    [self.view addSubview:SplashView];
    self.SplashView = SplashView;
    

    // Do any additional setup after loading the view.
}

-(void)updateViewConstraints
{
    [self.SplashView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.left.right.bottom.mas_equalTo(self.view);

    }];
    [super updateViewConstraints];
}



@end
