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
#import "GiftView.h"
#import "XianHuaViewController.h"
#import "ShangXiangViewController.h"
#import "JiPinViewController.h"
#import "ZhuangShiViewController.h"
#import "GiftModel.h"
#import "HZHttpClient.h"
#import "MuDiDetailModel.h"

@interface MDDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,GiftViewDelegate,XianHuaViewControllerDelegate,ShangXiangViewControllerDelegate,ZhuangShiViewControllerDelegate,JiPinViewControllerDelegate>
@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@property(nonatomic,strong) UIImageView *right_imageview;
@property(nonatomic,copy)NSMutableArray *names;
@property(nonatomic,copy)NSMutableArray *images;

@property(nonatomic,copy)NSMutableArray *names2;
@property(nonatomic,copy)NSMutableArray *images2;

@property(nonatomic,strong) GiftView *giftView;
@property(nonatomic,assign) BOOL *isLike;

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,copy)MuDiDetailModel *mDetail;

@property(nonatomic,strong)UIImageView *bg_imageview;
@property(nonatomic,strong)UIImageView *mubei_imageview;
@property(nonatomic,strong)UIImageView *photo;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *title_label;
@end

@implementation MDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"main_bg"]];
    [self.view setBackgroundColor:bgColor];
    [self.view addSubview:self.navigationView];
    
    [self requestDetail];
    
    _names = [NSMutableArray arrayWithObjects:@"追思一生",@"相册",@"视频", nil];
    _isLike = NO;
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
    
    _contentView = [[UIImageView alloc]init];
    [self.view addSubview:_contentView];
    _contentView.userInteractionEnabled = YES;
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.bottom.mas_equalTo(collectionview.mas_top);
    }];
    
    CGFloat height = ([UIScreen mainScreen].bounds.size.height-64-[[UIApplication sharedApplication] statusBarFrame].size.height-tabBarHeight);
    
    _bg_imageview = [[UIImageView alloc]init];
    [_contentView addSubview:_bg_imageview];
    [_bg_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_contentView);
        make.right.mas_equalTo(_contentView);
        make.top.mas_equalTo(_contentView);
        make.height.mas_equalTo(height/2);
    }];
    [_bg_imageview sd_setImageWithURL:[NSURL URLWithString:@"http://www.hwsyq.com/data/images/background/bg2.jpg"] placeholderImage:nil options:SDWebImageRetryFailed];
    _bg_imageview.contentMode = UIViewContentModeScaleAspectFill;
    _bg_imageview.layer.masksToBounds = YES;
    
    
    _mubei_imageview = [[UIImageView alloc]init];
    [_contentView addSubview:_mubei_imageview];
    [_mubei_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_contentView);
        make.right.mas_equalTo(_contentView);
        make.bottom.mas_equalTo(_contentView);
        make.height.mas_equalTo(height);
    }];
    [_mubei_imageview sd_setImageWithURL:[NSURL URLWithString:@"http://www.hwsyq.com/data/images/background/01.png"] placeholderImage:nil options:SDWebImageRetryFailed];
    _mubei_imageview.contentMode = UIViewContentModeScaleAspectFill;
    _mubei_imageview.layer.masksToBounds = YES;
    
    
    UICollectionViewFlowLayout *layout2 = [UICollectionViewFlowLayout new];
    layout2.itemSize = CGSizeMake(50, 50);
    layout2.minimumLineSpacing = 10;
    layout2.minimumInteritemSpacing = 10;
    
    UICollectionView *collectionview2 = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout2];
    [self.view addSubview:collectionview2];
    [collectionview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_contentView).mas_offset(([UIScreen mainScreen].bounds.size.width-230)/2);
        make.right.mas_equalTo(_contentView).mas_offset(-([UIScreen mainScreen].bounds.size.width-230)/2);
        make.bottom.mas_equalTo(collectionview.mas_top).mas_offset(-20);
        make.height.mas_equalTo(50);
    }];
    collectionview2.tag = 2000;
    collectionview2.backgroundColor = [UIColor clearColor];
    collectionview2.delegate = self;
    collectionview2.dataSource = self;
    [collectionview2 registerNib:[UINib nibWithNibName:@"DetailMenuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"detail_menu_cell"];
    
    
    _name = [[UILabel alloc]init];
    [_contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).mas_equalTo(-10);
    }];
    _name.font = [UIFont systemFontOfSize:13];
    _name.textColor = [UIColor whiteColor];
    
    _photo = [[UIImageView alloc]init];
    [_contentView addSubview:_photo];
    [_photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_name.mas_top).mas_offset(-5);
        make.centerX.mas_equalTo(_contentView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(30);
    }];
    _photo.backgroundColor = [UIColor clearColor];
    //    photo.contentMode = UIViewContentModeScaleAspectFill;
    [_photo sd_setImageWithURL:[NSURL URLWithString:@"http://www.hwsyq.com/data/images/shizhe/2017091422292149.jpg"]];
    
}

