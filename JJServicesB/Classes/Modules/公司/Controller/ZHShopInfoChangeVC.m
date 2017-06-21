//
//  CDCompanyMgtVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/13.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHShopInfoChangeVC.h"
#import "AddressPickerView.h"
#import <CoreLocation/CoreLocation.h>
#import "ZHMapController.h"
#import "ZHGoodsDetailEditView.h"
#import "TLImagePicker.h"
#import "TLUploadManager.h"
#import "ZHShopTypeChooseVC.h"
#import "CDCompany.h"
#import "CDImageUpLoadView.h"
#import "TypeModel.h"
#import "TypeChooseVC.h"


#define LEFT_WIDTH_SHOP 120
#define INPUT_HEIGHT 44
@interface ZHShopInfoChangeVC ()<UIPickerViewDataSource>


@property (nonatomic,strong) TLTextField *shopNameTf;
@property (nonatomic,strong) TLTextField *shopAddressTf; //地址
@property (nonatomic,strong) TLTextField *detailAddressTf; //详细地址
@property (nonatomic,strong) TLTextField *shopLocationTf;
@property (nonatomic,strong) TLTextField *shopPhoneTf;
@property (nonatomic,strong) TLTextField *sloganTf;
@property (nonatomic, strong) TLTextView *advTextView;


@property (nonatomic, strong) TLTextField *peopleNameTf;
@property (nonatomic,strong) TLTextField *rateTf;
@property (nonatomic,strong) TLTextField *locationDetailAddressTf;
@property (nonatomic, strong) TLTextField *scaleTf;
@property (nonatomic, strong) CDImageUpLoadView *thumailImageUpLoadView;

@property (nonatomic, strong) TLTextField *birthTf; //成立时间
@property (nonatomic, strong) TLTextField *capitalTf; //注册资本



@property (nonatomic,strong) AddressPickerView *addressPicker;
@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) ZHGoodsDetailEditView *shopDetailView;

@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *area;


//记录封面图片有更换过吗
@property (nonatomic, assign) BOOL thumbilImageChanged;
@property (nonatomic, assign) BOOL coverImgChanged;
@property (nonatomic, assign) BOOL detailImgsChanged;


@property (nonatomic, strong) NSMutableArray <TypeModel *> *guimoModels;

@end

@implementation ZHShopInfoChangeVC
{
    TLImagePicker *_picker;
    dispatch_group_t  _uploadGroup;

}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"店铺管理";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    self.coverImgChanged = NO;
    _uploadGroup = dispatch_group_create();
    
    
    [self setPlaceholderViewTitle:@"加载失败" operationTitle:@"重新加载"];
    
    //先加载店铺信息
    [self tl_placeholderOperation];
    
  
    //
    
    
}

- (void)tl_placeholderOperation {

    
    dispatch_group_t _group = dispatch_group_create();
    __block successCount = 0;
    
    [TLProgressHUD showWithStatus:nil];

    //
    dispatch_group_enter(_group);
    [[CDCompany company] getShopInfoSuccess:^(NSDictionary *shopDict) {
        
        successCount ++;
        dispatch_group_leave(_group);

  
        
    } failure:^(NSError *error) {
        dispatch_group_leave(_group);

        
    }];
    
    //获取规模
    dispatch_group_enter(_group);

    TLNetworking *http = [TLNetworking new];
    http.code = @"807706";
    http.parameters[@"parentKey"] = @"comp_scale";
    [http postWithSuccess:^(id responseObject) {
        
        dispatch_group_leave(_group);
        successCount ++;

        NSArray <NSDictionary *>*arr = responseObject[@"data"];
        
        self.guimoModels = [[NSMutableArray alloc] initWithCapacity:arr.count];
        
        [arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            TypeModel *model = [TypeModel new];
            model.key = obj[@"dkey"];
            model.value = obj[@"dvalue"];
            
            [self.guimoModels addObject:model];
        
        }];
        
    } failure:^(NSError *error) {
        
        dispatch_group_leave(_group);

    }];
    
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        
        [TLProgressHUD dismiss];
        if (successCount == 2) {
            
            //表头 和 表尾
            [self removePlaceholderView];

            [self setUpTableViewHeaderAndFooter];
            
            [self setUpUI];
            [self initData];
            
        } else {
        
            [self addPlaceholderView];
        }
        
    });


}

