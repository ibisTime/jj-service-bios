//
//  ZHMineSetVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHMineSetVC.h"
#import "ZHSetGroup.h"
#import "ZHSetCell.h"
#import "ZHAccountAboutVC.h"

//#import "ZHBankCardListVC.h"
//#import "ChatManager.h"

#import "TLImagePicker.h"
#import "TLUploadManager.h"
#import "SDWebImageManager.h"
#import "ZHAboutUsVC.h"
#import "ZHChangeMobileVC.h"
#import "ZHPwdRelatedVC.h"

@interface ZHMineSetVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) NSMutableArray <ZHSetGroup *> *groups;

@property (nonatomic,strong) UIImageView *portraitImageView;//头像
@property (nonatomic,strong) UILabel *phoneLbl;
//@property (nonatomic,strong) UILabel *contractLbl;
@property (nonatomic,copy) NSString *cacheStr;

@property (nonatomic,strong) UITableView *tableV;

@end

@implementation ZHMineSetVC
{
    TLImagePicker *imagePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人设置";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    self.phoneLbl.text = [ZHUser user].mobile;
    
    //
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    
    if (size < 1024*1024) {
        
        self.cacheStr = [NSString stringWithFormat:@"%.2fKB",size/(1024*1024.0)];
        
    } else if (size < 1024*1024*1024) {
    
        self.cacheStr = [NSString stringWithFormat:@"%.2fM",size/(1024*1024*1024.0)];
    }
    
    UITableView *setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:setTableView];
    setTableView.dataSource = self;
    setTableView.delegate = self;
    self.tableV = setTableView;

    self.groups = [NSMutableArray array];
    [self.groups addObject:[ZHSetGroup new]];
    [self.groups addObject:[self setGroup00]];
    [self.groups addObject:[self setGroup01]];
    
    //退出登录
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    UIButton *loginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 44) title:@"退出登录" backgroundColor:[UIColor whiteColor]];
    [footerView addSubview:loginOutBtn];
    [loginOutBtn setTitleColor:[UIColor zh_themeColor] forState:UIControlStateNormal];
    [loginOutBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    setTableView.tableFooterView = footerView;

    self.portraitImageView.image = [UIImage imageNamed:@"头像占位图"];
    
//    if ([ZHShop shop].contractNo) {
//        self.contractLbl.text = [ZHShop shop].contractNo;
//
//    } else {
//    
//        self.contractLbl.text = @"暂无合同";
//
//    }
    
    [self userInfoChange];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoChange) name:kUserInfoChange object:nil];
}

- (void)userInfoChange {

//    NSString *photo = [ZHUser user].userExt.photo;
//    if (photo) {
//        [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:[photo convertThumbnailImageUrl]] placeholderImage:[UIImage imageNamed:@"头像占位图"]];
//    }
//    
    self.phoneLbl.text = [ZHUser user].mobile;


}

