//
//  NSDate+QuysFormat.m
//  quysAdvice
//
//  Created by wxhmbp on 2020/4/18.
//  Copyright © 2020年 Quys. All rights reserved.
//

#import "NSDate+QuysFormat.h"

@implementation NSDate (QuysFormat)
/**
  格式化时间
 
 @param date <#date description#>
 @return <#return value description#>
 */
+ (NSDate*)buildDate:(NSDate*)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return  [date  dateByAddingTimeInterval: interval];
}
@end