- (void)initData {
 
    CDCompany *company = [CDCompany company];
    
    if (company.logo) {
        
      [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[company.logo convertThumbnailImageUrl]] placeholderImage:[UIImage imageNamed:@"商铺"]];
        
    }

    
    self.shopNameTf.text = company.name;
    
    if (company.province) {
       
        self.shopAddressTf.text = [NSString stringWithFormat:@"%@%@%@",company.province,company.city,company.area];
        self.detailAddressTf.text = company.address;
        self.province = company.province;
        self.city = company.city;
        self.area = company.area;
    }

    
    if(company.longitude) {
    
      self.locationDetailAddressTf.text = [NSString stringWithFormat:@"Lng:%@ Lat:%@",[NSString stringWithFormat:@"%.2lf",[company.longitude floatValue]],[NSString stringWithFormat:@"%.2lf",[company.latitude floatValue]]];
        self.longitude = company.longitude;
        self.latitude = company.latitude;
    }

    if (company.scale) {
        
        [self.guimoModels enumerateObjectsUsingBlock:^(TypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.key isEqualToString:company.scale]) {
                
                self.scaleTf.text = obj.value;
            }
            
        }];
        
    }
    
    //
    self.shopPhoneTf.text = company.mobile;
    self.peopleNameTf.text = company.corporation;
    
    NSString *thumailStr = [company.advPic convertThumbnailImageUrl];
    [self.thumailImageUpLoadView.imageView sd_setImageWithURL:[NSURL URLWithString:thumailStr] placeholderImage:[UIImage imageNamed:@"商铺"]];
    
    //
    self.capitalTf.text = company.registeredCapital;
    self.birthTf.text = company.regtime;
    
    if (company.slogan) {
        
        self.advTextView.text = company.slogan;

    }
    
    self.shopDetailView.detailTextView.text = company.desc;
    self.shopDetailView.images =  company.detailPics.mutableCopy;
    
}


#pragma mark- 去定位
- (void)goMap {
    
    ZHMapController *mapVC = [[ZHMapController alloc] init];
    [mapVC setConfirm:^(CLLocationCoordinate2D point,NSString *detailAddress){
        
        self.longitude = [NSString stringWithFormat:@"%.14lf",point.longitude];
        self.latitude = [NSString stringWithFormat:@"%.14lf",point.latitude];
        
        self.locationDetailAddressTf.text = [NSString stringWithFormat:@"Lng:%@ Lat:%@",[NSString stringWithFormat:@"%.2lf",point.longitude],[NSString stringWithFormat:@"%.2lf",point.latitude]];
        
    }];
    [self.navigationController pushViewController:mapVC animated:YES];
    
}


- (void)chooseScale {

    TypeChooseVC *vc = [[TypeChooseVC alloc] init];
    vc.typeArrays = self.guimoModels;
    [vc setSelected:^(TypeModel *model){
        
        [self.navigationController popViewControllerAnimated:YES];
        self.scaleTf.text = model.value;
        
    }];
    [self.navigationController pushViewController:vc animated:YES];


}


- (void)setUpUI {

    //头
    UIScrollView *bgSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:bgSV];
    
    //
    UIView *headerV = [self setUpTableViewHeaderAndFooter];
    [bgSV addSubview:headerV];
    
    //
    self.shopNameTf = [self tfWithFrame:CGRectMake(0, headerV.yy + 10, SCREEN_WIDTH, 45) leftTitle:@"店铺名称" placeholder:@"请输入店铺名称"];
    [bgSV addSubview:self.shopNameTf];
    self.shopNameTf.userInteractionEnabled = NO;
    
    //
    self.shopAddressTf = [self tfWithFrame:CGRectMake(0, self.shopNameTf.yy, SCREEN_WIDTH, 45) leftTitle:@"省/市/区(县)" placeholder:@"请选择地址"];
    [bgSV addSubview:self.shopAddressTf];
    self.shopAddressTf.enabled = NO;
    UIButton *chooseAddressBtn = [[UIButton alloc] initWithFrame:self.shopAddressTf.frame];
    [bgSV addSubview:chooseAddressBtn];
    [chooseAddressBtn addTarget:self action:@selector(chooseAddress) forControlEvents:UIControlEventTouchUpInside];
    
    
    //
    self.detailAddressTf = [self tfWithFrame:CGRectMake(0, self.shopAddressTf.yy , SCREEN_WIDTH, 45) leftTitle:@"详细地址" placeholder:@"请输入详细地址"];
    [bgSV addSubview: self.detailAddressTf];
    
    //经纬度
    self.locationDetailAddressTf = [self tfWithFrame:CGRectMake(0, self.detailAddressTf.yy , SCREEN_WIDTH, 45) leftTitle:@"经纬度" placeholder:nil];
    [bgSV addSubview: self.locationDetailAddressTf];
