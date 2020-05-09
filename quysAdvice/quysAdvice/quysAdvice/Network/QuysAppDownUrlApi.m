//
//  QuysAppDownUrlApi.m
//  quysAdvice
//
//  Created by quys on 2019/12/24.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAppDownUrlApi.h"

@implementation QuysAppDownUrlApi

-(NSString *)requestUrl
{
    return self.downUrl;
}

-(YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}


-(YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}


-(YTKResponseSerializerType)responseSerializerType
{
    return YTKResponseSerializerTypeHTTP;
}
@end
