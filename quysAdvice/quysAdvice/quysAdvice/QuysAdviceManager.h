//
//  QuysAdviceManager.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysAdSplashService.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuysAdviceManager : NSObject

+ (instancetype)shareManager;



- (void)configSplashAdvice:(NSString*)businessID key:(NSString*)businessKey;

- (QuysAdSplash*)createSplashAdvice:(id <QuysAdSplashDelegate>)deleagte;

@end

NS_ASSUME_NONNULL_END
