//
//  CDServicesInfoChangeVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/18.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "OperationServicesVC.h"
//#import "ZHGoodsDetailEditView.h"
#import "TypeChooseVC.h"
#import "TypeModel.h"
#import "CDImageUpLoadView.h"
#import "TLImagePicker.h"
#import "TLUploadManager.h"


@interface OperationServicesVC ()

@property (nonatomic, strong) TLTextField *nameTf;
@property (nonatomic, strong) TLTextField *quoteMaxTf;
@property (nonatomic, strong) TLTextField *quoteMinTf;


@property (nonatomic, strong) TLTextField *tgfwTf; //提供服务
@property (nonatomic, strong) TLTextField *feeModeTf; //收费模式
@property (nonatomic, strong) TLTextField *payCycleTf; //付款周期

@property (nonatomic, strong) TLTextField *scyylmTf;//擅长类目

@property (nonatomic, strong)  CDImageUpLoadView *successCaseUploadView;

@property (nonatomic, assign) BOOL coverImgChanged;
@property (nonatomic, assign) BOOL detailImgChanged;
@property (nonatomic, assign) BOOL reusemImgChanged;

@property (nonatomic, copy) NSString *tgfw;
@property (nonatomic, copy) NSString *feeMode;
@property (nonatomic, copy) NSString *payCycle;


@property (nonatomic, strong) NSMutableArray <TypeModel *>*tgfwModels;
@property (nonatomic, strong) NSMutableArray <TypeModel *>*feeModels;
@property (nonatomic, strong) NSMutableArray <TypeModel *>*payCycleModels;

@end

@implementation OperationServicesVC {

    TLImagePicker *_picker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setPlaceholderViewTitle:@"加载失败" operationTitle:@"重新加载"];
        [self tl_placeholderOperation];

    
}



- (void)tl_placeholderOperation {

    dispatch_group_t _group =  dispatch_group_create();
    __block NSInteger successCount = 0;

    dispatch_group_enter(_group);
    TLNetworking *http = [TLNetworking new];
    http.code = @"807706";
    http.parameters[@"parentKey"] = @"dp_tgfw";
    [http postWithSuccess:^(id responseObject) {
        
        dispatch_group_leave(_group);
        successCount ++;
        
        NSArray <NSDictionary *>*arr = responseObject[@"data"];
        
        self.tgfwModels = [[NSMutableArray alloc] initWithCapacity:arr.count];
        
        [arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            TypeModel *model = [TypeModel new];
            model.key = obj[@"dkey"];
            model.value = obj[@"dvalue"];
            
            [self.tgfwModels addObject:model];
            
        }];
        
    } failure:^(NSError *error) {
        
        dispatch_group_leave(_group);

    }];
    
    //
    dispatch_group_enter(_group);
    TLNetworking *http2 = [TLNetworking new];
    http2.code = @"807706";
    http2.parameters[@"parentKey"] = @"fee_mode";
    [http2 postWithSuccess:^(id responseObject) {
        
        dispatch_group_leave(_group);
        successCount ++;
        
        NSArray <NSDictionary *>*arr = responseObject[@"data"];
        
        self.feeModels = [[NSMutableArray alloc] initWithCapacity:arr.count];
        
        [arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            TypeModel *model = [TypeModel new];
            model.key = obj[@"dkey"];
            model.value = obj[@"dvalue"];
            
            [self.feeModels addObject:model];
            
        }];
        
    } failure:^(NSError *error) {
        
        dispatch_group_leave(_group);
        
    }];

    
    //
    
    dispatch_group_enter(_group);
    TLNetworking *http3 = [TLNetworking new];
    http3.code = @"807706";
    http3.parameters[@"parentKey"] = @"pay_cycle";
    [http3 postWithSuccess:^(id responseObject) {
        
        dispatch_group_leave(_group);
        successCount ++;
        
        NSArray <NSDictionary *>*arr = responseObject[@"data"];
        
        self.payCycleModels = [[NSMutableArray alloc] initWithCapacity:arr.count];
        
        [arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            TypeModel *model = [TypeModel new];
            model.key = obj[@"dkey"];
            model.value = obj[@"dvalue"];
            
            [self.payCycleModels addObject:model];
            
        }];
        
    } failure:^(NSError *error) {
        
        dispatch_group_leave(_group);
        
    }];
    
    
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        if (successCount == 3) {
            [self removePlaceholderView];
            [self setUpUI];
            [self initData];
            
        } else {
        
            [self addPlaceholderView];
        
        }
        
        
    });


}

