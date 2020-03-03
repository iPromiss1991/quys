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
#import "QuysFullScreenReplaceView.h"
#import "QuysAdOpenScreenVM.h"
@interface QuysAdOpenScreenService()<YTKRequestDelegate>
@property (nonatomic,assign,readwrite) BOOL loadAdViewEnable;

@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) NSString *bussinessKey;
@property (nonatomic,assign) CGRect cgFrame;
@property (nonatomic,strong) UIWindow *window;


@property (nonatomic,strong) QuysAdSplashApi *api;


@end


@implementation QuysAdOpenScreenService
- (instancetype)initWithID:businessID key:bussinessKey cGrect:(CGRect)cgFrame  backgroundImage:(UIImage*)imgReplace eventDelegate:(nonnull id<QuysAdviceOpeenScreenDelegate>)delegate window:(UIWindow*)window;
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeBackgroundImageViewAndWindow) name:kRemoveBackgroundImageViewNotify object:nil];
        self.businessID = businessID;
        self.bussinessKey = bussinessKey;
        self.delegate = delegate;
        self.cgFrame = cgFrame;
        self.window = window;
        [self config:imgReplace];
    }return self;
}

#pragma mark - PrivateMethod


- (void)config:(UIImage*)imgReplace
{
    //配置api 并请求数据
    QuysAdSplashApi *api = [[QuysAdSplashApi alloc]init];
    api.businessID = self.businessID;
    api.bussinessKey = self.bussinessKey;
    api.delegate = self;
    self.api = api;
    [self loadAdViewNow:imgReplace];
}


/// 开始加载视图
- (void)loadAdViewNow:(UIImage*)imgReplace
{
    if ([[QuysAdviceManager shareManager] loadAdviceEnable])
    {
        [self addBackgroundImageView:imgReplace];
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
    QuysAdOpenScreenVM *vm =  [[QuysAdOpenScreenVM alloc] initWithModel:adViewModel delegate:self.delegate frame:self.cgFrame window:self.window ];
    self.adviceView = [vm createAdviceView];
    self.adviceView?(self.loadAdViewEnable = YES):(self.loadAdViewEnable = NO);
}



/// 展示视图
- (void)showAdView
{
    if (self.loadAdViewEnable)
    {
        self.adviceView.hidden = NO;
        //TODO
        //        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        //        animation.duration = .3;
        //        animation.fromValue = @(0.5);
        //        animation.toValue = @(1);
        //        [self.adviceView.layer addAnimation:animation forKey:@"animation"];
    }else
    {
        //视图正在创建中。。。
    }
}


- (void)addBackgroundImageView:(UIImage*)imgBackground
{
    QuysFullScreenReplaceView *vBack = [[QuysFullScreenReplaceView alloc]initWithFrame:[UIScreen mainScreen].bounds  image:imgBackground];
    [[UIApplication sharedApplication].delegate.window addSubview:vBack];
}


- (void)removeBackgroundImageViewAndWindow
{
    [self removeBackgroundImageView];
    [self removeWindow:self.adviceView];
}

- (void)removeBackgroundImageView
{
    //移除delegate.window的遮罩图
    for (id  subObj in [UIApplication sharedApplication].delegate.window.subviews)
    {
        if ([subObj isKindOfClass:[QuysFullScreenReplaceView class]])
        {
            [subObj removeFromSuperview];
        }
    }
}


- (void)removeWindow:(UIWindow*)window
{
   window.hidden = YES;
   window = nil;
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
        [self removeBackgroundImageView];
    }else
    {
        [self removeBackgroundImageViewAndWindow];
        if ([self.delegate respondsToSelector:@selector(quys_requestFial:error:)])
        {
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:kQuysNetworkParsingErrorCode userInfo:@{NSUnderlyingErrorKey:@"数据解析异常！"}];
            [self.delegate quys_requestFial:self error:error];
        }
        
    }
}


- (void)requestFailed:(__kindof YTKBaseRequest *)request
{
    [self removeBackgroundImageViewAndWindow];
    if ([self.delegate respondsToSelector:@selector(quys_requestFial:error:)])
    {
        [self.delegate quys_requestFial:self error:request.error];
    }
    
}

-(UIWindow *)adviceView
{
    if (_adviceView == nil)
    {
        _adviceView.windowLevel = UIWindowLevelAlert+1;
        UIViewController *rootVC = [UIViewController new];
        _adviceView.rootViewController = rootVC;
    }return _adviceView;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRemoveBackgroundImageViewNotify object:nil];
}
@end
