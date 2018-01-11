//
//  GiftCollectionViewCell.m
//  SangYuQing
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GiftCollectionViewCell.h"
#import "GiftModel.h"

@interface GiftCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *name_label;

@property (weak, nonatomic) IBOutlet UILabel *jifen_label;

@end

@implementation GiftCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.borderColor = [UIColor colorWithHexString:@"CD853F"].CGColor;
}

-(void)configWithModel:(GiftModel*)model{
    [_imageview sd_setImageWithURL:[NSURL URLWithString:model.image]];
    _name_label.text = model.name;
    _jifen_label.text = model.jifen;
    _time_label.text = model.time;
}

@end
