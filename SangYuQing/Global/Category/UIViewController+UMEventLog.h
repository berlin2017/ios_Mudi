//
//  UIViewController+UMEventLog.h
//  AOPLog
//
//  Created by History on 15/9/9.
//  Copyright © 2015年 history. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (UMEventLog)
/**
 *  PV统计
 *  如果页面需要进行PV统计,设置`eventName`
 */
@property (copy, nonatomic) NSString *eventName;

@end
