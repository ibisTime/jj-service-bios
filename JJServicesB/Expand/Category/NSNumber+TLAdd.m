//
//  NSNumber+TLAdd.m
//  ZHCustomer
//
//  Created by  tianlei on 2017/1/5.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "NSNumber+TLAdd.h"

@implementation NSNumber (TLAdd)

- (NSString *)convertToRealMoney {
        
        
        if (!self) {
            
            NSLog(@"金额不能为空");
            return nil;
        }
        
        long long m = [self longLongValue];
        double value = m/1000.0;
        
        NSString *tempStr =  [NSString stringWithFormat:@"%.3f",value];
        NSString *subStr = [tempStr substringWithRange:NSMakeRange(0, tempStr.length - 1)];
        
        //  return [NSString stringWithFormat:@"%.2f",value];
        return subStr;
}

- (NSString *)convertToSimpleRealMoney {

    long long m = [self longLongValue];
    CGFloat value = m/1000;
    return [NSString stringWithFormat:@"%.f",value];

}

@end
