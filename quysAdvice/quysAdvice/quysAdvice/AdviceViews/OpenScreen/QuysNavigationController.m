//
//  QuysNavigationController.m
//  quysAdvice
//
//  Created by quys on 2019/12/24.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysNavigationController.h"
#import "UIViewController+QuysGetRootController.h"
#import "QuysOpenScreenWindow.h"
@interface QuysNavigationController ()
@property (nonatomic,strong) UIView *viewContain;
@property (nonatomic,strong) UIButton *btnLeft;
@property (nonatomic,strong) UILabel *lblTitle;
@property (nonatomic,strong) UIButton *btnright;


@end

@implementation QuysNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor greenColor];
    
    UIView *viewContain = [[UIView alloc]init];
    viewContain.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:viewContain];
    self.viewContain = viewContain;
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft addTarget:self action:@selector(clickLeftBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnLeft setTitle:@"返回" forState:UIControlStateNormal];
    [btnLeft setTitle:@"" forState:UIControlStateHighlighted];
    [btnLeft setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnLeft setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.viewContain addSubview:btnLeft];
    self.btnLeft = btnLeft;
    
    
    UIButton *btnright = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnright addTarget:self action:@selector(clickRightBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnright setTitle:@"下一步" forState:UIControlStateNormal];
    [btnright setTitle:@"" forState:UIControlStateHighlighted];
    [btnright setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnright setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.viewContain addSubview:btnright];
    self.btnright = btnright;
    
    
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.text = @"导航栏";
    [self.viewContain addSubview:lblTitle];
    self.lblTitle = lblTitle;
    
    [self.view bringSubviewToFront:self.viewContain];
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

-(void)updateViewConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kNavBarHeight);
    }];
    
    [self.btnLeft mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).offset(kStatusBarHeight);
        make.left.mas_equalTo(self.viewContain).offset(kScale_W(20)).priorityHigh();
        make.bottom.mas_equalTo(self.viewContain);
        make.width.mas_greaterThanOrEqualTo(kScale_W(100));
    }];
    
    [self.lblTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).offset(kStatusBarHeight);
        make.left.mas_greaterThanOrEqualTo(self.btnLeft.mas_right).offset(kScale_W(5));
        make.bottom.mas_equalTo(self.viewContain);
        make.centerX.mas_equalTo(self.viewContain);
    }];
    
    [self.btnright mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).offset(kStatusBarHeight);
        make.left.mas_equalTo(self.lblTitle.mas_right).offset(kScale_W(5));
        make.bottom.mas_equalTo(self.viewContain);
        make.width.mas_greaterThanOrEqualTo(kScale_W(100));
        make.right.mas_equalTo(self.viewContain).priorityHigh();
    }];
    
    [super updateViewConstraints];
}

#pragma mark - PrivateMethod

- (void)clickLeftBtnEvent:(UIButton*)sender
{
    UIViewController *currentVC = [UIViewController quys_findVisibleViewController:[QuysOpenScreenWindow class]];
    if ([currentVC respondsToSelector:@selector(clickLeftBtnRespond)])
    {
        [currentVC performSelector:@selector(clickLeftBtnRespond)];
    }
}


- (void)clickRightBtnEvent:(UIButton*)sender
{
    UIViewController *currentVC = [UIViewController quys_findVisibleViewController:[QuysOpenScreenWindow class]];
    if ([currentVC respondsToSelector:@selector(clickRightBtnRespond)])
    {
        [currentVC performSelector:@selector(clickRightBtnRespond)];
    }
}


#pragma mark - 给ViewController 实现的方法



- (void)clickLeftBtnRespond
{
    
}



- (void)clickRightBtnRespond
{
    
    
}





- (void)setHideNavbar:(BOOL)hideNavbar
{
    _hideNavbar = hideNavbar;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
