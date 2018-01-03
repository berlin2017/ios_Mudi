//
//  HomeNavCollectionViewCell.m
//  SangYuQing
//
//  Created by mac on 2017/12/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeNavCollectionViewCell.h"

@interface HomeNavCollectionViewCell(){
    
}
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *label;
@end

@implementation HomeNavCollectionViewCell



-(void)configWithMode{
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).mas_offset(5);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    _label = [[UILabel alloc]init];
    [self.contentView addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageView.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.contentView);
    }];
    _label.font = [UIFont systemFontOfSize:14];
    
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514450989988&di=b9d2b71adc10306f918cc5ff3db4ebae&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01e4a1564da3d76ac7251c94308050.png%401280w_1l_2o_100sh.png"]];
    _imageView.image = [UIImage imageNamed:@"ic_siren_light"];
    _label.text = @"私人墓园";
}

@end
