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
 
@end



@implementation QuysAdSplash

- (instancetype)initWithViewModel:(QuysAdSplashVM *)viewModel
{
    if (self = [super initWithFrame:[UIScreen  mainScreen].bounds])
    {
        [self createUI];
        self.vm = viewModel;
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
    imgView.contentMode = UIViewContentModeRedraw;
    [self.viewContain addSubview:imgView];
    self.imgView = imgView;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose addTarget:self action:@selector(clickCloseBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnClose setTitle:@"" forState:UIControlStateNormal];
    [btnClose setTitle:@"" forState:UIControlStateHighlighted];
    [btnClose setImage:[UIImage imageNamed:@"guanbi" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [btnClose setImage:[UIImage imageNamed:@"guanbi_press" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    [self.imgView addSubview:btnClose];
    self.btnClose = btnClose;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(kScale_H(kNavBarHeight +10));
        make.left.mas_equalTo(self).offset(kScale_H(30));
        make.right.mas_equalTo(self).offset(kScale_H(-30));
        make.bottom.mas_equalTo(self).offset(kScale_H(-kNavBarHeight));

    }];
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView).offset(kScale_H(5));
        make.right.mas_equalTo(self.imgView).offset(kScale_W(-5)).priorityHigh();
        make.left.mas_greaterThanOrEqualTo(self.imgView).priorityLow();
        make.width.height.mas_equalTo(kScale_W(22));
        
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
    [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",self.imgView.frame.size.width)];
    [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",self.imgView.frame.size.height)];
    
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


- (void)updateReplaceDictionary:(NSString *)replaceKey value:(NSString *)replaceVlue
{
    [[[QuysAdviceManager shareManager] dicMReplace] setObject:replaceVlue forKey:replaceKey];
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
