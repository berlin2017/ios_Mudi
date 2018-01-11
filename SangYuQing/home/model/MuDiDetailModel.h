//
//  MuDiDetailModel.h
//  SangYuQing
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MuDiDetailModel : MTLModel <MTLJSONSerializing>

@property(nonatomic,copy)NSString *account_name;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *sz_name;
@property(nonatomic,copy)NSString *sz_avatar;
@property(nonatomic,copy)NSString *cemetery_id;
@property(nonatomic,copy)NSString *sz_id;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *jibai_count;
@property(nonatomic,assign)NSString *liulan_count;

@property(nonatomic,copy)NSString *total_jifen;
@property(nonatomic,assign)NSString *birthdate;
@property(nonatomic,copy)NSString *deathdate;
@property(nonatomic,assign)NSString *mubei;
@property(nonatomic,assign)NSString *beijing;

@property(nonatomic,assign)NSInteger follow;
@end
