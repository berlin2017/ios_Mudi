//
//  UserScoreViewController.m
//  SangYuQing
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UserScoreViewController.h"
#import "UserScoreCollectionViewCell.h"
#import "UIColor+Helper.h"
#import "UIView+ToastHelper.h"
#import "UserScorePayCollectionViewCell.h"
#import "UserScoreDetailViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import "WXApi.h"

@interface UserScoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WXApiDelegate>
@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@property(nonatomic,copy)NSIndexPath *lastIndexPath;
@property(nonatomic,copy)NSIndexPath *lastPayIndexPath;
@end

@implementation UserScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"main_bg"]];
    [self.view setBackgroundColor:bgColor];
    [self.view addSubview:self.navigationView];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *key_recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    
    
    UIScrollView * scrollview = [[UIScrollView alloc]init];
    [self.view addSubview:scrollview];
    scrollview.userInteractionEnabled = YES;
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
    }];

    UIView *contentview = [[UIView alloc]init];
    [scrollview addSubview:contentview];
    contentview.userInteractionEnabled = YES;

    UIView *topview = [[UIView alloc]init];
    [contentview addSubview:topview];
    topview.userInteractionEnabled = YES;
    [topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.top.mas_equalTo(self.navigationView.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(100);
    }];
    UIImageView *bg = [[UIImageView alloc]init];
    [topview addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(topview);
    }];
    bg.image = [UIImage imageNamed:@"user_jifen_bg"];


    UILabel *score = [[UILabel alloc]init];
    [topview addSubview:score];
    [score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(topview);
    }];
    score.text = @"0";
    score.font = [UIFont systemFontOfSize:19];



    UILabel *name = [[UILabel alloc]init];
    [topview addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topview);
        make.right.mas_equalTo(score.mas_left).mas_offset(-40);
    }];
    name.text = @"当前积分:";
    name.font = [UIFont systemFontOfSize:15];

    UILabel *jifen = [[UILabel alloc]init];
    [topview addSubview:jifen];
    [jifen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topview);
        make.left.mas_equalTo(score.mas_left).mas_offset(40);
    }];
    jifen.text = @"积分";
    jifen.font = [UIFont systemFontOfSize:15];



    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-60)/3 , 60);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    UICollectionView *collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionview.delegate = self;
    collectionview.dataSource = self;
    collectionview.tag = 1000;
    collectionview.userInteractionEnabled = YES;
    [collectionview registerNib:[UINib nibWithNibName:@"UserScoreCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"score_jifen_cell"];
    [contentview addSubview:collectionview];

    collectionview.backgroundColor = [UIColor clearColor];
    [collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.top.mas_equalTo(topview.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(60*2+20);
    }];
    
    UICollectionViewFlowLayout *layout2 = [UICollectionViewFlowLayout new];
    layout2.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-60)/2 , 50);
    layout2.minimumLineSpacing = 10;
    layout2.minimumInteritemSpacing = 10;
    UICollectionView *collectionview2 = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout2];
    collectionview2.delegate = self;
    collectionview2.dataSource = self;
    collectionview2.tag = 2000;
        collectionview2.userInteractionEnabled = YES;
    [collectionview2 registerNib:[UINib nibWithNibName:@"UserScorePayCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"score_pay_cell"];
    [contentview addSubview:collectionview2];
    collectionview2.backgroundColor = [UIColor clearColor];
    [collectionview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.top.mas_equalTo(collectionview.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(60);
    }];

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [contentview addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width*0.6);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(collectionview2.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(40);
    }];
    btn.userInteractionEnabled = YES;
    [btn setTitle:@"确认支付" forState: UIControlStateNormal];
    btn.tintColor = [UIColor whiteColor];
    btn.backgroundColor = [UIColor colorWithHexString:@"CD853F"];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];

    UILabel *bottom_name = [[UILabel alloc]init];
    [contentview addSubview:bottom_name];
    [bottom_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn.mas_bottom).mas_offset(40);
        make.left.mas_equalTo(self.view).mas_equalTo(10);
        make.right.mas_equalTo(self.view).mas_equalTo(-10);
    }];
    bottom_name.text = @"支付说明";
    bottom_name.userInteractionEnabled = YES;
    bottom_name.font = [UIFont systemFontOfSize:19];

    UILabel *bottom_detail = [[UILabel alloc]init];
    [contentview addSubview:bottom_detail];
    [bottom_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottom_name.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view).mas_equalTo(10);
        make.right.mas_equalTo(self.view).mas_equalTo(-10);
    }];
    bottom_detail.numberOfLines = 0;
    bottom_detail.text = @"支付说明shjdkfl;kksdffffffffffffffff";
    bottom_detail.font = [UIFont systemFontOfSize:15];

    UILabel *bottom_name2 = [[UILabel alloc]init];
    [contentview addSubview:bottom_name2];
    [bottom_name2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottom_detail.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view).mas_equalTo(10);
        make.right.mas_equalTo(self.view).mas_equalTo(-10);
    }];
    bottom_name2.text = @"支付说明";
    bottom_name2.font = [UIFont systemFontOfSize:19];

    UILabel *bottom_detail2 = [[UILabel alloc]init];
    [contentview addSubview:bottom_detail2];
    [bottom_detail2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottom_name2.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view).mas_equalTo(10);
        make.right.mas_equalTo(self.view).mas_equalTo(-10);
    }];
    bottom_detail2.numberOfLines = 0;
    bottom_detail2.text = @"支付说明shjdkfl;kksdffffffffffffffff";
    bottom_detail2.font = [UIFont systemFontOfSize:15];

    [contentview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(bottom_detail2.mas_bottom);
        make.right.mas_equalTo(self.view);
    }];
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 1000) {
        return 6;
    }
        return 2;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1000) {
        UserScoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"score_jifen_cell" forIndexPath:indexPath];
        return cell;
    }else{
        UserScorePayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"score_pay_cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        [cell configWithIndex:indexPath.row];
        return cell;
    }
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"cell #%d was selected", indexPath.row);
    return;
}

