//
//  UIViewController+QuysGetRootController.h
//  quysAdvice
//
//  Created by quys on 2019/12/24.
//  Copyright © 2019 Quys. All rights reserved.
//

 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (QuysGetRootController)

/// 找到最上层的控制器VC
/// @param windowClass 在哪一个window上查找
+ (UIViewController *)quys_findVisibleViewController:(id)windowClass;


/// 推出视图控制器
/// @param viewControllerToPresent 待推出的VC
/// @param flag 是否动画
/// @param completion 回调
- (void)quys_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
@end

NS_ASSUME_NONNULL_END
