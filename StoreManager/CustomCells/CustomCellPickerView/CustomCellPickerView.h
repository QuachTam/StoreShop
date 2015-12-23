//
//  CustomCellPickerView.h
//  StoreManager
//
//  Created by ATam on 12/23/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewModel.h"

@interface CustomCellPickerView : UITableViewCell <UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) UIPickerView *pickerView;
@property (nonatomic, strong) PickerViewModel *model;
@property (nonatomic, copy, readwrite) void(^didSelectedRow)(NSInteger index, NSString *text);
- (void)reloadPickerView;
@end
