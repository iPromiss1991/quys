//
//  QuysAdSplashService.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdSplashService.h"
#import "QuysAdSplashApi.h"
#import "QuysAdviceOuterlayerDataModel.h"
#import "QuysAdviceModel.h"
@interface QuysAdSplashService()<YTKRequestDelegate>
@property (nonatomic,assign,readwrite) BOOL loadAdViewEnable;

@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) NSString *bussinessKey;
@property (nonatomic,assign) CGRect cgFrame;

@property (nonatomic,strong) UIView *parentView;

@property (nonatomic,strong) QuysAdSplashApi *api;
@property (nonatomic,strong) QuysAdSplash *splashview;
@property (nonatomic,weak) id <QuysAdSplashDelegate> innerDelegate;//!< SDK内部处理事件的delegate


@end


@implementation QuysAdSplashService
- (instancetype)initWithID:businessID key:bussinessKey cGrect:(CGRect)cgFrame eventDelegate:(nonnull id<QuysAdSplashDelegate>)delegate parentView:(nonnull UIView *)parentView
{
    if (self = [super init])
    {
        self.businessID = businessID;
        self.bussinessKey = bussinessKey;
        self.delegate = delegate;
        self.parentView = parentView;
        self.cgFrame = cgFrame;
        [self config];
    }return self;
}

#pragma mark - PrivateMethod


- (void)config
{
    //配置api 并请求数据
    QuysAdSplashApi *api = [[QuysAdSplashApi alloc]init];
    api.businessID = self.businessID;
    api.bussinessKey = self.bussinessKey;
    api.delegate = self;
    self.api = api;
    
}


/// 发起请求
- (void)loadAdViewNow
{
    kWeakSelf(self)
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([weakself.delegate respondsToSelector:@selector(quys_requestStart)])
        {
            [weakself.delegate quys_requestStart];
        }
            [weakself.api start];
    });
    
}


/// 根据响应数据创建指定view
/// @param adViewModel 响应数据包装后的viewModel
- (void)configAdviceView:(QuysAdSplashVM<QuysAdSplashDelegate>*)adViewModel
{
    self.innerDelegate = adViewModel;
    kWeakSelf(self)
    //根据数据创建指定的视图（目前插屏广告只有该一种view，so。。。）
    QuysAdSplash *splashview = [[QuysAdSplash alloc]initWithFrame:self.cgFrame viewModel:adViewModel];
    adViewModel.cgView = self.cgFrame;
    //点击事件
    splashview.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
        if ([weakself.innerDelegate respondsToSelector:@selector(quys_interstitialOnClick:)])
                       {
                           [weakself.innerDelegate quys_interstitialOnClick:cp];
                       }
        if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnClick:)])
                {
                    [weakself.delegate quys_interstitialOnClick:cp];
                }
    };
    
    //关闭事件
    splashview.quysAdviceCloseEventBlockItem = ^{
        if ([weakself.innerDelegate respondsToSelector:@selector(quys_interstitialOnAdClose)])
        {
            [weakself.innerDelegate quys_interstitialOnAdClose];
        }
         if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnAdClose)])
                {
                    [weakself.delegate quys_interstitialOnAdClose];
                }
    };
    
    //曝光事件
    splashview.quysAdviceStatisticalCallBackBlockItem = ^{
        if ([weakself.innerDelegate respondsToSelector:@selector(quys_interstitialOnExposure)])
        {
            [weakself.innerDelegate quys_interstitialOnExposure];
        }
         if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnExposure)])
                {
                    [weakself.delegate quys_interstitialOnExposure];
                }
    };
    [splashview hlj_setTrackTag:kStringFormat(@"%ld",[splashview hash]) position:0 trackData:@{}];
    self.splashview = splashview;
    self.loadAdViewEnable = YES;
}



/// 展示视图
- (void)showAdView
{
    if (self.loadAdViewEnable)
    {
        [self.parentView addSubview:self.splashview];
    }else
    {
        //视图正在创建中。。。
    }
}


#pragma mark - YTKRequestDelegate

-(void)requestFinished:(__kindof YTKBaseRequest *)request
{
    QuysAdviceOuterlayerDataModel *outerModel = [QuysAdviceOuterlayerDataModel yy_modelWithJSON:request.responseJSONObject];
    if (outerModel && outerModel.data.count)
    {
        QuysAdviceModel *adviceModel = outerModel.data[0];
        QuysAdSplashVM *vm = [[QuysAdSplashVM alloc] initWithModel:adviceModel];
        [self configAdviceView:vm];//warnning：此处创建innerDelegate！！！
        //请求成功回调
        if ([self.innerDelegate respondsToSelector:@selector(quys_requestSuccess)])
        {
            [self.innerDelegate quys_requestSuccess];
        }
        
        if ([self.delegate respondsToSelector:@selector(quys_requestSuccess)])
        {
            [self.delegate quys_requestSuccess];
        }
    }else
    {
        if ([self.delegate respondsToSelector:@selector(quys_requestFial:)])
               {
                   NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:kQuysNetworkParsingErrorCode userInfo:@{NSUnderlyingErrorKey:@"数据解析异常！"}];
                   [self.delegate quys_requestFial:error];
               }
       
    }
}


- (void)requestFailed:(__kindof YTKBaseRequest *)request
{
    if ([self.delegate respondsToSelector:@selector(quys_requestFial:)])
    {
        [self.delegate quys_requestFial:request.error];
    }
          
}




-(void)dealloc
{
    
}
@end
