//
//  NSNumber+TLAdd.h
//  ZHCustomer
//
//  Created by  tianlei on 2017/1/5.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (TLAdd)

//转换金额
- (NSString *)convertToRealMoney;
- (NSString *)convertToSimpleRealMoney;

@end
