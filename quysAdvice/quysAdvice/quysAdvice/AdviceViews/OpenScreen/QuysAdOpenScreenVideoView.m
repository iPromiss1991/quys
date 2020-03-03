//
//  QuysAdOpenScreenVideoView.m
//  quysAdvice
//
//  Created by wxhmbp on 2020/3/3.
//  Copyright © 2020年 Quys. All rights reserved.
//

#import "QuysAdOpenScreenVideoView.h"
@interface QuysAdOpenScreenVideoView()

@end

@implementation QuysAdOpenScreenVideoView

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
    
    
}


@end
