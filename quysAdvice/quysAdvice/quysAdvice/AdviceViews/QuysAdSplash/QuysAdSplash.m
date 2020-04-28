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

@property (nonatomic,strong) UIButton *btnClose;
@property (nonatomic,assign) CGRect cgFrame;

@end



@implementation QuysAdSplash

- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysAdSplashVM *)viewModel
{
    if (self = [super initWithFrame:[UIScreen  mainScreen].bounds])
    {
        [self createUI];
        self.vm = viewModel;
        self.cgFrame = frame;
    }
    return self;
}

- (void)createUI
{
    self.backgroundColor = kRGB16(MaskColor1, .8);
    UIView *viewContain = [[UIView alloc]init];
     UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageVIewEvent:)];
    [viewContain addGestureRecognizer:tap];
    [self addSubview:viewContain];
    self.viewContain = viewContain;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgView.userInteractionEnabled = YES;
    [self.viewContain addSubview:imgView];
    self.imgView = imgView;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose addTarget:self action:@selector(clickCloseBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnClose setTitle:@"" forState:UIControlStateNormal];
    [btnClose setTitle:@"" forState:UIControlStateHighlighted];
    [btnClose setImage:[UIImage imageNamed:@"guanbi" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [btnClose setImage:[UIImage imageNamed:@"guanbi_press" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    [self.viewContain addSubview:btnClose];
    self.btnClose = btnClose;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(self.frame.size.width? self.cgFrame.size.width:0);
        make.height.mas_equalTo(self.frame.size.height?self.cgFrame.size.height:0);
    }];
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).offset(kScale_W(2));
        make.right.mas_equalTo(self.viewContain).offset(kScale_W(-2));
        make.left.mas_greaterThanOrEqualTo(self.viewContain);
        make.width.height.mas_equalTo(kScale_W(22)).priorityHigh();
        
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
        self.quysAdviceClickEventBlockItem(cpBegainResult,cpBegain);
    }
    self.frame = CGRectZero;
    [self removeFromSuperview];
}

- (void)clickCloseBtEvent:(UIButton*)sender
{

    if (self.quysAdviceCloseEventBlockItem)
    {
        self.quysAdviceCloseEventBlockItem();
    }
    self.frame = CGRectZero;
    [self removeFromSuperview];
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
