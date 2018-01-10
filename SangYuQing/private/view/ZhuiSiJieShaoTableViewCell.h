//
//  ZhuiSiJieShaoTableViewCell.h
//  SangYuQing
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZDetailModel.h"

@protocol ZhuiSiJieShaoTableViewCellDelegate <NSObject>

@optional
-(void)reloadDataWithType:(int)type;
@end

@interface ZhuiSiJieShaoTableViewCell : UITableViewCell

-(void)configWithModel:(SZDetailModel*)model;
-(void)configWithModel:(SZDetailModel*)model type:(int)type;

@property(nonatomic,weak)id<ZhuiSiJieShaoTableViewCellDelegate>delegate;
@end