//当cell高亮时返回是否高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//     UserScoreCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath ];
//    //设置(Highlight)高亮下的颜色
//   [cell setBackgroundColor:[UIColor clearColor]];
//}

- (void)collectionView:(UICollectionView *)collectionView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1000) {
        if (indexPath!=_lastIndexPath) {
            UserScoreCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath ];
            [cell setBackColor:[UIColor colorWithHexString:@"CD853F"]];
            UserScoreCollectionViewCell *cell2 = [collectionView cellForItemAtIndexPath:_lastIndexPath ];
            [cell2 setBackColor:[UIColor clearColor]];
            _lastIndexPath = indexPath;
        }
    }else if(collectionView.tag == 2000){
        if (indexPath!=_lastPayIndexPath) {
            UserScorePayCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath ];
            [cell setBoraderColor:[UIColor colorWithHexString:@"CD853F"]];
            UserScorePayCollectionViewCell *cell2 = [collectionView cellForItemAtIndexPath:_lastPayIndexPath ];
            [cell2 setBoraderColor:[UIColor clearColor]];
            _lastPayIndexPath = indexPath;
        }
    }
   
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
        title.text = @"我的积分";
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
        
        UILabel *right_title = [[UILabel alloc]init];
        [_navigationView addSubview:right_title];
        [right_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_navigationView).mas_offset(-10);
            make.bottom.mas_equalTo(_navigationView).mas_offset(-17);
            make.height.mas_equalTo(30);
        }];
        right_title.font = [UIFont systemFontOfSize:14];
        right_title.text = @"积分记录";
        right_title.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toLog)];
        [right_title addGestureRecognizer:tap];
    }
    return _navigationView;
}

