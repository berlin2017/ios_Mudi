//
//  UserScoreCollectionViewCell.m
//  SangYuQing
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UserScoreCollectionViewCell.h"

@implementation UserScoreCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentView.layer.masksToBounds = YES;
}

-(void)setBackColor:(UIColor*)color{
     self.contentView.layer.backgroundColor = color.CGColor;
}

@end
