//
//  ServicesBaseVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/19.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "ServicesBaseVC.h"
#import "ZHGoodsDetailEditView.h"
#import "QNUploadManager.h"
#import "TLUploadManager.h"
#import "TLImagePicker.h"

@interface ServicesBaseVC ()

@property (nonatomic, assign) BOOL detailImgsChanged;
@property (nonatomic, assign) BOOL coverImgChanged;


@end

@implementation ServicesBaseVC
{
    dispatch_group_t _uploadGroup;
    TLImagePicker *_picker;


}

//- (void)hiddenCommon {
//
//
//}
//
//- (void)showCommon {
//
//}

- (void)viewDidLoad {

    [super viewDidLoad];


    
    _uploadGroup = dispatch_group_create();
    
    
    //
    self.bgSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:self.bgSV];

    //
    self.headerView = [self setUpTableViewHeaderView];
    [self.bgSV addSubview:self.headerView];
    
    //
    //
//    self.quoteMinTf = [self tfWithFrame:CGRectMake(0, self.nameTf.yy, SCREEN_WIDTH, 45) leftTitle:@"最小报价" placeholder:@"请输入"];
//    [self.bgSV addSubview:self.quoteMinTf];
//    self.quoteMinTf.keyboardType = UIKeyboardTypeDecimalPad;
//    
//    //
//    self.quoteMaxTf = [self tfWithFrame:CGRectMake(0, self.quoteMinTf.yy, SCREEN_WIDTH, 45) leftTitle:@"最大报价" placeholder:@"请输入"];
//    [self.bgSV addSubview:self.quoteMaxTf];
//    self.quoteMaxTf.keyboardType = UIKeyboardTypeDecimalPad;

    
    //
    self.detailEditView = [[ZHGoodsDetailEditView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.detailEditView.placholder = @"请输入简介";
    self.detailEditView.typeNameLbl.text = @"简介";
    [self.bgSV addSubview:self.detailEditView];
    
}


//
//- (BOOL)valitInput {
//
//    if ([self.coverImageView.image isEqual:[UIImage imageNamed:@"商铺"]]) {
//        [TLAlert alertWithInfo:@"请选择缩略图"];
//        return NO;
//    }
//    
//    if (self.detailEditView.images.count <= 0) {
//        
//        [TLAlert alertWithInfo:@"请选详情图片"];
//
//        return NO;
//    }
//
//    return YES;
//}


#pragma mark- 保存事件
- (void)saveWithCoverImg:(NSString *)hasCoverImgStr {
    

    
    UIImage *coverImg = self.coverImageView.image;
    _uploadGroup = dispatch_group_create();
    
    //元素为已上传的图片，可能为 0
    __block NSMutableArray <NSString *>*detailImagUrls = [NSMutableArray array];
    
    //元素为未上传的图片，可能为 0
    __block  NSMutableArray <UIImage *>*detailImgs = [NSMutableArray array];
    
    //上传成功 的key
    __block  NSMutableArray <NSString *>*detailImgsUploadSuccessKeys = [NSMutableArray array];
    
    [self.detailEditView.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UIImage class]]) {
            
            self.detailImgsChanged = YES;
            [detailImgs addObject:obj];
            
            //第一张已经为[uiimage image] 后续肯定为Img
            if(idx == 0) {
                *stop = YES;
                detailImgs = self.detailEditView.images;
            }
            
        } else { //为url
            
            [detailImagUrls addObject:obj];
            
        }
        
    }];
    
    if (detailImagUrls) {
        detailImgsUploadSuccessKeys = [NSMutableArray arrayWithArray:detailImagUrls];
    }
    
    
    //封面图片
    NSString *coverImgKey = [TLUploadManager imageNameByImage:coverImg];
    __block NSString *coverImgSuccessKey;
    
    
    //需要上传图片
    if (self.coverImgChanged || self.detailImgsChanged) {//----------
        
        TLNetworking *getUploadToken = [TLNetworking new];
        getUploadToken.showView = self.view;
        getUploadToken.code = @"807900";
        getUploadToken.parameters[@"token"] = [ZHUser user].token;
        [getUploadToken postWithSuccess:^(id responseObject) {
            
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [TLProgressHUD showWithStatus:nil];
        
            QNUploadManager *uploadManager = [TLUploadManager qnUploadManager];
            NSString *token = responseObject[@"data"][@"uploadToken"];

            //封面图片上传
            if(self.coverImgChanged){
                dispatch_group_enter(_uploadGroup);
                NSData *data =  UIImageJPEGRepresentation(coverImg, 1);
                [uploadManager putData:data key:coverImgKey token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    
                    dispatch_group_leave(_uploadGroup);
                    if (info.error) {
                        
                        [TLAlert alertWithHUDText:@"店铺图片上传失败"];
                        return ;
                        
                    }
                    coverImgSuccessKey = key;
                    
                } option:nil];
                
            }
            
         
            
            //其它图片上传
            if (self.detailImgsChanged) {
                for (NSInteger i = 0; i < detailImgs.count; i ++) {
                    
                    dispatch_group_enter(_uploadGroup);
                    UIImage *image = detailImgs[i];
                    NSData *data =  UIImageJPEGRepresentation(image, 1);
                    [uploadManager putData:data key:[TLUploadManager imageNameByImage:image] token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                        
                        dispatch_group_leave(_uploadGroup);
                        if (info.error) {
                            
                            [TLAlert alertWithHUDText:@"店铺图片上传失败"];
                            return ;
                            
                        }
                        
                        [detailImgsUploadSuccessKeys addObject:key];
                        
                    } option:nil];
                    
                }
                
            }
            //上传完进行汇总
            if (!self.coverImgChanged) {
                
#warning --mark dangrous
                coverImgSuccessKey = hasCoverImgStr;
                
            }
            
            
            dispatch_group_t group  = _uploadGroup;
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                
                [TLProgressHUD dismiss];
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                if (!coverImgSuccessKey) {
                    return ;
                }
                
                
                if (detailImgsUploadSuccessKeys.count != self.detailEditView.images.count) {
                    return;
                }
                
                //
                [self upLoadImageSuccessCoverImgKey:coverImgSuccessKey detailImageKeys:[detailImgsUploadSuccessKeys componentsJoinedByString:@"||"]];
                
            });
            
            
        } failure:^(NSError *error) {
            
        }];
        
        return;
    }
    
    
    [self upLoadImageSuccessCoverImgKey:hasCoverImgStr detailImageKeys:[self.detailEditView.images componentsJoinedByString:@"||"]];
    
}

