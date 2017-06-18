//
//  TLAlert.h
//  WeRide
//
//  Created by  tianlei on 2016/11/25.
//  Copyright © 2016年 trek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MBProgressHUD;
@class SVProgressHUD;

@interface TLAlert : NSObject

//SVProgressHUD新版
+ (void)alertHUDWithMsg:(NSString *)msg;

//info
+ (void)alertWithInfo:(NSString *)msg;
//error
+ (void)alertWithError:(NSString *)msg;
//success
+ (void)alertWithSucces:(NSString *)msg;



+ (void)alertWithHUDText:(NSString *)msg;

//设置延迟时间
+ (void)alertWithHUDText:(NSString *)text duration:(NSTimeInterval)sec complection:(void(^)())complection;

//--//基于系统的alertController
+ (void)alertWithMsg:(NSString * )message;
+ (void)alertWithMsg:(NSString * )message viewCtrl:(UIViewController *)vc;

+ (void)alertWithTitile:(NSString *)title
                message:(NSString *)message;


+ (void)alertWithTitile:(NSString *)title
                message:(NSString *)message
          confirmAction:(void(^)())confirmAction;





/**
 复杂
 */
+ (UIAlertController *)alertWithTitle:(NSString *)title
                                  msg:(NSString *)msg
                           confirmMsg:(NSString *)confirmMsg
                            cancleMsg:(NSString *)cancleMsg
                                maker:(UIViewController *)viewCtrl
                               cancle:(void(^)(UIAlertAction *action))cancle
                              confirm:(void(^)(UIAlertAction *action))confirm;
    

/**
 简版
 */
+ (UIAlertController *)alertWithTitle:(NSString *)title
                                  msg:(NSString *)msg
                           confirmMsg:(NSString *)confirmMsg
                            cancleMsg:(NSString *)msg
                               cancle:(void(^)(UIAlertAction *action))cancle
                              confirm:(void(^)(UIAlertAction *action))confirm;


@end
