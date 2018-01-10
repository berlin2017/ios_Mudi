//
//  ZhuiSiLiuYanTableViewCell.m
//  SangYuQing
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZhuiSiLiuYanTableViewCell.h"
#import "LiuYanModel.h"

@interface ZhuiSiLiuYanTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation ZhuiSiLiuYanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _photo.layer.cornerRadius = 15;
    _photo.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configWithModel:(LiuYanModel *)model{
    [_photo sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"ic_user"]];
    _name.text = model.name;
    _time.text = model.time;
    _content.text = model.content;
}

@end
