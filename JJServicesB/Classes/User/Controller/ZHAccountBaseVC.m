//
//  ZHAccountBaseVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHAccountBaseVC.h"
#import "ZHCaptchaView.h"

@interface ZHAccountBaseVC ()

@end

@implementation ZHAccountBaseVC
- (void)loadView {

    [super loadView];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgImageView .userInteractionEnabled = YES;
    bgImageView.image = [UIImage imageNamed:@"登录背景"];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName : [UIFont systemFontOfSize:18],
                                                                      NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                      
                                                                      }];
    self.view = bgImageView;

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
 
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
    
    self.bgSV = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _bgSV.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.bgSV.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 1);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.bgSV addGestureRecognizer:tap];
    [self.view addSubview:_bgSV];

}
- (void)tap {

    [self.view endEditing:YES];

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
