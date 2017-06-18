//
//  ZHNavigationController.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHNavigationController.h"
//#import "CDShopInfoChangeVC.h"
//#import "CDShopMgtVC.h"

@interface ZHNavigationController ()<UINavigationControllerDelegate>

@end

@implementation ZHNavigationController
//- (void)load{
//
//    
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

//    [[UINavigationBar appearance] setBackgroundColor:[UIColor zh_themeColor]];
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName : [UIColor whiteColor]
                                                 }];
    
    self.navigationBar.backIndicatorImage = [UIImage imageNamed:@"返回_白色"];
    self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"返回_白色"];
    
//    self.delegate = self;
    
}


//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

//    if ([viewController isKindOfClass:[CDShopInfoChangeVC class]]) {
//        
//        [self changeSimpleBarWithBar:navigationController.navigationBar themeColor:[UIColor shopThemeColor]];
//        
//        return;
//        
//    } else if([viewController isKindOfClass:[CDShopMgtVC class]]) {
//    
//          [self changeHardBarWithBar:navigationController.navigationBar themeColor:[UIColor shopThemeColor]];
//        return;
//    }
    
    
    
//    if([viewController isKindOfClass:[CDShopInfoChangeVC class]]) {
//        
//        
//    } else if([viewController isKindOfClass:[CDShopInfoChangeVC class]]) {
//        
//        
//    }
//}

- (void)changeHardBarWithBar:(UINavigationBar *)bar themeColor:(UIColor *)color {

    bar.barTintColor = color;
    bar.tintColor = [UIColor whiteColor];
    
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName :  [UIColor whiteColor]
                                  }];


}


- (void)changeSimpleBarWithBar:(UINavigationBar *)bar themeColor:(UIColor *)color {


    bar.barTintColor = [UIColor whiteColor];
    bar.tintColor = color;
    
    [bar setTitleTextAttributes:@{
                                                                 NSForegroundColorAttributeName : color
                                                                 }];

}

//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//
//
//
//}

- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;

}


@end
