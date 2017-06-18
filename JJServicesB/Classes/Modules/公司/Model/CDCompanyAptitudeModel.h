//
//  CDCompanyAptitudeModel.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/16.
//  Copyright © 2017年  tianlei. All rights reserved.
//  公司--资质

#import "TLBaseModel.h"


//typedef NS_ENUM(NSUInteger, CompanyAptitudeStatus) {
//    CompanyAptitudeStatusWillCheck,
//    CompanyAptitudeStatusPass,
//    CompanyAptitudeStatusRefuse
//};

@interface CDCompanyAptitudeModel : TLBaseModel

@property (nonatomic, copy) NSString *code;

//@property (nonatomic, copy) NSString *description;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *qualifyName;


//@property (nonatomic, assign ,readonly) CompanyAptitudeStatus aptitudeStatus;

//1 待审核    2审核通过  3审核不通过
@property (nonatomic, copy) NSString *status;

//code = 2;
//description = "\U6444\U5f71/\U62cd\U6444";
//name = "\U6444\U5f71/\U62cd\U6444";
//status = 1;
//type = 2;
//updateDatetime = "Jun 11, 2017 1:12:16 PM";
//updater = admin;

@end
