//
//  ZhuiSiJiWenTableViewCell.m
//  SangYuQing
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZhuiSiJiWenTableViewCell.h"
#import "JiWenModel.h"

@interface ZhuiSiJiWenTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *count_label;
@property (weak, nonatomic) IBOutlet UILabel *content_label;

@end

@implementation ZhuiSiJiWenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_time_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.centerX);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configWithModel:(JiWenModel *)model{
    _titleLabel.text = model.title;
    _time_label.text = model.time;
    _content_label.text = model.content;
    _count_label.text = [NSString stringWithFormat:@"阅读:%d",model.count];
    _name_label.text = model.name;
}

@end
