//
//  CDServiceBaseModel.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDServiceBaseModel.h"

@implementation CDServiceBaseModel

+ (NSDictionary *)tl_replacedKeyFromPropertyName {

    return @{@"desc": @"description"};
    

}

- (NSArray<NSString *> *)detailPics {
    
    return [self.advPic componentsSeparatedByString:@"||"];
}

@end