-(void)requestDetail{
    if (!_sz_id) {
        [self.view makeCenterOffsetToast:@"页面错误,请退出重试"];
        return;
    }
    HZHttpClient *client = [HZHttpClient httpClient];
    [HZLoadingHUD showHUDInView:self.view];
    [client hcGET:@"/v1/gongmu/detail" parameters:@{@"id":_sz_id,} success:^(NSURLSessionDataTask *task, id object) {
        
        if(object[@"state"]){
            NSLog(@"success");
            _mDetail =[MTLJSONAdapter modelOfClass:[MuDiDetailModel class] fromJSONDictionary:object[@"data"][@"CemeteryInfo"] error:nil];
            [_mubei_imageview sd_setImageWithURL:[NSURL URLWithString:_mDetail.mubei]];
            [_bg_imageview sd_setImageWithURL:[NSURL URLWithString:_mDetail.beijing]];
            [_photo sd_setImageWithURL:[NSURL URLWithString:_mDetail.sz_avatar]];
            _name.verticalText = _mDetail.sz_name;
            _title_label.text = _mDetail.sz_name;
        }else{
            [self.view makeCenterOffsetToast:object[@"msg"]];
        }
        [HZLoadingHUD hideHUDInView:self.view];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.view makeCenterOffsetToast:@"请求失败，请重试"];
        [HZLoadingHUD hideHUDInView:self.view];
    }];
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
        
        
        //跳转到鲜花界面
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UITabBarController *tabBarController = [sb instantiateViewControllerWithIdentifier:@"detail_xianhua"];
//        tabBarController.view.backgroundColor = [UIColor clearColor];

       
        XianHuaViewController *controller = tabBarController.viewControllers[0];
        controller.delegate2 = self;
        ShangXiangViewController *controller2 = tabBarController.viewControllers[0];
        controller2.delegate2 = self;
        JiPinViewController *controller3 = tabBarController.viewControllers[0];
        controller3.delegate2 = self;
        ZhuangShiViewController *controller4 = tabBarController.viewControllers[0];
        controller4.delegate2 = self;
        
        self.definesPresentationContext = YES;
        tabBarController.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        tabBarController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        tabBarController.selectedIndex = indexPath.row;
        [self presentViewController:tabBarController animated:YES completion:nil];
        
        
//        tabBarController.selectedIndex = indexPath.row;
//        [self.navigationController pushViewController:tabBarController animated:NO];
        
    }
}

//当cell高亮时返回是否高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)clickWithModel:(GiftModel*)model{
    _giftView = [[GiftView alloc]initWithFrame:CGRectMake(100, 50, 60, 60)];
    [_giftView setImage:model.image];
    _giftView.userInteractionEnabled = YES;
    _giftView.delegate = self;
    [_contentView addSubview:_giftView];
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
        
        _title_label = [[UILabel alloc]init];
        [_navigationView addSubview:_title_label];
        [_title_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_navigationView);
            make.bottom.mas_equalTo(_navigationView).mas_offset(-17);
            make.height.mas_equalTo(30);
        }];
        _title_label.font = [UIFont systemFontOfSize:17];
        _title_label.text = @"详情";
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
        
        _right_imageview = [[UIImageView alloc]init];
        [_navigationView addSubview:_right_imageview];
        [_right_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_navigationView).mas_offset(-10);
            make.bottom.mas_equalTo(_navigationView).mas_offset(-19.5);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(25);
        }];
        _right_imageview.image = [UIImage imageNamed:@"ic_like"];
        _right_imageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(likeOrNot)];
        [_right_imageview addGestureRecognizer:tap];
    }
    return _navigationView;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)likeOrNot{
    _isLike = !_isLike;
    if (_isLike) {
        _right_imageview.image = [UIImage imageNamed:@"user_like"];
    }else{
        _right_imageview.image = [UIImage imageNamed:@"ic_like"];
    }
    
    //网络请求  关注
}

-(void)confirm{
    [_giftView finishEdit];
}

@end
