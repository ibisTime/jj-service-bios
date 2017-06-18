//
//  ZHMapController.h
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/14.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "TLBaseVC.h"
#import <CoreLocation/CoreLocation.h>

@interface ZHMapController : TLBaseVC
@property (nonatomic,copy)  void(^confirm)(CLLocationCoordinate2D point,NSString *detailAddress);

@end
