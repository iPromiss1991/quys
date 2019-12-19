//
//  QuysInformationFlowDefault.m
//  quysAdvice
//
//  Created by quys on 2019/12/16.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysInformationFlowMorePictureView.h"
@interface QuysInformationFlowMorePictureView()


@property (nonatomic,strong) UIView *viewContain;
@property (nonatomic,strong) UILabel *lblContent;

@property (nonatomic,strong) UIImageView *imgViewOne;
@property (nonatomic,strong) UIImageView *imgViewTwo;
@property (nonatomic,strong) UIImageView *imgViewThree;

@property (nonatomic,strong) UILabel *lblTag;
@property (nonatomic,strong) UILabel *lblType;
@property (nonatomic,strong) UIButton *btnClose;


@end



@implementation QuysInformationFlowMorePictureView

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
    lblContent.numberOfLines = 3;
    lblContent.text = @"加载中..加载中..加载中..加载中..加载中..加载中..加载中..加载中..加载中..加载中..加载中..加载中..加载中..加载中..";
    [lblContent setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [lblContent setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    self.lblContent = lblContent;
    [self.viewContain addSubview:lblContent];
    
    UIImageView *imgViewOne = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgViewOne.userInteractionEnabled = YES;
    [self.viewContain addSubview:imgViewOne];
    self.imgViewOne = imgViewOne;
    
    UIImageView *imgViewTwo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgViewTwo.userInteractionEnabled = YES;
    [self.viewContain addSubview:imgViewTwo];
    self.imgViewTwo = imgViewTwo;
    
    UIImageView *imgViewThree = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgViewThree.userInteractionEnabled = YES;
    [self.viewContain addSubview:imgViewThree];
    self.imgViewThree = imgViewThree;
    
    UILabel *lblTag = [[UILabel alloc] init];
    lblTag.text = @"广告";
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
        make.top.left.right.mas_equalTo(self.viewContain);
    }];
    
    [self.imgViewOne mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblContent.mas_bottom);
        make.left.mas_equalTo(self.viewContain);
        make.width.mas_equalTo(self.imgViewTwo);
        make.bottom.mas_equalTo(self.imgViewTwo);
        make.height.mas_equalTo(self.viewContain).multipliedBy(0.5);
    }];
    
    [self.imgViewTwo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgViewOne);
        make.left.mas_equalTo(self.imgViewOne.mas_right);
        make.width.mas_equalTo(self.imgViewThree);
        make.bottom.mas_equalTo(self.imgViewThree);
        make.height.mas_equalTo(self.viewContain).multipliedBy(0.5);
    }];
    
    [self.imgViewThree mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgViewTwo);
        make.left.mas_equalTo(self.imgViewTwo.mas_right);
        make.right.mas_equalTo(self.viewContain);
        make.bottom.mas_equalTo(self.viewContain).offset(kScale_W(-22));
        make.height.mas_equalTo(self.viewContain).multipliedBy(0.5);
    }];
    
    [self.lblTag mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btnClose);
        make.left.mas_equalTo(self.lblContent);
        make.bottom.mas_equalTo(self.viewContain).offset(kScale_H(-2)).priorityHigh();
    }]; 
    
    
    [self.lblType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblTag).priorityHigh();
        make.left.mas_equalTo(self.lblTag.mas_right).offset(kScale_W(2)).priorityHigh();
        make.bottom.mas_equalTo(self.lblTag);
    }];
    
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lblType.mas_right).offset(kScale_W(2)).priorityLow();
        make.top.mas_equalTo(self.imgViewThree.mas_bottom);
        make.right.mas_equalTo(self.viewContain).offset(kScale_W(-2));
        make.width.height.mas_equalTo(kScale_W(22));
        make.bottom.mas_equalTo(self.lblTag).priorityLow();
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


- (void)setVm:(QuysInformationFlowVM *)vm
{
    _vm = vm;
    [self.imgViewOne sd_setImageWithURL:[NSURL URLWithString:vm.arrImgUrl[0]]];
    [self.imgViewTwo sd_setImageWithURL:[NSURL URLWithString:vm.arrImgUrl[1]]];
    [self.imgViewThree sd_setImageWithURL:[NSURL URLWithString:vm.arrImgUrl[2]]];
}

@end
