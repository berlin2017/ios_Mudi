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
#import "PrivateCreateViewController.h"

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
    tableview.backgroundColor = [UIColor colorWithHexString:@"D9D9D9"];
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
        return 0;
    }
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section) {
        PrivateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"siren_cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
//    }else{
//        PrivateTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"siren_top_cell" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor clearColor];
//        return cell;
//    }
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
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
        view.userInteractionEnabled = YES;
        UIImageView *imageview = [[UIImageView alloc]init];
        [view addSubview:imageview];
        imageview.image = [UIImage imageNamed:@"siren_home_top"];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(view);
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
//    if(indexPath.section==0){
//        return 400;
//    }
    return 160;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section) {
        return 40;
    }else{
        return 300;
    }
}

//#pragma mark -- 代理方法
////实现了这个方法就有滑动的删除按钮了
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

//这个方法就是可以自己添加一些侧滑出来的按钮，并执行一些命令和按钮设置
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //设置按钮(它默认第一个是修改系统的)
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"删除");
    }];
    //设置按钮(它默认第一个是修改系统的)
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //执行跳转到下个界面操作
        //        NextViewController *vc = [[NextViewController alloc]init];
        //        [self presentViewController:vc animated:YES completion:nil];
    }];

//    action1.backgroundColor = [UIColor colorWithRed:0.9305 green:0.3394 blue:1.0 alpha:1.0];

    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"取消关注");
    }];


    if(indexPath.section==1){
        return @[action,action1];
    }else if (indexPath.section==2){
        return @[action2];
    }
    return nil;
}



// 自定义导航栏
-(UIView *)navigationView{
    
    if(_navigationView == nil){
        _navigationView = [[UIView alloc]init];
        _navigationView.userInteractionEnabled = YES;
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
        
        UILabel *right_label = [[UILabel alloc]init];
        right_label.userInteractionEnabled = YES;
        [_navigationView addSubview:right_label];
        [right_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(title);
            make.right.mas_equalTo(_navigationView).mas_offset(-10);;
        }];
        right_label.font = [UIFont systemFontOfSize:14];
        right_label.text = @"快速建墓";
        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickRightMenu)];
        [right_label addGestureRecognizer:gesture];
    }
    return _navigationView;
}

-(void)onclickRightMenu{
    PrivateCreateViewController *controller = [[PrivateCreateViewController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
