//
//  QuysUploadApiTaskManager.m
//  quysAdvice
//
//  Created by quys on 2019/12/16.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysUploadApiTaskManager.h"

static const NSInteger AsyncThreadCount = 20;//线程同步最大并发数
@interface QuysUploadApiTaskManager()
@property (nonatomic,strong) NSMutableArray <NSString*> *arrUrls;

@property (nonatomic,strong) NSConditionLock *conditionLock;

@property (nonatomic,strong) dispatch_queue_t productQueue;
@property (nonatomic,strong) dispatch_queue_t confumeQueue;


@end


@implementation QuysUploadApiTaskManager


+ (instancetype)shareManager
{
    static QuysUploadApiTaskManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
        manager.conditionLock = [[NSConditionLock alloc]initWithCondition:0];
        manager.productQueue = dispatch_queue_create("com.quys.adviceP", DISPATCH_QUEUE_CONCURRENT);
        manager.confumeQueue = dispatch_queue_create("com.quys.adviceC", DISPATCH_QUEUE_CONCURRENT);
    });
    return manager;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [QuysUploadApiTaskManager shareManager] ;
}
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [QuysUploadApiTaskManager shareManager] ;
}

- (void)addTaskUrls:(NSArray *)arrUrlArr
{
    kWeakSelf(self);
    dispatch_async(self.productQueue, ^{
        [weakself.conditionLock lockWhenCondition:0];
        [weakself.arrUrls addObjectsFromArray:arrUrlArr];
        [weakself.conditionLock unlockWithCondition:1];
    });
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         [weakself confumeUrls];
    });
}


- (void)confumeUrls
{
    kWeakSelf(self)

    dispatch_async(self.confumeQueue, ^{
        while (YES) {
            [self.conditionLock lockWhenCondition:1];
            [weakself.arrUrls enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //宏替换
                       obj =  [weakself replaceSpecifiedString:obj];
                       //发起网络请求
                       NSURL *requestUrl = [NSURL URLWithString:kStringFormat(@"%@",obj)];
                       NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
                       request.HTTPMethod = @"GET";
                       NSURLSessionConfiguration *config= [NSURLSessionConfiguration defaultSessionConfiguration];
                       NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
                       NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                           NSLog(@"上报请求完成:%@d\n",obj);
                       } ];
                       [task resume];
                       NSLog(@"上报请求:%@\n",obj);
            }];
            [weakself.arrUrls removeAllObjects];
            [weakself.conditionLock unlockWithCondition:0];
        }
    });
}


- (NSString*)replaceSpecifiedString:(NSString*)strForReplace
{
     
    return [[QuysAdviceManager shareManager] replaceSpecifiedString:strForReplace];
}


-(NSMutableArray<NSString *> *)arrUrls
{
    if (_arrUrls ==nil) {
        _arrUrls = [NSMutableArray new];
    }return _arrUrls;
}


@end
