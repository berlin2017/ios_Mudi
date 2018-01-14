//
//  WriteJiWenViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WriteJiWenViewController.h"
#import "UserLoginViewController.h"

@interface WriteJiWenViewController ()
@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UITextField *textfild2;
@property(nonatomic,strong) UITextField *textfild;
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
    
    _textfild2 = [[UITextField alloc]init];
    [self.view addSubview:_textfild2];
    [_textfild2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.top.mas_equalTo(self.navigationView.mas_bottom).mas_offset(20);
    }];
    _textfild2.placeholder = @"请输入祭文标题";
    _textfild2.backgroundColor = [UIColor whiteColor];
    
    _textfild = [[UITextField alloc]init];
    [self.view addSubview:_textfild];
    [_textfild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.top.mas_equalTo(_textfild2.mas_bottom).mas_offset(20);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height-64-[[UIApplication sharedApplication] statusBarFrame].size.height - 120);
    }];
    _textfild.placeholder = @"请输入祭文";
    _textfild.backgroundColor = [UIColor whiteColor];
    _textfild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_textfild addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    
}

-(void)hideKey{
    [self.view endEditing:YES];
}

-(void)passConTextChange:(id)sender{
    UITextField* target=(UITextField*)sender;
    _label.text = [NSString stringWithFormat:@"剩余%zd",1000 - target.text.length];
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
    if ([NSString isEmptyString:_textfild2.text]) {
        [self.view makeCenterOffsetToast:@"标题不能为空"];
        return;
    }
    if ([NSString isEmptyString:_textfild.text]) {
        [self.view makeCenterOffsetToast:@"内容不能为空"];
        return;
    }
    
    HZHttpClient *client = [HZHttpClient httpClient];
    [client hcPOST:@"/v1/jiwen/add" parameters:@{@"szid":_sz_id,@"type":@"1",@"title":_textfild2.text,@"content":_textfild.text}  success:^(NSURLSessionDataTask *task, id object) {
        if ([object[@"state_code"] isEqualToString:@"0000"]) {
           [self.view makeCenterOffsetToast:@"留言成功"];
        }else if([object[@"state_code"] isEqualToString:@"8888"]){
            [self.view makeCenterOffsetToast:@"登录信息已过期，请重新登录"];
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"user" bundle:nil];
            UserLoginViewController * viewController = [sb instantiateViewControllerWithIdentifier:@"user_login"];
            [self.navigationController pushViewController:viewController animated:YES];
        }else{
            [self.view makeCenterOffsetToast:object[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.view makeCenterOffsetToast:@"请求失败,请重试"];
    }];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
