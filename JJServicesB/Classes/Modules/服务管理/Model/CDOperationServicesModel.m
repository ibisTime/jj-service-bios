//
//  CDOperationServicesModel.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/20.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDOperationServicesModel.h"

@implementation CDOperationServicesModel
- (NSDictionary *)tgfwDict {

    NSDictionary *dict = @{
                           @"A" : @"运营",
                           @"B" : @"推广",
                           @"C" : @"拍摄",
                           @"D" : @"美工",
                           @"E" : @"客服",
                           @"F" : @"仓储",
                           @"G" : @"打包发货"
                           
                           };
    
    return dict;

}

- (NSDictionary *)feeModeDict {

      NSDictionary *dict = @{
                                   @"1" : @"基础服务费+提成",
                                   @"2" : @"服务费",
                                   @"3" : @"提成"
                                   
                                   };
    
    return dict;
}


- (NSDictionary *)payCycleDict {

    NSDictionary *dict = @{
                                @"1" : @"月付",
                                @"2" : @"季付",
                                @"3" : @"半年付",
                                @"4" : @"年付"
                                };
    return dict;
}
@end
