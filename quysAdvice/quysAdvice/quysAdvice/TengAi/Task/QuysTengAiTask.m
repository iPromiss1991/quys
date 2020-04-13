//
//  QuysTengAiTask.m
//  quysAdvice
//
//  Created by quys on 2020/4/10.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysTengAiTask.h"
#import "QuysTengAiNetworkApi.h"
#import "QuysAdviceOuterlayerDataModel.h"
@interface QuysTengAiTask()
@property (nonatomic,strong) QuysTengAiNetworkApi *api;
@property (nonatomic,strong) NSMutableDictionary *dicMReplace;//!<需要“宏替换”的字符数组



@end


@implementation QuysTengAiTask


- (instancetype)init
{
    if (self == [super init])
    {
        [self config];
    }return self;
}

- (void)config
{
    //TODO:构建请求api参数
    QuysTengAiNetworkApi *api = [[QuysTengAiNetworkApi alloc]init];
    self.api = api;
    
}

- (void)start

{
    self.api.businessID = self.businessID;
    self.api.bussinessKey = self.bussinessKey;
    NSLog(@"\n\n获取广告数据开始\n");

    [self.api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
             {
                 QuysAdviceOuterlayerDataModel *outerModel = [QuysAdviceOuterlayerDataModel yy_modelWithJSON:request.responseJSONObject];
                 if (outerModel && outerModel.data.count)
                 {
                     QuysAdviceModel *adviceModel = outerModel.data[0];
                     [self upload:adviceModel];

                 }
                 NSLog(@"\n\n获取广告数据结束：%@\n",[outerModel yy_modelToJSONObject]);

                 //TODO：测试
                 [self upload:[QuysAdviceModel new]];

             }
        });
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"\n请求数据错误：<<<%@\n",request.error);
    }];
  

    NSLog(@"\n\n上报开始\n");

}

