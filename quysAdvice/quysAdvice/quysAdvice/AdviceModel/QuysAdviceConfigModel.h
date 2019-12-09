//
//  QuysAdviceConfigModel.h
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuysAdviceConfigModel : NSObject
@property (nonatomic,strong) NSString *businessID;//!< 广告ID
@property (nonatomic,strong) NSString *businessKey;//!< 广告Key

- (instancetype)initWithID:(NSString*)businessID key:(NSString*)businessKey;


@end

NS_ASSUME_NONNULL_END
