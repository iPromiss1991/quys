//
//  UIViewController+QuysGetRootController.m
//  quysAdvice
//
//  Created by quys on 2019/12/24.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "UIViewController+QuysGetRootController.h"

 

@implementation UIViewController (QuysGetRootController)



+ (UIViewController *)quys_findVisibleViewController:(id)windowClass
{
    UIViewController *frontUIViewController = nil;
    UIWindow *defaultWindow = [[UIApplication sharedApplication] keyWindow];
    NSArray *windows = [[UIApplication sharedApplication] windows];
           for(UIWindow *tmpWin in windows)
           {
               if ([tmpWin isKindOfClass:[windowClass class]] )
               {
                   defaultWindow = tmpWin;
                   break;
               }
           }
    if (defaultWindow && [[defaultWindow subviews] count] > 0)
    {
        UIView *frontView = [[defaultWindow subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            frontUIViewController = nextResponder;
        } else
        {
            frontUIViewController = defaultWindow.rootViewController;
        }
        if (frontUIViewController)
        {
            frontUIViewController = [self topDisplayViewController:frontUIViewController];
            while (frontUIViewController && frontUIViewController.presentedViewController)
            {
                frontUIViewController = [self topDisplayViewController:frontUIViewController.presentedViewController];
            }
        }
    }
    return frontUIViewController;
    
}
 
+ (UIViewController *)topDisplayViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]])
    {
        return [self topDisplayViewController:[(UINavigationController *)viewController topViewController]];
    } else if ([viewController isKindOfClass:[UITabBarController class]])
    {
        return [self topDisplayViewController:[(UITabBarController *)viewController selectedViewController]];
    } else
    {
        return viewController;
    }
    return nil;
}


@end
