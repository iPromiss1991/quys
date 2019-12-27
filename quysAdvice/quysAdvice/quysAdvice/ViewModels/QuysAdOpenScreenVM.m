//
//  QuysAdSplashVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdOpenScreenVM.h"
#import "QuysAdviceModel.h"
#import "QuysOpenScreenWindow.h"
#import "QuysFullScreenReplaceView.h"
#import "QuysNavigationController.h"
#import "QuysWebViewController.h"
#import "QuysPictureViewController.h"
#import "QuysAppDownUrlApi.h"
#import "QuysDownAddressModel.h"
@interface QuysAdOpenScreenVM()
@property (nonatomic,strong) QuysAdviceModel *adModel;
@property (nonatomic,weak) id <QuysAdSplashDelegate> delegate;
@property (nonatomic,assign) CGRect cgFrame;
@property (nonatomic,strong) UIView *adView;
@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) QuysAdOpenScreenService *service;

@end



@implementation QuysAdOpenScreenVM
- (instancetype)initWithModel:(QuysAdviceModel*)model delegate:(id<QuysAdSplashDelegate>)delegate frame:(CGRect)cgFrame  window:(UIWindow*)window
{
    if (self = [super init])
    {
        self.delegate = delegate;
        self.window = window;
        [self packingModel:model frame:cgFrame];
    }
    return self;
}


#pragma mark - PrivateMethod

- (void)packingModel:(QuysAdviceModel*)model frame:(CGRect)cgFrame
{
    self.adModel = model;
    self.cgFrame = cgFrame;
    [self updateReplaceDictionary:kResponeAdWidth value:kStringFormat(@"%ld",_adModel.width)];
    [self updateReplaceDictionary:kResponeAdHeight value:kStringFormat(@"%ld",_adModel.height)];
    [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",cgFrame.size.width)];
    [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",cgFrame.size.height)];
    self.strImgUrl = model.imgUrl;
}



- (void)updateReplaceDictionary:(NSString *)replaceKey value:(NSString *)replaceVlue
{
    [[[QuysAdviceManager shareManager] dicMReplace] setObject:replaceVlue forKey:replaceKey];
}

- (void)uploadServer:(NSArray*)uploadUrlArr
{
    [[QuysUploadApiTaskManager shareManager] addTaskUrls:uploadUrlArr];
}


#pragma mark - QuysAdSplashDelegate

- (UIView *)createAdviceView
{
    switch (self.adModel.creativeType) {
        case QuysAdviceCreativeTypeDefault:
        {
            kWeakSelf(self)
            QuysOpenScreenWindow *adView = [[QuysOpenScreenWindow alloc]initWithFrame:self.cgFrame viewModel:self];
            [adView hlj_setTrackTag:kStringFormat(@"%ld",[adView hash]) position:0 trackData:@{}];
            
           //点击事件
                adView.quysAdviceClickEventBlockItem = ^(CGPoint cp) {
                    [weakself interstitialOnClick:cp];
                    if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnClick:service:)])
                    {
                        [weakself.delegate quys_interstitialOnClick:cp service:(QuysAdBaseService*)weakself.service];
                    }
                };
                
                //关闭事件
                adView.quysAdviceCloseEventBlockItem = ^{
                    if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnAdClose:)])
                    {
                        [weakself.delegate quys_interstitialOnAdClose:(QuysAdBaseService*)weakself.service];
                    }
                };
                
                //曝光事件
                adView.quysAdviceStatisticalCallBackBlockItem = ^{
                    [weakself interstitialOnExposure];
                    if ([weakself.delegate respondsToSelector:@selector(quys_interstitialOnExposure:)])
                    {
                        [weakself.delegate quys_interstitialOnExposure:(QuysAdBaseService*)weakself.service];
                    }
                };
                self.adView = adView;
                return adView;
                
            }
            default:
                return nil;
                break;
            
    }
}


#pragma mark - Event

#pragma mark - QuysOpenScreenWindow

