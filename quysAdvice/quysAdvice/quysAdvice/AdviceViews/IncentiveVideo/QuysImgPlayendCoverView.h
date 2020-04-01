//
//  QuysImgPlayendCoverView.h
//  quysAdvice
//
//  Created by quys on 2020/1/3.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface QuysImgPlayendCoverView : UIView
@property (nonatomic,copy) QuysAdviceCloseEventBlock quysAdviceCloseEventBlockItem;
@property (nonatomic,copy) QuysAdviceClickEventBlock quysAdviceClickEventBlockItem;
@property (nonatomic,copy) QuysAdviceStatisticalCallBackBlock quysAdviceStatisticalCallBackBlockItem;


@property (nonatomic,strong) NSString *strImageUrl;

@end

NS_ASSUME_NONNULL_END
