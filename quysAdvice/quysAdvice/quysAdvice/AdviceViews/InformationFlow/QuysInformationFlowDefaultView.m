//
//  QuysInformationFlowDefault.m
//  quysAdvice
//
//  Created by quys on 2019/12/16.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysInformationFlowDefaultView.h"
@interface QuysInformationFlowDefaultView()


@property (nonatomic,strong) UIView *viewContain;
@property (nonatomic,strong) UILabel *lblContent;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *lblTag;

@property (nonatomic,strong) UILabel *lblType;
@property (nonatomic,strong) UIButton *btnClose;


@end



@implementation QuysInformationFlowDefaultView

- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysInformationFlowVM *)viewModel
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
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageVIewEvent:)];
    [viewContain addGestureRecognizer:tap];
    [self addSubview:viewContain];
    self.viewContain = viewContain;
    
    UILabel *lblContent = [[UILabel alloc] init];
    lblContent.numberOfLines = 0;
    lblContent.text = @"加载中...加载中...加载中...加载中...加载中...加载中...加载中...加载中...加载中...加载中...加载中...加载中...加载中...加载中...加载中...加载中...加载中...加载中...";
    self.lblContent = lblContent;
    [self.viewContain addSubview:lblContent];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgView.userInteractionEnabled = YES;
    [self.viewContain addSubview:imgView];
    self.imgView = imgView;
    
    UILabel *lblTag = [[UILabel alloc] init];
    lblTag.text = @"广告";
    lblTag.backgroundColor = [UIColor redColor];
    kViewRadius(lblTag, kScale_W(5));
    self.lblTag = lblTag;
    [self.viewContain addSubview:lblTag];

    
    UILabel *lblType = [[UILabel alloc] init];
    lblType.text = @"新闻";
    self.lblType = lblType;
    [self.viewContain addSubview:lblType];
    
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
    
    [self.lblContent mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(self.viewContain).priorityHigh();
         make.left.mas_equalTo(self.viewContain).offset(kScale_W(2));
        make.right.mas_equalTo(self.viewContain).offset(kScale_W(-2));
    }];
    
    
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.lblContent.mas_bottom).priorityHigh();;
           make.left.right.mas_equalTo(self.viewContain);
       }];
    
    
    
    [self.lblTag mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(kScale_W(2)).priorityHigh();
        make.height.mas_equalTo(kScale_H(18));//TODO:字体、样式、布局？
        make.left.mas_equalTo(self.viewContain).offset(kScale_W(2));
        make.bottom.mas_equalTo(self.viewContain).offset(kScale_W(-2));
    }];
    
    
    [self.lblType mas_updateConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(self.lblTag).priorityHigh();
         make.left.mas_equalTo(self.lblTag.mas_right).offset(kScale_W(5));
    }];
    
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.lblTag).priorityHigh();
        make.left.greaterThanOrEqualTo(self.lblType.mas_right).offset(kScale_W(2));
        make.right.mas_equalTo(self.viewContain).offset(kScale_W(-2));
        make.width.height.mas_equalTo(kScale_W(22)).priorityHigh();
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
   //TODO:动画分类==代理回调！移除视图,点击事件接受对象？img：viewContain。
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"transform.scale";
//    animation.toValue = @(.5);
//    animation.duration = .3;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    [self.layer addAnimation:animation forKey:@"scale"];
//
//    animation.delegate = self;
}

//根据：runtime消息传递机制，子类先找到function的selector，然后直接调用实现（覆盖了：父类以及父类的类别）
- (void)hlj_viewStatisticalCallBack
{
    
    if (self.quysAdviceStatisticalCallBackBlockItem)
           {
               self.quysAdviceStatisticalCallBackBlockItem();
           }
}

 
- (void)setVm:(QuysInformationFlowVM *)vm
{
    _vm = vm;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:vm.strImgUrl]];
}

@end
