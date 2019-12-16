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
        self.vm = viewModel;
    }
    return self;
}

- (void)createUI
{
    UIView *viewContain = [[UIView alloc]init];
    viewContain.backgroundColor = [UIColor blueColor];
    [self addSubview:viewContain];
    self.viewContain = viewContain;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageVIewEvent:)];
    [imgView addGestureRecognizer:tap];
    [self.viewContain addSubview:imgView];
    self.imgView = imgView;
    
    UIView *viewStrokeLine = [[UIView alloc]init];
    viewStrokeLine.backgroundColor = [UIColor clearColor];
    [self.viewContain addSubview:viewStrokeLine];
    self.viewStrokeLine = viewStrokeLine;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose addTarget:self action:@selector(clickCloseBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnClose setTitle:@"" forState:UIControlStateNormal];
    [btnClose setTitle:@"" forState:UIControlStateHighlighted];
    [btnClose setImage:[UIImage imageNamed:@"close" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [btnClose setImage:[UIImage imageNamed:@"close_press" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    [self.viewContain addSubview:btnClose];
    self.btnClose = btnClose;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).offset(kScale_H(0)).priorityHigh();
        make.right.mas_equalTo(self.viewContain).offset(kScale_W(-0));
        make.width.height.mas_equalTo(kScale_W(22)).priorityHigh();
    }];
    
    [self.viewStrokeLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btnClose.mas_bottom).priorityHigh();
        make.centerX.mas_equalTo(self.btnClose);
        make.width.mas_equalTo(kScale_W(1));
        make.height.mas_equalTo(kScale_H(0)).priorityHigh();
    }];
    
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.viewContain);
           make.left.right.bottom.mas_equalTo(self.viewContain);
       }];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}




#pragma mark - PrivateMethod

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)tapImageVIewEvent:(UITapGestureRecognizer*)sender
{
    //获取触发触摸的点
    CGPoint cpBegain = [sender locationInView:self];
    CGPoint cpBegainResult = [self convertPoint:cpBegain toView:[UIApplication sharedApplication].keyWindow];//相对于屏幕的坐标
    if (self.quysAdviceClickEventBlockItem)
    {
        self.quysAdviceClickEventBlockItem(cpBegainResult);
    }
    
    
}

- (void)clickCloseBtEvent:(UIButton*)sender
{
    if (self.quysAdviceCloseEventBlockItem)
       {
           self.quysAdviceCloseEventBlockItem();
       }
}

//根据：runtime消息传递机制，子类先找到function的selector，然后直接调用实现（覆盖了：父类以及父类的类别）
- (void)hlj_viewStatisticalCallBack
{
    
    if (self.quysAdviceStatisticalCallBackBlockItem)
           {
               self.quysAdviceStatisticalCallBackBlockItem();
           }
}

 
- (void)setVm:(QuysAdSplashVM *)vm
{
    _vm = vm;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:vm.strImgUrl]];
}

@end
