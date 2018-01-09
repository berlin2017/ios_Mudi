//
//  HZLocationManager.m
//  AnhuiNews
//
//  Created by History on 15/8/19.
//  Copyright © 2015年 ahxmt. All rights reserved.
//

#import "HZLocationManager.h"
#import <BaiduMapAPI/BMapKit.h>

NSString * const kHZLocationManagerDidUpdateUserLocationNotification = @"com.history.location.manager.did.update.user.location.notification";
NSString * const kHZLocaitonManagerDidGetReverseGeoCodeNotification = @"com.history.location.manager.did.get.reverse.geo.code.notification";

NSString * const kHZLocationCoordinate              = @"com.history.location.coordinate";
NSString * const kHZLocationLatitude                = @"com.history.location.latitude";
NSString * const kHZLocationLongitude               = @"com.history.location.longitude";
NSString * const kHZLocationAddress                 = @"com.history.location.address";

@interface HZLocationManager () <BMKGeoCodeSearchDelegate, BMKLocationServiceDelegate>
{
    BMKGeoCodeSearch *_geoCodeSearch;
    BMKLocationService *_locService;
}
@end

@implementation HZLocationManager
@synthesize coordinate = _coordinate;
@synthesize addressDetail = _addressDetail;

+ (instancetype)share
{
    static HZLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[HZLocationManager alloc] init];
        }
    });
    
    return manager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
        _geoCodeSearch.delegate = self;
        
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
    }
    return self;
}

- (void)startUserLocationService
{
    [_locService startUserLocationService];
}

- (void)dealloc
{
//    _geoCodeSearch.delegate = self;
//    _locService.delegate = self;
}

#pragma mark - Location
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (!error) {
        NSString *address = [NSString stringWithFormat:@"%@,%@,%@,%@,%@", result.addressDetail.province, result.addressDetail.city, result.addressDetail.district, result.addressDetail.streetName, result.addressDetail.streetNumber];
        HZLog(@"%@", address);
        [HZPreference saveObject:address forKey:kHZLocationAddress];
        _addressDetail = result.addressDetail;
        _hasReversed = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:kHZLocaitonManagerDidGetReverseGeoCodeNotification object:nil];
    }
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_locService stopUserLocationService];
    
    [HZPreference saveCoordinate:userLocation.location.coordinate forKey:kHZLocationCoordinate];
    _hasLocated = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:kHZLocationManagerDidUpdateUserLocationNotification object:nil];
    _coordinate = userLocation.location.coordinate;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL res =
    [_geoCodeSearch reverseGeoCode:reverseGeocodeSearchOption];
    if (!res) {
        HZLog(@"反编码失败");
    }
}

#pragma mark - Getter & Setter
- (CLLocationCoordinate2D)coordinate
{
    if (_hasLocated) {
        return _coordinate;
    }
    else {
        return [HZPreference coordinateForKey:kHZLocationCoordinate];
    }
}
- (BMKAddressComponent *)addressDetail
{
    if (_hasReversed) {
        return _addressDetail;
    }
    else {
        NSString *addressString = [HZPreference objectForKey:kHZLocationAddress];
        NSArray *array = [addressString componentsSeparatedByString:@","];
        if (addressString && 5 == array.count) {
            BMKAddressComponent *component = [[BMKAddressComponent alloc] init];
            component.province     = array[0];
            component.city         = array[1];
            component.district     = array[2];
            component.streetName   = array[3];
            component.streetNumber = array[4];
            return component;
        }
        else {
            return nil;
        }
    }
}
@end
