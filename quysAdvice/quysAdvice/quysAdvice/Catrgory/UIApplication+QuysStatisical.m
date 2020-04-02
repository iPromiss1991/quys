
//
//  UIApplication+QuysStatisical.m
//  quysAdvice
//
//  Created by quys on 2020/4/2.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "UIApplication+QuysStatisical.h"



@implementation UIApplication (QuysStatisical)
+(void)load
{
    
    SEL sendEventSel = @selector(sendEvent:);
    SEL quys_sendEventSel = @selector(quys_sendEvent:);
    [self exChanageMethodSystemSel:sendEventSel swizzSel:quys_sendEventSel];
}

+ (void)exChanageMethodSystemSel:(SEL)systemSel swizzSel:(SEL)swizzSel{
    //两个方法的Method
    Method systemMethod = class_getInstanceMethod([self class], systemSel);
    Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
    //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
    BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
    if (isAdd) {
        //如果成功，说明类中不存在这个方法的实现
        //将被交换方法的实现替换到这个并不存在的实现
        class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        //否则，交换两个方法的实现
        method_exchangeImplementations(systemMethod, swizzMethod);
    }
}

- (void)quys_sendEvent:(UIEvent*)event
{
    
    if (event.type==UIEventTypeTouches)
    {
        UITouch *touch = [event.allTouches anyObject];
        
        if (touch.phase == UITouchPhaseBegan)
        {
            UITouch *touch = [event.allTouches anyObject];
            CGPoint locationPointView = [touch locationInView:touch.view];
            CGPoint locationPointWindow = [touch locationInView:touch.window];
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:[NSDate quys_getNowTimeTimestamp] forKey:kCLICK_TIME_START];
            
            //展示广告
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%6f",locationPointView.x) forKey:k_RE_DOWN_X];
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%6f",locationPointView.y) forKey:k_RE_DOWN_Y];
            
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%6f",locationPointWindow.x) forKey:kClickInsideDownX];
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%6f",locationPointWindow.y) forKey:kClickInsideDownY];
            //激励视频
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%6f",locationPointWindow.x) forKey:kCLICK_DOWN_X];
            [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%6f",locationPointWindow.y) forKey:kCLICK_DOWN_Y];
            
        }
        
        if (touch.phase == UITouchPhaseMoved)
        {
            
        }
        
        if (touch.phase == UITouchPhaseEnded)
        {
            if (event.allTouches.count == 1)
            {
                UITouch *touch = [event.allTouches anyObject];
                CGPoint locationPointView = [touch locationInView:touch.view];
                CGPoint locationPointWindow = [touch locationInView:touch.window];
                [[[QuysAdviceManager shareManager] dicMReplace] setObject:[NSDate quys_getNowTimeTimestamp] forKey:kCLICK_TIME_END];
                
                //展示广告
                [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%6f",locationPointView.x) forKey:k_RE_UP_X];
                [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%6f",locationPointView.y) forKey:k_RE_UP_Y];
                
                [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%6f",locationPointWindow.x) forKey:kClickUPX];
                [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%6f",locationPointWindow.y) forKey:kClickUPY];
                //激励视频
                [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%6f",locationPointWindow.x) forKey:kCLICK_UP_X];
                [[[QuysAdviceManager shareManager] dicMReplace] setObject:kStringFormat(@"%6f",locationPointWindow.y) forKey:kCLICK_UP_Y];
            }
        }
    }
    
    [self quys_sendEvent:event];
}



@end
