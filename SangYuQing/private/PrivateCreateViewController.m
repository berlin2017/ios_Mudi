//
//  PrivateCreateViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PrivateCreateViewController.h"
#import "CreatEditTableViewCell.h"
#import "CreatPhotoTableViewCell.h"
#import "CreatCheckBoxTableViewCell.h"

@interface PrivateCreateViewController ()<UITableViewDelegate,UITableViewDataSource,CreatCheckBoxTableViewCellDelegate,UIImagePickerControllerDelegate,CreatPhotoTableViewCellDelegate>

@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@property (nonatomic,strong)UITableView *tableview;
@property(nonatomic,copy)NSMutableArray *array;
@property(nonatomic,copy)UIImage *choseImage;
@end

@implementation PrivateCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"main_bg"]];
    [self.view setBackgroundColor:bgColor];
    [self.view addSubview:self.navigationView];
    UITapGestureRecognizer *key_recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKey)];
    [self.navigationView addGestureRecognizer:key_recognizer];
    
    _array = [NSMutableArray arrayWithObjects:@"逝者姓名:",@"生辰日期:",@"忌辰日期:",@"情感关系:",@"上传照片:",@"是否公开:", nil];
    _tableview = [[UITableView alloc]init];
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.userInteractionEnabled = YES;
    _tableview.backgroundColor = [UIColor clearColor];
    [_tableview registerNib:[UINib nibWithNibName:@"CreatEditTableViewCell" bundle:nil] forCellReuseIdentifier:@"creat_edit_cell"];
    [_tableview registerNib:[UINib nibWithNibName:@"CreatPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"creat_photo_cell"];
    [_tableview registerNib:[UINib nibWithNibName:@"CreatCheckBoxTableViewCell" bundle:nil] forCellReuseIdentifier:@"creat_check_cell"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==4) {
        CreatPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"creat_photo_cell"];
        cell.delegate = self;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    if (indexPath.row==5) {
        CreatCheckBoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"creat_check_cell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
        return cell;
    }
    CreatEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"creat_edit_cell"];
    if (indexPath.row==1||indexPath.row==2) {
        cell.edittext.enabled = NO;
    }
    cell.name_label.text = _array[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]init];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.userInteractionEnabled = YES;
    [btn setTitle:@"创建墓园" forState: UIControlStateNormal];
    btn.tintColor = [UIColor whiteColor];
    btn.backgroundColor = [UIColor colorWithHexString:@"CD853F"];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(160);
        make.center.mas_equalTo(footer);
    }];
    return footer;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1||indexPath.row==2) {
        
    }
    
    if(indexPath.row==4){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(void)choseImage{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark 调用系统相册及拍照功能实现方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * chosenImage = info[UIImagePickerControllerEditedImage];
    CreatPhotoTableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    cell.imageview.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

-(void)checkedChanged:(BOOL)isChecked{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
    if (isChecked) {
        [_array removeObjectAtIndex:6];
        [_tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_tableview reloadData];
    }else{
        [_array insertObject:@"设置密码:" atIndex:6];
        [_tableview reloadData];
    }
}

-(void)commit{
    
}

-(void)hideKey{
    [self.view endEditing:YES];
}

// 自定义导航栏
-(UIView *)navigationView{
    
    if(_navigationView == nil){
        _navigationView = [[UIView alloc]init];
        _navigationView.userInteractionEnabled = YES;
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
        title.text = @"快速建墓";
        
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
        
        //        UILabel *right_label = [[UILabel alloc]init];
        //        right_label.userInteractionEnabled = YES;
        //        [_navigationView addSubview:right_label];
        //        [right_label mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.centerY.mas_equalTo(title);
        //            make.right.mas_equalTo(_navigationView).mas_offset(-10);;
        //        }];
        //        right_label.font = [UIFont systemFontOfSize:14];
        //        right_label.text = @"快速建墓";
        //        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickRightMenu)];
        //        [right_label addGestureRecognizer:gesture];
    }
    return _navigationView;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

