//
//  ZHSJIntroduceVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2017/4/6.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "ZHSJIntroduceVC.h"
#import <WebKit/WebKit.h>

@interface ZHSJIntroduceVC ()

@end

@implementation ZHSJIntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新手入门";
    
    WKWebView *webView = [[WKWebView alloc] init];
    [self.view addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    http.code = @"807717";
    http.parameters[@"ckey"] = @"guide";
    http.parameters[@"token"] = [ZHUser user].token;
    [http postWithSuccess:^(id responseObject) {
        
        NSString *styleStr = @"<style type=\"text/css\"> *{ font-size:30px;}</style>";
        NSString *htmlStr = responseObject[@"data"][@"note"];
        [webView loadHTMLString:[NSString stringWithFormat:@"%@%@",htmlStr,styleStr] baseURL:nil];
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
}



@end