//
- (void)initData {
    
    
    if (self.operationModel) {
        
        self.nameTf.text = self.operationModel.name;
        self.quoteMaxTf.text = [NSString stringWithFormat:@"%@",[self.operationModel.quoteMax convertToRealMoney]];
        self.quoteMinTf.text = [NSString stringWithFormat:@"%@",[self.operationModel.quoteMin convertToRealMoney]];
        
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[self.operationModel.advPic convertThumbnailImageUrl]]];
        self.detailEditView.images =  self.operationModel.detailPics.mutableCopy;
        self.detailEditView.detailTextView.text = self.operationModel.desc;
        
        [self.successCaseUploadView.imageView sd_setImageWithURL:[NSURL URLWithString:[self.operationModel.sucCase convertThumbnailImageUrl]]];
        
        
        //
        self.tgfw = self.operationModel.tgfw;
        [self.tgfwModels enumerateObjectsUsingBlock:^(TypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.key isEqualToString:self.tgfw]) {
                
                self.tgfwTf.text = obj.value;

            }
        }];
        
        //
        self.payCycle = self.operationModel.payCycle;
        [self.payCycleModels enumerateObjectsUsingBlock:^(TypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.key isEqualToString:self.payCycle]) {
                
                self.payCycleTf.text = obj.value;
            }
        }];
        
        //
        self.feeMode = self.operationModel.feeMode;
        [self.feeModels enumerateObjectsUsingBlock:^(TypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.key isEqualToString:self.feeMode]) {
                
                self.feeModeTf.text = obj.value;
                
            }
        }];
        
        self.scyylmTf.text = self.operationModel.scyylm;
     
    }

    
}


//- (void)chooseType {
//    
//    TypeModel *model = [TypeModel new];
//    model.key = @"是";
//    model.value = @"1";
//    
//    TypeModel *noModel = [TypeModel new];
//    noModel.key = @"否";
//    noModel.value = @"0";
//    
//    TypeChooseVC *vc = [[TypeChooseVC alloc] init];
//    vc.typeArrays = @[model,noModel];
//    [self.navigationController pushViewController:vc animated:YES];
//    [vc setSelected:^(TypeModel *model){
//        
//        [self.navigationController popViewControllerAnimated:YES];
//        self.isDingZhiTf.text = model.key;
//        self.isDingZhi = model.value;
//        
//    }];
//    
//    
//}

#pragma mark- 提供服务
- (void)tgfwTypeChoose {

    
    
    TypeChooseVC *vc = [[TypeChooseVC alloc] init];
    
    //
////    A 运营 B 推广 C 拍摄 D 美工 E 客服 F 仓储 G 打包发货
//    NSDictionary *dict = @{
//                           @"A" : @"运营",
//                           @"B" : @"推广",
//                           @"C" : @"拍摄",
//                           @"D" : @"美工",
//                           @"E" : @"客服",
//                           @"F" : @"仓储",
//                           @"G" : @"打包发货"
//
//                           };
//    
//    NSMutableArray *arrs = [[NSMutableArray alloc] init];
//    
//    [dict.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//     
//        TypeModel *AModel = [TypeModel new];
//        AModel.value = obj;
//        AModel.key = dict[obj];
//        
//        [arrs addObject:AModel];
//        
//        
//    }];
    
    vc.typeArrays = self.tgfwModels;
        [self.navigationController pushViewController:vc animated:YES];
        [vc setSelected:^(TypeModel *model){
    
        [self.navigationController popViewControllerAnimated:YES];
            
         self.tgfwTf.text = model.value;
            self.tgfw = model.key;
            
        }];
    //
    

}

