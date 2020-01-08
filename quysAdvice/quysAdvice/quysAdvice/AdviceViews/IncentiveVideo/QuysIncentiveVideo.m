//
//  QuysAdSplash.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysIncentiveVideo.h"
#import "QuysVideoPlayerView.h"
#import "QuysImgPlayendCoverView.h"
@interface QuysIncentiveVideo()<QuysVideoPlayerDelegate>
@property (nonatomic,strong) UIView *viewContain;

@property (nonatomic,strong) UIButton *btnCounntdown;//!< 倒计时
@property (nonatomic,strong) UIButton *btnClose;

//TODO:videoPlayerView
@property (nonatomic,strong) QuysVideoPlayerView *playerView;
@property (nonatomic,strong) QuysImgPlayendCoverView *imgPlayendCover;


@property (nonatomic,strong) UIView *viewFootContain;
@property (nonatomic,strong) UIImageView *imgLogo;
@property (nonatomic,strong) UILabel *lblContent;
@property (nonatomic,strong) UIButton *btnVoice;//!< 声音

//倒计时
@property (nonatomic,assign) NSInteger countdownLeft;


@end


//TODO:文案展示？（不清楚），倒计时（循环引用）
@implementation QuysIncentiveVideo

- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysIncentiveVideoVM *)viewModel
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
    UIView *viewContain = [[UIView alloc]initWithFrame:CGRectZero];
     UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageVIewEvent:)];
    [viewContain addGestureRecognizer:tap];
    [self addSubview:viewContain];
    self.viewContain = viewContain;
    
    
    QuysVideoPlayerView *playerView = [[QuysVideoPlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    playerView.delegate = self;
    [playerView hlj_setTrackTag:kStringFormat(@"%ld",[playerView hash]) position:0 trackData:@{}];//因为是全屏显示，所以父视图被遮挡（hidden= yes），所以曝光为NO。
    [self.viewContain addSubview:playerView];
    self.playerView = playerView;
    
    //
    QuysImgPlayendCoverView *imgPlayendCover = [[QuysImgPlayendCoverView alloc] init];
    imgPlayendCover.userInteractionEnabled = YES;
    imgPlayendCover.hidden = YES;
    [imgPlayendCover hlj_setTrackTag:kStringFormat(@"%ld",[imgPlayendCover hash]) position:0 trackData:@{}];//因为是全屏显示，所以父视图被遮挡（hidden= yes），所以曝光为NO。
    [self.playerView addSubview:imgPlayendCover];
    self.imgPlayendCover = imgPlayendCover;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose addTarget:self action:@selector(clickCloseBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnClose setTitle:@"" forState:UIControlStateNormal];
    [btnClose setTitle:@"" forState:UIControlStateHighlighted];
    [btnClose setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnClose setImage:[UIImage imageNamed:@"close" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [btnClose setImage:[UIImage imageNamed:@"close" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    [self.viewContain addSubview:btnClose];
    self.btnClose = btnClose;
    
    UIButton *btnCounntdown = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCounntdown.userInteractionEnabled = NO;
    [btnCounntdown setTitle:@"" forState:UIControlStateNormal];
    [btnCounntdown setTitle:@"" forState:UIControlStateHighlighted];
    [btnCounntdown setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.viewContain addSubview:btnCounntdown];
    self.btnCounntdown = btnCounntdown;
    
    //
    UIView *viewFootContain = [[UIView alloc]initWithFrame:self.frame];
     [self.viewContain addSubview:viewFootContain];
    self.viewFootContain = viewFootContain;
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    imgLogo.userInteractionEnabled = YES;
    [self.viewFootContain addSubview:imgLogo];
    self.imgLogo = imgLogo;
    
    UILabel *lblContent = [[UILabel alloc] init];
    lblContent.numberOfLines = 3;
    lblContent.text = @"优化完黑屏现象后，我们发现还存在一个现象，那就是广告展示完进入首页后，首页才刚开始加载，需要一段等待时间.    我们可以利用展示广告这段时间对首页内容进行预加载，在广告展示完毕后进入首页可以看到已经就绪的首页。调用VC的view属性触发VC的预加载，如下所示。";
    [lblContent setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [lblContent setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    self.lblContent = lblContent;
    [self.viewFootContain addSubview:lblContent];
    
    UIButton *btnVoice = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnVoice addTarget:self action:@selector(clickVoiceBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnVoice setTitle:@"" forState:UIControlStateNormal];
    [btnVoice setTitle:@"" forState:UIControlStateHighlighted];
    [btnVoice setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnVoice setImage:[UIImage imageNamed:@"voice" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [btnVoice setImage:[UIImage imageNamed:@"voice" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    [self.viewFootContain addSubview:btnVoice];
    self.btnVoice = btnVoice;
    
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.btnCounntdown mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btnClose);
        make.left.mas_equalTo(self.viewContain).offset(kScale_W(20));
        make.width.mas_equalTo(kScale_W(60)).priorityHigh();
        make.height.mas_equalTo(kScale_W(22)).priorityHigh();
    }];
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).mas_offset(kScale_H(StatusBarHeight)).priorityHigh();
        make.left.mas_greaterThanOrEqualTo(self.btnCounntdown.mas_right);
        make.right.mas_equalTo(self.viewContain).mas_offset(kScale_W(-5));
        make.width.mas_equalTo(kScale_W(60)).priorityHigh();
        make.height.mas_equalTo(kScale_H(40)).priorityHigh();
    }];
    
    [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).priorityHigh();
        make.left.right.mas_equalTo(self.viewContain);
    }];
    
    [self.imgPlayendCover mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.playerView);
    }];
    
    //
    [self.viewFootContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.playerView.mas_bottom).priorityHigh();
        make.left.right.bottom.mas_equalTo(self.viewContain);
        make.height.mas_equalTo(kScale_H(100)).priorityHigh();
    }];
    
    [self.imgLogo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.viewFootContain).priorityHigh();
        make.left.mas_equalTo(self.viewFootContain).mas_offset(kScale_W(5));
        make.width.mas_equalTo(kScale_W(60)).priorityHigh();
        make.height.mas_equalTo(kScale_H(60)).priorityHigh();
    }];
    
    [self.lblContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewFootContain).mas_offset(kScale_H(5));
        make.left.mas_equalTo(self.imgLogo.mas_right).mas_offset(kScale_W(5));
        make.bottom.mas_equalTo(self.viewFootContain).mas_offset(kScale_H(-10));
    }];
    
    //TODO：音量按钮布局待确认！
    [self.btnVoice mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imgLogo).priorityHigh();
        make.left.mas_equalTo(self.lblContent.mas_right).mas_offset(kScale_W(5));
        make.right.mas_equalTo(self.viewFootContain).mas_offset(kScale_W(-5)).priorityHigh();
        make.width.mas_equalTo(kScale_W(60)).priorityHigh();
        make.height.mas_equalTo(kScale_H(40)).priorityHigh();
        
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
    if (self.vm.isClickable)
    {
        [self playStatesChanged];
        //获取触发触摸的点
        CGPoint cpBegain = [sender locationInView:self];
        CGPoint cpBegainResult = [self convertPoint:cpBegain toView:[UIApplication sharedApplication].keyWindow];//相对于屏幕的坐标
        if (self.quysAdviceClickEventBlockItem)
        {
            self.quysAdviceClickEventBlockItem(cpBegainResult);
        }
    }
}


