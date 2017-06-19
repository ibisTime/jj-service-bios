//
//  CDServicesHelper.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDServicesHelper.h"


#define ADD_SERVICES_CODE_KEY @"ADD"
#define CHANGE_SERVICES_CODE_KEY @"CHANGE"
#define DELETE_SERVICES_CODE_KEY @"DELETE"
#define LIST_SERVICES_SERVICES_CODE_KEY @"PAGE"

@implementation CDServicesHelper


+ (instancetype)helper {

    static CDServicesHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        helper = [[CDServicesHelper alloc] init];
        
    });
    
    return helper;

}

- (void)setAptitudeType:(NSString *)aptitudeType {

    _aptitudeType = [aptitudeType copy];
    
//    (1 摄影/2 拍摄 3培训/ 4店铺代运营 /5培训 /6美工)
    
    NSDictionary *dict = @{
                           
                           @"1" : @{
                                   ADD_SERVICES_CODE_KEY : @"612080",
                                   DELETE_SERVICES_CODE_KEY : @"612081",
                                   CHANGE_SERVICES_CODE_KEY : @"612082",
                                   LIST_SERVICES_SERVICES_CODE_KEY : @"612086"
                                   },
                           
                           @"2" : @{
                                   ADD_SERVICES_CODE_KEY : @"612080",
                                   DELETE_SERVICES_CODE_KEY : @"612081",
                                   CHANGE_SERVICES_CODE_KEY : @"612082",
                                   LIST_SERVICES_SERVICES_CODE_KEY : @"612086"
                                   },
                           
                           @"3" : @{
                                   ADD_SERVICES_CODE_KEY : @"612090",
                                   DELETE_SERVICES_CODE_KEY : @"612091",
                                   CHANGE_SERVICES_CODE_KEY : @"612092",
                                   LIST_SERVICES_SERVICES_CODE_KEY : @"612096"
                                   },
                           
                           //店铺代运营
                           @"4" : @{
                                   ADD_SERVICES_CODE_KEY : @"612110",
                                   CHANGE_SERVICES_CODE_KEY : @"612111",
                                   DELETE_SERVICES_CODE_KEY : @"612112",
                                   LIST_SERVICES_SERVICES_CODE_KEY : @"612116"
                                   },
                           
                           //培训
                           @"5" : @{
                                   ADD_SERVICES_CODE_KEY : @"",
                                   CHANGE_SERVICES_CODE_KEY : @"",
                                   DELETE_SERVICES_CODE_KEY : @"",
                                   LIST_SERVICES_SERVICES_CODE_KEY : @""
                                   },
                           
                           //美工
                           @"6" : @{
                                   ADD_SERVICES_CODE_KEY : @"",
                                   CHANGE_SERVICES_CODE_KEY : @"",
                                   DELETE_SERVICES_CODE_KEY : @"",
                                   LIST_SERVICES_SERVICES_CODE_KEY : @""
                                   }
                           
                           };


    self.addServiceCode = dict[_aptitudeType][ADD_SERVICES_CODE_KEY];
    self.deleteServiceCode = dict[_aptitudeType][DELETE_SERVICES_CODE_KEY];
    self.changeServiceCode = dict[_aptitudeType][CHANGE_SERVICES_CODE_KEY];
    self.listServiceCode = dict[_aptitudeType][LIST_SERVICES_SERVICES_CODE_KEY];
    
    
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @{
          @"" : @"",
          
          };
    }
    return self;
}
@end
