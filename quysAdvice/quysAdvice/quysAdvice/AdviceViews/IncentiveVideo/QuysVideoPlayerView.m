//
//  QuysVideoPlayerView.m
//  quysAdvice
//
//  Created by quys on 2020/1/2.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysVideoPlayerView.h"
#import <AVKit/AVKit.h>

@interface QuysVideoPlayerView ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) UILabel *speedTextLabel;//显示网速Label

@property (nonatomic, strong) id playbackObserver;
@property (nonatomic) BOOL buffered;//是否缓冲完毕

@end

@implementation QuysVideoPlayerView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor cyanColor];
        [self.layer addSublayer:self.playerLayer];
        [self addSubview:self.speedTextLabel];

    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - Init
-(AVPlayer *)player{
    
    if (!_player) {
        _player = [[AVPlayer alloc] init];
        __weak typeof(self) weakSelf = self;
        // 每秒回调一次
        self.playbackObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
            [weakSelf quys_videoPlay];
            NSTimeInterval totalTime = CMTimeGetSeconds(weakSelf.player.currentItem.duration);//总时长
            NSTimeInterval currentTime = time.value / time.timescale;//当前时间进度
            weakSelf.playProgress= currentTime / totalTime;
        }];
    }
    return _player;
    
}

-(AVPlayerLayer *)playerLayer{
    
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return _playerLayer;
    
}


//设置播放地址
-(void)setUrlVideo:(NSString *)urlVideo{
    
    [self.player seekToTime:CMTimeMakeWithSeconds(0, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self.player play];//开始播放视频
        
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlVideo]];
    [self vpc_addObserverToPlayerItem:item];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.player replaceCurrentItemWithPlayerItem:item];
        [self vpc_playerItemAddNotification];
        [self vpc_playerRemoveNotification];
    });
    
}


#pragma mark - PrivateMethod


-(void)playButtonWithStates:(BOOL)state
{
    
    if (state)
    {
        [self.player pause];
    }else
    {
        [self.player play];
    }
    
}


- (void)vpc_sliderTouchBegin:(UISlider *)sender {
    [self.player pause];
}


#pragma mark - lTime

- (void)quys_videoPlay
{
    BOOL isNormalStatus = NO;
    NSTimeInterval totalTime = CMTimeGetSeconds(self.player.currentItem.duration);//总时长
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);//当前时间进度
    
    // 切换视频源时totalTime/currentTime的值会出现nan导致时间错乱
    if (!(totalTime >= 0) || !(currentTime >= 0))
    {
        totalTime = 0;
        currentTime = 0;
    }else
    {
        isNormalStatus = YES;
    }
    
    NSInteger totalMin = totalTime / 60;
    NSInteger totalSec = (NSInteger)totalTime % 60;
    NSString *totalTimeStr = [NSString stringWithFormat:@"%02ld:%02ld",totalMin,totalSec];
    self.totalTime = totalTimeStr;

    NSInteger currentMin = currentTime / 60;
    NSInteger currentSec = (NSInteger)currentTime % 60;
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02ld:%02ld",currentMin,currentSec];
    self.currentTime = currentTimeStr;
    
    if ([self.delegate respondsToSelector:@selector(quys_videoPlay:isCorrectStatus:)])
    {
        [self.delegate quys_videoPlay:@{kAVPlayerItemTotalTime:[NSString stringWithFormat:@"%02ld:%02ld",totalMin,totalSec],kAVPlayerItemCurrentTime:[NSString stringWithFormat:@"%02ld:%02ld",currentMin,currentSec]} isCorrectStatus:isNormalStatus];
    }
}

#pragma mark - 观察者

- (void)vpc_playerRemoveNotification {
    // 移除通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(validatePlayer) name:kAVPlayerItemDidRemoveNotification object:nil];
}

- (void)vpc_playerItemAddNotification {
    // 播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vpc_playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

-(void)vpc_playbackFinished:(NSNotification *)noti{
    [self.player pause];
}

- (void)vpc_addObserverToPlayerItem:(AVPlayerItem *)playerItem {
    // 监听播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 监听缓冲进度
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)vpc_playerItemRemoveNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

- (void)vpc_playerItemRemoveObserver {
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay)
        {
            [self quys_videoPlay];
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        NSArray *array = self.player.currentItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);//本次缓冲起始时间
        NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);//缓冲时间
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        float totalTime = CMTimeGetSeconds(self.player.currentItem.duration);//视频总长度
        float progress = totalBuffer/totalTime;//缓冲进度
        NSLog(@"progress = %lf",progress);
        
        //如果缓冲完了，拖动进度条不需要重新显示缓冲条
        if (!self.buffered)
        {
            if (progress == 1.0)
            {
                self.buffered = YES;
            }
            self.playProgress = progress;
        }
        NSLog(@"yon = %@",self.buffered ? @"yes" : @"no");
    }
}

- (void)validatePlayer
{
    [self.player removeTimeObserver:self.playbackObserver];
    [self vpc_playerItemRemoveObserver];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setMute
{
   (self.player.volume == 0.0)?(self.player.volume = 1.0):(self.player.volume = 0.0f);
}

- (void)dealloc
{
    [self validatePlayer];
}

@end
