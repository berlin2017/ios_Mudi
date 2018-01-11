//
//  GifListViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GifListViewController.h"
#import "GiftCollectionViewCell.h"
#import "GiftModel.h"

@interface GifListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation GifListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.userInteractionEnabled = YES;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-50)/4, 120);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.userInteractionEnabled = YES;
    [collectionView registerNib:[UINib nibWithNibName:@"GiftCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"gift_cell"];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GiftCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gift_cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    GiftModel *model = [[GiftModel alloc]init];
    model.name = @"植树";
    model.time = @"3天";
    model.image = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1086904127,3928418468&fm=27&gp=0.jpg";
    model.jifen = @"10积分";
    [cell configWithModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GiftModel *model = [[GiftModel alloc]init];
    model.name = @"植树";
    model.time = @"3天";
    model.image = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1086904127,3928418468&fm=27&gp=0.jpg";
    model.jifen = @"10积分";
    if ([_delegate respondsToSelector:@selector(clickWithModel:)]) {
        [_delegate clickWithModel:model];
    }
}


@end
