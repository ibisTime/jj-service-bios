//
//  ZHMapController.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/14.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHMapController.h"
#import <MapKit/MapKit.h>

@interface ZHMapController ()<MKMapViewDelegate>

@property (nonatomic,assign) BOOL isFirst;
@property (nonatomic,strong) UIImageView *locationImageView;
@property (nonatomic,strong) MKMapView *mapV;
@property (nonatomic,assign) BOOL isFailure;

@end

@implementation ZHMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFirst = NO;
    self.isFailure = NO;
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    self.title = @"选择位置";
    //显示用户位置
    mapView.showsUserLocation = YES;
    mapView.userTrackingMode = MKUserTrackingModeNone;
    mapView.delegate = self;
    [self.view addSubview:mapView];
    self.mapV = mapView;
    
    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmAction)];
    self.locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, (SCREEN_HEIGHT - 64)/2.0, 66, 107)];
    self.locationImageView.center = CGPointMake(SCREEN_WIDTH/2.0, (SCREEN_HEIGHT - 64)/2.0);
//    self.locationImageView.backgroundColor = [UIColor orangeColor];
    self.locationImageView.image = [UIImage imageNamed:@"greenPin_lift"];
    [self.view addSubview:self.locationImageView];
    
    
}

- (void)confirmAction {

    if (_isFailure) {
        [TLAlert alertWithHUDText:@"定位失败"];
        return;
    }
    
    
    CLLocationCoordinate2D locationPoint = [self.mapV convertPoint:self.locationImageView.center toCoordinateFromView:self.view];
    
    
    if (self.confirm) {
        self.confirm(locationPoint,nil);
        [self.navigationController popViewControllerAnimated:YES];

    }
    
    //            CLPlacemark *placeMark = placemarks[0];
    //
    //            NSString *detailAddress = [NSString stringWithFormat:@"%@%@%@",placeMark.locality ? placeMark.locality : @"" ,placeMark.subLocality ?placeMark.subLocality : @"" ,placeMark.thoroughfare ? placeMark.thoroughfare : @""];
    


}

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView {


//    NSLog(@"开始定位");
//    [TLAlert alertWithHUDText:@"定位失败"];


}

- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView {

//    NSLog(@"停止定位");

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation  {

    if (userLocation && !_isFirst)
    {
        _isFirst = YES;
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location,1500 ,1500);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:region];
        [mapView setRegion:adjustedRegion animated:NO];
    }

}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {

    [TLAlert alertWithHUDText:@"无法获取您当前位置"];

}


@end
