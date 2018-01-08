//
//  UserLoginViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UserLoginViewController.h"
#import "UserRegisterViewController.h"
#import "UserFrogetPassViewController.h"

@interface UserLoginViewController (){
    
    __weak IBOutlet UIButton *login_btn;
    __weak IBOutlet UIButton *register_btn;
    __weak IBOutlet UILabel *forget_label;
}
@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@end

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"main_bg"]];
    [self.view setBackgroundColor:bgColor];
    login_btn.layer.cornerRadius = 5;
    login_btn.layer.masksToBounds = YES;
    
    register_btn.layer.cornerRadius = 5;
    register_btn.layer.masksToBounds = YES;
    register_btn.layer.borderWidth = 1;
    register_btn.layer.borderColor = [UIColor blackColor].CGColor;
    [register_btn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toFroget)];
    forget_label.userInteractionEnabled = YES;
    [forget_label addGestureRecognizer:tap];
    
//    [self.view addSubview:self.navigationView];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *key_recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKey)];
    [self.view addGestureRecognizer:key_recognizer];
}

-(void)toFroget{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"user" bundle:nil];
    UserFrogetPassViewController * viewController = [sb instantiateViewControllerWithIdentifier:@"user_froget"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)toRegister{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"user" bundle:nil];
    UserRegisterViewController * viewController = [sb instantiateViewControllerWithIdentifier:@"user_resgister"];
    [self.navigationController pushViewController:viewController animated:YES];
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
        title.text = @"登录";
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

-(void)hideKey{
    [self.view endEditing:YES];
}
@end
