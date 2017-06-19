//
//  CDEduServicesModel.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDServiceBaseModel.h"

@interface CDEduServicesModel : CDServiceBaseModel

@property (nonatomic, strong) NSNumber *lectorNum;
@property (nonatomic, strong) NSNumber *mtrainNum;
@property (nonatomic, strong) NSNumber *mtrainTimes;

@property (nonatomic, copy) NSString *resume1;
@property (nonatomic, copy) NSString *resume2;
@property (nonatomic, copy) NSString *resume3;
@property (nonatomic, copy) NSString *course;



@end
