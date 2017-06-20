//
//  CDIdeaModel.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/20.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "CDIdeaModel.h"

@implementation CDIdeaModel


//      意向状态：APPLY("1", "未查看"), PASS_YES("2", "已查看/处理通过"), PASS_NO("3", "不通过");

- (NSString *)logo {

    return self.company[@"logo"];

}
- (NSString *)getStatusName {

    NSDictionary *dict = @{
                           
                           @"1" : @"未查看",
                           @"2" : @"已查看",
                           @"3" : @"不通过"
                           };

    return dict[self.status] ? : self.status;
}

@end