#pragma mark- 收费模式
- (void)sfmsTypeChoose {

    
    TypeChooseVC *vc = [[TypeChooseVC alloc] init];
    
    //
//    1 基础服务费+提成 2 服务费 3 提成
//    NSDictionary *dict = @{
//                           @"1" : @"基础服务费+提成",
//                           @"2" : @"服务费",
//                           @"3" : @"提成"
//                           
//                           };
//    
//    NSMutableArray *arrs = [[NSMutableArray alloc] init];
//    
//    [dict.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        TypeModel *AModel = [TypeModel new];
//        AModel.value = obj;
//        AModel.key = dict[obj];
//        
//        [arrs addObject:AModel];
//        
//    }];
    
    vc.typeArrays = self.feeModels;
    
    [self.navigationController pushViewController:vc animated:YES];
    [vc setSelected:^(TypeModel *model){
        
        [self.navigationController popViewControllerAnimated:YES];
        self.feeModeTf.text = model.value;
        self.feeMode = model.key;
    }];
    

}


#pragma mark- 付款选择
- (void)payCycleTypeChoose {

    
    TypeChooseVC *vc = [[TypeChooseVC alloc] init];
//    1 月付 2 季付 3 半年付 4 年付
//    NSDictionary *dict = @{
//                           @"1" : @"月付",
//                           @"2" : @"季付",
//                           @"3" : @"半年付",
//                           @"4" : @"年付"
//                           };
//    
//    NSMutableArray *arrs = [[NSMutableArray alloc] init];
//    
//    [dict.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        TypeModel *AModel = [TypeModel new];
//        AModel.value = obj;
//        AModel.key = dict[obj];
//        
//        [arrs addObject:AModel];
//        
//    }];
    
    vc.typeArrays = self.payCycleModels;
    
    [self.navigationController pushViewController:vc animated:YES];
    [vc setSelected:^(TypeModel *model){
        
        [self.navigationController popViewControllerAnimated:YES];
        self.payCycleTf.text = model.value;
        self.payCycle = model.key;
    }];

}


- (void)selectImg:(id)sender {
    
    __weak typeof(self) weakself = self;
    _picker = [[TLImagePicker alloc] initWithVC:self];
    _picker.pickFinish = ^(NSDictionary *info){
        
        UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
        
        if ([sender isEqual:weakself.successCaseUploadView.uploadBtn]) {
            
            weakself.successCaseUploadView.imageView.image = image;
            weakself.reusemImgChanged = YES;
            
        } else {
            
            //封面图上传
            weakself.coverImageView.image = image;
            weakself.coverImgChanged = YES;
            
        }
        
    };
    
    [_picker picker];
    
    
}

