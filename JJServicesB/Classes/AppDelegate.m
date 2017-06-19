//
//  AppDelegate.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.

#import "AppDelegate.h"
#import "ZHNavigationController.h"
#import "ZHHomeVC.h"
#import "ZHUserLoginVC.h"
//#import <AMapFoundationKit/AMapFoundationKit.h>
//#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>
//#import "AppDelegate+Chat.h"
//#import "AppDelegate+JPush.h"
#import "IQKeyboardManager.h"
//#import "ChatViewController.h"
//#import "ChatManager.h"

#import "ZHUserRegistVC.h"
#import "ZHUserForgetPwdVC.h"
//#import "UMMobClick/MobClick.h"
#import "AppConfig.h"
//#import "Player.h"

@interface AppDelegate ()

@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//      意向状态：APPLY("1", "未查看"), PASS_YES("2", "已查看/处理通过"), PASS_NO("3", "不通过");
//    tgfw(必填)	提供服务	A 运营 B 推广 C 拍摄 D 美工 E 客服 F 仓储 G 打包发货
    
    
    //
    //配置环境
    [AppConfig config].runEnv = RunEnvDev;
    
    
    
    //
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    
    //键盘处理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
//    [manager.disabledToolbarClasses addObject:[UIViewController class]];
//    [manager.disabledToolbarClasses addObject:[ZHUserLoginVC class]];
//    [manager.disabledToolbarClasses addObject:[ZHUserRegistVC class]];
//    [manager.disabledToolbarClasses addObject:[ZHUserForgetPwdVC class]];
    
    //
     [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor zh_themeColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : [UIColor whiteColor]
                                                           }];
    
    
    if([[ZHUser user] isLogin]){
                
        self.window.rootViewController = [[ZHNavigationController alloc] initWithRootViewController:[[ZHHomeVC alloc] init]];
        
    } else {
        
        self.window.rootViewController = [[ZHNavigationController alloc] initWithRootViewController:[[ZHUserLoginVC alloc] init]];
        
    }
    
    //登入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin) name:kUserLoginNotification object:nil];
    //用户登出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginOut) name:kUserLoginOutNotification object:nil];
    
  
    return YES;
    
}



- (void)userLogin {
    
    self.window.rootViewController = [[ZHNavigationController alloc] initWithRootViewController:[[ZHHomeVC alloc] init]];
}

- (void)userLoginOut {
    
    //取消推送别名
//    [JPUSHService setAlias:@"" callbackSelector:nil object:nil];
    
    
    [[ZHUser user] loginOut];
    
    

    
    self.window.rootViewController = [[ZHNavigationController alloc] initWithRootViewController:[[ZHUserLoginVC alloc] init]];
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    
}

@end
