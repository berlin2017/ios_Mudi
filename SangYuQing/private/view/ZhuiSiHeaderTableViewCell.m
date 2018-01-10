//
//  ZhuiSiHeaderTableViewCell.m
//  SangYuQing
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZhuiSiHeaderTableViewCell.h"
#import "SZDetailModel.h"

@interface ZhuiSiHeaderTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *birthday_label;
@property (weak, nonatomic) IBOutlet UILabel *death_label;
@property (weak, nonatomic) IBOutlet UILabel *fangke_label;
@property (weak, nonatomic) IBOutlet UILabel *jidian_label;
@property (weak, nonatomic) IBOutlet UIImageView *photo_image;

@end

@implementation ZhuiSiHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _photo_image.layer.borderColor = [[UIColor whiteColor]CGColor];
    _photo_image.layer.borderWidth = 1;
    _photo_image.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configWithModel:(SZDetailModel*)model{
    _name_label.text = model.name;
    _birthday_label.text = [NSString stringWithFormat:@"生辰:%@",model.birthday];
    _death_label.text = [NSString stringWithFormat:@"祭辰:%@",model.death];
    _fangke_label.text = [NSString stringWithFormat:@"访客: %d人",model.fangke];
     _jidian_label.text = [NSString stringWithFormat:@"祭奠: %d人",model.jidian];
    [_photo_image sd_setImageWithURL:[NSURL URLWithString:model.image]];
}

@end
