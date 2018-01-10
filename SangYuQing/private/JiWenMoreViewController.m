//
//  JiWenMoreViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "JiWenMoreViewController.h"
#import "HZRefreshTableView.h"
#import "ZhuiSiJiWenTableViewCell.h"
#import "JiWenModel.h"
#import "JiWenDetailTableViewCell.h"

@interface JiWenMoreViewController ()<HZRefreshTableDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation JiWenMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"main_bg"]];
    [self.view setBackgroundColor:bgColor];
    [self.view addSubview:self.navigationView];
    
    _tableview = [[UITableView alloc]init];
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
    }];
    
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview registerNib:[UINib nibWithNibName:@"ZhuiSiJiWenTableViewCell" bundle:nil] forCellReuseIdentifier:@"zhuisi_jiwen_cell"];
     [_tableview registerNib:[UINib nibWithNibName:@"JiWenDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"jiwen_detail_cell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section) {
        return 1;
    }
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        return UITableViewAutomaticDimension;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        JiWenDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jiwen_detail_cell"];
        [cell configWithString:@"1969－1975年　陕西省延川县文安驿公社梁家河大队知青、党支部书记1975－1979年　清华大学化工系基本有机合成专业学习1979－1982年　国务院办公厅、中央军委办公厅秘书（现役）1982－1983年　河北省正定县委副书记1983－1985年　河北省正定县委书记，正定县武装部第一政委、党委第一书记1985－1988年　福建省厦门市委常委、副市长习近平从政之路习近平从政之路(20张)1988－1990年　福建省宁德地委书记，宁德军分区党委第一书记1990－1993年　福建省福州市委书记、市人大常委会主任，福州军分区党委第一书记1993－1995年　福建省委常委，福州市委书记、市人大常委会主任，福州军分区党委第一书记1995－1996年　福建省委副书记，福州市委书记、市人大常委会主任，福州军分区党委第一书记1996－1999年　福建省委副书记，福建省高炮预备役师第一政委习近平(12张)1999－2000年　福建省委副书记、代省长，南京军区国防动员委员会副主任，福建省国防动员委员会主任，福建省高炮预备役师第一政委2000－2002年　福建省委副书记、省长，南京军区国防动员委员会副主任，福建省国防动员委员会主任，福建省高炮预备役师第一政委1998－2002年清华大学人文社会学院马克思主义理论与思想政治教育专业在职研究生班学习，获法学博士学位）2002－2002年　浙江省委副书记、代省长，南京军区国防动员委员会副主任，浙江省国防动员委员会主任"];
        cell.backgroundColor = [UIColor colorWithHexString:@"DFDFDF"];
        return cell;
    }
    ZhuiSiJiWenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zhuisi_jiwen_cell"];
    JiWenModel *model = [[JiWenModel alloc]init];
    model.title = @"标题";
    model.count = 10;
    model.name = @"小明";
    model.time = @"2018-01-10 10:00:00";
    model.content = @"nice gay";
    [cell configWithModel:model];
    cell.backgroundColor = [UIColor colorWithHexString:@"DFDFDF"];
    return cell;
}

-(void)headerRefresh{
    
}

-(void)footerRefresh{
    
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
        title.text = @"祭文管理";
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
        
        //        UILabel *right_title = [[UILabel alloc]init];
        //        [_navigationView addSubview:right_title];
        //        [right_title mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.mas_equalTo(_navigationView).mas_offset(-10);
        //            make.bottom.mas_equalTo(_navigationView).mas_offset(-17);
        //            make.height.mas_equalTo(30);
        //        }];
        //        right_title.font = [UIFont systemFontOfSize:14];
        //        right_title.text = @"积分记录";
        //        right_title.userInteractionEnabled = YES;
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toLog)];
        //        [right_title addGestureRecognizer:tap];
    }
    return _navigationView;
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
