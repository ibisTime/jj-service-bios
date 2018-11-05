//
//  ZHPwdRelatedVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "CDShopRegisterVC.h"
#import "TLImagePicker.h"
#import "QNUploadManager.h"
#import "TLUploadManager.h"
#import "ZHNavigationController.h"
#import "ZHHomeVC.h"
#import "CDShopRegisterVC.h"
#import "CDImageUpLoadView.h"

@interface CDShopRegisterVC ()

@property (nonatomic,strong) TLTextField *shopNameTf;
@property (nonatomic,strong) TLTextField *realNameTf;

//@property (nonatomic, strong) UIImageView *idCardImageView;
@property (nonatomic, strong) CDImageUpLoadView *imageUpLoadView;


@property (nonatomic,strong) TLTextField *phoneTf;
@property (nonatomic,strong) TLCaptchaView *captchaView;
@property (nonatomic,strong) TLTextField *pwdTf;
//@property (nonatomic,strong) TLTextField *rePwdTf;
@property (nonatomic, strong) UIScrollView *bgSV;
@property (nonatomic, strong) TLImagePicker *imagePicker;


@end

@implementation CDShopRegisterVC




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.bgSV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"注册";
    
    [self setUpUI];
    
    //
    __weak typeof(self) weakSelf = self;
    self.imagePicker = [[TLImagePicker alloc] initWithVC:self];
    [self.imagePicker setPickFinish:^(NSDictionary *info,UIImage *newImg){
        
 
        weakSelf.imageUpLoadView.imageView.image = newImg;
        
    }];
    
    
}

- (void)sendCaptcha {
    
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


- (void)confirm {
    
    if (![self.shopNameTf.text valid]) {
        
        [TLAlert alertWithHUDText:@"请输入个体名称"];
        return;
    }
    
    if (!self.imageUpLoadView.imageView.image) {
        
        [TLAlert alertWithHUDText:@"请选则证件图片"];
        return;
    }
    
    if (![self.realNameTf.text valid]) {
        
        [TLAlert alertWithHUDText:@"请输入实际负责人名称"];
        
        return;
    }
    
    
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
    

    TLNetworking *getUploadToken = [TLNetworking new];
    getUploadToken.showView = self.view;
    getUploadToken.code = @"807900";
    [getUploadToken postWithSuccess:^(id responseObject) {
        
        [TLProgressHUD showWithStatus:nil];
        
        NSString *token = responseObject[@"data"][@"uploadToken"];
        QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
            builder.zone = [QNZone zone0];
        }];
        
//        QNUploadManager *uploadManager = [TLUploadManager qnUploadManager];
        QNUploadManager *uploadManager = [[QNUploadManager alloc] initWithConfiguration:config];
        //封面图片上传
        UIImage *coverImg = self.imageUpLoadView.imageView.image;
        NSString *coverImgKey = [TLUploadManager imageNameByImage:coverImg];
        
            NSData *data =  UIImageJPEGRepresentation(coverImg, 1);
            [uploadManager putData:data key:coverImgKey token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                [TLProgressHUD dismiss];
                if (info.error) {
                
                   [TLAlert alertWithHUDText:@"图片上传失败"];
                   return;

                }
                    
                [self applyWithImgKey:key];
                
                
            } option:nil];
        
        
    } failure:^(NSError *error) {
       
        
    }];
    

}

