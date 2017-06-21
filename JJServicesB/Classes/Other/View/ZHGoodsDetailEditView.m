//
//  ZHGoodsDetailVC.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/15.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHGoodsDetailEditView.h"
#import "ZHPhotosView.h"

@interface ZHGoodsDetailEditView() <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) ZHPhotosView *photosView;
//@property (nonatomic,strong) UILabel *placeholderLbl;

@end

@implementation ZHGoodsDetailEditView
{

    UIButton *_addPhotoBtn;

}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat typeNameHeight = 36;//顶部提示
        CGFloat photoChooseHeight = 90;
        CGFloat textViewBottomMargin = 0;

        CGFloat textViewH = self.height
                            - typeNameHeight
                            - photoChooseHeight
                            - textViewBottomMargin;
        //
        self.typeNameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, frame.size.width, typeNameHeight)
                                      textAligment:NSTextAlignmentLeft
                                   backgroundColor:[UIColor whiteColor]
                                              font:[UIFont secondFont]
                                         textColor:[UIColor themeColor]];
        [self addSubview:self.typeNameLbl];
        
        //textView
        self.detailTextView = [[TLTextView alloc] initWithFrame:CGRectMake(11, self.typeNameLbl.yy, frame.size.width - 32, textViewH)];
        self.detailTextView.font = [UIFont secondFont];
        self.detailTextView.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:self.detailTextView];
        
        //照片添加的
        UIButton *addImagBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, _detailTextView.yy + textViewBottomMargin, 60, 60)];
        [self addSubview:addImagBtn];
        [addImagBtn setImage:[UIImage imageNamed:@"添加图片"] forState:UIControlStateNormal];
        addImagBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [addImagBtn addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
        _addPhotoBtn = addImagBtn;
        
        ZHPhotosView *photosView = [[ZHPhotosView alloc] initWithFrame:CGRectMake(addImagBtn.xx + 10, self.detailTextView.yy + textViewBottomMargin, frame.size.width - addImagBtn.xx - 10, photoChooseHeight)];
        [self addSubview:photosView];
        self.photosView = photosView;
        photosView.backgroundColor = [UIColor whiteColor];

        //
//        CGFloat itemW = (frame.size.width - addImagBtn.xx - 5 - 15)/4.0;
//        itemW = 
//        photosView.itemSize = CGSizeMake(itemW, itemW - 5);
        
        //
        addImagBtn.centerY = photosView.centerY - 5;
        
    }

    return self;
}

- (void)setHiddenPhotoChooseBtn:(BOOL)hiddenPhotoChooseBtn {

    _hiddenPhotoChooseBtn = hiddenPhotoChooseBtn;
    
    _addPhotoBtn.hidden = _hiddenPhotoChooseBtn;
    
}
- (void)setHiddenPhotoChoose:(BOOL )hiddenPhotoChoose {

    _hiddenPhotoChoose = hiddenPhotoChoose;
    
    if (hiddenPhotoChoose) {
        _addPhotoBtn.userInteractionEnabled = NO;
        _photosView.userInteractionEnabled = YES;
    }

}
#pragma mark- 设置 photosView的图片
- (NSMutableArray  *)images {

    return self.photosView.images;
    
}

- (void)setImages:(NSMutableArray *)images {

    self.photosView.images = [NSMutableArray arrayWithArray:images];

}

- (void)setPlacholder:(NSString *)placholder {

    _placholder = [placholder copy];
    self.detailTextView.placholder = _placholder;
    
//    self.placeholderLbl.text = placholder;

}

- (void)addPhoto {
    
    UIImagePickerController *pickCtrl = [[UIImagePickerController alloc] init];
    pickCtrl.delegate = self;
    
    UIAlertController *chooseImageCtrl = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action00 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        pickCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
        [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:pickCtrl animated:YES completion:nil];
        
    }];
    
    UIAlertAction *action01 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        pickCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:pickCtrl animated:YES completion:nil];
        
    }];
    
    UIAlertAction *action02 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [chooseImageCtrl addAction:action00];
    [chooseImageCtrl addAction:action01];
    [chooseImageCtrl addAction:action02];
    [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:chooseImageCtrl animated:YES completion:nil];

//    UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
//    pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    pickVC.delegate = self;
//    //    pickVC.allowsEditing = YES;
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pickVC animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //获取图片，
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    //压缩图片--简单压缩
    NSData *data =  UIImageJPEGRepresentation(image, ZIP_COEFFICIENT);
    UIImage *newImage = [[UIImage alloc] initWithData:data];
    
    //可以在上一步，修剪图片
    if (self.photosView.images) {
        
        //每次选择图片，都会对数组进行重新赋值
        NSMutableArray *arr = self.photosView.images;
        [arr addObject:newImage];
        self.photosView.images =  arr;
        
    } else {
        
        self.photosView.images =  [NSMutableArray arrayWithObject:newImage];
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)beginEdit {

    [self.detailTextView becomeFirstResponder];

}

@end
