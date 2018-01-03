//
//  UserInfoViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"
#import "UserInfoListCell.h"
#import "UIColor+Helper.h"
#import "AddressPickerView.h"

@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,AddressPickerViewDelegate>
@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@property (nonatomic ,strong) AddressPickerView * pickerView;
@property (nonatomic ,strong) NSString * location_string;
@property (nonatomic ,strong) UITableView * tableview;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"main_bg"]];
    [self.view setBackgroundColor:bgColor];
    [self.view addSubview:self.navigationView];
    
    _tableview = [[UITableView alloc]init];
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.tableFooterView = [UIView new];
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
    }];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview registerNib:[UINib nibWithNibName:@"UserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"userinfo_header"];
    [_tableview registerNib:[UINib nibWithNibName:@"UserInfoListCell" bundle:nil] forCellReuseIdentifier:@"userinfo_cell"];
    [self.view addSubview:self.pickerView];
}

- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]init];
        _pickerView.delegate = self;
        [_pickerView setTitleHeight:50 pickerViewHeight:165];
        // 关闭默认支持打开上次的结果
        _pickerView.isAutoOpenLast = NO;
    }
    return _pickerView;
}

#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClick{
    [self.pickerView hide];
    
}
- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
     [self.pickerView hide];
    _location_string = [NSString stringWithFormat:@"%@%@",province,city];
    [_tableview reloadData];
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
        title.text = @"个人信息";
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
    }
    return _navigationView;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 5;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section== 0 ) {
        UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userinfo_header"];
        cell .backgroundColor = [UIColor colorWithHexString:@"D9D9D9"];
        return cell;
    }
    
    UserInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userinfo_cell"];
    cell.backgroundColor = [UIColor colorWithHexString:@"D9D9D9"];
    switch (indexPath.row) {
        case 0:
            [cell configWithName:@"用户名" value:@"test"];
            [cell hideRight];
            break;
        case 1:
            [cell configWithName:@"昵称" value:@"test_nick"];
            break;
        case 2:
            [cell configWithName:@"性别" value:@"男"];
            break;
        case 3:
            [cell configWithName:@"手机" value:@"12345667"];
            break;
        case 4:
            [cell configWithName:@"籍贯" value: _location_string];
            break;
            
        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 80;
    }
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section) {
        return 10;
    }
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
    if (indexPath.section== 0 ) {
        
        return;
    }
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            [_pickerView show];
            break;
            
        default:
            break;
    }
}

@end
