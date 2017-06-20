//
//  OperationServicesVC.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "ServicesBaseVC.h"
#import "CDOperationServicesModel.h"


@interface OperationServicesVC : ServicesBaseVC

@property (nonatomic, strong) CDOperationServicesModel *operationModel;

@property (nonatomic, copy) void(^success)();

@end
