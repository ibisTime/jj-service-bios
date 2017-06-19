//
//  CDServicesHelper.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDServicesHelper : NSObject

+ (instancetype)helper;

@property (nonatomic, copy) NSString *aptitudeType;

@property (nonatomic, copy) NSString *addServiceCode;
@property (nonatomic, copy) NSString *changeServiceCode;
@property (nonatomic, copy) NSString *deleteServiceCode;
@property (nonatomic, copy) NSString *listServiceCode;


@end