- (void)upLoadImageSuccessCoverImgKey:(NSString  *)coverImageKey detailImageKeys:(NSString *)keys {

    @throw [NSException exceptionWithName:@"" reason:@"子类应该实现该尴尬" userInfo:nil];


}

- (void)selectImg {

    __weak typeof(self) weakself = self;
    _picker = [[TLImagePicker alloc] initWithVC:self];
    _picker.pickFinish = ^(NSDictionary *info, UIImage *newImg){
        
       
    
            //封面图上传
        weakself.coverImageView.image = newImg;
        weakself.coverImgChanged = YES;
        
        
    };
    
    [_picker picker];


}


- (UIView *)setUpTableViewHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    headerView.backgroundColor = [UIColor whiteColor];
    //图片选择手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImg)];
    [headerView addGestureRecognizer:tap];
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 5, 100, 25) textAligment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] font:[UIFont secondFont] textColor:[UIColor zh_textColor]];
    [headerView addSubview:nameLbl];
    nameLbl.centerY = headerView.height/2.0;
    nameLbl.text = @"缩略图";
    //
    
    
    //
    UIImageView *shopCoverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 60)];
    shopCoverImageView.image = [UIImage imageNamed:@"商铺"];
    shopCoverImageView.xx_size = SCREEN_WIDTH - 20;
    shopCoverImageView.clipsToBounds = YES;
    shopCoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    shopCoverImageView.centerY = headerView.height/2.0;
    [headerView addSubview:shopCoverImageView];
    self.coverImageView = shopCoverImageView;
    
    
    return headerView;
    
}

@end
