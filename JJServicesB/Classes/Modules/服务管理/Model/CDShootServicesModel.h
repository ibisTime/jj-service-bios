//
//  CDShootServicesModel.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDServiceBaseModel.h"

@interface CDShootServicesModel : CDServiceBaseModel

@property (nonatomic, strong) NSNumber *pyNum;
@property (nonatomic, strong) NSNumber *sysNum;
@property (nonatomic, copy) NSString *scpslm; //栏目

@property (nonatomic, copy) NSString *isDz;
@property (nonatomic, copy) NSString *works;

@end
