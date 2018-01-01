//
//  PrivateTableViewCell.m
//  SangYuQing
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PrivateTableViewCell.h"

@implementation PrivateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // 画虚线
    // 创建一个imageView 高度是你想要的虚线的高度 一般设为2
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    UIImageView * _lineImg = [[UIImageView alloc] init];
//    [self.contentView addSubview:_lineImg];
//    [_lineImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.contentView);
//        make.right.mas_equalTo(self.contentView);
//        make.bottom.mas_equalTo(self.contentView);
//        make.height.height.mas_equalTo(2);
//    }];
//    // 调用方法 返回的iamge就是虚线
//    _lineImg.image = [self drawLineByImageView:_lineImg];
    // 添加到控制器的view上
    
}




// 返回虚线image的方法
- (UIImage *)drawLineByImageView:(UIImageView *)imageView{
    UIGraphicsBeginImageContext(imageView.frame.size); //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度 1是高度
    float lengths[] = {5,1};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithWhite:0.408 alpha:1.000].CGColor);
    CGContextSetLineDash(line, 0, 10, 2); //画虚线
    CGContextMoveToPoint(line, 0.0, 2.0); //开始画线
    CGContextAddLineToPoint(line, self.contentView.frame.size.width - 10, 2.0);
    
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