//
- (void)setUpUI {
    
    UIScrollView *bgSV = self.bgSV;
    
    //
    self.nameTf = [self tfWithFrame:CGRectMake(0, self.headerView.yy + 10, SCREEN_WIDTH, 45) leftTitle:@"名称" placeholder:@"请输入名称"];
    [bgSV addSubview:self.nameTf];
    
    //
    self.quoteMinTf = [self tfWithFrame:CGRectMake(0, self.nameTf.yy, SCREEN_WIDTH, 45) leftTitle:@"最小报价" placeholder:@"请输入"];
    [bgSV addSubview:self.quoteMinTf];
    self.quoteMinTf.keyboardType = UIKeyboardTypeDecimalPad;
    
    //
    self.quoteMaxTf = [self tfWithFrame:CGRectMake(0, self.quoteMinTf.yy, SCREEN_WIDTH, 45) leftTitle:@"最大报价" placeholder:@"请输入"];
    [bgSV addSubview:self.quoteMaxTf];
    self.quoteMaxTf.keyboardType = UIKeyboardTypeDecimalPad;
    
    
    //
    self.tgfwTf = [self tfWithFrame:CGRectMake(0, self.quoteMaxTf.yy, SCREEN_WIDTH, 45) leftTitle:@"服务类型" placeholder:@"请选择"];
    [bgSV addSubview:self.tgfwTf];
    self.tgfwTf.userInteractionEnabled = NO;
    UIControl *tgfwMaskCtrl = [[UIControl alloc] initWithFrame:self.tgfwTf.frame];
    [bgSV addSubview:tgfwMaskCtrl];
    [tgfwMaskCtrl addTarget:self action:@selector(tgfwTypeChoose) forControlEvents:UIControlEventTouchUpInside];
    
    
    //
    self.feeModeTf = [self tfWithFrame:CGRectMake(0, self.tgfwTf.yy, SCREEN_WIDTH, 45) leftTitle:@"收费模式" placeholder:@"请选择"];
    [bgSV addSubview:self.feeModeTf];
    self.feeModeTf.userInteractionEnabled = NO;
    
    UIControl *sfmsMaskCtrl = [[UIControl alloc] initWithFrame:self.feeModeTf.frame];
    [bgSV addSubview:sfmsMaskCtrl];
    [sfmsMaskCtrl addTarget:self action:@selector(sfmsTypeChoose) forControlEvents:UIControlEventTouchUpInside];
    //
    
    
    self.payCycleTf = [self tfWithFrame:CGRectMake(0, self.feeModeTf.yy, SCREEN_WIDTH, 45) leftTitle:@"付款周期" placeholder:@"请选择"];
    [bgSV addSubview:self.payCycleTf];
    self.payCycleTf.userInteractionEnabled = NO;
    UIControl *payCycleMaskCtrl = [[UIControl alloc] initWithFrame:self.payCycleTf.frame];
    [bgSV addSubview:payCycleMaskCtrl];
    [payCycleMaskCtrl addTarget:self action:@selector(payCycleTypeChoose) forControlEvents:UIControlEventTouchUpInside];
    
    //
    self.scyylmTf = [self tfWithFrame:CGRectMake(0, self.payCycleTf.yy, SCREEN_WIDTH, 45) leftTitle:@"擅长类目" placeholder:@"请选择"];
    [bgSV addSubview:self.scyylmTf];
    
    //
//    self.scyylmTf = [self tfWithFrame:CGRectMake(0, self.feeModeTf.yy, SCREEN_WIDTH, 45) leftTitle:@"擅长类目" placeholder:@"请选择"];
//    [bgSV addSubview:self.scyylmTf];
    
    //
    self.successCaseUploadView = [[CDImageUpLoadView alloc] initWithFrame:CGRectMake(0, self.scyylmTf.yy, SCREEN_WIDTH, 80)];
    [bgSV addSubview:self.successCaseUploadView];
    
    self.successCaseUploadView.titleLbl.text = @"成功案例";
    [bgSV addSubview:self.successCaseUploadView];
     [self.successCaseUploadView.uploadBtn addTarget:self action:@selector(selectImg:) forControlEvents:UIControlEventTouchUpInside];

  
//    UIControl *maskCtrl = [[UIControl alloc] initWithFrame:self.isDingZhiTf.frame];
//    [bgSV addSubview:maskCtrl];
//    [maskCtrl addTarget:self action:@selector(chooseType) forControlEvents:UIControlEventTouchUpInside];
    
    
    //简介
    //    self.detailEditView = [[ZHGoodsDetailEditView alloc] initWithFrame:CGRectMake(0, self.self.priceTf.yy, SCREEN_WIDTH, 200)];
    //    self.detailEditView.placholder = @"请输入一些描述信息";
    //    self.detailEditView.typeNameLbl.text = @"描述";
    //    [bgSV addSubview:self.detailEditView];
    
    self.detailEditView.y = self.successCaseUploadView.yy + 10;
    
    //
    UIButton *confirmBtn = [UIButton zhBtnWithFrame:CGRectMake(20, self.detailEditView.yy + 30, SCREEN_WIDTH - 40, 45) title:@"确认"];
    [bgSV addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(saveService) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *hintLbl = [UILabel labelWithFrame:CGRectMake(20, confirmBtn.yy + 10, confirmBtn.width, 20) textAligment:NSTextAlignmentLeft
                               backgroundColor:[UIColor clearColor]
                                          font:FONT(14)
                                     textColor:[UIColor textColor]];
    
    [bgSV addSubview:hintLbl];
    hintLbl.text = @"点击确认后将会有工作人员与您联系";
    
    bgSV.contentSize = CGSizeMake(SCREEN_WIDTH, hintLbl.yy  +10);
    
}

#pragma mark- 保存操作
- (void)saveService {
    
    if (![self valitInput]) {
        
        return;
    }
    
    //先上传图片后提交信息
    [self uploadImgAfterSaveInfo];
    
    //
    
}


- (void)uploadImgAfterSaveInfo {
    
    
    //元素为已上传的图片，可能为 0
    __block NSMutableArray <NSString *>*detailImagUrls = [NSMutableArray array];
    //元素为未上传的图片，可能为 0
    __block  NSMutableArray <UIImage *>*detailImgs = [NSMutableArray array];
    [self.detailEditView.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UIImage class]]) {
            
            self.detailImgChanged = YES;
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
    
    
    //加入图片全部上传成功后应该的到的key
    NSString *coverImgSuccessKey = self.coverImgChanged ? [TLUploadManager imageNameByImage:self.coverImageView.image] : self.operationModel.pic;
    NSString *reusemImgSuccessKey = self.reusemImgChanged ? [TLUploadManager imageNameByImage:self.successCaseUploadView.imageView.image] : self.operationModel.sucCase;
    NSString *detailImgSuccessKeys = nil;
    
    //可能要上唇的详情图片
    NSMutableArray *shouldUploadDetailImgKeys = [[NSMutableArray alloc] init];
    [detailImgs enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [shouldUploadDetailImgKeys addObject:[TLUploadManager imageNameByImage:obj]];
        
    }];
    
    [detailImagUrls addObjectsFromArray:shouldUploadDetailImgKeys];
    
    //最终的详情url数组
    detailImgSuccessKeys = [detailImagUrls componentsJoinedByString:@"||"];
    
    
    if (self.coverImgChanged || self.detailImgChanged || self.reusemImgChanged) {
        //需要上传图片
        
        NSMutableArray <UIImage *>*imgs = [[NSMutableArray alloc] init];
        NSMutableArray <NSString *>*imgKeys = [[NSMutableArray alloc] initWithCapacity:imgs.count];
        
        
        if (self.coverImgChanged) {
            
            [imgs addObject:self.coverImageView.image];
            [imgKeys addObject:coverImgSuccessKey];
            
        }
        
        if (self.reusemImgChanged) {
            
            [imgs addObject:self.successCaseUploadView.imageView.image];
            [imgKeys addObject:reusemImgSuccessKey];
            
        }
        
        if (self.detailImgChanged) {
            
            [imgs addObjectsFromArray:detailImgs];
            [imgKeys addObjectsFromArray:shouldUploadDetailImgKeys];
            
        }
        
        
        
        [self uploadImgWithImgs:imgs keys:imgKeys success:^{
            
            [self uploadServices:coverImgSuccessKey resumImgKey:reusemImgSuccessKey detailImgKeys:detailImgSuccessKeys];
            
            
        }];
        return;
        
    }
    
    //不需要上传图片
    [self uploadServices:coverImgSuccessKey resumImgKey:reusemImgSuccessKey detailImgKeys:detailImgSuccessKeys];
    
}