- (ZHSetGroup *)setGroup00 {

    
    
    __weak typeof(self) weakSelf = self;
    ZHSetGroup *group = [[ZHSetGroup alloc] init];
    
    ZHSetItem *item00 = [[ZHSetItem alloc] init];
    item00.title = @"修改手机号";
    item00.action = ^(){
        
        ZHChangeMobileVC *vc = [[ZHChangeMobileVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
        [vc setChangeMobileSuccess:^(NSString *mobile){
            
            weakSelf.phoneLbl.text = mobile;
            [[ZHUser user] updateUserInfo];
            
        }];
        
    };
   
    //
    ZHSetItem *item01 = [[ZHSetItem alloc] init];
    item01.title = @"修改登录密码";
    item01.action = ^(){
        
        ZHPwdRelatedVC *vc = [[ZHPwdRelatedVC alloc] initWith:ZHPwdTypeReset];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    
    ZHSetItem *item02 = [[ZHSetItem alloc] init];
    item02.title = @"修改支付密码";
    item02.action = ^(){
        
        ZHPwdRelatedVC *vc = [[ZHPwdRelatedVC alloc] initWith:ZHPwdTypeTradeReset];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    
    
    group.setItems = @[item00,item01,item02];
    return group;
    
//    __weak typeof(self) weakSelf = self;
//    //银行卡
//    ZHSetItem *cardItem = [[ZHSetItem alloc] init];
//    cardItem.title = @"我的银行卡";
//    cardItem.type = ZHSetItemAccessoryTypeArrow;
//    cardItem.action = ^(){
//    
////        ZHBankCardListVC *bankVC = [[ZHBankCardListVC alloc] init];
////        [weakSelf.navigationController pushViewController:bankVC animated:YES];
//    };
//    
//    //账户安全
//    ZHSetItem *securityItem = [[ZHSetItem alloc] init];
//    securityItem.title = @"账户安全";
//    securityItem.type = ZHSetItemAccessoryTypeArrow;
//    securityItem.action = ^(){
//        
//     [weakSelf.navigationController pushViewController:[[ZHAccountAboutVC alloc] init] animated:YES];
//        
//    };
//    
//    ZHSetItem *newMsgNotificationItem = [[ZHSetItem alloc] init];
//    newMsgNotificationItem.title = @"新消息通知";
//    newMsgNotificationItem.type = ZHSetItemAccessoryTypeSwitch;
//    newMsgNotificationItem.action = ^(){
//        
//        NSLog(@"查看银行卡");
//        
//    };
//    
//    //
//    ZHSetItem *cleanItem = [[ZHSetItem alloc] init];
//    cleanItem.title = @"清理缓存";
//    cleanItem.type = ZHSetItemAccessoryTypeLabel;
//    cleanItem.action = ^(){
//        
//        //        [TLAlert alertWithTitle:nil Message:@"清理缓存" confirmMsg:@"清理" CancleMsg:@"取消" cancle:^(UIAlertAction *action) {
//        //
//        //        } confirm:^(UIAlertAction *action) {
//        //
//        //            weakSelf.cacheStr = @"0B";
//        //            [weakSelf.tableV reloadData];
//        //
//        //            [[SDImageCache sharedImageCache] clearDisk];
//        //
//        //        }];
//        
//        
//        
//    };
//    
//    //账户安全
//    ZHSetItem *securityItem = [[ZHSetItem alloc] init];
//    securityItem.title = @"关于我们";
//    securityItem.type = ZHSetItemAccessoryTypeArrow;
//    securityItem.action = ^(){
//        
//        ZHAboutUsVC *aboutUsVC = [[ZHAboutUsVC alloc] init];
//        [self.navigationController pushViewController:aboutUsVC animated:YES];
//        
//    };

    


}

- (ZHSetGroup *)setGroup01 {
    
    ZHSetGroup *group = [[ZHSetGroup alloc] init];
    
    __weak typeof(self) weakSelf = self;
    //银行卡
    ZHSetItem *newMsgNotificationItem = [[ZHSetItem alloc] init];
    newMsgNotificationItem.title = @"新消息通知";
    newMsgNotificationItem.type = ZHSetItemAccessoryTypeSwitch;
    newMsgNotificationItem.action = ^(){
        
        NSLog(@"查看银行卡");
        
    };
    
    //
    ZHSetItem *cleanItem = [[ZHSetItem alloc] init];
    cleanItem.title = @"清理缓存";
    cleanItem.type = ZHSetItemAccessoryTypeLabel;
    cleanItem.action = ^(){
        
//        [TLAlert alertWithTitle:nil Message:@"清理缓存" confirmMsg:@"清理" CancleMsg:@"取消" cancle:^(UIAlertAction *action) {
//            
//        } confirm:^(UIAlertAction *action) {
//            
//            weakSelf.cacheStr = @"0B";
//            [weakSelf.tableV reloadData];
//            
//            [[SDImageCache sharedImageCache] clearDisk];
//            
//        }];

        
        
    };
    
    //账户安全
    ZHSetItem *securityItem = [[ZHSetItem alloc] init];
    securityItem.title = @"关于我们";
    securityItem.type = ZHSetItemAccessoryTypeArrow;
    securityItem.action = ^(){
  
        ZHAboutUsVC *aboutUsVC = [[ZHAboutUsVC alloc] init];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
        
    };
    
    group.setItems = @[securityItem];
    return group;
    
}

- (void)loginOut {

   
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginOutNotification object:nil];

}


#pragma mark-- imagePickDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {


}

#pragma mark-- delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:NO];

        return;
        __weak typeof(self) weakself = self;

        imagePicker = [[TLImagePicker alloc] initWithVC:self];
        imagePicker.allowsEditing = YES;
        imagePicker.pickFinish = ^(NSDictionary *info){
            
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.1);
            weakself.portraitImageView.image = [UIImage imageWithData:imgData];
            //进行上传
            TLUploadManager *manager = [TLUploadManager manager];
            [manager getTokenShowView:weakself.view succes:^(NSString *token) {
                
                QNUploadManager *manager = [[QNUploadManager alloc] init];
                [manager putData:imgData key:[TLUploadManager imageNameByImage:image] token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    
                    if (info.error) {
                        [TLAlert alertWithHUDText:@"修改头像失败"];
                        return ;
                    }
                    
                    TLNetworking *http = [TLNetworking new];
                    http.showView = weakself.view;
                    http.code = @"805077";
                    http.parameters[@"userId"] = [ZHUser user].userId;
                    http.parameters[@"photo"] = key;
                    http.parameters[@"token"] = [ZHUser user].token;
                    [http postWithSuccess:^(id responseObject) {
                        
                        [TLAlert alertWithHUDText:@"修改头像成功"];
//                        [ZHUser user].userExt.photo = key;

                        [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoChange object:nil];

                    } failure:^(NSError *error) {
                        
                        
                    }];

                } option:nil];
                
                
            } failure:^(NSError *error) {
                
            }];
            
        
         
        };
        [imagePicker picker];
    
    } else {
        
        ZHSetItem *item = self.groups[indexPath.section].setItems[indexPath.row];
        if(item.action){
            item.action();
        }
    
    }
    

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (UIImageView *)portraitImageView {

    if (!_portraitImageView) {
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 19, 50, 50)];
        _portraitImageView.layer.cornerRadius = 25;
        _portraitImageView.clipsToBounds = YES;
    }
    
    return _portraitImageView;

}


