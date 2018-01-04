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
#import "UserLoginViewController.h"

@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,AddressPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong) UIView *navigationView;       // 导航栏
@property (nonatomic,strong) UIImageView *scaleImageView; // 顶部图片
@property (nonatomic ,strong) AddressPickerView * pickerView;
@property (nonatomic ,strong) NSString * location_string;
@property (nonatomic ,strong) UITableView * tableview;
@property (nonatomic ,strong) UIImage* photo;
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
        cell .backgroundColor = [UIColor colorWithHexString:@"DFDFDF"];
        if (_photo) {
            [cell setPhotoWithImage:_photo];
        }else{
            [cell setPhotoWithUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514450989988&di=b9d2b71adc10306f918cc5ff3db4ebae&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01e4a1564da3d76ac7251c94308050.png%401280w_1l_2o_100sh.png"];
        }
        return cell;
    }
    
    UserInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userinfo_cell"];
    cell.backgroundColor = [UIColor colorWithHexString:@"DFDFDF"];
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
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        alert.view.tintColor = [UIColor blackColor];
        //通过拍照上传图片
        UIAlertAction * takingPicAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {

                UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }

        }];
        //从手机相册中选择上传图片
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }

        }];

        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }];

        [alert addAction:takingPicAction];
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
       
        return;
    }
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改昵称" message:@"请输入昵称" preferredStyle:UIAlertControllerStyleAlert];
            //以下方法就可以实现在提示框中输入文本；
            
            //在AlertView中添加一个输入框
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
                textField.placeholder = @"请输入昵称";
            }];
            
            //添加一个确定按钮 并获取AlertView中的第一个输入框 将其文本赋值给BUTTON的title
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
                
                //输出 检查是否正确无误
                NSLog(@"你输入的文本%@",envirnmentNameTextField.text);
                
                
            }]];
            
            //添加一个取消按钮
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            
            //present出AlertView
            [self presentViewController:alertController animated:true completion:nil];
            break;
        }
        case 2:{
            UIAlertController * sheet = [UIAlertController alertControllerWithTitle:nil message:@"选择性别" preferredStyle:UIAlertControllerStyleActionSheet];
            
            [sheet addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
                
                NSLog(@"在这里处理选择之后的事");
                
            }]];
            
            [sheet addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
                
                NSLog(@"在这里处理选择之后的事");
                
            }]];
            
            [sheet addAction:[UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:sheet animated:YES completion:nil];
            break;
        }
        case 3:{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改手机号码" message:@"请输入手机号码" preferredStyle:UIAlertControllerStyleAlert];
            //以下方法就可以实现在提示框中输入文本；
            
            //在AlertView中添加一个输入框
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
                textField.placeholder = @"请输入手机号码";
            }];
            
            //添加一个确定按钮 并获取AlertView中的第一个输入框 将其文本赋值给BUTTON的title
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
                
                //输出 检查是否正确无误
                NSLog(@"你输入的文本%@",envirnmentNameTextField.text);
                
                
            }]];
            
            //添加一个取消按钮
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            
            //present出AlertView
            [self presentViewController:alertController animated:true completion:nil];
            break;
        }
        case 4:
            [_pickerView show];
            break;
            
        default:
            break;
    }
}

#pragma mark 调用系统相册及拍照功能实现方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * chosenImage = info[UIImagePickerControllerEditedImage];
    UIImageView * picImageView = (UIImageView *)[self.view viewWithTag:500];
    picImageView.image = chosenImage;
    chosenImage = [self imageWithImageSimple:chosenImage scaledToSize:CGSizeMake(60, 60)];
    NSData * imageData = UIImageJPEGRepresentation(chosenImage, 0.9);
    
    _photo = chosenImage;
    [_tableview reloadData];
    
    //    [self saveImage:chosenImage withName:@"avatar.png"];
    //    NSURL * filePath = [NSURL fileURLWithPath:[self documentFolderPath]];
    //将图片上传到服务器
    //    --------------------------------------------------------
    //    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:nil];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/json", nil];
    //    NSString * urlString = [NSString stringWithFormat:@"%@appuser/modifyUserIcon",BASE_URL];
    //    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    //    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:1];
    //    [dict setObject:[userDefaults objectForKey:@"user_id"] forKey:@"user_id"];
    //    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //        //通过post请求上传用户头像图片,name和fileName传的参数需要跟后台协商,看后台要传的参数名
    //        [formData appendPartWithFileData:imageData name:@"img" fileName:@"img.jpg" mimeType:@"image/jpeg"];
    //
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        //解析后台返回的结果,如果不做一下处理,打印结果可能是一些二进制流数据
    //        NSError *error;
    //        NSDictionary * imageDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
    //        //上传成功后更新数据
    //        self.personModel.adperurl = imageDict[@"adperurl"];
    //        NSLog(@"上传图片成功0---%@",imageDict);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"上传图片-- 失败  -%@",error);
    //    }];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
//用户取消选取时调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

@end
