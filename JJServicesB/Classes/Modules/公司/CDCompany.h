//
//  CDCompany.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/15.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDCompanyAptitudeModel.h"

typedef NS_ENUM(NSUInteger, AptitudeType) {

    AptitudeTypeUnApply,
    AptitudeTypeWillCheck,
    AptitudeTypeRefuse,
    AptitudeTypePass
   
};

@interface CDCompany : NSObject

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *corporation;
@property (nonatomic, copy) NSString *idNo;

@property (nonatomic, copy) NSString *remark;


@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *name;

//
@property (nonatomic, copy) NSString *status;

//(1 公司 2个体户)
@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *updateDatetime;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *token;

//
@property (nonatomic, strong) CDCompanyAptitudeModel *gsQualify;

@property (nonatomic, assign, readonly) AptitudeType aptitudeType;


+ (instancetype)company;

- (void)getShopInfoSuccess:(void(^)(NSDictionary *shopDict))success failure:(void(^)(NSError *error))failure;

@end