- (void)uploadServices:(NSString *)coverImgKey resumImgKey:(NSString *)reusemImgKey detailImgKeys:(NSString *)detailImgKeys {
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    

    if (self.operationModel) {
        

        http.parameters[@"code"] = self.operationModel.code;
        http.code = @"612112";
        
    } else {
        
        http.code = @"612110";
        
    }
    //
    http.parameters[@"name"] = self.nameTf.text;
    http.parameters[@"pic"] = detailImgKeys;
    http.parameters[@"advPic"] = coverImgKey;
    http.parameters[@"companyCode"] = [CDCompany company].code;
    http.parameters[@"quoteMin"] = [self.quoteMinTf.text convertToSysMoney];
    http.parameters[@"quoteMax"] = [self.quoteMaxTf.text convertToSysMoney];
    http.parameters[@"qualityCode"] = [CDCompany company].gsQualify.code;
    http.parameters[@"description"] = self.detailEditView.detailTextView.text;
    http.parameters[@"publisher"] = [ZHUser user].userId;
    
    //以上为必填，
    http.parameters[@"sucCase"] = self.scyylmTf.text;
    http.parameters[@"tgfw"] = self.tgfw;
    http.parameters[@"feeMode"] = self.feeMode;
    http.parameters[@"payCycle"] = self.payCycle;
    http.parameters[@"scyylm"] = self.scyylmTf.text;
    //
    http.parameters[@"sucCase"] = reusemImgKey;

    
    
    [http postWithSuccess:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        if (self.success) {
            self.success();
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
    
}



- (void)uploadImgWithImgs:(NSArray<UIImage *> *)imgs keys:(NSArray <NSString *>*)nameKeys success:(void(^)())success {
    
    
    if (!imgs || !nameKeys || imgs.count != nameKeys.count) {
        
        [TLAlert alertWithInfo:@"请检查图片数组"];
        return;
    }
    
    //
    dispatch_group_t uploadImgGroup = dispatch_group_create();
    TLNetworking *getUploadToken = [TLNetworking new];
    getUploadToken.showView = self.view;
    getUploadToken.code = @"807900";
    getUploadToken.parameters[@"token"] = [ZHUser user].token;
    [getUploadToken postWithSuccess:^(id responseObject) {
        
        //
        __block NSInteger successCount = 0;
        
        [TLProgressHUD showWithStatus:nil];
        QNUploadManager *uploadManager = [TLUploadManager qnUploadManager];
        NSString *token = responseObject[@"data"][@"uploadToken"];
        
        [imgs enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            dispatch_group_enter(uploadImgGroup);
            NSData *data =  UIImageJPEGRepresentation(obj, 1);
            [uploadManager putData:data key:nameKeys[idx] token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                
                dispatch_group_leave(uploadImgGroup);
                
                if (info.error) {
                    [TLAlert alertWithHUDText:@"店铺上传失败"];
                    return ;
                    
                }
                successCount ++;
                
            } option:nil];
            
        }];
        
        //
        dispatch_group_notify(uploadImgGroup, dispatch_get_main_queue(), ^{
            
            [TLProgressHUD dismiss];
            
            if (successCount == nameKeys.count) {
                //上传完成
                
                if (success) {
                    success();
                }
                
            }
            
            
        });
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
}



- (BOOL)valitInput {
    
    if ([self.coverImageView.image isEqual:[UIImage imageNamed:@"商铺"]]) {
        [TLAlert alertWithInfo:@"请选择缩略图"];
        return NO;
    }
    
    if (self.detailEditView.images.count <= 0) {
        
        [TLAlert alertWithInfo:@"请选详情图片"];
        
        return NO;
    }
    
    if (![self.detailEditView.detailTextView.text valid]) {
        
        [TLAlert alertWithInfo:@"请输入详情"];
        return NO;
    }
    
    if (!self.successCaseUploadView.imageView) {
        
        [TLAlert alertWithInfo:@"请上传成功案例"];

        return NO;
    }
    
    if (![self.nameTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入名称"];
        return NO;
    }
    //
    if (![self.quoteMinTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入最小报价"];
        return NO;
    }
    if (![self.quoteMaxTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入最大报价"];
        return NO;
    }
    
    if (![self.tgfw valid]) {
        
        [TLAlert alertWithInfo:@"请选择服务类型"];
        return NO;
    }
    
    if (![self.tgfw valid]) {
        
        [TLAlert alertWithInfo:@"请选择服务类型"];
        return NO;
    }
    
    if (![self.tgfw valid]) {
        
        [TLAlert alertWithInfo:@"请选择服务类型"];
        return NO;
    }
    
    if (![self.feeMode valid]) {
        
        [TLAlert alertWithInfo:@"请选择收费模式"];
        return NO;
    }
    
    if (![self.payCycle valid]) {
        
        [TLAlert alertWithInfo:@"请选择付款周期"];
        return NO;
    }
    
    return YES;
}


//- (void)upLoadImageSuccessCoverImgKey:(NSString *)coverImageKey detailImageKeys:(NSString *)keys {
//    
//    TLNetworking *http = [TLNetworking new];
//    http.showView = self.view;
//    
////    if (self.shootModel) {
////        
////        http.code = @"612082";
////        http.parameters[@"code"] = self.shootModel.code;
////        
////    } else {
////        
////        http.code = @"612080";
////        
////    }
//    http.parameters[@"name"] = self.nameTf.text;
//    http.parameters[@"pic"] = coverImageKey;
//    http.parameters[@"advPic"] = keys;
//    http.parameters[@"companyCode"] = [CDCompany company].code;
//    http.parameters[@"quoteMin"] = self.quoteMinTf.text;
//    http.parameters[@"quoteMax"] = self.quoteMaxTf.text;
//    http.parameters[@"qualityCode"] = [CDCompany company].gsQualify.code;
//    http.parameters[@"description"] = self.detailEditView.detailTextView.text;
//    http.parameters[@"publisher"] = [ZHUser user].userId;
//    //
//    http.parameters[@"pyNum"] = self.tgfwTf.text;
//    http.parameters[@"feeMode"] = @"";
//    http.parameters[@"payCycle"] = @"";
//    http.parameters[@"scyylm"] = @"";
//    http.parameters[@"sucCase"] = @"";
//
//    
//    [http postWithSuccess:^(id responseObject) {
//        
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        
//    } failure:^(NSError *error) {
//        
//        
//    }];
//    
//    
//    
//    
//}

- (TLTextField *)tfWithFrame:(CGRect)frame leftTitle:(NSString *)title placeholder:(NSString *)placeholder {
    
    TLTextField *tf = [[TLTextField alloc] initWithframe:frame leftTitle:title titleWidth:110 placeholder:placeholder];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lineColor];
    [tf addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tf);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(tf.mas_bottom);
    }];
    return tf;
    
}


//- (UIView *)setUpTableViewHeaderView {
//
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
//    headerView.backgroundColor = [UIColor whiteColor];
//    //图片选择手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImg)];
//    [headerView addGestureRecognizer:tap];
//
//    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 5, 100, 25) textAligment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] font:[UIFont secondFont] textColor:[UIColor zh_textColor]];
//    [headerView addSubview:nameLbl];
//    nameLbl.centerY = headerView.height/2.0;
//    nameLbl.text = @"店铺封面";
//    //    self.coverHintLbl = nameLbl;
//
//    //
//    UIImageView *shopCoverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 60)];
//    shopCoverImageView.image = [UIImage imageNamed:@"商铺"];
//    shopCoverImageView.xx_size = SCREEN_WIDTH - 20;
//    shopCoverImageView.clipsToBounds = YES;
//    shopCoverImageView.contentMode = UIViewContentModeScaleAspectFill;
//    shopCoverImageView.centerY = headerView.height/2.0;
//    [headerView addSubview:shopCoverImageView];
//    self.coverImageView = shopCoverImageView;
//
//
//    return headerView;
//    
//}

@end
