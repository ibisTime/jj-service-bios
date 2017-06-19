//
//  CDServicesListVC.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "TLBaseVC.h"

typedef NS_ENUM(NSUInteger, ServicesType) {
    ServicesTypeShoot = 0,
    ServicesTypeEdu = 1,
    ServicesTypeOperation = 2
};

@interface CDServicesListVC : TLBaseVC

@property (nonatomic, assign) ServicesType type;
- (void)beginRefresh;

@end
