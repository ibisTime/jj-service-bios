//
//  CDServiceTypeChooseVC.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//  添加服务之前，先选择类型

#import "TLBaseVC.h"

@interface CDServiceTypeChooseVC : TLBaseVC

@property (nonatomic, copy) void(^selected)(NSInteger idx);

@end
