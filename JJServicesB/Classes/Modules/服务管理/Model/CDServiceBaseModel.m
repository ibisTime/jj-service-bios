//
//  CDServiceBaseModel.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDServiceBaseModel.h"

@implementation CDServiceBaseModel


- (NSString *)getStatusName {

    NSDictionary *dict = @{
                           @"1" : @"正常" ,
                           @"0"  : @"违规"
                           };
    return dict[self.status];
    
}
+ (NSDictionary *)tl_replacedKeyFromPropertyName {

    return @{@"desc": @"description"};
    

}

- (NSArray<NSString *> *)detailPics {
    
    return [self.pic componentsSeparatedByString:@"||"];
}

@end
