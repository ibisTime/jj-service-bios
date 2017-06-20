//
//  CDIdeaModel.h
//  JJServicesB
//
//  Created by  tianlei on 2017/6/20.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "TLBaseModel.h"

//      意向状态：APPLY("1", "未查看"), PASS_YES("2", "已查看/处理通过"), PASS_NO("3", "不通过");

@interface CDIdeaModel : TLBaseModel

@property (nonatomic, copy) NSString *intMobile;
@property (nonatomic, copy) NSString *intName;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *submitDatetime;

//洽谈内容
@property (nonatomic, copy) NSString *hzContent;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSDictionary *company;

@property (nonatomic, copy,readonly) NSString *logo;
@property (nonatomic, copy) NSString *remark;





- (NSString *)getStatusName;

@end
