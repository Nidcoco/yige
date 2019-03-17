//
//  LocationHelper.h
//  inManNew
//
//  Created by 杨为聪 on 14-6-23.
//  Copyright (c) 2014年 杨为聪. All rights reserved.
//
#import "LocationHelper.h"
#import <UIKit/UIKit.h>

@interface LocationHelper () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) DidGetGeolocationsCompledBlock didGetGeolocationsCompledBlock;

@end

@implementation LocationHelper

+ (instancetype)helper
{
    static LocationHelper * helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[LocationHelper alloc]init];
    });
    
    return helper;
}

- (void)setup {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 5.0;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        [_locationManager requestWhenInUseAuthorization];
    }
}

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.locationManager.delegate = nil;
    self.locationManager = nil;
    self.didGetGeolocationsCompledBlock = nil;
}

- (void)getCurrentGeolocationsCompled:(DidGetGeolocationsCompledBlock)compled {
    self.didGetGeolocationsCompledBlock = compled;
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManager Delegate

// 代理方法实现
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:
     ^(NSArray* placemarks, NSError* error) {
         
         if (placemarks.count > 0) {
             CLPlacemark * placemark = [placemarks objectAtIndex:0];
             //获取城市
             NSString * city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             NSString *province = placemark.administrativeArea;
             NSDictionary * addressDictionary = placemark.addressDictionary;    //地址详情字典
             
             //储存纬度,经度
             NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:addressDictionary];
             [dict setObject:@(newLocation.coordinate.latitude) forKey:@"latitude"];
             [dict setObject:@(newLocation.coordinate.longitude) forKey:@"longitude"];
             
             if (self.didGetGeolocationsCompledBlock) {
                 self.didGetGeolocationsCompledBlock(dict, province, city);
             }
         }
     }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    [manager stopUpdatingLocation];
}

@end
