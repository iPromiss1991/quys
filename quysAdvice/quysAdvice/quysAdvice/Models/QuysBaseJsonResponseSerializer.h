//
//  QuysJsonResponseSerializer.h
//  quysAdvice
//
//  Created by quys on 2019/12/12.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///数据模型解析基类
@interface QuysBaseJsonResponseSerializer : NSObject
- (id)QuysJsonResponseSerializer:(id)jsonResponse;
@end

NS_ASSUME_NONNULL_END
