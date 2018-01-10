//
//  MDDetailViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MDDetailViewController.h"
#import "ButtomBarCollectionViewCell.h"
#import "DetailMenuCollectionViewCell.h"
#import "UILabel+Extension.h"
#import "DetailTabBarViewController.h"
#import "ZhuiSiViewController.h"

@interface MDDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@property(nonatomic,copy)NSMutableArray *names;
@property(nonatomic,copy)NSMutableArray *images;

@property(nonatomic,copy)NSMutableArray *names2;
@property(nonatomic,copy)NSMutableArray *images2;
@end

@implementation MDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"main_bg"]];
    [self.view setBackgroundColor:bgColor];
    [self.view addSubview:self.navigationView];
    
    _names = [NSMutableArray arrayWithObjects:@"追思一生",@"相册",@"视频", nil];
    //    _names = [NSMutableArray arrayWithObjects:@"追思一生",@"相册",@"视频",@"祭品管理", nil];
    _images = [NSMutableArray arrayWithObjects:@"ic_bottom_zhuisi_light",@"ic_bottom_photo_light",@"ic_bottom_video_light",@"ic_bottom_jipin_light", nil];
    
    _names2 = [NSMutableArray arrayWithObjects:@"鲜花",@"上香",@"祭品",@"装饰", nil];
    _images2 = [NSMutableArray arrayWithObjects:@"ic_detail_xianhua",@"ic_detail_shangxiang",@"ic_detail_jipin",@"ic_detail_zhuangshi", nil];
    
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarVC.tabBar.frame.size.height;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width)/(_names.count) , tabBarHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height- tabBarHeight, [UIScreen mainScreen].bounds.size.width, tabBarHeight) collectionViewLayout:layout];
    [self.view addSubview:collectionview];
    collectionview.tag = 1000;
    UIImageView *bg = [[UIImageView alloc]init];
    bg.image = [UIImage imageNamed:@"button_bg"];
    collectionview.backgroundView = bg;
    collectionview.delegate = self;
    collectionview.dataSource = self;
    [collectionview registerNib:[UINib nibWithNibName:@"ButtomBarCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"bottom_bar_cell"];
    
    UIView *contentView = [[UIImageView alloc]init];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.bottom.mas_equalTo(collectionview.mas_top);
    }];
    
    CGFloat height = ([UIScreen mainScreen].bounds.size.height-64-[[UIApplication sharedApplication] statusBarFrame].size.height-tabBarHeight);
    
    UIImageView *bg_imageview = [[UIImageView alloc]init];
    [contentView addSubview:bg_imageview];
    [bg_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView);
        make.right.mas_equalTo(contentView);
        make.top.mas_equalTo(contentView);
        make.height.mas_equalTo(height/2);
    }];
    [bg_imageview sd_setImageWithURL:[NSURL URLWithString:@"http://www.hwsyq.com/data/images/background/bg2.jpg"] placeholderImage:nil options:SDWebImageRetryFailed];
    bg_imageview.contentMode = UIViewContentModeScaleAspectFill;
    bg_imageview.layer.masksToBounds = YES;
    
    
    UIImageView *mubei_imageview = [[UIImageView alloc]init];
    [contentView addSubview:mubei_imageview];
    [mubei_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView);
        make.right.mas_equalTo(contentView);
        make.bottom.mas_equalTo(contentView);
        make.height.mas_equalTo(height);
    }];
    [mubei_imageview sd_setImageWithURL:[NSURL URLWithString:@"http://www.hwsyq.com/data/images/background/01.png"] placeholderImage:nil options:SDWebImageRetryFailed];
    mubei_imageview.contentMode = UIViewContentModeScaleAspectFill;
    mubei_imageview.layer.masksToBounds = YES;
    
    
    UICollectionViewFlowLayout *layout2 = [UICollectionViewFlowLayout new];
    layout2.itemSize = CGSizeMake(50, 50);
    layout2.minimumLineSpacing = 10;
    layout2.minimumInteritemSpacing = 10;
    
    UICollectionView *collectionview2 = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout2];
    [self.view addSubview:collectionview2];
    [collectionview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView).mas_offset(([UIScreen mainScreen].bounds.size.width-230)/2);
        make.right.mas_equalTo(contentView).mas_offset(-([UIScreen mainScreen].bounds.size.width-230)/2);
        make.bottom.mas_equalTo(collectionview.mas_top).mas_offset(-20);
        make.height.mas_equalTo(50);
    }];
    collectionview2.tag = 2000;
    collectionview2.backgroundColor = [UIColor clearColor];
    collectionview2.delegate = self;
    collectionview2.dataSource = self;
    [collectionview2 registerNib:[UINib nibWithNibName:@"DetailMenuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"detail_menu_cell"];
    
    
    UILabel *name = [[UILabel alloc]init];
    [contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).mas_equalTo(-10);
    }];
    name.verticalText = @"毛泽东之墓";
    name.font = [UIFont systemFontOfSize:13];
    name.textColor = [UIColor whiteColor];
    
    UIImageView *photo = [[UIImageView alloc]init];
    [contentView addSubview:photo];
    [photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(name.mas_top).mas_offset(-5);
        make.centerX.mas_equalTo(contentView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(30);
    }];
    photo.backgroundColor = [UIColor clearColor];
    //    photo.contentMode = UIViewContentModeScaleAspectFill;
    [photo sd_setImageWithURL:[NSURL URLWithString:@"http://www.hwsyq.com/data/images/shizhe/2017091422292149.jpg"]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 1000) {
        return _names.count;
    }
    return _names2.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1000) {
        ButtomBarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bottom_bar_cell" forIndexPath:indexPath];
        [cell configWithName:_names[indexPath.row] image:[UIImage imageNamed:_images[indexPath.row]]];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else{
        DetailMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detail_menu_cell" forIndexPath:indexPath];
        [cell configWithName:_names2[indexPath.row] image:[UIImage imageNamed:_images2[indexPath.row]]];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag==1000){
        //        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //        DetailTabBarViewController *controller = [sb instantiateViewControllerWithIdentifier:@"detail_story"];
        //        UITabBarController *tabbar = [[UITabBarController alloc]init];
        //        for (int i=0; i<_names.count; i++) {
        //            ZhuiSiViewController *cont= [[ZhuiSiViewController alloc]init];
        //            cont.navigationItem.title = _names[i];
        //            [tabbar addChildViewController:cont];
        //        }
        //        [self.navigationController pushViewController:tabbar animated:YES];
        
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                            NSFontAttributeName: [UIFont systemFontOfSize:12.f],
                                                            }
                                                 forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                            NSFontAttributeName: [UIFont systemFontOfSize:12.f],
                                                            }
                                                 forState:UIControlStateNormal];
        [UITabBarItem appearance].titlePositionAdjustment = UIOffsetMake(0, -1);
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UITabBarController *tabBarController = [sb instantiateViewControllerWithIdentifier:@"detail_story"];
        NSArray *normalImages = @[@"ic_bottom_zhuisi",@"ic_bottom_photo",@"ic_bottom_video",@"ic_bottom_jipin"
                                  ];
        
        NSInteger index = 0;
        NSMutableArray *array =[NSMutableArray new];
        for (UIViewController *viewController in tabBarController.viewControllers) {
            
            if ([tabBarController.viewControllers lastObject]==viewController&&_names.count==3) {
                

            }else{
                UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:_names[index]
                                                                   image:[[UIImage imageNamed:normalImages[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                           selectedImage:[[UIImage imageNamed:_images[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                viewController.tabBarItem = item;
                [array addObject:viewController];
                ++ index;
            }
        }
        [tabBarController setViewControllers:array];
        tabBarController.selectedIndex = indexPath.row;
        [self.navigationController pushViewController:tabBarController animated:YES];
    }else{
        
    }
}

//当cell高亮时返回是否高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 自定义导航栏
-(UIView *)navigationView{
    
    if(_navigationView == nil){
        _navigationView = [[UIView alloc]init];
        _navigationView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64+ [[UIApplication sharedApplication] statusBarFrame].size.height);
        
        _scaleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64+ [[UIApplication sharedApplication] statusBarFrame].size.height)];
        _scaleImageView.image = [UIImage imageNamed:@"bar_bg"];
        _scaleImageView.alpha = 1;
        [_navigationView addSubview:_scaleImageView];
        
        UILabel *title = [[UILabel alloc]init];
        [_navigationView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_navigationView);
            make.bottom.mas_equalTo(_navigationView).mas_offset(-17);
            make.height.mas_equalTo(30);
        }];
        title.font = [UIFont systemFontOfSize:17];
        title.text = @"详情";
        UIImageView *back_imageview = [[UIImageView alloc]init];
        [_navigationView addSubview:back_imageview];
        [back_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_navigationView).mas_offset(10);
            make.bottom.mas_equalTo(_navigationView).mas_offset(-19.5);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(25);
        }];
        back_imageview.image = [UIImage imageNamed:@"ic_back"];
        back_imageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
        [back_imageview addGestureRecognizer:gesture];
        
        UIImageView *right_imageview = [[UIImageView alloc]init];
        [_navigationView addSubview:right_imageview];
        [right_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_navigationView).mas_offset(-10);
            make.bottom.mas_equalTo(_navigationView).mas_offset(-19.5);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(25);
        }];
        right_imageview.image = [UIImage imageNamed:@"ic_like"];
        right_imageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(likeOrNot)];
        [right_imageview addGestureRecognizer:tap];
    }
    return _navigationView;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)likeOrNot{
    
}
@end
