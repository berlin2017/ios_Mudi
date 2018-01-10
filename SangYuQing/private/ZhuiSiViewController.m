//
//  ZhuiSiViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZhuiSiViewController.h"
#import "ZhuiSiLiuYanTableViewCell.h"
#import "LiuYanModel.h"
#import "ZhuiSiJiWenTableViewCell.h"
#import "JiWenModel.h"
#import "ZhuiSiHeaderTableViewCell.h"
#import "SZDetailModel.h"
#import "ZhuiSiJieShaoTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "WriteLiuYanViewController.h"
#import "WriteJiWenViewController.h"
#import "LiuYanMoreViewController.h"
#import "JiWenMoreViewController.h"

@interface ZhuiSiViewController ()<UITableViewDelegate,UITableViewDataSource,ZhuiSiJieShaoTableViewCellDelegate>
@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)int type;
@end

@implementation ZhuiSiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _type = 4;
    self.navigationController.navigationBarHidden = YES;
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"main_bg"]];
    [self.view setBackgroundColor:bgColor];
    [self.view addSubview:self.navigationView];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableview];
    _tableview.backgroundColor = [UIColor clearColor];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview registerNib:[UINib nibWithNibName:@"ZhuiSiLiuYanTableViewCell" bundle:nil] forCellReuseIdentifier:@"zhuisi_liuyan_cell"];
    [_tableview registerNib:[UINib nibWithNibName:@"ZhuiSiJiWenTableViewCell" bundle:nil] forCellReuseIdentifier:@"zhuisi_jiwen_cell"];
    [_tableview registerNib:[UINib nibWithNibName:@"ZhuiSiHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"zhuisi_header_cell"];
    [_tableview registerNib:[UINib nibWithNibName:@"ZhuiSiJieShaoTableViewCell" bundle:nil] forCellReuseIdentifier:@"zhuisi_jieshao_cell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return 10;
        case 3:
            return 15;
        default:
            break;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            ZhuiSiHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zhuisi_header_cell"];
            SZDetailModel *model = [[SZDetailModel alloc]init];
            model.image = @"https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=60c889ffb051f819f125044ce28f2dd0/ae51f3deb48f8c54cd34cafb3a292df5e1fe7f7a.jpg";
            model.name = @"小明";
            model.birthday = @"2018-01-10";
            model.death = @"2018-01-11";
            model.fangke = 100;
            model.jidian = 200;
            [cell configWithModel:model];
            cell.backgroundColor = [UIColor colorWithHexString:@"DFDFDF"];
            return cell;
        }
            break;
        case 1:
        {
            ZhuiSiJieShaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zhuisi_jieshao_cell"];
            SZDetailModel *model = [[SZDetailModel alloc]init];
            model.image = @"https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=60c889ffb051f819f125044ce28f2dd0/ae51f3deb48f8c54cd34cafb3a292df5e1fe7f7a.jpg";
            model.name = @"小明";
            model.birthday = @"2018-01-10";
            model.death = @"2018-01-11";
            model.fangke = 100;
            model.jidian = 200;
            model.jieshao = @"中共第十五届中央候补委员，十六届、十七届、十八届、十九届中央委员，十七届中央政治局委员、常委、中央书记处书记，十八届、十九届中央政治局委员、常委、中央委员会总书记。第十一届全国人大第一次会议当选为中华人民共和国副主席。十七届五中全会增补为中共中央军事委员会副主席。第十一届全国人大常委会第十七次会议任命为中华人民共和国中央军事委员会副主席。十八届一中全会任中共中央军事委员会主席。第十二届全国人大第一次会议当选为中华人民共和国主席、中华人民共和国中央军事委员会主席。十九届一中全会任中共中央军事委员会主席。";
            [cell configWithModel:model type:_type];
            cell.delegate = self;
            cell.backgroundColor = [UIColor colorWithHexString:@"DFDFDF"];
            return cell;
        }
            break;
        case 2:
        {
            ZhuiSiLiuYanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zhuisi_liuyan_cell"];
            LiuYanModel *model = [[LiuYanModel alloc]init];
            model.image = @"https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=60c889ffb051f819f125044ce28f2dd0/ae51f3deb48f8c54cd34cafb3a292df5e1fe7f7a.jpg";
            model.name = @"小明";
            model.time = @"2018-01-10";
            model.content = @"break和continue都是用来控制循环结构的，主要是停止循环。1.break有时候我们想在某种条件出现的时候终止循环而不是等到循环条件为false才终止。这是我们可以使用break来完成。break用于完全结束一个循环，跳出循环体执行循环后面的语句。2.continuecontinue和break有点类似，区别在于continue只是终止本次循环，接着还执行后面的循环，break则完全终止循环。可以理解为continue是跳过当次循环中剩下的语句，执行下一次循环。";
            [cell configWithModel:model];
            cell.backgroundColor = [UIColor colorWithHexString:@"DFDFDF"];
            return cell;
        }
            break;
        case 3:
        {
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
            break;
        default:
            break;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2||indexPath.section==3) {
        return 100;
    }
    if(indexPath.section==1){
        return UITableViewAutomaticDimension;
    }
    
    return 140;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2||section==3) {
        return 50;
    }
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2||section==3) {
        return 60;
    }
    if(section==1){
        return 10;
    }
    return 0.01f;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==2||section==3) {
        
        UIView *footer = [[UIView alloc]init];
        footer.backgroundColor = [UIColor colorWithHexString:@"DFDFDF"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"查看更多" forState:UIControlStateNormal];
        btn.tintColor = [UIColor whiteColor];
        btn.backgroundColor = [UIColor colorWithHexString:@"CD853F"];
        [footer addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(160);
            make.center.mas_equalTo(footer);
        }];
        btn.tag = section;
        [btn addTarget:self action:@selector(toMore:) forControlEvents:UIControlEventTouchUpInside];
        return footer;
    }
    return nil;
}

