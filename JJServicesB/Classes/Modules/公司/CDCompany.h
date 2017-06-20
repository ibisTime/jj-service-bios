//
//  CDCompany.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/15.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDCompanyAptitudeModel.h"

#define SHOOT_APTITUDE_KEY @"2"
#define EDU_APTITUDE_KEY @"1"
#define OPERATION_APTITUDE_KEY @"4"


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
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *province;

//图片
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *advPic; //多张

@property (nonatomic, copy, readonly) NSArray <NSString *>*detailPics;
/**
 广告语
 */
@property (nonatomic, copy) NSString *slogan;
//规模
@property (nonatomic, copy) NSString *scale;

@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *registeredCapital;
@property (nonatomic, copy) NSString *regtime;
@property (nonatomic, copy) NSString *desc;


//(1 店铺 2个体户)
@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *updateDatetime;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *token;


//
@property (nonatomic, strong) CDCompanyAptitudeModel *gsQualify;

@property (nonatomic, assign, readonly) AptitudeType aptitudeType;

@property (nonatomic, copy) NSArray <CDCompanyAptitudeModel *>*aptitudeModles;

- (void)loginOut;

+ (instancetype)company;

- (void)getShopInfoSuccess:(void(^)(NSDictionary *shopDict))success failure:(void(^)(NSError *error))failure;

- (void)getAptitudeModelsSuccess:(void(^)())success failure:(void(^)())failure;

//address = "\U9690\U9690\U7ea6\U7ea6";
//advPic = "IOS_1497840833637814_1536_2048.jpg";

//area = "\U8354\U6e7e\U533a";
//city = "\U5e7f\U5dde\U5e02";
//code = CO201706191037413175;
//corporation = "\U767e\U5408";
//description = qwe;
//gsQualify =         {
//    applyDatetime = "Jun 19, 2017 10:38:01 AM";
//    applyUser = U201706191037412878219;
//    code = GQ201706191038018606;
//    companyCode = CO201706191037413175;
//    qualifyCode = 7;
//    qualifyName = "\U8f6f\U4ef6\U5f00\U53d1";
//    qualifyType = 7;
//    slogan = "\U6211";
//    status = 2;
//};
//gzNum = 0;
//idNo = "ios\U2014\U2014test";
//latitude = "30.28820988806264";
//location = 0;
//logo = "IOS_1497840833637626_750_1334.jpg";
//longitude = "120.00163680059602";
//mobile = 125;
//name = ios;
//orderNo = 0;
//pic = "IOS_1497840833637814_1536_2048.jpg";
//priceRange = 123;
//province = "\U5e7f\U4e1c\U7701";
//registeredCapital = 23;
//regtime = 12;
//scale = ty;
//slogan = qwe;
//status = 1;
//type = 2;
//updateDatetime = "Jun 19, 2017 10:53:58 AM";
//updater = U201706191037412878219;
//userId = U201706191037412878219;
@end
