//
//  ZHUserRegistVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHUserRegistVC.h"
#import "ZHCaptchaView.h"
//#import "ChatManager.h"
#import "UICKeyChainStore.h"

@interface ZHUserRegistVC ()

@property (nonatomic,strong) ZHAccountTf *phoneTf;
@property (nonatomic,strong) ZHCaptchaView *captchaView;
@property (nonatomic,strong) ZHAccountTf *pwdTf;


@end

@implementation ZHUserRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";

    [self setUpUI];

}

- (void)sendCaptcha {

    if (![self.phoneTf.text isPhoneNum]) {
        
        [TLAlert alertWithHUDText:@"请输入正确的手机号"];
        
        return;
    }
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = CAPTCHA_CODE;
    http.parameters[@"bizType"] = USER_REG_CODE;
    http.parameters[@"mobile"] = self.phoneTf.text;
    
    [http postWithSuccess:^(id responseObject) {
        
        [self.captchaView.captchaBtn begin];
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)goReg {

    if (![self.phoneTf.text isPhoneNum]) {
        
        [TLAlert alertWithHUDText:@"请输入正确的手机号"];
        
        return;
    }
    
    if (!(self.captchaView.captchaTf.text && self.captchaView.captchaTf.text.length > 3)) {
        [TLAlert alertWithHUDText:@"请输入正确的验证码"];

        return;
    }
    
    if (!(self.pwdTf.text &&self.pwdTf.text.length > 5)) {
        
        [TLAlert alertWithHUDText:@"请输入6位以上密码"];
        return;
    }
    
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = USER_REG_CODE;
    http.parameters[@"mobile"] = self.phoneTf.text;
    http.parameters[@"loginPwd"] = self.pwdTf.text;
    http.parameters[@"loginPwdStrength"] = @"2";
    http.parameters[@"isRegHx"] = @"1";
    http.parameters[@"smsCaptcha"] = self.captchaView.captchaTf.text;
    
    [http postWithSuccess:^(id responseObject) {
       
//        [TLAlert alertWithHUDText:@"注册成功"];
        
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            NSString *tokenId = responseObject[@"data"][@"token"];
            NSString *userId = responseObject[@"data"][@"userId"];
            
        
            //获取用户信息
            TLNetworking *http = [TLNetworking new];
            http.showView = self.view;
            http.code = USER_INFO;
            http.parameters[@"userId"] = userId;
            http.parameters[@"token"] = tokenId;
            [http postWithSuccess:^(id responseObject) {
                
                NSDictionary *userInfo = responseObject[@"data"];
                [ZHUser user].userId = userId;
                [ZHUser user].token = tokenId;
                [[ZHUser user] saveUserInfo:userInfo token:tokenId userId:userId];
                [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification object:nil];
                
             
                //进行账号密码的存储
                UICKeyChainStore *keyChainStore = [UICKeyChainStore keyChainStoreWithService:[UICKeyChainStore defaultService]];
                [keyChainStore setString:self.phoneTf.text forKey:KEY_CHAIN_USER_NAME_KEY error:nil];
                [keyChainStore setString:self.pwdTf.text forKey:KEY_CHAIN_USER_PASS_WORD_KEY error:nil];
                
                
            } failure:^(NSError *error) {
                
                
            }];
            
//        });
 
    } failure:^(NSError *error) {
        
        
    }];
    
}


- (void)setUpUI {

    CGFloat margin = ACCOUNT_MARGIN;
    CGFloat w = SCREEN_WIDTH - 2*margin;
    CGFloat h = ACCOUNT_HEIGHT;
    CGFloat middleMargin = ACCOUNT_MIDDLE_MARGIN;
    
    //账号
    ZHAccountTf *phoneTf = [[ZHAccountTf alloc] initWithFrame:CGRectMake(margin, 50, w, h)];
    phoneTf.zh_placeholder = @"请输入手机号";
    phoneTf.leftIconView.image = [UIImage imageNamed:@"手机号"];
    [self.bgSV addSubview:phoneTf];
    self.phoneTf = phoneTf;
    phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    
    //验证码
    ZHCaptchaView *captchaView = [[ZHCaptchaView alloc] initWithFrame:CGRectMake(margin, phoneTf.yy + middleMargin, w, h)];
    [self.bgSV addSubview:captchaView];
    captchaView.captchaTf.leftIconView.image = [UIImage imageNamed:@"验证码"];
    captchaView.captchaTf.zh_placeholder = @"请输入验证码";
    [captchaView.captchaBtn addTarget:self action:@selector(sendCaptcha) forControlEvents:UIControlEventTouchUpInside];
    self.captchaView = captchaView;
    
    //密码
    ZHAccountTf *pwdTf = [[ZHAccountTf alloc] initWithFrame:CGRectMake(margin, captchaView.yy + middleMargin, w, h)];
    pwdTf.secureTextEntry = YES;
    pwdTf.zh_placeholder = @"请输入密码";
    pwdTf.leftIconView.image = [UIImage imageNamed:@"密码"];
    [self.bgSV addSubview:pwdTf];
    self.pwdTf = pwdTf;
    
    //登陆

    UIButton *regBtn = [UIButton zhBtnWithFrame:CGRectMake(margin,pwdTf.yy + 70, w, h) title:@"注册"];
    [regBtn addTarget:self action:@selector(goReg) forControlEvents:UIControlEventTouchUpInside];
    [self.bgSV addSubview:regBtn];

}

@end
