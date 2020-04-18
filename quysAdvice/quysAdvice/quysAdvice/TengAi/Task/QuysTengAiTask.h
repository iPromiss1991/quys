//
//  QuysTengAiTask.h
//  quysAdvice
//
//  Created by quys on 2020/4/10.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

 #define kQuysTengAiRealTaskNotifyKey @"kQuysTengAiRealTaskNotifyKey"//!<广告进度


NS_ASSUME_NONNULL_BEGIN

@interface QuysTengAiTask : NSObject

@property (nonatomic,strong) NSString *businessID;
@property (nonatomic,strong) NSString *bussinessKey;




@property (nonatomic,assign) float exposureRate;//!<  曝光率
@property (nonatomic,assign) float clickRate;//!<  点击率
@property (nonatomic,assign) float deeplinkRate;//!<  deeplink率


@property (nonatomic, strong) NSString *postNotifyName;//!< <#Explement #>

 - (void)start;

@end

NS_ASSUME_NONNULL_END
