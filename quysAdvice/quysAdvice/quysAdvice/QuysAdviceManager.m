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

- (NSMutableDictionary*)combineReplaceKeyAndValues
{
    
    NSMutableDictionary *dicM = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                 kResponeAdWidth,@"",
                                 kResponeAdHeight,@"",
                                 kRealAdWidth,@"",
                                 kRealAdHeight,@"",
                                 kClickInsideDownX,@"",
                                 kClickInsideDownY,@"",
                                 kClickUPX,@"",
                                 kClickUPY,@"",
                                 nil];
    return dicM;
}


-(NSMutableDictionary *)dicMReplace
{
    if (_dicMReplace == nil)
    {
      _dicMReplace = [self combineReplaceKeyAndValues];
    }
    return _dicMReplace;
}
@end
