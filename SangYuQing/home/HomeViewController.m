//
//  HomeViewController.m
//  SangYuQing
//
//  Created by mac on 2017/12/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "View+MASAdditions.h"
#import "HZBannerView.h"
#import "HomeNavCollectionViewCell.h"
#import "UIColor+Helper.h"
#import "HomeNewCollectionViewCell.h"
#import "GongMuCollectionViewCell.h"

@interface HomeViewController ()<HZBannerViewDelegate,HZBannerViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    
}

@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIScrollView *scorllview;
@property (nonatomic,strong) UICollectionView *nav_collectionview;
@property(nonatomic,strong) UITableView * top_table;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    _scorllview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-tabBarHeight)];
    _scorllview.showsHorizontalScrollIndicator = NO;
    _scorllview.showsVerticalScrollIndicator = YES;
//    _scorllview.scrollsToTop = NO;
    _scorllview.delegate = self;
    _scorllview.userInteractionEnabled = YES;
    [self.view addSubview:_scorllview];

    
    _contentView = [[UIView alloc]init];
    _contentView.userInteractionEnabled = YES;
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"main_bg"]];
                        
                        
    [self.view setBackgroundColor:bgColor];
    [_scorllview addSubview:_contentView];
    
    HZBannerView *bannerView = [[HZBannerView alloc] initWithFrame:CGRectMake(0, -[[UIApplication sharedApplication] statusBarFrame].size.height, [UIScreen mainScreen].bounds.size.width, 300)];
    bannerView.delegate = self;
    bannerView.dataSource = self;
    [_contentView addSubview:bannerView];
    
    
    //导航
     UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collectionViewLayout.minimumInteritemSpacing = 10;
    collectionViewLayout.minimumLineSpacing = 0;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 60;
    collectionViewLayout.itemSize = CGSizeMake(width / 4, 74);
    _nav_collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
    _nav_collectionview.bounces = NO;
    _nav_collectionview.scrollsToTop = NO;
//    _nav_collectionview.backgroundColor = [UIColor colorWithHexRGB:0x000000 alpha:0.1];
    _nav_collectionview.backgroundColor = [UIColor clearColor];
    [_nav_collectionview registerClass:[HomeNavCollectionViewCell class] forCellWithReuseIdentifier:@"nav_cell"];
    _nav_collectionview.dataSource = self;
    _nav_collectionview.delegate = self;
    _nav_collectionview.tag = 1000;
    [self.contentView addSubview:_nav_collectionview];

    [_nav_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(bannerView.mas_bottom);
        make.height.mas_equalTo(80*2);
    }];
    
    //最新
    UIView *new_header = [[UIView alloc]init];
//    new_header.backgroundColor = [UIColor colorWithHexRGB:0x000000 alpha:0.1];
    new_header.backgroundColor = [UIColor clearColor];
    [_contentView addSubview:new_header];
    [new_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(_nav_collectionview.mas_bottom).mas_equalTo(10);;
        make.height.mas_equalTo(50);
    }];
    UIImageView *imageView = [[UIImageView alloc]init];
    [new_header addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(new_header).mas_offset(10);
        make.bottom.mas_equalTo(new_header).mas_offset(-15);
        make.centerX.mas_equalTo(new_header);
    }];
    imageView.image = [UIImage imageNamed:@"new_title"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView *bottom_imageview = [[UIImageView alloc]init];
    [new_header addSubview:bottom_imageview];
    [bottom_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(imageView);
        make.bottom.mas_equalTo(new_header).mas_offset(-5);
        make.centerX.mas_equalTo(new_header);
        make.left.mas_equalTo(new_header).mas_offset(10);
        make.right.mas_equalTo(new_header).mas_offset(-10);
    }];
    bottom_imageview.image = [UIImage imageNamed:@"new_title_bottom"];
//    bottom_imageview.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(100, 170);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 2;

    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
//    collectionView.backgroundColor = [UIColor colorWithHexRGB:0x000000 alpha:0.1];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.tag = 2000;
    [collectionView registerNib:[UINib nibWithNibName:@"HomeNews" bundle:nil] forCellWithReuseIdentifier:@"homeNew"];
    [_contentView addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(new_header.mas_bottom);
        make.height.mas_equalTo(170);
    }];
    
    //公墓
    UIView *new_header2 = [[UIView alloc]init];
    new_header2.userInteractionEnabled = YES;
