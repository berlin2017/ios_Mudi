//
//  PrivateTableViewCell.h
//  SangYuQing
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MuDIModel;

@interface PrivateTableViewCell : UITableViewCell

-(void)configWithModel:(MuDIModel*)model;
@end
