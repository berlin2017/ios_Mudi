//
//  HomeNewCollectionViewCell.m
//  SangYuQing
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeNewCollectionViewCell.h"
@interface HomeNewCollectionViewCell(){
    
    __weak IBOutlet UIImageView *imageview;
    __weak IBOutlet UILabel *nameview;
}
@end

@implementation HomeNewCollectionViewCell

-(void)configWithModel{
    [imageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514450989988&di=b9d2b71adc10306f918cc5ff3db4ebae&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01e4a1564da3d76ac7251c94308050.png%401280w_1l_2o_100sh.png"]];
    nameview.text = @"张三";
}

@end