-(void)toMore:(UIButton*)btn{
    if (btn.tag==2) {
        LiuYanMoreViewController *controller = [[LiuYanMoreViewController alloc]init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        JiWenMoreViewController *controller = [[JiWenMoreViewController alloc]init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==2||section==3) {
        UIView *header = [[UIView alloc]init];
        header.backgroundColor = [UIColor clearColor];
        
        UIView *bottom = [[UIView alloc]init];
        [header addSubview:bottom];
        bottom.userInteractionEnabled = YES;
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.bottom.mas_equalTo(header);
            make.left.mas_equalTo(header);
            make.right.mas_equalTo(header);
        }];
        bottom.backgroundColor = [UIColor colorWithHexString:@"DFDFDF"];
        
        UIImageView *leftImage = [[UIImageView alloc]init];
        [bottom addSubview:leftImage];
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bottom);
            make.left.mas_equalTo(bottom).mas_offset(10);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(20);
        }];
        leftImage.image = [UIImage imageNamed:@"ic_liuyan_title"];
        UILabel *title = [[UILabel alloc]init];
        NSString *s;
        if (section==2) {
            s = @"留言";
        }else{
            s = @"祭文";
        }
        title.text = s;
        title.textColor = [UIColor darkGrayColor];
        [bottom addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImage.mas_right).mas_offset(10);
            make.centerY.mas_equalTo(bottom);
        }];
        
        UILabel *right_label = [[UILabel alloc]init];
        right_label.text =[NSString stringWithFormat: @"写%@",s];
        right_label.textColor = [UIColor darkGrayColor];
        [bottom addSubview:right_label];
        [right_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bottom).mas_offset(-10);
            make.centerY.mas_equalTo(bottom);
        }];
        right_label.tag = section;
        right_label.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toWrite:)];
        
        [right_label addGestureRecognizer:gesture];
        
        UIImageView *rightImage = [[UIImageView alloc]init];
        [bottom addSubview:rightImage];
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bottom);
            make.right.mas_equalTo(right_label.mas_left).mas_offset(-10);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(20);
        }];
        rightImage.image = [UIImage imageNamed:@"ic_liuyan"];
        return header;
    }
    return nil;
}

-(void)toWrite:(UITapGestureRecognizer *)gesture{
    if (gesture.view.tag == 2) {
        WriteLiuYanViewController *controller = [[WriteLiuYanViewController alloc]init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        WriteJiWenViewController *controller = [[WriteJiWenViewController alloc]init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

-(void)reloadDataWithType:(int)type{
    _type = type;
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
        title.text = @"追思一生";
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