//    self.locationDetailAddressTf.text = @"点击定位";
    self.locationDetailAddressTf.enabled = NO;
    UIButton *jwdbtn = [[UIButton alloc] initWithFrame:CGRectMake(0,  self.locationDetailAddressTf.y, SCREEN_WIDTH - 10, self.locationDetailAddressTf.height)];
    jwdbtn.backgroundColor = [UIColor clearColor];
    jwdbtn.titleLabel.font = FONT(15);
    [jwdbtn setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
    jwdbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [bgSV addSubview:jwdbtn];
    [jwdbtn setTitle:@"点击定位" forState:UIControlStateNormal];
    [jwdbtn addTarget:self action:@selector(goMap) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    self.peopleNameTf
    = [self tfWithFrame:CGRectMake(0, self.locationDetailAddressTf.yy , SCREEN_WIDTH, 45) leftTitle:@"法人姓名" placeholder:@"请输入法人姓名"];
    [bgSV addSubview:self.peopleNameTf];
    self.peopleNameTf.userInteractionEnabled = NO;
    
    //电话
    self.shopPhoneTf
         = [self tfWithFrame:CGRectMake(0, self.peopleNameTf.yy , SCREEN_WIDTH, 45) leftTitle:@"联系电话" placeholder:@"请输入联系电话"];
    [bgSV addSubview:self.shopPhoneTf];
    self.shopPhoneTf.keyboardType = UIKeyboardTypeNumberPad;
    
    //此处应该有-----规模
    self.scaleTf
    = [self tfWithFrame:CGRectMake(0, self.shopPhoneTf.yy , SCREEN_WIDTH, 45) leftTitle:@"规模" placeholder:@"请输入规模"];
    [bgSV addSubview:self.scaleTf];
    self.scaleTf.userInteractionEnabled = NO;
    
    UIControl *scaleMaskCtrl = [[UIControl alloc] initWithFrame:self.scaleTf.frame];
    [bgSV addSubview:scaleMaskCtrl];
    [scaleMaskCtrl addTarget:self action:@selector(chooseScale) forControlEvents:UIControlEventTouchUpInside];
    


    //
    self.capitalTf
    = [self tfWithFrame:CGRectMake(0, self.scaleTf.yy + 0.5, SCREEN_WIDTH, 45) leftTitle:@"注册资本(万)" placeholder:@"请输入注册资本"];
    [bgSV addSubview:self.capitalTf];
    self.capitalTf.keyboardType = UIKeyboardTypeNumberPad;
    
    //时间
    self.birthTf
    = [self tfWithFrame:CGRectMake(0, self.capitalTf.yy , SCREEN_WIDTH, 45) leftTitle:@"成立年限(年)" placeholder:@"请输入成立年限"];
    [bgSV addSubview:self.birthTf];
    self.birthTf.keyboardType = UIKeyboardTypeDecimalPad;
    
    
    //广告语
    self.sloganTf
    = [self tfWithFrame:CGRectMake(0, self.birthTf.yy , SCREEN_WIDTH, 70) leftTitle:@"广告语" placeholder:nil];
    [bgSV addSubview:self.sloganTf];
    self.sloganTf.enabled = NO;
    
    self.advTextView = [[TLTextView alloc] initWithFrame:CGRectMake(105, self.sloganTf.y, SCREEN_WIDTH - 105, self.sloganTf.height - 1)];
    [bgSV addSubview:self.advTextView];
    self.advTextView.font = FONT(15);
    self.advTextView.textColor = [UIColor textColor];
    self.advTextView.placholder = @"请输入广告语";
    
    //此处应该有
    self.thumailImageUpLoadView = [[CDImageUpLoadView alloc] initWithFrame:CGRectMake(0, self.advTextView.yy + 1, SCREEN_WIDTH, 80)];
    [bgSV addSubview:self.thumailImageUpLoadView];
    self.thumailImageUpLoadView.titleLbl.text = @"广告图";
    [self.thumailImageUpLoadView.uploadBtn addTarget:self action:@selector(selectImg:) forControlEvents:UIControlEventTouchUpInside];
    
    //简介
    self.shopDetailView = [[ZHGoodsDetailEditView alloc] initWithFrame:CGRectMake(0, self.thumailImageUpLoadView.yy + 0.5, SCREEN_WIDTH, 200)];
    self.shopDetailView.placholder = @"请就关于您的店铺做一些简单描述";
    self.shopDetailView.typeNameLbl.text = @"店铺描述";
    [bgSV addSubview:self.shopDetailView];
    
    //
    UIButton *confitmBtn = [UIButton zhBtnWithFrame:CGRectMake(20, self.shopDetailView.yy + 30, SCREEN_WIDTH - 40, 45) title:@"提交"];
    [bgSV addSubview:confitmBtn];
    [confitmBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    //
    bgSV.contentSize = CGSizeMake(SCREEN_WIDTH, confitmBtn.yy + 20);
    
}


- (void)chooseAddress {
    
    [self.view endEditing:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:self.addressPicker];
    
}


//--//
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



#pragma mark- 保存事件
- (void)save {
    
    if (![self valitInput]) {
        return;
    }
    
    UIImage *coverImg = self.coverImageView.image;
    UIImage *thumailImg = self.thumailImageUpLoadView.imageView.image;
    
    _uploadGroup = dispatch_group_create();
    
    //元素为已上传的图片，可能为 0
    __block NSMutableArray <NSString *>*detailImagUrls = [NSMutableArray array];
    
    //元素为未上传的图片，可能为 0
    __block  NSMutableArray <UIImage *>*detailImgs = [NSMutableArray array];
    
    //上传成功 的key
    __block  NSMutableArray <NSString *>*detailImgsUploadSuccessKeys = [NSMutableArray array];
    
    [self.shopDetailView.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UIImage class]]) {
            
            self.detailImgsChanged = YES;
            [detailImgs addObject:obj];
            //第一张已经为[uiimage image] 后续肯定为Img
            if(idx == 0) {
                *stop = YES;
                detailImgs = self.shopDetailView.images;
            }
            
        } else {
            
            [detailImagUrls addObject:obj];
            
        }
        
    }];
    
    if (detailImagUrls) {
        detailImgsUploadSuccessKeys = [NSMutableArray arrayWithArray:detailImagUrls];
    }
    
    
    //封面图片
    NSString *coverImgKey = [TLUploadManager imageNameByImage:coverImg];
    __block NSString *coverImgSuccessKey;
    
    //缩略图
    NSString *thumbilImgKey = [TLUploadManager imageNameByImage:thumailImg];
    __block NSString *thumbilImgSuccessKey;
    
    
    
    //需要上传图片
    if (self.coverImgChanged || self.detailImgsChanged || self.thumbilImageChanged) {//----------
        
        TLNetworking *getUploadToken = [TLNetworking new];
        getUploadToken.showView = self.view;
        getUploadToken.code = @"807900";
        getUploadToken.parameters[@"token"] = [ZHUser user].token;
        [getUploadToken postWithSuccess:^(id responseObject) {
            

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
            
            //缩略图上传
            if (self.thumbilImageChanged) {
                
                dispatch_group_enter(_uploadGroup);
                NSData *data =  UIImageJPEGRepresentation(thumailImg, 1);
                [uploadManager putData:data key:thumbilImgKey token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    dispatch_group_leave(_uploadGroup);
                    if (info.error) {
                        
                        [TLAlert alertWithError:@"缩略图片上传失败"];
                        return ;
                        
                    }
                    thumbilImgSuccessKey = key;
                    
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
                coverImgSuccessKey = [CDCompany company].logo;
                
            }
            
            if (!self.thumbilImageChanged) {
                
                thumbilImgSuccessKey = [CDCompany company].pic;
            }
            
            dispatch_group_t group  = _uploadGroup;
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                

                [TLProgressHUD dismiss];
                if (!coverImgSuccessKey) {
                    return ;
                }
                
                if (!thumbilImgSuccessKey) {
                    return ;
                }
                
                if (detailImgsUploadSuccessKeys.count != self.shopDetailView.images.count) {
                    return;
                }
                
                //
                [self upLoadImageSuccess:coverImgSuccessKey thumailImageKey:thumbilImgSuccessKey detailImageKeys:[detailImgsUploadSuccessKeys componentsJoinedByString:@"||"]];

            });
            
            
        } failure:^(NSError *error) {
            
        }];
        
    } else {
        
        
       [self upLoadImageSuccess:[CDCompany company].slogan thumailImageKey:[CDCompany company].pic detailImageKeys:[CDCompany company].advPic];
        
    }
    
}

