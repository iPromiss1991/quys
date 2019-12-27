//
//  QuysWebViewController.h
//  quysAdvice
//
//  Created by quys on 2019/12/24.
//  Copyright © 2019 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///webview
@interface QuysWebViewController : UIViewController

- (instancetype)initWithUrl:(NSString *)requestUrl;

- (instancetype)initWithHtml:(NSString *)html;
@end

NS_ASSUME_NONNULL_END
