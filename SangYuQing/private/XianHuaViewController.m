//
//  XianHuaViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XianHuaViewController.h"
#import "GifListViewController.h"

@interface XianHuaViewController ()<HZPageVcDataSource, HZPageVcDelegate,GifListViewControllerDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *navLabel;
@end

@implementation XianHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor clearColor];
    self.view.userInteractionEnabled = YES;
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark - HZPageVcDataSource & Delegate
- (NSUInteger)numberOfContentForPageVc:(HZPageViewController *)pageVc
{
    return 10;
}
- (NSString *)pageVc:(HZPageViewController *)pageVc titleAtIndex:(NSUInteger)index
{
    return @"title";
}
- (UIViewController *)pageVc:(HZPageViewController *)pageVc viewControllerAtIndex:(NSUInteger)index
{
    GifListViewController *con = [[GifListViewController alloc]init];
    con.delegate = self;
    return con;
}

- (void)pageVc:(HZPageViewController *)pageVc didChangeToIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    
}

-(void)clickWithModel:(GiftModel *)model{
    if ([_delegate2 respondsToSelector:@selector(clickWithModel:)]) {
        [_delegate2 clickWithModel:model];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
