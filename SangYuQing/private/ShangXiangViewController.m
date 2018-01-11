//
//  ShangXiangViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ShangXiangViewController.h"
#import "GifListViewController.h"

@interface ShangXiangViewController ()<HZPageVcDataSource, HZPageVcDelegate,GifListViewControllerDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *navLabel;
@end

@implementation ShangXiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.view.backgroundColor = [UIColor clearColor];
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

-(void)back{
    //    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
