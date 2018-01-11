//
//  UserHomeViewController.m
//  SangYuQing
//
//  Created by mac on 2017/12/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UserHomeViewController.h"
#import "UIColor+Helper.h"
#import "UserHeaderTableViewCell.h"
#import "UserInfoViewController.h"
#import "TestViewController.h"
#import "PrivateMoreViewController.h"
#import "UserSettingsViewController.h"
#import "UserLoginViewController.h"
#import "UserScoreViewController.h"


@interface UserHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片

@end

@implementation UserHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"main_bg"]];
    [self.view setBackgroundColor:bgColor];
    
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.tableFooterView = [UIView new];
    tableview.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(-[[UIApplication sharedApplication] statusBarFrame].size.height);
    }];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"user_cell"];
    [tableview registerNib:[UINib nibWithNibName:@"UserHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"user_header"];
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
        title.text = @"个人中心";
        
    }
    return _navigationView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 2;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section== 0 ) {
        UserHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user_header"];
        return cell;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"user_cell"];
    }
    cell.backgroundColor = [UIColor colorWithHexString:@"DFDFDF"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.section) {
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"user_jifen"];
            cell.textLabel.text = @"我的积分";
            cell.detailTextLabel.text = @"1000";
            break;
        case 2:
            if(indexPath.row){
                cell.imageView.image = [UIImage imageNamed:@"user_like"];
                cell.textLabel.text = @"我的关注";
            }else{
                cell.imageView.image = [UIImage imageNamed:@"user_siren"];
                cell.textLabel.text = @"私人墓园";
            }
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"user_settings"];
            cell.textLabel.text = @"设置";
            break;
            
        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 250;
    }
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
                        UserInfoViewController *controller = [[UserInfoViewController alloc]init];
            //             TestViewController *controller = [[TestViewController alloc]init];
                        controller.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:controller animated:YES];
//            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"user" bundle:nil];
//            UserLoginViewController * viewController = [sb instantiateViewControllerWithIdentifier:@"user_login"];
//            [viewController setHidesBottomBarWhenPushed:YES];
//            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 1:{
            UserScoreViewController *controller = [[UserScoreViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case 2:
            if(indexPath.row){
                PrivateMoreViewController *controller = [[PrivateMoreViewController alloc]init];
                controller.hidesBottomBarWhenPushed = YES;
                controller.titleName = @"我的关注";
                [self.navigationController pushViewController:controller animated:YES];
            }else{
                PrivateMoreViewController *controller = [[PrivateMoreViewController alloc]init];
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
            break;
        case 3:{
            UserSettingsViewController *controller = [[UserSettingsViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
