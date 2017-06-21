//
//  CDCompanyAptitudeModel.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/16.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDCompanyAptitudeModel.h"

@implementation CDCompanyAptitudeModel


+ (NSDictionary *)tl_replacedKeyFromPropertyName {


    return @{@"desc" : @"description"};

}

//- (CompanyAptitudeStatus)aptitudeStatus {
//
//    //0 待审核 1 审核通过 2 审核不通过
//    if ([self.status isEqualToString:@"0"]) {
//        
//        return CompanyAptitudeStatusWillCheck;
//        
//    } else if ([self.status isEqualToString:@"1"]) {
//    
//        return CompanyAptitudeStatusPass;
//
//    
//    } else {
//    
//        return CompanyAptitudeStatusRefuse;
//        
//    }
//
//    
//}


@end
