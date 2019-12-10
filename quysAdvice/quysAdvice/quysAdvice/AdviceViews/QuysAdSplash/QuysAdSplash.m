//
//  QuysAdSplash.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdSplash.h"
@interface QuysAdSplash()
@property (nonatomic,strong) UIView *viewContain;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIView *viewStrokeLine;

@property (nonatomic,strong) UIButton *btnClose;


@end



@implementation QuysAdSplash

- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysAdSplashVM *)viewModel
{
    if (self = [super initWithFrame:frame])
    {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIView *viewContain = [[UIView alloc]init];
    viewContain.backgroundColor = [UIColor clearColor];
    [self addSubview:viewContain];
    self.viewContain = viewContain;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageVIewEvent:)];
    [imgView addGestureRecognizer:tap];
    [self.viewContain addSubview:imgView];
    self.imgView = imgView;
    
    UIView *viewStrokeLine = [[UIView alloc]init];
    viewStrokeLine.backgroundColor = [UIColor clearColor];
    [self.viewContain addSubview:viewStrokeLine];
    self.viewContain = viewStrokeLine;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose addTarget:self action:@selector(clickCloseBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnClose setTitle:@"" forState:UIControlStateNormal];
    [btnClose setTitle:@"" forState:UIControlStateHighlighted];
    [btnClose setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnClose setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.viewContain addSubview:btnClose];
    self.btnClose = btnClose;
    
}

- (void)updateConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewContain).offset(kScale_H(5));
        make.right.equalTo(self.viewContain).offset(kScale_W(-10));
        make.width.height.mas_equalTo(kScale_W(44));
    }];
    
    [self.viewStrokeLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btnClose.mas_bottom);
        make.centerX.mas_equalTo(self.btnClose);
        make.width.mas_equalTo(kScale_W(1));
        make.width.mas_equalTo(kScale_H(10));
    }];
    
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.viewStrokeLine.mas_bottom);
           make.left.right.bottom.mas_equalTo(self.viewContain);
       }];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


#pragma mark - PrivateMethod

- (void)tapImageVIewEvent:(UITapGestureRecognizer*)sender
{
    
}

- (void)clickCloseBtEvent:(UIButton*)sender
{
    
}


@end
