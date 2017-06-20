//
//  ZHUser.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/14.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHUser.h"
#import "ZHUserExt.h"

#define USER_ID_KEY @"user_id_key_zh"
#define TOKEN_ID_KEY @"token_id_key_zh"
#define USER_INFO_DICT_KEY @"user_info_dict_key_zh"

NSString *const kUserLoginNotification = @"kUserLoginNotification_zh";
NSString *const kUserLoginOutNotification = @"kUserLoginOutNotification_zh";
NSString *const kUserInfoChange = @"kUserInfoChange_zh";

@implementation ZHUser

+ (instancetype)user {

    static ZHUser *user = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        user = [[ZHUser alloc] init];
    });
    
    return user;

}




- (void)saveUserInfo:(NSDictionary *)userInfo token:(NSString *)token userId:(NSString *)userId {

    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:USER_INFO_DICT_KEY];
    
    if (userId && token) {
        
        [[NSUserDefaults standardUserDefaults] setObject:userId forKey:USER_ID_KEY];
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:TOKEN_ID_KEY];
        
    } else {
    
        NSLog(@"请传入用户信息");
    }
   

}


- (BOOL)isLogin {

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefault objectForKey:USER_ID_KEY];
    NSString *token = [userDefault objectForKey:TOKEN_ID_KEY];
    if (userId && token) {
        
        self.userId = userId;
        self.token = token;
        
        [self setUserInfoWithDict:[userDefault objectForKey:USER_INFO_DICT_KEY]];
        
        return YES;
    } else {
    
    
        return NO;
    }

    
    
    
}

- (void)loginOut {

    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList([CDCompany class], &count);
    // 遍历
    for (int i = 0; i < count; i++) {
        
        // An opaque type that represents an Objective-C declared property.
        objc_property_t property = properties[i];
        // 获取属性的名称
        const char *cName = property_getName(property);
        
        //        NSLog(@"%c---%c",cName,property_getAttributes(property));
        
        // 转换为Objective
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        //基础数据类型，不能置为nil
        if ([name isEqualToString:@"isReg"] || [name isEqualToString:@"haveShopInfo"]) {
            
            continue;
        }
        
        [self setValue:nil forKeyPath:name];
    }
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:TOKEN_ID_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_INFO_DICT_KEY];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"user_login_out_notification" object:nil];

}


- (void)updateUserInfo {
//
//    TLNetworking *http = [TLNetworking new];
//    http.isShowMsg = NO;
//    http.code = USER_INFO;
//    http.parameters[@"userId"] = [ZHUser user].userId;
//    http.parameters[@"token"] = [ZHUser user].token;
//    [http postWithSuccess:^(id responseObject) {
//        
//        [self setUserInfoWithDict:responseObject[@"data"]];
//        [self saveUserInfo:responseObject[@"data"]];
//        [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoChange object:nil];
//        
//    } failure:^(NSError *error) {
//        
//        
//    }];
//    
//    
}


- (void)setUserInfoWithDict:(NSDictionary *)dict {

    [self setValuesForKeysWithDictionary:dict];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"description"]) {
//        self.descriptionShop = value;
    }
    
}

@end
