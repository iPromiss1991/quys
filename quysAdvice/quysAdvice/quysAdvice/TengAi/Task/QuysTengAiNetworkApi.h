//
//  QuysTengAiNetworkApi.h
//  quysAdvice
//
//  Created by quys on 2020/4/10.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysBaseNetworkApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuysTengAiNetworkApi :QuysBaseNetworkApi
@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) NSString *bussinessKey;
@end

NS_ASSUME_NONNULL_END
