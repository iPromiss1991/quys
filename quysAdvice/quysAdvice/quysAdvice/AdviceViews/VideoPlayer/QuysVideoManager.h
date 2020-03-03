//
//  QuysVideoManager.h
//  quysAdvice
//
//  Created by wxhmbp on 2020/3/3.
//  Copyright © 2020年 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuysVideoManager : NSObject

- (UIView*)createPlayerView;

- (void)quys_play;

- (void)quys_resume;

- (void)quys_suspend;

@end

NS_ASSUME_NONNULL_END
