//
//  NSURLSessionDataTask+Redirect.h
//  quysAdvice
//
//  Created by quys on 2020/5/9.
//  Copyright © 2020 Quys. All rights reserved.
//

 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLSessionDataTask (Redirect)

- (void)redirectToAppStore:(NSString*)redirectUrl  callBack:(void(^)(NSString* strAppstoreUrl))callBackBlock;
@end

NS_ASSUME_NONNULL_END

