//
//  QuysAdSplashVM.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdSplashVM.h"
#import "QuysAdviceModel.h"

@implementation QuysAdSplashVM
- (instancetype)initWithModel:(QuysAdviceModel *)model
{
    if (self = [super init])
    {
        [self packingModel:model];
    }
    return self;
}

- (void)packingModel:(QuysAdviceModel*)model
{
    self.strImgUrl = model.imgUrl;
}
@end
