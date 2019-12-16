//
//  QuysUploadStatisticsModel.h
//  quysAdvice
//
//  Created by quys on 2019/12/16.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///上报统计模型
@interface QuysUploadStatisticsModel : NSObject
@property (nonatomic,assign) BOOL exposured;//!<是否已经曝光
@property (nonatomic,assign) BOOL clicked;//!<是否已经点击
@property (nonatomic,assign) BOOL beginDownload;//!<是否开始下载


@end

NS_ASSUME_NONNULL_END
