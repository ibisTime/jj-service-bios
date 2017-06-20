//
//  ShootServicesVC.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "ServicesBaseVC.h"
#import "CDShootServicesModel.h"

@interface ShootServicesVC : ServicesBaseVC

@property (nonatomic, strong) CDShootServicesModel *shootModel;

@property (nonatomic, copy) void(^success)();

@end
