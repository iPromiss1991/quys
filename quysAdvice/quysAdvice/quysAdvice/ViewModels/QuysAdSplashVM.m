//
//  QuysAdSplashVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdSplashVM.h"
#import "QuysAdviceModel.h"
#import "QuysReportApi.h"
@interface QuysAdSplashVM()
@property (nonatomic,strong) QuysAdviceModel *adModel;
@property (nonatomic,strong) NSMutableDictionary *dicMReplace;


@end


//TOOD：实现ViewModel 业务逻辑、以及数据格式化
//宏替换：建议以其他的方式实现共享
@implementation QuysAdSplashVM
- (instancetype)initWithModel:(QuysAdviceModel *)model
{
    if (self = [super init])
    {
        [self packingModel:model];
    }
    return self;
}

#pragma mark - PrivateMethod

- (void)packingModel:(QuysAdviceModel*)model
{
    self.adModel = model;
    [self updateReplaceDictionary:kResponeAdWidth value:kStringFormat(@"%ld",_adModel.width)];
    [self updateReplaceDictionary:kResponeAdHeight value:kStringFormat(@"%ld",_adModel.height)];

    self.strImgUrl = model.imgUrl;
}

- (NSString*)replaceSpecifiedString:(NSString*)strForReplace
{
    __block NSString *strTemp = strForReplace;
    [self.dicMReplace enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString *obj, BOOL * _Nonnull stop) {
        if ([strTemp containsString:key])
        {
          strTemp = [strTemp stringByReplacingOccurrencesOfString:key withString:obj];
        }
    }];
    return strTemp;
}



- (void)updateReplaceDictionary:(NSString *)replaceKey value:(NSString *)replaceVlue
{
    [self.dicMReplace setObject:replaceVlue forKey:replaceKey];
}


#pragma mark - QuysAdSplashDelegate

- (void)quys_interstitialOnClick:(CGPoint)cpClick
{
    kWeakSelf(self)
    [self.adModel.clkTracking enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //宏替换
        obj =  [weakself replaceSpecifiedString:obj];

        //发起网络请求
        QuysReportApi *api = [QuysReportApi new];
        api.strRequestUrl = obj;
        NSLog(@"发起请求:%@",obj);
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"请求成功！");
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
             NSLog(@"请求失败！");

        }];
    }];
    
}



- (NSMutableDictionary*)combineReplaceKeyAndValues
{
    
    NSMutableDictionary *dicM = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                 kResponeAdWidth,@"",
                                 kResponeAdHeight,@"",
                                 kRealAdWidth,@"",
                                 kRealAdHeight,@"",
                                 kClickInsideDownX,@"",
                                 kClickInsideDownY,@"",
                                 kClickUPX,@"",
                                 kClickUPY,@"",
                                 nil];
    return dicM;
}


-(NSMutableDictionary *)dicMReplace
{
    if (_dicMReplace == nil)
    {
      _dicMReplace = [self combineReplaceKeyAndValues];
    }
    return _dicMReplace;
}
@end
