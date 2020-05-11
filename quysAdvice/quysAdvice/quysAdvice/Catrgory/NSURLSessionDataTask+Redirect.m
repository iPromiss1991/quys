//
//  NSURLSessionDataTask+Redirect.m
//  quysAdvice
//
//  Created by quys on 2020/5/9.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "NSURLSessionDataTask+Redirect.h"

@interface NSURLSessionDataTask()<NSURLSessionTaskDelegate>

@end

@implementation NSURLSessionDataTask (Redirect)
- (void)redirectToAppStore:(NSString*)redirectUrl  callBack:(void(^)(NSString* strAppstoreUrl))callBackBlock
{
    if ([redirectUrl containsString:@"itms-apps"] || [redirectUrl containsString:@"itms://"])//1、itms-appss://    2、itms-apps://
    {
        callBackBlock(redirectUrl);
    }else
    {
        NSURL *url = [NSURL URLWithString:redirectUrl];//http://suo.im/6dKUUu
        NSMutableURLRequest *quest = [NSMutableURLRequest requestWithURL:url];
        quest.HTTPMethod = @"GET";

        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue currentQueue]];
        NSURLSessionDataTask *task = [urlSession dataTaskWithRequest:quest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;

                                             NSLog(@"statusCode: %ld", urlResponse.statusCode);
                                             NSLog(@"allHeaderFields:\n%@", urlResponse.allHeaderFields);//x-apple-orig-url
            if (callBackBlock)
            {
                callBackBlock(urlResponse.URL.absoluteString);
            }
                                         }];
        [task resume];
    }
}

 
#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * __nullable))completionHandler
{
    NSLog(@"statusCode: %ld", response.statusCode);
    NSDictionary *headers = response.allHeaderFields;
    NSLog(@"%@", headers);
    NSLog(@"redirect   url: %@", headers[@"Location"]); // 重定向的地址，如：http://www.jd.com
    NSLog(@"newRequest url: %@", [request URL]);        // 重定向的地址，如：http://www.jd.com
    NSLog(@"redirect response url: %@", [response URL]);// 触发重定向请求的地址，如：http://www.360buy.com
/*
 方式一：
 https://apps.apple.com/cn/app/中国银行手机银行/id399608199
 https://itunes.apple.com/us/app/yao-ba/id1062767832?l=zh&ls=1&mt=8
 2020-05-09 10:36:09.215039+0800 趣[10150:2916613] redirect   url: https://apps.apple.com/cn/app/id930368978?930368978
 2020-05-09 10:36:09.215395+0800 趣[10150:2916613] newRequest url: https://apps.apple.com/cn/app/id930368978?930368978
 2020-05-09 10:36:09.245687+0800 趣[10150:2916613] redirect response url: http://suo.im/6dKUUu
 
 
 方式二：
 itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=399608199
 */
    completionHandler(request);
//    completionHandler(nil);// 参数为nil，表示拦截（禁止）重定向
}
@end
