//
//  QuysAdviceModel.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdviceModel.h"

@implementation QuysAdviceModel
//替换字符：
+ (NSDictionary *)modelCustomPropertyMapper
{
    return
  @{
        @"desc" : @"description"
    };
}
@end
