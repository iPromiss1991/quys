//
//  QuysTaskNotifyModel.h
//  quysAdvice
//
//  Created by wxhmbp on 2020/4/18.
//  Copyright © 2020年 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,QuysTaskNotifyType) {
    QuysTaskNotifyType_HasData = 1,
    QuysTaskNotifyType_Exposure ,
    QuysTaskNotifyType_Click,
    QuysTaskNotifyType_Deeplink
};
NS_ASSUME_NONNULL_BEGIN


@interface QuysTaskNotifyModel : NSObject
@property (nonatomic, assign) QuysTaskNotifyType taskType;//!< Explement
@property (nonatomic, assign) BOOL requestStatus;//!< Y/N
@property (nonatomic, assign) NSDate *currentDate;//!< <#Explement #>
@end

NS_ASSUME_NONNULL_END