- (UILabel *)phoneLbl {

    if (!_phoneLbl) {
        _phoneLbl = [UILabel labelWithFrame:CGRectMake(self.portraitImageView.xx + 20, self.portraitImageView.y, SCREEN_WIDTH - self.portraitImageView.xx - 20 - 20 - 30, 25)
                                   textAligment:NSTextAlignmentLeft
                                backgroundColor:[UIColor whiteColor]
                                           font:[UIFont secondFont]
                                      textColor:[UIColor zh_textColor]];
    }
    return _phoneLbl;

}

//- (UILabel *)contractLbl {
//
//    if (!_contractLbl) {
//        
//        
//       _contractLbl = [UILabel labelWithFrame:CGRectMake(self.phoneLbl.x, self.phoneLbl.yy, self.phoneLbl.width, 25)
//                                      textAligment:NSTextAlignmentLeft
//                                   backgroundColor:[UIColor whiteColor]
//                                              font:[UIFont systemFontOfSize:13]
//                                         textColor:[UIColor colorWithHexString:@"#999999"]];
//    }
//    return _contractLbl;
//
//}
#pragma mark-- dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headerCellId"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell addSubview:self.portraitImageView];
        
        [cell addSubview:self.phoneLbl];
        [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.portraitImageView.mas_right).offset(15);
            make.centerY.equalTo(self.portraitImageView.mas_centerY);
        }];

//        [cell addSubview:self.contractLbl];
        
        return cell;
    }
    
    ZHSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHSetCellId"];
    
    if (!cell) {
        
        cell = [[ZHSetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ceZHSetCellIdll"];
        
    }
    cell.setItem = self.groups[indexPath.section].setItems[indexPath.row];
    if (cell.infoLbl) {
        cell.infoLbl.text = self.cacheStr;
    }
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groups.count;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(section == 0) {
        return 1;
    }
    ZHSetGroup *group = self.groups[section];
    return group.setItems.count;

}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 0.1;
    }
    return 15;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 88;
    } else {
    
        return 44;
    }

}


@end
