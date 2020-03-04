//
//  QuysVideoContentView.h
//  quysAdvice
//
//  Created by quys on 2020/3/3.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^QuysAdviceVoiceEventBlock)(BOOL voiceEnable);
typedef void(^QuysAdviceCloseEventBlock)(void);//!< 关闭事件
typedef void(^QuysAdviceClickEventBlock)(CGPoint cp);//!< 点击事件
typedef void(^QuysAdviceStatisticalCallBackBlock)(void);//!< 曝光事件

@interface QuysVideoContentView : UIView

@property (nonatomic,strong) NSURL *quysPlayUrl;

@property (nonatomic,copy) QuysAdviceVoiceEventBlock quysAdviceVoiceEventBlockItem;
@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;

@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;

- (void)quys_play;
- (void)quys_remove;

@end

NS_ASSUME_NONNULL_END
