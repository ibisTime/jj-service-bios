//
//  EduServicesVC.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "ServicesBaseVC.h"
#import "CDEduServicesModel.h"

@interface EduServicesVC : ServicesBaseVC

@property (nonatomic, strong) CDEduServicesModel *eduModel;

//
@property (nonatomic, copy) void(^success)();

@end
