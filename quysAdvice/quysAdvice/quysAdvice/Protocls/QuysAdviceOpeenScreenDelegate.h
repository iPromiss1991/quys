
//
//  QuysAdviceOpeenScreenDelegate.h
//  quysAdvice
//
//  Created by quys on 2019/12/31.
//  Copyright © 2019 Quys. All rights reserved.
//

#import "QuysAdviceBaseDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QuysAdviceOpeenScreenDelegate <QuysAdviceBaseDelegate>

- (void)quys_videoPlaystart:(QuysAdBaseService*)service;

- (void)quys_videoPlayEnd:(QuysAdBaseService*)service;
@end

NS_ASSUME_NONNULL_END
