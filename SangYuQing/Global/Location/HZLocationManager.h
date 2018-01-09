//
//  HZLocationManager.h
//  AnhuiNews
//
//  Created by History on 15/8/19.
//  Copyright © 2015年 ahxmt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BMKAddressComponent;

extern NSString * const kHZLocationManagerDidUpdateUserLocationNotification;
extern NSString * const kHZLocaitonManagerDidGetReverseGeoCodeNotification;

extern NSString * const kHZLocationCoordinate;
extern NSString * const kHZLocationLatitude;
extern NSString * const kHZLocationLongitude;
extern NSString * const kHZLocationAddress;

@interface HZLocationManager : NSObject
@property (nonatomic, assign, readonly) BOOL hasLocated;
@property (nonatomic, assign, readonly) BOOL hasReversed;
@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong, readonly) BMKAddressComponent *addressDetail;
+ (instancetype)share;
- (void)startUserLocationService;
@end
