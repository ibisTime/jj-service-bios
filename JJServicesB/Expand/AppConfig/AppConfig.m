//
//  AppConfig.m
//  ZHCustomer
//
//  Created by  tianlei on 2017/2/12.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "AppConfig.h"


void TLLog(NSString *format, ...) {
    
    if ([AppConfig config].runEnv != RunEnvRelease) {
        
        va_list argptr;
        va_start(argptr, format);
        NSLogv(format, argptr);
        va_end(argptr);
    }
    
}

@implementation AppConfig

+ (instancetype)config {

    static dispatch_once_t onceToken;
    static AppConfig *config;
    dispatch_once(&onceToken, ^{
        
        config = [[AppConfig alloc] init];
        
    });

    return config;
}

- (void)setRunEnv:(RunEnv)runEnv {

    _runEnv = runEnv;
    switch (_runEnv) {
        case RunEnvRelease: {
        
           self.qiniuDomain = @"http://oru1eha7u.bkt.clouddn.com";
           self.chatKey = @"1139170317178872#zhpay";
           self.addr = @"http://139.224.200.54:5601"; //test
           self.shareBaseUrl = @"http://m.zhenghuijituan.com";

        }break;
            
        case RunEnvTest: {
            
            
            self.qiniuDomain = @"http://oru1eha7u.bkt.clouddn.com";
//            self.chatKey = @"1139170317178872#zhpay";
            
            self.addr = @"http://118.178.124.16:5501";
//            self.shareBaseUrl = @"http://118.178.124.16:5603";
            
        } break;
            
        case RunEnvDev: {
            
//            self.qiniuDomain = @"http://oi99f4peg.bkt.clouddn.com";
//            self.chatKey = @"tianleios#cd-test";
            
            http://121.43.101.148:8901/forward-service/api
            
//            self.qiniuDomain = @"http://omxvtiss6.bkt.clouddn.com";
            
             self.qiniuDomain = @"http://oru1eha7u.bkt.clouddn.com";
            
//            self.chatKey = @"1139170317178872#zhpay";
            self.addr = @"http://121.43.101.148:8901";
//            self.shareBaseUrl = @"http://osszhqb.hichengdai.com/share";
           
        } break;
            
    }
    
}


- (NSString *)pushKey {

    return @"01ff3e500410e11b9edd4fbd";
    
}


- (NSString *)aliMapKey {

    return @"6f5387b57bf8881f2cdd6124b54dc8df";
    
}


- (NSString *)wxKey {

    return @"wx9324d86fb16e8af0";
    
}




@end