/// 关闭广告
/// @param sender UIButton
- (void)clickCloseBtEvent:(UIButton*)sender
{
    [self closeAndRemovePlayer];
    if (self.quysAdviceCloseEventBlockItem)
    {
        self.quysAdviceCloseEventBlockItem();
    }
}

- (void)closeAndRemovePlayer
{
    [self playStatesChanged];
    [[NSNotificationCenter defaultCenter ] postNotificationName:kAVPlayerItemDidRemoveNotification object:nil];
    [[NSNotificationCenter defaultCenter ] postNotificationName:kRemoveBackgroundImageViewNotify object:nil];
}

/// 静音设置
/// @param sender UIButton
- (void)clickVoiceBtEvent:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        [self.btnVoice setImage:[UIImage imageNamed:@"mute" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [self.btnVoice setImage:[UIImage imageNamed:@"mute" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    }else
    {
        [self.btnVoice setImage:[UIImage imageNamed:@"voice" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
        [self.btnVoice setImage:[UIImage imageNamed:@"voice" inBundle:MYBUNDLE compatibleWithTraitCollection:nil] forState:UIControlStateHighlighted];
    }
    [self.playerView setMute];
    NSLog(@"%s",__PRETTY_FUNCTION__);
}


//根据：runtime消息传递机制，子类先找到function的selector，然后直接调用实现（覆盖了：父类以及父类的类别）
- (void)hlj_viewStatisticalCallBack
{
    //倒计时
    if (self.quysAdviceStatisticalCallBackBlockItem)
    {
        self.quysAdviceStatisticalCallBackBlockItem();
    }
}


- (void)countdownEvevt
{
    kWeakSelf(self)
    if (self.countdownLeft >= 1)
    {
        weakself.countdownLeft--;
        [weakself.btnCounntdown setTitle:kStringFormat(@"%lds",weakself.countdownLeft) forState:UIControlStateNormal];
        [weakself.btnCounntdown setTitle:kStringFormat(@"%lds",weakself.countdownLeft) forState:UIControlStateHighlighted];
        NSLog(@"%lds",weakself.countdownLeft);
    }else
    {
        [weakself.btnCounntdown setTitle:kStringFormat(@"") forState:UIControlStateNormal];
        [weakself.btnCounntdown setTitle:kStringFormat(@"") forState:UIControlStateHighlighted];
        NSLog(@"%lds",weakself.countdownLeft);
        //TODO:加载尾帧，同时继续播放剩余内容（方案：1、post 通知。  2、监听页面显示）
        switch (self.vm.videoEndShowType) {
            case QuysAdviceVideoEndShowTypeNone:
            {
                 self.imgPlayendCover.hidden = YES;
            }
                break;
            case QuysAdviceVideoEndShowTypeImageUrl:
            {
                self.imgPlayendCover.strImageUrl = self.vm.videoEndShowValue;
                self.imgPlayendCover.hidden = NO;
            }
                break;
            case QuysAdviceVideoEndShowTypeHtmlCode:
            {
                if (self.quysAdvicePlayEndCallBackBlockItem) {
                    self.quysAdvicePlayEndCallBackBlockItem(QuysAdviceVideoEndShowTypeHtmlCode);
                }
            }
                break;
            case QuysAdviceVideoEndShowTypeHtmlUrl:
            {     if (self.quysAdvicePlayEndCallBackBlockItem) {
                self.quysAdvicePlayEndCallBackBlockItem(QuysAdviceVideoEndShowTypeHtmlUrl);
            }
                
            }
                break;
                
            default:
                break;
        }
    }
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)playStatesChanged
{
    
    [self.playerView playStatesChanged];
    
}


 

#pragma mark -QuysVideoPlayerDelegate

//进度
- (void)quys_videoPlay:(NSDictionary *)playItemInfo isCorrectStatus:(BOOL)status
{
    if (status)
    {
        NSInteger totalTime = [self translateMediaTimeToSeconds:playItemInfo[kAVPlayerItemTotalTime]];
        NSInteger currentTime = [self translateMediaTimeToSeconds:playItemInfo[kAVPlayerItemCurrentTime]];
        self.countdownLeft = totalTime - currentTime;
        [self countdownEvevt];
        
        if (self.quysAdviceProgressEventBlockItem)
        {
            NSInteger progress = (currentTime/(CGFloat)totalTime)*100;
            self.quysAdviceProgressEventBlockItem(progress);
        }
    }
}

- (NSInteger)translateMediaTimeToSeconds:(NSString*)mediaTime
{
    NSArray *arrTimes = [mediaTime componentsSeparatedByString:@":"];
    NSInteger totalTime ;
    if (arrTimes.count == 2)
    {
        totalTime = [arrTimes[0] integerValue]*60 + [arrTimes[1] integerValue] ;
    }else
    {
        totalTime = [arrTimes[0] integerValue];
    }
    return totalTime;
}

- (void)setVm:(QuysIncentiveVideoVM *)vm
{
    _vm = vm;
    [self.imgLogo sd_setImageWithURL:[NSURL URLWithString:vm.strImgUrl]];
}

- (void)updateBlockItemsAndPalyStart
{
    kWeakSelf(self)
    self.playerView.quysAdvicePlayStartCallBackBlockItem = ^{
        weakself.quysAdvicePlayStartCallBackBlockItem();
    };
    self.playerView.quysAdviceLoadSucessCallBackBlockItem = self.quysAdviceLoadSucessCallBackBlockItem;
    self.playerView.quysAdviceLoadFailCallBackBlockItem = self.quysAdviceLoadFailCallBackBlockItem;
    
    self.playerView.quysAdviceMuteCallBackBlockItem = self.quysAdviceMuteCallBackBlockItem;
    self.playerView.quysAdviceCloseMuteCallBackBlockItem = self.quysAdviceCloseMuteCallBackBlockItem;
    
    self.playerView.quysAdviceSuspendCallBackBlockItem = self.quysAdviceSuspendCallBackBlockItem;
    self.playerView.quysAdvicePlayagainCallBackBlockItem = self.quysAdvicePlayagainCallBackBlockItem;
    
    
    //
    self.imgPlayendCover.quysAdviceStatisticalCallBackBlockItem = ^{
        //尾帧曝光
        weakself.quysAdviceEndViewStatisticalCallBackBlockItem();
    };
    
    self.imgPlayendCover.quysAdviceCloseEventBlockItem = ^{
        //尾帧关闭
        weakself.quysAdviceEndViewCloseEventBlockItem();//TODO：关闭window
    };
    
    self.imgPlayendCover.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
        //尾帧点击
        weakself.quysAdviceEndViewClickEventBlockItem(cp);
    };
    
    self.playerView.urlVideo = self.vm.videoUrl;
    self.playerView.quysAdviceStatisticalCallBackBlockItem = ^{
        //曝光：自动播放视频
        [weakself playStatesChanged];
    };
    
}



- (void)dealloc
{
    
}



@end
