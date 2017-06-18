//
//  ZHSetCell.m
//  ZHBusiness
//
//  Created by  tianlei on 2016/12/12.
//  Copyright © 2016年  tianlei. All rights reserved.
//

#import "ZHSetCell.h"

@implementation ZHSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.font = [UIFont secondFont];
        self.textLabel.textColor = [UIColor zh_textColor];
    }
    
    return self;
}

- (void)setSetItem:(ZHSetItem *)setItem {

    _setItem = setItem;
    self.textLabel.text = _setItem.title;
    if(_setItem.type == ZHSetItemAccessoryTypeArrow) {
        self.accessoryView = nil;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;

    } else if (_setItem.type == ZHSetItemAccessoryTypeSwitch) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryView = self.switchView;
        self.infoLbl.hidden = YES;
        self.switchView.hidden = NO;

    } else {
        
        self.accessoryView = self.infoLbl;
//        self.infoLbl.text = @"221 M";
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.infoLbl.hidden = NO;
        self.switchView.hidden = YES;

    }

}

- (UISwitch *)switchView {

    if (!_switchView) {
        
        _switchView = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        _switchView.on = YES;
        [_switchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        
    }

    return _switchView;
}

- (void)switchChange:(UISwitch *)sw {

    if (self.switchAction) {
        self.switchAction(sw.on);
    }
    

}

- (UILabel *)infoLbl {
    
    if (!_infoLbl) {
        
        _infoLbl = [UILabel labelWithFrame:CGRectMake(0, 0, 80, 40) textAligment:NSTextAlignmentRight
                                  backgroundColor:[UIColor whiteColor]
                                             font:[UIFont systemFontOfSize:12]
                                        textColor:[UIColor blackColor]];
        
    }
    return _infoLbl;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