- (void)upload:(QuysAdviceModel*)model
{
    if (self.uploadEnable)
    {
        {
            //TODO：上报事件
            //1、曝光：impTracking
            //2、点击：impTracking
            //3、视频播放开始：videoStart
            //4、视频播放结束：videoSuccess
            
            
            //TODO：上报事件参数构造
            NSLog(@"\n\n上报开始\n");
            if (model.impTracking.count)
            {
                [self updateReplaceDictionary:kClientTimeStamp value:[NSDate quys_getNowTimeTimestamp]];

                NSInteger width = [[NSString stringWithFormat:@"%lf",CGRectGetWidth([UIScreen mainScreen].bounds) ] integerValue];
                NSInteger height = [[NSString stringWithFormat:@"%lf",CGRectGetHeight([UIScreen mainScreen].bounds) ] integerValue];
                
                [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%ld",arc4random()%width)];
                [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%ld",arc4random()%height)];
             [self uploadUrl:model.impTracking];
                
            }
            
            
            if (model.clkTracking.count)
            {
                NSInteger pointX = [[NSString stringWithFormat:@"%lf",CGRectGetWidth([UIScreen mainScreen].bounds) ] integerValue];
                NSInteger pointY = [[NSString stringWithFormat:@"%lf",CGRectGetHeight([UIScreen mainScreen].bounds) ] integerValue];
                
                CGPoint cpClick = CGPointMake(arc4random()%pointX, arc4random()%pointY);
                CGPoint cpReClick = cpClick;
                
                NSString *strCpX = kStringFormat(@"%f",cpClick.x);
                NSString *strCpY = kStringFormat(@"%f",cpClick.y);
                
                NSString *strReCpX = kStringFormat(@"%f",cpReClick.x);
                NSString *strReCpY = kStringFormat(@"%f",cpReClick.y);
                
                //更新点击坐标
                [self updateReplaceDictionary:kClickInsideDownX value:strCpX];
                [self updateReplaceDictionary:kClickInsideDownY value:strCpY];
                
                [self updateReplaceDictionary:kClickUPX value:strCpX];
                [self updateReplaceDictionary:kClickUPY value:strCpY];
                //
                [self updateReplaceDictionary:k_RE_DOWN_X value:strReCpX];
                [self updateReplaceDictionary:k_RE_DOWN_Y value:strReCpY];
                
                [self updateReplaceDictionary:k_RE_UP_X value:strReCpX];
                [self updateReplaceDictionary:k_RE_UP_Y value:strReCpY];
                [self updateReplaceDictionary:kClientTimeStamp value:[NSDate quys_getNowTimeTimestamp]];
                
               [self uploadUrl:model.clkTracking];
                
            }
            
            
            if (model.videoStart.count)
               {
                   NSInteger width = [[NSString stringWithFormat:@"%lf",CGRectGetWidth([UIScreen mainScreen].bounds) ] integerValue];
                   NSInteger height = [[NSString stringWithFormat:@"%lf",CGRectGetHeight([UIScreen mainScreen].bounds) ] integerValue];
                   
                   [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%ld",arc4random()%width)];
                   [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%ld",arc4random()%height)];
                  [self uploadUrl:model.videoStart];
                   
               }
            
            if (model.videoSuccess.count)
               {
                   NSInteger width = [[NSString stringWithFormat:@"%lf",CGRectGetWidth([UIScreen mainScreen].bounds) ] integerValue];
                   NSInteger height = [[NSString stringWithFormat:@"%lf",CGRectGetHeight([UIScreen mainScreen].bounds) ] integerValue];
                   
                   [self updateReplaceDictionary:kRealAdWidth value:kStringFormat(@"%ld",arc4random()%width)];
                   [self updateReplaceDictionary:kRealAdHeight value:kStringFormat(@"%ld",arc4random()%height)];
                   [self uploadUrl:model.videoSuccess];
               }
            
            //
            
            
            //上报结束
            NSLog(@"\n\n上报结束\n");

            
            
        }
    }
}


#pragma mark - Help


- (void)uploadUrl:(NSArray *)arrUrlArr
{
    [arrUrlArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //宏替换
        obj =  [[QuysAdviceManager shareManager] replaceSpecifiedString:obj];
        //发起网络请求
        NSURL *requestUrl = [NSURL URLWithString:kStringFormat(@"%@",obj)];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
        request.HTTPMethod = @"POST";
        //设置请求头(可选, 在必要时添加)
        NSString *strUserAgent = [[QuysAdviceManager shareManager] strUserAgent];
        if (!kISNullString(strUserAgent))
        {
             [request setValue:strUserAgent forHTTPHeaderField: @"User-Agent"];
        }
        NSURLSessionConfiguration *config= [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        NSLog(@"\n上报请求完成:%@d\n",obj);
        }];
        
        [task resume];
        NSLog(@"\n上报请求:%@\n",obj);
    }];
}

- (void)updateReplaceDictionary:(NSString *)replaceKey value:(NSString *)replaceVlue
{
    [self.dicMReplace setObject:replaceVlue forKey:replaceKey];
}



- (NSString*)replaceSpecifiedString:(NSString*)strForReplace
{
    __block NSString *strTemp = strForReplace;
    [[self dicMReplace] setObject:[NSDate quys_getNowTimeTimestamp] forKey:kClientTimeStamp];
    [[self dicMReplace] setObject:[NSDate quys_getNowTimeSecond] forKey:kEVENT_TIME];
    [[self dicMReplace] setObject:[NSDate quys_getNowTimeTimestamp] forKey:kMILI_MISECONDS];
    //
    [[self dicMReplace] enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString *obj, BOOL * _Nonnull stop) {
        if ([strTemp containsString:key])
        {
            strTemp = [strTemp stringByReplacingOccurrencesOfString:key withString:obj];
        }
    }];
    return strTemp;
}



#pragma mark - Init


-(NSMutableDictionary *)dicMReplace
{
    if (_dicMReplace == nil)
    {
        _dicMReplace = [self combineReplaceKeyAndValues];
    }
    return _dicMReplace;
}

- (NSMutableDictionary*)combineReplaceKeyAndValues
{
    
    NSMutableDictionary *dicM = [[NSMutableDictionary alloc]initWithDictionary:@{
        kResponeAdWidth:@"",
        kResponeAdHeight:@"",
        kRealAdWidth:@"",
        kRealAdHeight:@"",
        kClickInsideDownX:@"",
        kClickInsideDownY:@"",
        kClickUPX:@"",
        kClickUPY:@"",
        kVideoScene:@"1",
        kLATITUDE:@"-999",
        kLONGITUDE:@"-999",
        kLAT:@"-999",
        kLON:@"-999"
    }];
    return dicM;
}


- (void)dealloc
{
    NSLog(@"\n\n<<<%s\n\n",__PRETTY_FUNCTION__);
}
@end