- (void)interstitialOnClick:(CGPoint)cpClick
{
    if (self.clickedAdvice)
    {
        NSString *strCpX = kStringFormat(@"%f",cpClick.x);
        NSString *strCpY = kStringFormat(@"%f",cpClick.y);
        //更新点击坐标
        [self updateReplaceDictionary:kClickInsideDownX value:strCpX];
        [self updateReplaceDictionary:kClickInsideDownY value:strCpY];
        
        [self updateReplaceDictionary:kClickUPX value:strCpX];
        [self updateReplaceDictionary:kClickUPY value:strCpY];
        self.adModel.statisticsModel.clicked = YES;
        [self uploadServer:self.adModel.clkTracking];
        
        if ([self.adView isMemberOfClass:[QuysOpenScreenWindow class]])
        {
            switch (self.adModel.ctype) {
                case QuysAdviceActiveTypeHtml:
                {
                    QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithHtml:self.adModel.htmStr];
                    QuysOpenScreenWindow *window = (QuysOpenScreenWindow*)self.adView;
                    QuysNavigationController *nav= (QuysNavigationController*)window.rootViewController;
                    [nav pushViewController:webVC animated:YES];                }
                    break;
                case QuysAdviceActiveTypeImageUrl:
                {
                    QuysPictureViewController *webVC = [[QuysPictureViewController alloc] initWithUrl:self.adModel.imgUrl];
                    QuysOpenScreenWindow *window = (QuysOpenScreenWindow*)self.adView;
                    QuysNavigationController *nav= (QuysNavigationController*)window.rootViewController;
                    [nav pushViewController:webVC animated:YES];
                }
                    break;
                case QuysAdviceActiveTypeWebURL:
                {
                    QuysWebViewController *webVC = [[QuysWebViewController alloc] initWithUrl:self.adModel.imgUrl];
                    QuysOpenScreenWindow *window = (QuysOpenScreenWindow*)self.adView;
                    QuysNavigationController *nav= (QuysNavigationController*)window.rootViewController;
                    [nav pushViewController:webVC animated:YES];
                }
                    break;
                case QuysAdviceActiveTypeDownAppAppstore:
                {
                    [self openUrl:self.adModel.downUrl];
                    
                }
                    break;
                case QuysAdviceActiveTypeDownAppWebUrl:
                {
                    [self getRealDownUrl:self.adModel.downUrl];
                }
                    break;
                default:
                    break;
            }
        }
    }else
    {
        
    }
}


- (void)openUrl:(NSString*)strUrl
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strUrl]];
    
}

- (void)getRealDownUrl:(NSString*)strWebUrl
{
    kWeakSelf(self)
    strWebUrl = [[QuysAdviceManager shareManager] replaceSpecifiedString:strWebUrl];
    QuysAppDownUrlApi *api = [QuysAppDownUrlApi new];
    api.downUrl = strWebUrl;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request)
    {
        if ( request.responseJSONObject[@"data"])
        {
            QuysDownAddressModel *model = [QuysDownAddressModel yy_modelWithJSON:request.responseJSONObject[@"data"]];
            if (!kISNullString(model.dstlink))
            {
                [weakself openUrl:model.dstlink];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

-(void)interstitialOnExposure
{
    if (self.exposuredAdvice)
    {
        [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%f",self.adView.frame.size.width)];
        [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%f",self.adView.frame.size.height)];
        [self uploadServer:self.adModel.impTracking];
        self.adModel.statisticsModel.exposured = YES;
    }else
    {
    }
}


- (void)removeBackgroundImageView
{
    for (id  subObj in [UIApplication sharedApplication].delegate.window.subviews)
    {
        if ([subObj isKindOfClass:[QuysFullScreenReplaceView class]])
        {
            [subObj removeFromSuperview];
        }
    }
}

- (void)validateWindow
{
    self.adView.hidden = YES;
    self.adView = nil;
}

- (NSInteger)showDuration
{
    return self.adModel.showDuration <= 0?5:self.adModel.showDuration;
}


-(BOOL)clickedAdvice
{
    if (self.adModel.statisticsModel.clicked)
    {
        if (self.adModel.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}

-(BOOL)exposuredAdvice
{
    if (self.adModel.statisticsModel.exposured)
    {
        if (self.adModel.isReportRepeatAble)
        {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return YES;
    }
}


- (void)dealloc
{
    
}


@end