//    new_header2.backgroundColor = [UIColor colorWithHexRGB:0x000000 alpha:0.1];
    new_header2.backgroundColor = [UIColor clearColor];
    [_contentView addSubview:new_header2];
    [new_header2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(collectionView.mas_bottom).mas_equalTo(10);;
        make.height.mas_equalTo(50);
    }];
    UIImageView *imageView2 = [[UIImageView alloc]init];
    [new_header2 addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(new_header2).mas_offset(10);
        make.bottom.mas_equalTo(new_header2).mas_offset(-15);
        make.centerX.mas_equalTo(new_header2);
    }];
    imageView2.image = [UIImage imageNamed:@"gongmu_title"];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView *bottom_imageview2 = [[UIImageView alloc]init];
    [new_header2 addSubview:bottom_imageview2];
    [bottom_imageview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.mas_equalTo(imageView);
        make.bottom.mas_equalTo(new_header2).mas_offset(-5);
        make.centerX.mas_equalTo(new_header2);
        make.left.mas_equalTo(new_header2).mas_offset(10);
        make.right.mas_equalTo(new_header2).mas_offset(-10);
    }];
    bottom_imageview2.image = [UIImage imageNamed:@"new_title_bottom"];
    
    UILabel *label = [[UILabel alloc]init];
    label.userInteractionEnabled = YES;
    [new_header2 addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(new_header2);
        make.right.mas_equalTo(new_header2).mas_offset(-10);
    }];
    label.text = @"查看全部>>";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [label addGestureRecognizer:labelTapGestureRecognizer];
    

    UICollectionViewFlowLayout *layout2 = [UICollectionViewFlowLayout new];
    layout2.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width)/3, ([UIScreen mainScreen].bounds.size.width)/3/3*4+45);
    layout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout2.minimumLineSpacing = 2;
    
    UICollectionView *collectionView2 = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout2];
//    collectionView2.backgroundColor = [UIColor colorWithHexRGB:0x000000 alpha:0.1];
    collectionView2.backgroundColor = [UIColor clearColor];
    collectionView2.delegate = self;
    collectionView2.dataSource = self;
    collectionView2.scrollsToTop = NO;
    collectionView2.showsVerticalScrollIndicator = NO;
    collectionView2.showsHorizontalScrollIndicator = NO;
    collectionView2.tag = 3000;
    [collectionView2 registerNib:[UINib nibWithNibName:@"GongMuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"homeGongmu"];
    [_contentView addSubview:collectionView2];
    
    [collectionView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(new_header2.mas_bottom);
        make.height.mas_equalTo(([UIScreen mainScreen].bounds.size.width)/3/3*4+45);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(bannerView);
        make.top.mas_equalTo(self.scorllview);
        make.bottom.mas_equalTo(collectionView2);
        make.left.mas_equalTo(bannerView);
        make.right.mas_equalTo(bannerView);
        make.bottom.equalTo(_contentView.superview.mas_bottom);
    }];
    
    [self.view addSubview:self.navigationView];
}

-(void)labelClick{
    self.tabBarController.selectedIndex = 2;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat minAlphaOffset = 0;//- 64;
    CGFloat maxAlphaOffset = 200;
    CGFloat offset = scrollView.contentOffset.y;
    if(offset==0){
        return;
    }
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    _scaleImageView.alpha = alpha;
}

// 自定义导航栏
-(UIView *)navigationView{
    
    if(_navigationView == nil){
        _navigationView = [[UIView alloc]init];
        _navigationView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64+ [[UIApplication sharedApplication] statusBarFrame].size.height);
        
        _scaleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64+ [[UIApplication sharedApplication] statusBarFrame].size.height)];
//        _scaleImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _scaleImageView.clipsToBounds = YES;
        _scaleImageView.image = [UIImage imageNamed:@"bar_bg"];
         _scaleImageView.alpha = 0;
        [_navigationView addSubview:_scaleImageView];
        
        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        [_navigationView addSubview:imageview];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_navigationView);
            make.bottom.mas_equalTo(_navigationView).mas_offset(-17);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(60);
        }];
       
        
    }
    return _navigationView;
}

#pragma mark - Banner DataSource & Delegate
- (NSURL *)bannerView:(HZBannerView *)bannerView imageURLAtIndex:(NSInteger)index
{
    if (index >= 4) {
        return nil;
    }
    return [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514450989988&di=b9d2b71adc10306f918cc5ff3db4ebae&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01e4a1564da3d76ac7251c94308050.png%401280w_1l_2o_100sh.png"];
}


- (NSInteger)numberOfBannerView:(HZBannerView *)bannerView
{
    return 4;
}

- (NSString *)bannerView:(HZBannerView *)bannerView imageTextAtIndex:(NSInteger)index
{
//    return @"this is title!";
    return nil;
}

- (void)bannerView:(HZBannerView *)bannerView didClickIndex:(NSInteger)index
{
//    ZANNewsModel *model = _bannerArray[index];
//    [self analyzeNewsModel:model];
//    [ZANReadNewsManager readNewsWithId:model.newsId];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag==1000) {
        return 6;
    }else{
        return 10;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag==1000) {
        HomeNavCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nav_cell" forIndexPath:indexPath];
        [cell configWithMode];
        return cell;
    }else if (collectionView.tag==2000){
        HomeNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeNew" forIndexPath:indexPath];
        [cell configWithModel];
        return cell;
    }else if (collectionView.tag==3000){
        GongMuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeGongmu" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell configWithModel];
        return cell;
    }
    return nil;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.tabBarController.selectedIndex = 1;
}



@end
