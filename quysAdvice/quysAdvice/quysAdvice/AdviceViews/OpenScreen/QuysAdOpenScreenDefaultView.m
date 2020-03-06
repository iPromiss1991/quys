//
//  QuysAdSplash.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdOpenScreenDefaultView.h"
@interface QuysAdOpenScreenDefaultView()
@property (nonatomic,strong) UIView *viewContain;
@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) UIButton *btnClose;

@property (nonatomic,strong) UIView *viewBottomContain;
@property (nonatomic,strong) UIImageView *imgSmallIcon;
@property (nonatomic,strong) UILabel *lblContent;
@property (nonatomic,strong) UIImageView *imgLogo;

@property (nonatomic,assign) NSInteger countdownLeft;
@property (nonatomic,strong) dispatch_source_t source_t;


@end


//TODO:文案展示？（不清楚），倒计时（循环引用）
@implementation QuysAdOpenScreenDefaultView

- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysAdOpenScreenVM *)viewModel
{
    if (self = [super initWithFrame:frame])
    {
        [self hlj_setTrackTag:kStringFormat(@"%ld",[self hash]) position:0 trackData:@{}];//因为是全屏显示，所以父视图被遮挡（hidden= yes），所以曝光为NO。
        [self createUI];
        self.vm = viewModel;
    }
    return self;
}

- (void)createUI
{
    UIView *viewContain = [[UIView alloc]initWithFrame:self.frame];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageVIewEvent:)];
    [viewContain addGestureRecognizer:tap];
    [self addSubview:viewContain];
    self.viewContain = viewContain;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"" ]];
    imgView.userInteractionEnabled = YES;
    [self.viewContain addSubview:imgView];
    self.imgView = imgView;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClose.backgroundColor = kRGB16(BackgroundColor1, 1);
    [btnClose addTarget:self action:@selector(clickCloseBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewContain addSubview:btnClose];
    self.btnClose = btnClose;
    
    
    UIView *viewBottomContain = [[UIView alloc] init];
    viewBottomContain.backgroundColor = [UIColor grayColor];
    viewBottomContain.alpha = .8;
    [self.viewContain addSubview:viewBottomContain];
    self.viewBottomContain = viewBottomContain;
    
    UIImageView *imgSmallIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgSmallIcon.userInteractionEnabled = YES;
    [self.viewBottomContain addSubview:imgSmallIcon];
    self.imgSmallIcon = imgSmallIcon;
    
    UILabel *lblContent = [[UILabel alloc] init];
    lblContent.numberOfLines = 0;
    lblContent.text = @"优化完黑屏现象后，我们发现还存在一个现象，那就是广告展示完进入首页后，首页才刚开始加载，需要一段等待时间.    我们可以利用展示广告这段时间对首页内容进行预加载，在广告展示完毕后进入首页可以看到已经就绪的首页。调用VC的view属性触发VC的预加载，如下所示。";
    [lblContent setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [lblContent setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    self.lblContent = lblContent;
    [self.viewBottomContain addSubview:lblContent];
    
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgLogo.userInteractionEnabled = YES;
    [self.viewBottomContain addSubview:imgLogo];
    self.imgLogo = imgLogo;
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.viewContain);
    }];
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).mas_offset(kScale_H(StatusBarHeight)).priorityHigh();
        make.left.mas_greaterThanOrEqualTo(self.viewContain);
        make.right.mas_equalTo(self.viewContain).mas_offset(kScale_W(-20));
        make.width.mas_equalTo(kScale_W(60)).priorityHigh();
        make.height.mas_equalTo(kScale_W(22)).priorityHigh();
        make.bottom.mas_lessThanOrEqualTo(self.viewContain).priorityHigh();
    }];
    
    
    [self.viewBottomContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.viewContain);
        make.top.mas_greaterThanOrEqualTo(self.viewContain.mas_bottom).offset(-kScale_H(200));
    }];
    
    [self.imgSmallIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_greaterThanOrEqualTo(self.viewBottomContain);
        make.left.mas_equalTo(self.viewBottomContain).mas_offset(kScale_W(20));
        make.bottom.mas_equalTo(self.viewBottomContain).mas_offset(kScale_H(-20));
        make.width.height.mas_equalTo(kScale_W(22)).priorityHigh();
    }];
    
    [self.lblContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_greaterThanOrEqualTo(self.viewBottomContain);
        make.left.mas_equalTo(self.imgSmallIcon.mas_right).mas_offset(kScale_W(5));
        make.bottom.mas_equalTo(self.viewBottomContain).mas_offset(kScale_H(-10));
    }];
    
    
    [self.imgLogo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imgSmallIcon).priorityHigh();
        make.left.mas_equalTo(self.lblContent.mas_right).mas_offset(kScale_W(5));
        make.right.mas_equalTo(self.viewBottomContain).mas_offset(kScale_W(-20)).priorityHigh();
        make.width.height.mas_equalTo(kScale_W(22)).priorityHigh();
    }];
    
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    kViewRadius(self.btnClose, kScale_H(10));
    
    
}


#pragma mark - PrivateMethod

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)tapImageVIewEvent:(UITapGestureRecognizer*)sender
{
    //    //暂停倒计时（因为倒计时完毕会移除当前的自定义window）
    //    dispatch_suspend(self.source_t);//TODO
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
    [[NSNotificationCenter defaultCenter ] postNotificationName:kRemoveBackgroundImageViewNotify object:nil];
    if (self.quysAdviceCloseEventBlockItem)
    {
        self.quysAdviceCloseEventBlockItem();
    }
}

//根据：runtime消息传递机制，子类先找到function的selector，然后直接调用实现（覆盖了：父类以及父类的类别）
- (void)hlj_viewStatisticalCallBack
{
    //倒计时
    [self countdownEvevt];
    if (self.quysAdviceStatisticalCallBackBlockItem)
    {
        self.quysAdviceStatisticalCallBackBlockItem();
    }
}


- (void)countdownEvevt
{
    
    kWeakSelf(self)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (self.countdownLeft >= 1)
        {
            weakself.countdownLeft--;
            NSString *strCountdownLeft = kStringFormat(@"%lds",weakself.countdownLeft);
            NSString *strDesc = kStringFormat(@"%@",@"跳过");
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:kStringFormat(@"%@%@",strCountdownLeft,strDesc)];
            [attr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:20]} range:NSMakeRange(0, strCountdownLeft.length)];
            [attr addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} range:NSMakeRange(2, strDesc.length)];
            [weakself.btnClose setAttributedTitle:attr forState:UIControlStateNormal];
        }else
        {
            dispatch_source_cancel(weakself.source_t );
            weakself.btnClose.titleLabel.attributedText = nil;
            [[NSNotificationCenter defaultCenter ] postNotificationName:kRemoveBackgroundImageViewNotify object:nil];
        }
        
    });
    dispatch_resume(timer);
    self.source_t = timer;
}

- (void)setVm:(QuysAdOpenScreenVM *)vm
{
    _vm = vm;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:vm.strImgUrl]];
    [self.imgSmallIcon sd_setImageWithURL:[NSURL URLWithString:vm.strImgUrl]];
    [self.imgLogo sd_setImageWithURL:[NSURL URLWithString:vm.strImgUrl]];
    self.countdownLeft = vm.showDuration;
    
}

- (void)dealloc
{
    
}

@end