- (void)applyWithImgKey:(NSString *)imgName {

    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"612050";
    
    http.parameters[@"mobile"] = self.phoneTf.text;
    http.parameters[@"smsCaptcha"] = self.captchaView.captchaTf.text;
    http.parameters[@"password"] = self.pwdTf.text;
    http.parameters[@"pwdStrength"] = @"1";
    http.parameters[@"name"] = self.shopNameTf.text;
    http.parameters[@"corporation"] = self.realNameTf.text;
    //    (1 店铺 2个体户)
    if (self.type == RegisterTypePersonal) {
        
        http.parameters[@"type"] = @"2";
        http.parameters[@"idNo"] = imgName;

    } else if (self.type == RegisterTypeEnterprise) {
        
        http.parameters[@"type"] = @"1";
        //工商营业执照号
        http.parameters[@"gsyyzzh"] = imgName;
    
    }

    //
    [http postWithSuccess:^(id responseObject) {
        
        
        NSString *conpanyCode = responseObject[@"data"][@"companyCode"];
        NSString *userId = responseObject[@"data"][@"userId"];
        NSString *token = responseObject[@"data"][@"token"];
        //
        //获取用户信息
        TLNetworking *http = [TLNetworking new];
        http.showView = self.view;
        http.code = USER_INFO;
        http.parameters[@"userId"] = userId;
        http.parameters[@"token"] = token;
        [http postWithSuccess:^(id responseObject) {
            
            NSDictionary *userInfo = responseObject[@"data"];
            [[ZHUser user] saveUserInfo:userInfo token:token userId:userId];
//            [[ZHUser user] setUserInfoWithDict:userInfo];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginNotification object:nil];
 
            //获取用户信息
            [UIApplication sharedApplication].keyWindow.rootViewController = [[ZHNavigationController alloc] initWithRootViewController:[ZHHomeVC new]];
            //进行账号密码的存储
//            UICKeyChainStore *keyChainStore = [UICKeyChainStore keyChainStoreWithService:[UICKeyChainStore defaultService]];
//            [keyChainStore setString:self.phoneTf.text forKey:KEY_CHAIN_USER_NAME_KEY error:nil];
//            [keyChainStore setString:self.pwdTf.text forKey:KEY_CHAIN_USER_PASS_WORD_KEY error:nil];
            
        } failure:^(NSError *error) {
            
            
        }];
        
        //获取店铺信息
        [[CDCompany company] getShopInfoSuccess:^(NSDictionary *shopDict) {
            
            
        } failure:^(NSError *error) {
            
        }];

        
        
        
        
        
    } failure:^(NSError *error) {
        
        
        
    }];


}


#pragma mark- 选择身份证
- (void)chooseIdCardPhoto {

    [self.imagePicker picker];

}

- (void)setUpUI {
    
    CGFloat leftW = 100;
    
    NSString *nameStr = nil;
    NSString *cardStr = nil;

    
    if (self.type == RegisterTypePersonal) {
        
        nameStr = @"个体名称";
        cardStr = @"身份证";
        
    } else if (self.type == RegisterTypeEnterprise) {

        nameStr = @"企业名称";
        cardStr = @"营业执照";
        
    }
    
    self.bgSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view  addSubview:self.bgSV];
    self.bgSV.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    
    //
    self.shopNameTf = [[TLTextField alloc] initWithframe:CGRectMake(0, 5, SCREEN_WIDTH, 45)
                                                    leftTitle:nameStr
                                                   titleWidth:leftW
                                                  placeholder:[NSString stringWithFormat:@"请输入%@",nameStr]];
    [self.bgSV addSubview:self.shopNameTf];
    
    //添加身份证
    
    self.imageUpLoadView = [[CDImageUpLoadView alloc] initWithFrame:CGRectMake(0,  self.shopNameTf.yy + 1, SCREEN_WIDTH, 80)];
    [self.bgSV addSubview:self.imageUpLoadView];
    self.imageUpLoadView.titleLbl.text = cardStr;
    [self.imageUpLoadView.uploadBtn addTarget:self action:@selector(chooseIdCardPhoto) forControlEvents:UIControlEventTouchUpInside];
    
//    UIView *chooseIdCardBgView = [[UIView alloc] initWithFrame:CGRectMake(0,  self.shopNameTf.yy + 1, SCREEN_WIDTH, 80)];
//    [self.bgSV addSubview:chooseIdCardBgView];
//    chooseIdCardBgView.backgroundColor = [UIColor whiteColor];
//    UILabel *hintlbl = [UILabel labelWithFrame:CGRectZero
//                                  textAligment:NSTextAlignmentLeft
//                               backgroundColor:[UIColor whiteColor]
//                                          font:FONT(15)
//                                     textColor:[UIColor textColor]];
//    [chooseIdCardBgView addSubview:hintlbl];
//    hintlbl.text = cardStr;
    
