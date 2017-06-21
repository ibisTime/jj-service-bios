 //
//  CDCompany.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/15.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDCompany.h"

#define ZH_SHOP_INFO_KEY @"ZH_SHOP_INFO_KEY"


@implementation CDCompany

+ (instancetype)company {
    
    static CDCompany *company;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        company = [[CDCompany alloc] init];

    });
    
    return company;
    
}

- (void)loginOut {

    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    // 遍历
    for (int i = 0; i < count; i++) {
        
        // An opaque type that represents an Objective-C declared property.
        objc_property_t property = properties[i];
        // 获取属性的名称
        const char *cName = property_getName(property);
        
        
        // 转换为Objective
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        //基础数据类型，不能置为nil
        if ([name isEqualToString:@"aptitudeType"] || [name isEqualToString:@"detailPics"]) {
            
            continue;
        }
        
        [self setValue:nil forKeyPath:name];
    }

}


- (AptitudeType)aptitudeType {

    if (self.gsQualify) {
//        0 待审核 1 审核通过 2 审核不通过
        if ([self.gsQualify.status isEqualToString:@"1"]) {
            
            return AptitudeTypeWillCheck;

        } else  if ([self.gsQualify.status isEqualToString:@"2"]) {
            
            return AptitudeTypePass;

            
        } if ([self.gsQualify.status isEqualToString:@"3"]) { //拒绝
            
            return AptitudeTypeRefuse;
            
        }

        //
        return 1000;
        
    } else { //未申请
    
        return AptitudeTypeUnApply;
    
    }
    
}


- (void)getShopInfoSuccess:(void(^)(NSDictionary *shopDict))success failure:(void(^)(NSError *error))failure {
    
    if (![ZHUser user].userId) {
        return;
    }
    
    //
    TLNetworking *http = [TLNetworking new];
    http.code = @"612063";
    http.parameters[@"userId"] = [ZHUser user].userId;
    http.parameters[@"token"] = [ZHUser user].token;
    
    //
    [http postWithSuccess:^(id responseObject) {
        
        NSDictionary *dict = responseObject[@"data"];
        
        //        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:array[0][@"store"]];
        if (dict.allKeys.count > 0) {
            //            dict[@"totalIncome"] = array[0][@"totalIncome"];
            //
            [self changCompanyInfoWithDict:dict];
            
            if (success) {
                success(dict);
            }
            
        } else {
            
            if (success) {
                success(nil);
            }
        }
        
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
    
}

- (void)getAptitudeModelsSuccess:(void(^)())success failure:(void(^)())failure {


    TLNetworking *http = [TLNetworking new];
    http.code = @"612016";
    //0 待审核 1 审核通过 2 审核不通过
    //    http.parameters[@"status"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        
        
        self.aptitudeModles = [CDCompanyAptitudeModel tl_objectArrayWithDictionaryArray:responseObject[@"data"]];
        
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:3];
        
        [self.aptitudeModles enumerateObjectsUsingBlock:^(CDCompanyAptitudeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
//            NSLog(@"%@-%@",obj.name,obj.code);

            if ([obj.code isEqualToString:@"1"] || [obj.code isEqualToString:@"2"] || [obj.code isEqualToString:@"4"]) {
                
                [arr addObject:obj];
//               人才招聘-9
//                产业园-8
//                 软件开发-7
//                仓配服务-6
//             客服外包-5
//                店铺代运营-4
//                 美工外包-3
//                摄影/拍摄-2
//                培训-1
                

            }
        }];
        
        self.aptitudeModles = arr;
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure();
        }
        
    }];

}




- (NSArray<NSString *> *)detailPics {
    
    return [self.pic componentsSeparatedByString:@"||"];
}

- (void)changCompanyInfoWithDict:(NSDictionary *)dict {
    
    
    //
//    [self setValuesForKeysWithDictionary:dict];
    
    self.code = dict[@"code"];
    self.name = dict[@"name"];
    self.corporation = dict[@"corporation"];
    self.remark = dict[@"remark"];

    self.city = dict[@"city"];
    self.province = dict[@"province"];
    self.area = dict[@"area"];
    self.latitude = dict[@"latitude"];
    self.longitude = dict[@"longitude"];
    self.address = dict[@"address"];

    //图片
    self.advPic = dict[@"advPic"];
    self.logo = dict[@"logo"];
    self.pic = dict[@"pic"];
    
    
    //
    self.scale = dict[@"scale"];
    self.slogan = dict[@"slogan"];
    self.desc = dict[@"description"];
    self.mobile = dict[@"mobile"];
    self.registeredCapital = dict[@"registeredCapital"];
    self.regtime = dict[@"regtime"];
    
    
    if (dict[@"gsQualify"]) {
     
        CDCompanyAptitudeModel *model = [CDCompanyAptitudeModel tl_objectWithDictionary:dict[@"gsQualify"]];
        //
        self.gsQualify = model;
        
    }
 
    
    //
    //存储信息
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:ZH_SHOP_INFO_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"%@ %@",key,value);
    
}

@end
