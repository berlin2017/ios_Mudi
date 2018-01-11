//
//  MuDIModel.m
//  SangYuQing
//
//  Created by mac on 2018/1/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MuDIModel.h"

@implementation MuDIModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"cemetery_id": @"cemetery_id",
             @"liulan_count": @"liulan_count",
             @"sz_id": @"sz_id",
             @"sz_name": @"sz_name",
             @"sz_avatar": @"sz_avatar",
             @"birthdate": @"birthdate",
             @"deathdate": @"deathdate",
             @"create_time": @"create_time",
             @"follow": @"follow",
             @"total_follow": @"total_follow",
             };
}

+ (NSValueTransformer *)followJSONTransformer
{
    return [MTLValueTransformer numberTransformer];
}

+ (NSValueTransformer *)total_followJSONTransformer
{
    return [MTLValueTransformer numberTransformer];
}
@end
