//
//  WriteJiWenViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WriteJiWenViewController.h"

@interface WriteJiWenViewController ()
@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@property(nonatomic,strong) UILabel *label;
@end

@implementation WriteJiWenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"main_bg"]];
    [self.view setBackgroundColor:bgColor];
    [self.view addSubview:self.navigationView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKey)];
    [self.view addGestureRecognizer:gesture];
    
    _label= [[UILabel alloc]init];
    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.bottom.mas_equalTo(self.view).mas_offset(-20);
    }];
    _label.text = @"剩余1000字";
    
    UITextField *textfild2 = [[UITextField alloc]init];
    [self.view addSubview:textfild2];
    [textfild2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.top.mas_equalTo(self.navigationView.mas_bottom).mas_offset(20);
    }];
    textfild2.placeholder = @"请输入祭文标题";
    textfild2.backgroundColor = [UIColor whiteColor];
    
    UITextField *textfild = [[UITextField alloc]init];
    [self.view addSubview:textfild];
    [textfild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.top.mas_equalTo(textfild2.mas_bottom).mas_offset(20);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height-64-[[UIApplication sharedApplication] statusBarFrame].size.height - 120);
    }];
    textfild.placeholder = @"请输入祭文";
    textfild.backgroundColor = [UIColor whiteColor];
    textfild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [textfild addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    
}

-(void)hideKey{
    [self.view endEditing:YES];
}

-(void)passConTextChange:(id)sender{
    UITextField* target=(UITextField*)sender;
    _label.text = [NSString stringWithFormat:@"剩余%d",1000 - target.text.length];
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
        title.text = @"写祭文";
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
        
        UIButton *right_btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_navigationView addSubview:right_btn];
        [right_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_navigationView).mas_offset(-10);
            make.bottom.mas_equalTo(_navigationView).mas_offset(-17);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(50);
        }];
        right_btn.backgroundColor = [UIColor colorWithHexString:@"CD853F"];
        [right_btn setTitle:@"提交" forState:UIControlStateNormal];
        right_btn.tintColor = [UIColor whiteColor];
        [right_btn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
        right_btn.layer.cornerRadius = 5;
        right_btn.layer.masksToBounds = YES;
    }
    return _navigationView;
}

-(void)commit{
    [self.view makeCenterOffsetToast:@"留言成功"];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
