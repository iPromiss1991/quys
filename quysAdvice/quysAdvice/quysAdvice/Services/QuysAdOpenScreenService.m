//
//  QuysAdSplashService.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdOpenScreenService.h"
#import "QuysAdSplashApi.h"
#import "QuysAdviceOuterlayerDataModel.h"
#import "QuysAdviceModel.h"
#import "QuysOpenScreenWindow.h"
#import "QuysAdOpenScreenVM.h"
@interface QuysAdOpenScreenService()<YTKRequestDelegate>
@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) NSString *bussinessKey;
@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) QuysAdOpenScreenVM *vm;

@property (nonatomic,strong) UIViewController *launchScreenVC;


@property (nonatomic,strong) QuysAdSplashApi *api;


//bg
@property (nonatomic,strong) NSDate *dateInitRequest;//!<初始化请求的date


@end


@implementation QuysAdOpenScreenService
- (instancetype)initWithID:businessID key:bussinessKey  launchScreenVC:(nonnull UIViewController *)launchScreenVC eventDelegate:(nonnull id<QuysAdviceOpeenScreenDelegate>)delegate
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeBackgroundImageViewAndWindow) name:kRemoveOpenScreenBackgroundImageViewNotify object:nil];
        self.businessID = businessID;
        self.bussinessKey = bussinessKey;
        self.delegate = delegate;
        self.bgShowDuration = 1;
        [self config:launchScreenVC];
    }return self;
}

#pragma mark - PrivateMethod


- (void)config:(UIViewController*)launchScreenVC
{
    //配置api 并请求数据
    QuysAdSplashApi *api = [[QuysAdSplashApi alloc]init];
    api.businessID = self.businessID;
    api.bussinessKey = self.bussinessKey;
    api.delegate = self;
    self.api = api;
    self.launchScreenVC = launchScreenVC;
}

- (void)loadAdViewAndShow
{
    self.dateInitRequest = [NSDate date];
    [self loadAdViewNow:self.launchScreenVC];

}

/// 开始加载视图
- (void)loadAdViewNow:(UIViewController*)launchScreenVC
{
    if ([[QuysAdviceManager shareManager] loadAdviceEnable])
    {
        [self addBackgroundImageView:launchScreenVC];
        kWeakSelf(self)
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if ([weakself.delegate respondsToSelector:@selector(quys_requestStart:)])
            {
                [weakself.delegate quys_requestStart:weakself];
            }
            [weakself.api start];
        });
    }
    
}


/// 根据响应数据创建指定view
/// @param adViewModel 响应数据包装后的viewModel
- (void)configAdviceViewVM:(QuysAdviceModel*)adViewModel
{
    QuysAdOpenScreenVM *vm =  [[QuysAdOpenScreenVM alloc] initWithModel:adViewModel delegate:self.delegate frame:[UIScreen mainScreen].bounds  ];
    self.adviceView = [vm createAdviceView];
    self.vm = vm;
}



/// 展示视图
- (void)showAdView
{
    NSDate *dateCurrent = [NSDate date];
    NSTimeInterval differ = [dateCurrent timeIntervalSinceDate:self.dateInitRequest];
    NSTimeInterval differFinal = self.bgShowDuration - differ >=0?(self.bgShowDuration - differ):0;
    NSLog(@"启动图展示时长：%lf",differFinal);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(differFinal* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.adviceView.hidden = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeBackgroundImageView];
        });
    });
}


/// 添加遮罩底图
/// @param launchScreenVC 底图
- (void)addBackgroundImageView:(UIViewController*)launchScreenVC
{
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    [mainWindow addSubview:launchScreenVC.view];
    [mainWindow bringSubviewToFront:launchScreenVC.view];
    self.launchScreenVC = launchScreenVC;
    
}


/// 移除window & 遮罩底图
- (void)removeBackgroundImageViewAndWindow
{
    [self removeBackgroundImageView];
    [self removeWindow:self.adviceView];
}

/// 延时移除window & 遮罩底图
- (void)removeBackgroundImageViewAndWindowDelay
{
    NSDate *dateCurrent = [NSDate date];
    NSTimeInterval differ = [dateCurrent timeIntervalSinceDate:self.dateInitRequest];
    NSTimeInterval differFinal = self.bgShowDuration - differ >=0?(self.bgShowDuration - differ):0;
    NSLog(@"启动图展示时长：%lf",differFinal);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(differFinal* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeBackgroundImageView];
        [self removeWindow:self.adviceView];
    });
}



/// 移除遮罩底图
- (void)removeBackgroundImageView
{
    kWeakSelf(self)
    //移除delegate.window的遮罩图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself.launchScreenVC.view removeFromSuperview];
    });
}


- (void)removeWindow:(UIWindow*)window
{
    for (id obj in window.subviews)
    {
        [obj removeFromSuperview];
    }
    __block UIWindow* windowTemp = window;
    //淡入淡出效果
    //    CATransition * ani = [CATransition animation];
    //    ani.type = kCATransitionFade;
    //    ani.subtype = kCATransitionFromRight;
    //    ani.duration = .2;
    //    [windowTemp.layer addAnimation:ani forKey:@"transitionAni"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        windowTemp.hidden = YES;
        windowTemp = nil;
    });
}


#pragma mark - YTKRequestDelegate

-(void)requestFinished:(__kindof YTKBaseRequest *)request
{
    QuysAdviceOuterlayerDataModel *outerModel = [QuysAdviceOuterlayerDataModel yy_modelWithJSON:request.responseJSONObject];
    if (outerModel && outerModel.data.count)
    {
        QuysAdviceModel *adviceModel = outerModel.data[0];
        [self configAdviceViewVM:adviceModel];
        if ([self.delegate respondsToSelector:@selector(quys_requestSuccess:)])
        {
            [self.delegate quys_requestSuccess:self];
        }
        [self showAdView];
    }else
    {
        [self removeBackgroundImageViewAndWindowDelay];
        if ([self.delegate respondsToSelector:@selector(quys_requestFial:error:)])
        {
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:kQuysNetworkParsingErrorCode userInfo:@{NSUnderlyingErrorKey:@"数据解析异常！"}];
            [self.delegate quys_requestFial:self error:error];
        }
        
    }
    NSLog(@"原始响应数据：\n<<<<<<<<%@",request.responseObject);
}


- (void)requestFailed:(__kindof YTKBaseRequest *)request
{
    [self removeBackgroundImageViewAndWindowDelay];
    if ([self.delegate respondsToSelector:@selector(quys_requestFial:error:)])
    {
        [self.delegate quys_requestFial:self error:request.error];
    }
    
}


#pragma mark - Init


-(UIWindow *)adviceView
{
    if (_adviceView == nil)
    {
        _adviceView.windowLevel = UIWindowLevelAlert - 1;
        UIViewController *rootVC = [UIViewController new];
        _adviceView.rootViewController = rootVC;
    }return _adviceView;
}

-(NSTimeInterval)bgShowDuration
{
    if (_bgShowDuration <= 0)
    {
        _bgShowDuration = 1;
    }return _bgShowDuration;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRemoveOpenScreenBackgroundImageViewNotify object:nil];
}
@end
