//
//  QuysAdviceConfigModel.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdviceConfigModel.h"

@implementation QuysAdviceConfigModel

- (instancetype)initWithID:(NSString *)businessID key:(NSString *)businessKey
{
    if (self = [super init])
    {
        self.businessID = businessID;
        self.businessKey = businessKey;
    }
    return self;
}
@end
