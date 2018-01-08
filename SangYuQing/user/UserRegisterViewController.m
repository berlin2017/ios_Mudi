//
//  UserRegisterViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "UIView+ToastHelper.h"
#import "UserRuleViewController.h"

@interface UserRegisterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *toLogin_label;
@property (weak, nonatomic) IBOutlet UIImageView *checkBox;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *ruleLabel;
@property(nonatomic,assign) BOOL isChecked;
@property (strong, nonatomic) IBOutlet UIControl *contentView;
@end

@implementation UserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isChecked = false;
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *key_recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKey)];
    [self.view addGestureRecognizer:key_recognizer];
    
    _toLogin_label.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tologin)];
    [_toLogin_label addGestureRecognizer:recognizer];
    
    _checkBox.userInteractionEnabled = YES;
    UITapGestureRecognizer *check_recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkChanged)];
    [_checkBox addGestureRecognizer:check_recognizer];
    
    _ruleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *rule_recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toRule)];
    [_ruleLabel addGestureRecognizer:rule_recognizer];
    
    [_sendBtn addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
}

-(void)tologin{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)checkChanged{
    if (_isChecked) {
        _isChecked = NO;
        _checkBox.image = [UIImage imageNamed:@"ic_check_normal"];
    }else{
        _isChecked = YES;
        _checkBox.image = [UIImage imageNamed:@"ic_check_checked"];
    }
}

-(void)sendCode{
    [self.view makeCenterOffsetToast:@"发送成功"];
}

-(void)toRule{
    UserRuleViewController *controller = [[UserRuleViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)hideKey{
    [self.view endEditing:YES];
}

@end
