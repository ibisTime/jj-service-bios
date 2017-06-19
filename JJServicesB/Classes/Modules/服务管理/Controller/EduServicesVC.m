//
//  CDServicesInfoChangeVC.m
//  JJServicesB
//
//  Created by  tianlei on 2017/6/18.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "EduServicesVC.h"
//#import "ZHGoodsDetailEditView.h"
#import "TypeChooseVC.h"
#import "TypeModel.h"
#import "CDImageUpLoadView.h"
#import "QNUploadManager.h"
#import "TLUploadManager.h"
#import "TLImagePicker.h"

@interface EduServicesVC ()

@property (nonatomic, strong) TLTextField *nameTf;
@property (nonatomic, strong) TLTextField *quoteMaxTf;
@property (nonatomic, strong) TLTextField *quoteMinTf;



@property (nonatomic, strong) TLTextField *lectorNumTf;

@property (nonatomic, strong) TLTextField *mtrainTimesTf; //月均场次
@property (nonatomic, strong) TLTextField *mtrainNumTf; //月均人数

@property (nonatomic, strong) TLTextField *courseTf; //培训课程


@property (nonatomic, strong) CDImageUpLoadView *upload1View;
//@property (nonatomic, strong) CDImageUpLoadView *upload2View;
//@property (nonatomic, strong) CDImageUpLoadView *upload3View;

@property (nonatomic, copy) NSString *resum1;
@property (nonatomic, copy) NSString *resum2;
@property (nonatomic, copy) NSString *resum3;


@property (nonatomic, assign) BOOL coverImgChanged;
@property (nonatomic, assign) BOOL detailImgChanged;
@property (nonatomic, assign) BOOL reusemImgChanged;


@end

@implementation EduServicesVC {

    TLImagePicker *_picker;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self tl_placeholderOperation];
    [self setUpUI];
    [self initData];
    
}


- (void)chooseResume:(id)sender {

    if ([sender isEqual:self.upload1View.uploadBtn]) {
        
//        self.upload1View.imageView.image = 
        
    }

}

