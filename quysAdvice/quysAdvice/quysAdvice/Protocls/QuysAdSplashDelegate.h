//
//  QuysAdSplashDelegate.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdviceBaseDelegate.h"

NS_ASSUME_NONNULL_BEGIN
///插屏协议
@protocol QuysAdSplashDelegate <QuysAdviceBaseDelegate>

@optional
- (void)quys_requestStart;

- (void)quys_requestSuccess;

- (void)quys_requestFial:(NSError*)error;

- (void)quys_interstitialOnExposure;

- (void)quys_interstitialOnClick;

- (void)quys_interstitialOnAdClose;

@end

NS_ASSUME_NONNULL_END
