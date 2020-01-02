//
//  QuysVideoPlayerView.h
//  quysAdvice
//
//  Created by quys on 2020/1/2.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kAVPlayerItemDidRemoveNotification @"kAVPlayerItemDidRemoveNotification"
#define kAVPlayerItemTotalTime @"kAVPlayerItemTotalTime"
#define kAVPlayerItemCurrentTime @"kAVPlayerItemCurrentTime"

NS_ASSUME_NONNULL_BEGIN

@protocol QuysVideoPlayerDelegate <NSObject>

-(void)quys_videoPlay:(NSDictionary*)playItemInfo isCorrectStatus:(BOOL)status;




@end

@interface QuysVideoPlayerView : UIView
@property (nonatomic, strong) NSString *urlVideo;
@property (nonatomic,assign) CGFloat playProgress;
@property (nonatomic,strong) NSString *totalTime;
@property (nonatomic,strong) NSString *currentTime;
@property (nonatomic,weak) id<QuysVideoPlayerDelegate> delegate;


- (void)setMute;
-(void)playButtonWithStates:(BOOL)state;


@end

NS_ASSUME_NONNULL_END
