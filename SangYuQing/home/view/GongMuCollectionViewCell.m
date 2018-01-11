//
//  GongMuCollectionViewCell.m
//  SangYuQing
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "GongMuCollectionViewCell.h"
#import "MuDIModel.h"

@interface GongMuCollectionViewCell(){
    
    __weak IBOutlet UILabel *likeview;
    __weak IBOutlet UILabel *lookview;
    __weak IBOutlet UILabel *dateview;
    __weak IBOutlet UIImageView *imageview;
    __weak IBOutlet UILabel *nameview;
}
@end

@implementation GongMuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configWithModel:(MuDIModel*)model{
    [imageview sd_setImageWithURL:[NSURL URLWithString:model.sz_avatar]];
    nameview.text = model.sz_name;
    likeview.text = [NSString stringWithFormat:@"%zd",model.total_follow];
    lookview.text = [NSString stringWithFormat:@"%@",model.liulan_count];
    dateview.text = [NSString stringWithFormat:@"%@-%@",model.birthdate,model.deathdate];
}
@end
