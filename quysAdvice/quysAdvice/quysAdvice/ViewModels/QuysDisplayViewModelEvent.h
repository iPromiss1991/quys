//
//  NSObject+QuysViewModelEvent.h
//  quysAdvice
//
//  Created by quys on 2020/5/9.
//  Copyright © 2020 Quys. All rights reserved.
//

 

#import <Foundation/Foundation.h>
#import "QuysWebViewController.h"
#import "QuysAdviceModel.h"
#import "QuysAppDownUrlApi.h"
#import "QuysDownAddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QuysDisplayViewModelEvent : NSObject
///展示类广告处理
-(void)interstitialOnExposure:(CGRect)frame  adviceModel:(QuysAdviceModel*)adModel;

- (void)interstitialOnClick:(CGPoint)cpClick cpRe:(CGPoint)cpReClick presentViewController:(UIViewController*)presentVC adviceModel:(QuysAdviceModel*)adModel;


/// 更新宏替换键&值
/// @param replaceKey key
/// @param replaceVlue value
- (void)updateReplaceDictionary:(NSString*)replaceKey value:(NSString*)replaceVlue;
@end

NS_ASSUME_NONNULL_END