- (void)selectImg:(id)sender {
    
    __weak typeof(self) weakself = self;
    _picker = [[TLImagePicker alloc] initWithVC:self];
    _picker.pickFinish = ^(NSDictionary *info){
        
        UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
        
        if ([sender isEqual:weakself.upload1View.uploadBtn]) {
            
            weakself.upload1View.imageView.image = image;
            weakself.reusemImgChanged = YES;
            
        } else {
        
            //封面图上传
            weakself.coverImageView.image = image;
            weakself.coverImgChanged = YES;
        
        }

    };
    
    [_picker picker];
    
    
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
    NSString *coverImgSuccessKey = self.coverImgChanged ? [TLUploadManager imageNameByImage:self.coverImageView.image] : self.eduModel.pic;
    NSString *reusemImgSuccessKey = self.reusemImgChanged ? [TLUploadManager imageNameByImage:self.upload1View.imageView.image] : self.eduModel.resume1;
    NSString *detailImgSuccessKeys = nil;
        
    //
    [detailImgs enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [detailImagUrls addObject:[TLUploadManager imageNameByImage:obj]];
        
    }];
    
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
            
            [imgs addObject:self.upload1View.imageView.image];
            [imgKeys addObject:reusemImgSuccessKey];

        }
        
        if (self.detailImgChanged) {
            
            [imgs addObjectsFromArray:detailImgs];
            //去图片名成
            [imgs enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [imgKeys addObject:[TLUploadManager imageNameByImage:obj]];
                
            }];
         
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
    
    if (self.eduModel) {
        
        http.code = @"612092";

        http.parameters[@"code"] = self.eduModel.code;

    } else {
    
        http.code = @"612090";

    }
    //
    http.parameters[@"name"] = self.nameTf.text;
    http.parameters[@"pic"] = coverImgKey;
    http.parameters[@"advPic"] = detailImgKeys;
    http.parameters[@"companyCode"] = [CDCompany company].code;
    http.parameters[@"quoteMin"] = self.quoteMinTf.text;
    http.parameters[@"quoteMax"] = self.quoteMaxTf.text;
    http.parameters[@"qualityCode"] = [CDCompany company].gsQualify.code;
    http.parameters[@"description"] = self.detailEditView.detailTextView.text;
    http.parameters[@"publisher"] = [ZHUser user].userId;
    
    //以上为必填，
    http.parameters[@"lectorNum"] = self.lectorNumTf.text;
    http.parameters[@"mtrainTimes"] = self.mtrainTimesTf.text;
    http.parameters[@"mtrainNum"] = self.mtrainNumTf.text;
    http.parameters[@"course"] = self.courseTf.text;
    
    //
    http.parameters[@"resume1"] = reusemImgKey;
    http.parameters[@"resume2"] = @"无";
    http.parameters[@"resume3"] = @"无";
    
    
    
    [http postWithSuccess:^(id responseObject) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
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




//
- (void)initData {
    
    
    if (self.eduModel) {
        
        self.nameTf.text = self.eduModel.name;
        self.quoteMaxTf.text = [self.eduModel.quoteMax stringValue];
        self.quoteMinTf.text = [self.eduModel.quoteMin stringValue];
        
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[self.eduModel.pic convertThumbnailImageUrl]]];
        self.detailEditView.images =  self.eduModel.detailPics.mutableCopy;
        self.detailEditView.detailTextView.text = self.eduModel.desc;
       [self.upload1View.imageView sd_setImageWithURL:[NSURL URLWithString:[self.eduModel.resume1 convertThumbnailImageUrl]]];
        
        self.lectorNumTf.text = [@1 stringValue];
        self.mtrainNumTf.text = [@1 stringValue];
        self.mtrainTimesTf.text = [@3 stringValue];
        self.courseTf.text=  @"课程";
        
    } else {
    
        
        self.nameTf.text = @"name";
        self.quoteMaxTf.text = [NSString stringWithFormat:@"%@",@"1"];
        self.quoteMinTf.text = [NSString stringWithFormat:@"%@",@"2"];
        
        self.detailEditView.detailTextView.text = @"desc";
        
        self.lectorNumTf.text = [@1 stringValue];
        self.mtrainNumTf.text = [@1 stringValue];
        self.mtrainTimesTf.text = [@3 stringValue];
        self.courseTf.text=  @"课程";
    
    }
    
    
    
    
    
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
    self.lectorNumTf = [self tfWithFrame:CGRectMake(0, self.quoteMaxTf.yy, SCREEN_WIDTH, 45) leftTitle:@"讲师人数" placeholder:@"请输入"];
    [bgSV addSubview:self.lectorNumTf];
    self.lectorNumTf.keyboardType = UIKeyboardTypeNumberPad;

    //
    self.mtrainNumTf = [self tfWithFrame:CGRectMake(0, self.lectorNumTf.yy, SCREEN_WIDTH, 45) leftTitle:@"月均场次" placeholder:@"请输入"];
    [bgSV addSubview:self.mtrainNumTf];
    self.mtrainNumTf.keyboardType = UIKeyboardTypeNumberPad;
    
    
    //
    self.mtrainTimesTf = [self tfWithFrame:CGRectMake(0, self.mtrainNumTf.yy, SCREEN_WIDTH, 45) leftTitle:@"月均人数" placeholder:@"请输入"];
    [bgSV addSubview:self.mtrainTimesTf];
    self.mtrainTimesTf.keyboardType = UIKeyboardTypeNumberPad;
    
    //
    self.courseTf = [self tfWithFrame:CGRectMake(0, self.mtrainTimesTf.yy, SCREEN_WIDTH, 45) leftTitle:@"课程" placeholder:@"请输入"];
    [bgSV addSubview:self.courseTf];
    
    //
    self.upload1View = [[CDImageUpLoadView alloc] initWithFrame:CGRectMake(0,  self.courseTf.yy + 0.5, SCREEN_WIDTH, 80)];
    [bgSV addSubview:self.upload1View];
    self.upload1View.titleLbl.text = @"核心讲师简历1";
    [self.upload1View.uploadBtn addTarget:self action:@selector(selectImg:) forControlEvents:UIControlEventTouchUpInside];
    
    //
//    self.upload2View = [[CDImageUpLoadView alloc] initWithFrame:CGRectMake(0,  self.upload1View.yy + 0.5, SCREEN_WIDTH, 80)];
//    [bgSV addSubview:self.upload2View];
//    self.upload2View.titleLbl.text = @"核心讲师简历2";
//    [self.upload2View.uploadBtn addTarget:self action:@selector(chooseResume:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //
//    self.upload3View = [[CDImageUpLoadView alloc] initWithFrame:CGRectMake(0,  self.upload2View.yy + 0.5, SCREEN_WIDTH, 80)];
//    [bgSV addSubview:self.upload3View];
//    self.upload3View.titleLbl.text = @"核心讲师简历3";
//    [self.upload3View.uploadBtn addTarget:self action:@selector(chooseResume:) forControlEvents:UIControlEventTouchUpInside];
    
    //简介
    self.detailEditView.y = self.upload1View.yy + 10;
    
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


- (BOOL)valitInput {
    
//    [super valitInput];
    if ([self.coverImageView.image isEqual:[UIImage imageNamed:@"商铺"]]) {
        [TLAlert alertWithInfo:@"请选择缩略图"];
        return NO;
    }
    
    if (self.detailEditView.images.count <= 0) {
        
        [TLAlert alertWithInfo:@"请选详情图片"];
        
        return NO;
    }
    
    //不需要验证图片
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
    
    if (![self.lectorNumTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入讲师人数"];
        return NO;
    }
    
    if (![self.mtrainNumTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入月均人数"];
        return NO;
    }
    
    //
    if (![self.mtrainTimesTf.text valid]) {
        
        [TLAlert alertWithInfo:@"输入月均场次"];
        return NO;
    }
    
    if (!self.upload1View.imageView.image) {
        
        [TLAlert alertWithInfo:@"请上传简历"];
        return NO;
    }
    
    return YES;
    
}

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


@end