#pragma mark- 提交信息
- (void)upLoadImageSuccess:(NSString *)coverImageKey thumailImageKey:(NSString *)thumailImageKey detailImageKeys:(NSString *)detailImgKeys {
    
    TLNetworking *http = [TLNetworking new];
    http.showView = self.view;
    
   http.code = @"612052"; //重新提交
   http.parameters[@"code"] = [CDCompany company].code;
   http.parameters[@"updater"] = [ZHUser user].userId;
   
   //封面
   http.parameters[@"logo"] = coverImageKey;
   http.parameters[@"province"] = self.province;
   http.parameters[@"city"] = self.city;
   http.parameters[@"area"] = self.area;
   http.parameters[@"address"] = self.detailAddressTf.text; //详细地址
    http.parameters[@"longitude"] = self.longitude; //经度
    http.parameters[@"latitude"] = self.latitude; //纬度
    http.parameters[@"mobile"] = self.shopPhoneTf.text; //订购电话
    
    [self.guimoModels enumerateObjectsUsingBlock:^(TypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.value isEqual:self.scaleTf.text]) {
            
            http.parameters[@"scale"] = obj.key;
            *stop = YES;
        }
    }];
//    http.parameters[@"name"] = self.shopNameTf.text;
    //
    http.parameters[@"pic"] = thumailImageKey;
    http.parameters[@"advPic"] = detailImgKeys; //店铺图片
    http.parameters[@"description"] = self.advTextView.text;
    http.parameters[@"slogan"] = self.advTextView.text; //广告语
    http.parameters[@"registeredCapital"] = self.capitalTf.text; //广告语
    http.parameters[@"regtime"] = self.birthTf.text; //成立时间
    http.parameters[@"token"] = [ZHUser user].token;
    
    //
    [http postWithSuccess:^(id responseObject) {
        
        [TLAlert alertWithHUDText:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
        [[CDCompany company] getShopInfoSuccess:^(NSDictionary *shopDict) {
            
            
        } failure:^(NSError *error) {
            
            
        }];
        if (self.success) {
            self.success();
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}



#pragma mark- 封面图片选择事件,封面图片选择编制改变
- (void)selectImg:(id)sender {

    __weak typeof(self) weakself = self;
    _picker = [[TLImagePicker alloc] initWithVC:self];
    _picker.pickFinish = ^(NSDictionary *info){
        
        UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
        NSData *imgData = UIImageJPEGRepresentation(image, ZIP_COEFFICIENT);
        
        if ([sender isEqual:weakself.thumailImageUpLoadView.uploadBtn]) {
            //缩略图上传
            weakself.thumailImageUpLoadView.imageView.image = [UIImage imageWithData:imgData];
            weakself.thumbilImageChanged = YES;
            
        } else {
            //封面图上传
            weakself.coverImageView.image = [UIImage imageWithData:imgData];
            weakself.coverImgChanged = YES;
        }
       
        
    };
    
    [_picker picker];

}

#pragma mark- 定位的回调
- (void)location {

    ZHMapController *mapVC = [[ZHMapController alloc] init];
    mapVC.confirm = ^(CLLocationCoordinate2D point,NSString *detailAddress){
    
        self.longitude = [NSString stringWithFormat:@"%.14lf",point.longitude];
        self.latitude = [NSString stringWithFormat:@"%.14lf",point.latitude];
        self.locationDetailAddressTf.alpha = 1;
        self.locationDetailAddressTf.text = detailAddress;
    };
    
    [self.navigationController pushViewController:mapVC animated:YES];
    
}



#pragma mark- tableView 头和尾
- (UIView *)setUpTableViewHeaderAndFooter {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    headerView.backgroundColor = [UIColor whiteColor];
    //图片选择手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImg:)];
    [headerView addGestureRecognizer:tap];
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 5, 100, 25) textAligment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] font:[UIFont secondFont] textColor:[UIColor zh_textColor]];
    [headerView addSubview:nameLbl];
    nameLbl.centerY = headerView.height/2.0;
    nameLbl.text = @"店铺封面";
//    self.coverHintLbl = nameLbl;
    
    //
    UIImageView *shopCoverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 60)];
    shopCoverImageView.image = [UIImage imageNamed:@"商铺"];
    shopCoverImageView.xx_size = SCREEN_WIDTH - 20;
    shopCoverImageView.clipsToBounds = YES;
    shopCoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    shopCoverImageView.centerY = headerView.height/2.0;
    [headerView addSubview:shopCoverImageView];
    self.coverImageView = shopCoverImageView;
    
