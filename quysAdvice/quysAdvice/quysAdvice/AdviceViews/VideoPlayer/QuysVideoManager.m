//
//  QuysVideoManager.m
//  quysAdvice
//
//  Created by wxhmbp on 2020/3/3.
//  Copyright © 2020年 Quys. All rights reserved.
//

#import "QuysVideoManager.h"
#import "QuysVideoContentView.h"
@interface QuysVideoManager()
@property (nonatomic, strong) QuysVideoContentView *contentView;//!< <#Explement #>

@end

@implementation QuysVideoManager

+ (instancetype)shareManager
{
    static QuysVideoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    return manager;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [QuysVideoManager shareManager] ;
}
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [QuysVideoManager shareManager] ;
}


- (UIView *)createPlayerView
{
    return self.contentView;
}


- (QuysVideoContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[QuysVideoContentView alloc] init];
    }return _contentView;
}


@end