//    self.idCardImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"身份证"]];
//    [chooseIdCardBgView addSubview:self.idCardImageView];
//    self.idCardImageView.clipsToBounds = YES;
//    self.idCardImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.idCardImageView.layer.cornerRadius = 4;
//    self.idCardImageView.layer.masksToBounds = YES;
//
//    //
//    UIButton *chooseBtn = [UIButton zhBtnWithFrame:CGRectZero title:@"选择"];
//    [chooseIdCardBgView addSubview:chooseBtn];
//    [chooseBtn addTarget:self action:@selector(chooseIdCardPhoto) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    [hintlbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(chooseIdCardBgView.mas_left).offset(15);
//        make.centerY.equalTo(chooseIdCardBgView.mas_centerY);
//    }];
//    [self.idCardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(chooseIdCardBgView.mas_centerY);
//        make.left.equalTo(hintlbl.mas_right).offset(60);
//        make.width.mas_equalTo(75);
//        make.height.mas_equalTo(55);
//    }];
//    
//    [chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerY.equalTo(chooseIdCardBgView.mas_centerY);
//        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(60);
//        make.right.equalTo(chooseIdCardBgView.mas_right).offset(-60);
//        
//    }];
    
    
    //
    self.realNameTf = [[TLTextField alloc] initWithframe:CGRectMake(0, self.imageUpLoadView.yy + 0.5, SCREEN_WIDTH, 45)
                                               leftTitle:@"实际负责人"
                                              titleWidth:leftW
                                             placeholder:@"请输入负责人真实姓名"];
    [self.bgSV addSubview:self.realNameTf];
    
    
    
    //手机号
    TLTextField *phoneTf = [[TLTextField alloc] initWithframe:CGRectMake(0,  self.realNameTf.yy + 10, SCREEN_WIDTH, 45)
                                                    leftTitle:@"手机号"
                                                   titleWidth:leftW
                                                  placeholder:@"请输入手机号"];
    [self.bgSV addSubview:phoneTf];
    phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    
    self.phoneTf = phoneTf;
    
    
    //验证码
    TLCaptchaView *captchaView = [[TLCaptchaView alloc] initWithFrame:CGRectMake(phoneTf.x, phoneTf.yy + 1, phoneTf.width, phoneTf.height)];
    [self.bgSV addSubview:captchaView];
    _captchaView = captchaView;
//    captchaView.captchaTf.x =  captchaView.captchaTf.x + 10;
//    captchaView.captchaTf.width =  captchaView.captchaTf.width - 10;

    
    [captchaView.captchaBtn addTarget:self action:@selector(sendCaptcha) forControlEvents:UIControlEventTouchUpInside];
    [captchaView.captchaBtn setBackgroundColor:[UIColor themeColor] forState:UIControlStateNormal];
    
    
    //新密码
    TLTextField *pwdTf = [[TLTextField alloc] initWithframe:CGRectMake(phoneTf.x, captchaView.yy + 1, phoneTf.width, phoneTf.height)
                                                  leftTitle:@"密码"
                                                 titleWidth:leftW
                                                placeholder:@"请输入密码(不少于6位)"];
    [self.bgSV addSubview:pwdTf];
    pwdTf.secureTextEntry = YES;
    self.pwdTf = pwdTf;
    
//    //重新输入
//    TLTextField *rePwdTf = [[TLTextField alloc] initWithframe:CGRectMake(phoneTf.x, pwdTf.yy + 1, phoneTf.width, phoneTf.height)
//                                                    leftTitle:@"确认密码"
//                                                   titleWidth:leftW
//                                                  placeholder:@"确认"];
//    [self.bgSV addSubview:rePwdTf];
//    rePwdTf.secureTextEntry = YES;
//    self.rePwdTf = rePwdTf;
    
    //确认按钮
    UIButton *confirmBtn = [UIButton zhBtnWithFrame:CGRectMake(20, self.pwdTf.yy + 30, SCREEN_WIDTH - 40, 44) title:@"确认"];
    [self.bgSV addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setBackgroundColor:[UIColor themeColor] forState:UIControlStateNormal];
    
    
    self.bgSV.contentSize = CGSizeMake(SCREEN_WIDTH, (confirmBtn.yy > (SCREEN_HEIGHT - 64)) ?confirmBtn.yy : SCREEN_HEIGHT - 50);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
