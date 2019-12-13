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
@property (nonatomic,strong) NSArray *arrMReplace;//!<需要“宏替换”的字符数组


+ (instancetype)shareManager;

@end

NS_ASSUME_NONNULL_END
