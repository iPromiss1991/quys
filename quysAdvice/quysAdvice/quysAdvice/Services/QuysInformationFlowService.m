//
//  QuysAdSplashService.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysInformationFlowService.h"
#import "QuysAdSplashApi.h"
#import "QuysAdviceOuterlayerDataModel.h"
#import "QuysAdviceModel.h"
#import "QuysInformationFlowDefaultView.h"
#import "QuysInformationFlowVM.h"

@interface QuysInformationFlowService()<YTKRequestDelegate>
@property (nonatomic,assign,readwrite) BOOL loadAdViewEnable;

@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) NSString *bussinessKey;
@property (nonatomic,assign) CGRect cgFrame;

@property (nonatomic,strong) UIView *parentView;

@property (nonatomic,strong) QuysAdSplashApi *api;
@property (nonatomic,strong) UIView *adviceView;//!<


@end


@implementation QuysInformationFlowService
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
    if ([[QuysAdviceManager shareManager] loadAdviceEnable])
    {
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
    QuysInformationFlowVM *vm =  [[QuysInformationFlowVM alloc] initWithModel:adViewModel delegate:self.delegate frame:self.cgFrame service:self];
    self.adviceView = [vm createAdviceView];
    self.loadAdViewEnable = YES;
}


/// 展示视图
- (UIView*)showAdView
{
    if (self.loadAdViewEnable)
    {
        [self.parentView addSubview:self.adviceView];
        return self.adviceView;
    }else
    {
        //视图正在创建中。。。
        return nil;
    }
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
    }else
    {
        if ([self.delegate respondsToSelector:@selector(quys_requestFial:error:)])
        {
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:kQuysNetworkParsingErrorCode userInfo:@{NSUnderlyingErrorKey:@"没有相关广告！"}];//TODO:全局替换报错文案
            [self.delegate quys_requestFial:self error:error];
        }
        
    }
}


- (void)requestFailed:(__kindof YTKBaseRequest *)request
{
    if ([self.delegate respondsToSelector:@selector(quys_requestFial:error:)])
    {
        [self.delegate quys_requestFial:self error:request.error];
    }
    
}




-(void)dealloc
{
    
}
@end
