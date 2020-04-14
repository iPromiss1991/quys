//
//  QuysTengAiTask.h
//  quysAdvice
//
//  Created by quys on 2020/4/10.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuysTengAiTask : NSObject

@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) NSString *bussinessKey;


@property (nonatomic,assign) BOOL exposureEnable;


@property (nonatomic,assign) float clickRate;//!<  曝光率
@property (nonatomic,assign) BOOL clickEnable;
- (void)start;

@end

NS_ASSUME_NONNULL_END
