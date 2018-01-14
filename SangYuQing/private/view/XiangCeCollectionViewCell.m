//
//  XiangCeCollectionViewCell.m
//  SangYuQing
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XiangCeCollectionViewCell.h"
#import "PhotoItem.h"

@interface XiangCeCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *xiangce_imageview;
@property (weak, nonatomic) IBOutlet UILabel *xiangce_name;

@end
@implementation XiangCeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

-(void)configWithModel:(PhotoItem*)model{
    _xiangce_name.text = model.name;
    [_xiangce_imageview sd_setImageWithURL:[NSURL URLWithString:model.image]];
}

@end
