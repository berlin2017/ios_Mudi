//
//  PrivateHomeViewController.m
//  SangYuQing
//
//  Created by mac on 2017/12/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PrivateHomeViewController.h"
#import "PrivateTableViewCell.h"
#import "PrivateTopTableViewCell.h"
#import "UIColor+Helper.h"
#import "PrivateMoreViewController.h"

@interface PrivateHomeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}
@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@end

@implementation PrivateHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
   
    
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"main_bg"]];
    [self.view setBackgroundColor:bgColor];
    
    UITableView *tableview = [[UITableView alloc]init];
    [self.view addSubview:tableview];
    tableview.backgroundColor = [UIColor clearColor];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(-[[UIApplication sharedApplication] statusBarFrame].size.height);
    }];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerNib:[UINib nibWithNibName:@"PrivateTableViewCell" bundle:nil] forCellReuseIdentifier:@"siren_cell"];
    [tableview registerNib:[UINib nibWithNibName:@"PrivateTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"siren_top_cell"];
    
    [self.view addSubview:self.navigationView];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        PrivateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"siren_cell" forIndexPath:indexPath];
         cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else{
        PrivateTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"siren_top_cell" forIndexPath:indexPath];
         cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
//    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-1, -1, [UIScreen mainScreen].bounds.size.width, 40)];
        view.userInteractionEnabled = YES;
        UIImageView *imageview = [[UIImageView alloc]init];
        [view addSubview:imageview];
        imageview.image = [UIImage imageNamed:@"siren_item_header"];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).mas_offset(10);
            make.centerY.mas_equalTo(view);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
        }];
        UILabel *label = [[UILabel alloc]init];
        label.text = @"我创建的墓地";
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageview.mas_right).mas_offset(10);
            make.centerY.mas_equalTo(view);
        }];
        
        UILabel *label2 = [[UILabel alloc]init];
        label2.text = @"查看全部>>";
        label2.font = [UIFont systemFontOfSize:12];
        [view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(view).mas_offset(-10);
            make.centerY.mas_equalTo(view);
        }];
        label2.userInteractionEnabled = YES;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toMore)];
        [label2 addGestureRecognizer:labelTapGestureRecognizer];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithHexRGB:0x000000 alpha:0.1];
         [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(view);
            make.left.mas_equalTo(view);
            make.bottom.mas_equalTo(view);
            make.height.mas_equalTo(1);
        }];
        return view;
    }
    return nil;
}

-(void)toMore{
    PrivateMoreViewController *controller = [[PrivateMoreViewController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 400;
    }
    return 160;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section) {
        return 40;
    }else{
        return 0;
    }
}


// 自定义导航栏
-(UIView *)navigationView{
    
    if(_navigationView == nil){
        _navigationView = [[UIView alloc]init];
        _navigationView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64+ [[UIApplication sharedApplication] statusBarFrame].size.height);
        
        _scaleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64+ [[UIApplication sharedApplication] statusBarFrame].size.height)];
        _scaleImageView.image = [UIImage imageNamed:@"bar_bg"];
        _scaleImageView.alpha = 0;
        [_navigationView addSubview:_scaleImageView];
        
        UILabel *title = [[UILabel alloc]init];
        [_navigationView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_navigationView);
            make.bottom.mas_equalTo(_navigationView).mas_offset(-17);
            make.height.mas_equalTo(30);
        }];
        title.font = [UIFont systemFontOfSize:17];
        title.text = @"私人墓园";
        
    }
    return _navigationView;
}


@end
