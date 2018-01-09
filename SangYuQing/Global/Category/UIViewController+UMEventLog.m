//
//  UIViewController+UMEventLog.m
//  AOPLog
//
//  Created by History on 15/9/9.
//  Copyright © 2015年 history. All rights reserved.
//

#import "UIViewController+UMEventLog.h"
#import <objc/runtime.h>
#import "HZSwizzling.h"

static char eventNameKey;

@implementation UIViewController (UMEventLog)
#pragma mark - Swizzling Function
- (void)swizzling_viewWillAppear:(BOOL)animated
{
    [self swizzling_viewWillAppear:animated];
    
    // Logging
    if (self.eventName) {
        [MobClick beginLogPageView:self.eventName];
        HZLog(@"%@ - %@", NSStringFromSelector(_cmd), self.eventName);
    }
}
- (void)swizzling_viewWillDisappear:(BOOL)animated
{
    [self swizzling_viewWillDisappear:animated];
    
    // Logging
    if (self.eventName) {
        [MobClick endLogPageView:self.eventName];
        HZLog(@"%@ - %@", NSStringFromSelector(_cmd), self.eventName);
    }
}


+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwizzlingMethod([self class], @selector(viewWillAppear:), @selector(swizzling_viewWillAppear:));
        SwizzlingMethod([self class], @selector(viewWillDisappear:), @selector(swizzling_viewWillDisappear:));
    });
}

#pragma mark - Private Function
- (void)popBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dismissBackAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter & Setter
- (void)setEventName:(NSString *)eventName
{
    objc_setAssociatedObject(self, &eventNameKey, eventName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)eventName
{
    return objc_getAssociatedObject(self, &eventNameKey);
}


@end