-(void)toLog{
    UserScoreDetailViewController *controller = [[UserScoreDetailViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)hideKey{
//    [self.view endEditing:YES];
    [self.view makeCenterOffsetToast:@"hsdfjklsd;fl"];
}

-(void)toPay{
    if (_lastPayIndexPath.row==0) {
        [self weixinPay];
    }else{
        [self aliPay];
    }
}

-(void)weixinPay{
    //调起微信支付
    PayReq *request = [[[PayReq alloc] init] autorelease];
    
    request.partnerId = @"10000100";
    
    request.prepayId= @"1101000000140415649af9fc314aa427";
    
    request.package = @"Sign=WXPay";
    
    request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
    
    request.timeStamp= @"1397527777";
    
    request.sign= @"582282D72DD2B03AD892830965F428CB16E7A256";
    
    [WXApi sendReq:request];
    
}

-(void)aliPay{
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2017101009233282";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCZArg62iof19Bphh+AJa0VbU/ilQDVQzj7iGhjq4ntZFSUec21xeA1jNw5oo+stHJT40n8UFE3K4ev+kaGkhouXlZYJLsxksRtMPQ3cSEcE1ufIL8/2W8uXKr273PtW4n/jg23nBXUyusQLT6L57kk/pU0dV7R8d/fZTEzbnTIFXneXTdQp+LmITotSQ3UxFAM6Dv7ofVc2THJwKeJueGl4Xogrv1lvU1+T+cszQ+Zvi1hFm2h4Vr+Ibtv9GKlRlJURvrB+rBeHAvsiehBNMxFXXwJWjsr+yoCbfnTWsKnSUrKMSZRiR+HnGeJ/8UjLexe0HR6Hgyhy2xJrBuDuvUvAgMBAAECggEATehFl6mnkykWs/QXq+8DDwrmhu7pSqz8oY4V4NHh256fNi5CoJANFhcPtsTftMb4A2CSNkdK4vVmFCMxr6lKbVuZSS4Cpj4dh59KacRPYHU2zHInDsKOSqPiZPMNKsjWHendcCSoNP3Q7B6tXxzwdzatD9XHHsyx+ZQTliVijtEY/WzteW9sZdnf2LaTbQ0uDgxWd+u/oJc2HHiWiVXZKVT+xBwRP+1j9S6uZ2hHNDRp6Uzc5ENSAymjCIFvn0aR6QC8AC5tpIRMxgLRU8NzVqJEmk5e0KPtQkKlaG8O4t30SmuImS3umAaxOf2M59s1F1/3uFHVpB9UqsHMsvtSsQKBgQD8dYjdNeDHjNBGmnwnioL9fQyk8B12741UicTYBOwD1krdil7eqUkrA20FiD8N9wOKO2SrDKPOeMAYnDwiIdZYPSf0QQPZ1Yic+TDrNQ+ARfDr3VTETcuqpCVeDxV2u6NYWn7x9seTN/f9tJDE/SI+jZS+A+PBGlXRie+HsB/eNwKBgQCbKBxkD08o30VyMxOCeamFHBB9oFlAXgH4y0pS3ERuH6J0xwW/OO5kqvfYC3GMCermTuyf0D4XbDpwedlJJ3GIabnhZ1RX2YGOT3s1sQWYo2dp4K1IqR8qQYnEfOlqr1ljla41FeXMjhSsPEp/viNU3bj0OaeYaJKupCkfQ1hkyQKBgFIEMRmEhmjtw0Acshb6dcG6XWA8LaZU/ronI872EmLQvHOqn1WA86dIrqNsduenhvvifbrgGVtbeTTFlPeVvJfgDlnYwVKEf6RXhF/1VfrbPgCyX/aCO5dNSmJ7TgLLxK5QgAtFm+Kk/Sjr/1gv0G83+cmdY+F5F8ZCJJIVUtUTAoGAdnfR9bSaxKJ17BSDuQQcI76h+MoOW89rwgO25D27IjqVWIT+JlvZ6pOAWj2inUKVUPTCR+RBBLFmjar79ZdgYMAZZbn39HvnKDoX4Y8grsNVmsoqhWhcm28fOiAGOadZoWgQdAgcRmvV7Qy79X3AjHQfXJsJFJ4EIcTGgVBylcECgYAB7UEd6dAzh33B1VKUTK3GBue8TeX9A0tQHP4e348stwWmFAxQmZxX/WV7/ePaQLFpcXrPoUEVgc92T0gRC/JcQisnzwZP++fOL5a6eVEuXI3KdC0qeKtRcYkqs7bIA+fDFp13XlhWHy6fYmE/J3Ytp5mmZdVAGSQZMzRMqhu/Nw==";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少appId或者私钥,请检查参数设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           
                                                       }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}



#pragma mark -
#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
