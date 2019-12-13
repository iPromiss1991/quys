//
//  QuysAdviceManager.m
//  quysAdvice
//
//  Created by quys on 2019/12/9.
//  Copyright © 2019 Quys. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "QuysAdviceManager.h"
#import "QuysAdviceConfigModel.h"

@interface QuysAdviceManager()

@property (nonatomic,strong) NSMapTable *mapTable;


@end


@implementation QuysAdviceManager

+ (instancetype)shareManager
{
    static QuysAdviceManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    return manager;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [QuysAdviceManager shareManager] ;
}
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [QuysAdviceManager shareManager] ;
}





#pragma mark - PrivateMethod


- (NSMapTable *)mapTable
{
    if (_mapTable == nil) {
        _mapTable = [[NSMapTable alloc] initWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableStrongMemory capacity:6];
    }
    return _mapTable;
}

-(NSArray *)arrMReplace
{
    if (_arrMReplace == nil)
    {
      _arrMReplace = @[
            @"__REQ_WIDTH__",
            @"__REQ_HEIGHT__",
            @"__WIDTH__",
            @"__HEIGHT__",
            @"__DOWN_X__",
            @"__DOWN_Y__",
            @"__UP_X__",
            @"__UP_Y__"
        ];
        
    }return _arrMReplace;
}
@end