//   //被拒绝原因
//   self.refuseLbl = [UILabel labelWithFrame:CGRectMake(20, nameLbl.yy + 2, 100, 20) textAligment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] font:[UIFont thirdFont] textColor:[UIColor blackColor]];
//   [headerView addSubview:self.refuseLbl];
//    
//    [self.refuseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(nameLbl.mas_left);
//        make.top.equalTo(nameLbl.mas_bottom).offset(5);
//        make.right.equalTo(self.coverImageView.mas_left);
//    }];

    //
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
    footerView.backgroundColor = [UIColor whiteColor];
    ZHGoodsDetailEditView *shopDetailView = [[ZHGoodsDetailEditView alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH - 10, 240)];
    shopDetailView.placholder = @"输入店铺详情";
    shopDetailView.typeNameLbl.text = @"店铺详述";
    [footerView addSubview:shopDetailView];
    self.shopDetailView = shopDetailView;
//    self.shopInfoTableView.tableFooterView = footerView;
    
    return headerView;
    
}


#pragma mark- pickerView ---- dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 10;
}

- (AddressPickerView *)addressPicker {

    if (!_addressPicker) {
        
        
        _addressPicker = [[AddressPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
//        __weak AddressPickerView *weakPick = _addressPicker;
        __weak typeof(self) weakSelf = self;
        _addressPicker.confirm = ^(NSString *province,NSString *city,NSString *area){
            
            weakSelf.shopAddressTf.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
            weakSelf.province = province;
            weakSelf.city = city;
            weakSelf.area = area;
            
        };
        
    }
    return _addressPicker;

}

#pragma mark- 店铺信息验证
- (BOOL)valitInput {
    
    if ([self.coverImageView.image isEqual:[UIImage imageNamed:@"商铺"]]) {
        [TLAlert alertWithHUDText:@"请选择店铺封面"];
        return NO;
    }
    
    if (![self.shopPhoneTf.text valid]) {
        [TLAlert alertWithHUDText:@"请填写店铺名称"];
        return NO;
    }
    
    if (![self.shopAddressTf.text valid]) {
        [TLAlert alertWithHUDText:@"请选择店铺地区"];
        return NO;
    }
    
    if (![self.detailAddressTf.text valid]) {
        [TLAlert alertWithHUDText:@"请输入店铺详细地址"];
        return NO;
    }
    
    
    //定位
    if(![self.longitude valid] || ![self.latitude valid]){
        [TLAlert alertWithHUDText:@"请对店铺进行定位"];
        return NO;
    }
    
    if (!self.thumailImageUpLoadView.imageView.image) {
        [TLAlert alertWithInfo:@"请上传广告图"];
        return NO;
    }
    
    //
    if (![self.shopPhoneTf.text valid]) {
        [TLAlert alertWithHUDText:@"请输入联系电话"];
        return NO;
    }
    
    //
    if (![self.scaleTf.text valid]) {
        [TLAlert alertWithHUDText:@"请输入规模"];
        return NO;
    }
    
    if (![self.birthTf.text valid]) {
        [TLAlert alertWithHUDText:@"请输入成立年限"];
        return NO;
    }
    
    if (![self.capitalTf.text valid]) {
        [TLAlert alertWithHUDText:@"请输入注册资本"];
        return NO;
    }
    
    
    //
    if (![self.advTextView.text valid]) {
        [TLAlert alertWithHUDText:@"请输入广告语"];
        return NO;
    }
    
    if (![self.shopDetailView.detailTextView.text valid]) {
        [TLAlert alertWithHUDText:@"请填写店铺详细信息"];
        return NO;
    }
    
    if (!self.shopDetailView.images.count) {
        [TLAlert alertWithHUDText:@"请填选择店铺详情图片"];
        return NO;
    }
    return YES;
    
}

@end
