//
//  QuysAdOpenScreenVideoView.m
//  quysAdvice
//
//  Created by quys on 2020/3/4.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysAdOpenScreenVideoView.h"
#import "QuysVideoContentView.h"
#import "QuysAdOpenScreenVM.h"
@interface QuysAdOpenScreenVideoView()
@property (nonatomic,strong) QuysVideoContentView *videoView;

@end



@implementation QuysAdOpenScreenVideoView

- (instancetype)initWithFrame:(CGRect)frame viewModel:(QuysAdOpenScreenVM *)viewModel
{
    if (self = [super initWithFrame:frame])
    {
        self.vm = viewModel;
        [self createUI];
        [self setupConfig];
    }
    return self;
}

- (void)createUI
{
    kWeakSelf(self)
    QuysVideoContentView *videoView = [[QuysVideoContentView alloc] init];
    videoView.quysAdviceClickEventBlockItem = ^(CGPoint cp, CGPoint cpRe) {
        [weakself clickEvent:cp  cpRe:cpRe];
    };
    videoView.quysAdviceCloseEventBlockItem = ^{
        [weakself closeEvent];
    };
    videoView.quysAdviceStatisticalCallBackBlockItem = ^{
        [weakself statisticalEvent];
    };
    videoView.showDuration = self.vm.showDuration;
    self.videoView = videoView;
    [self addSubview:videoView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.videoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


- (void)clickEvent:(CGPoint)cp cpRe:(CGPoint)cpRe
{
    if (self.quysAdviceClickEventBlockItem)
    {
        self.quysAdviceClickEventBlockItem(cp,cpRe);
    }
}

- (void)closeEvent
{
    if (self.quysAdviceCloseEventBlockItem)
    {
        self.quysAdviceCloseEventBlockItem();
    }
}

- (void)statisticalEvent
{
    if (self.quysAdviceStatisticalCallBackBlockItem)
    {
        self.quysAdviceStatisticalCallBackBlockItem();
    }
}



#pragma mark - PrivateMethod
- (void)setupConfig
{
    [self.videoView setQuysPlayUrl:[NSURL URLWithString:self.vm.materialUrl]];
    
}

- (void)dealloc
{
    
}

@end
