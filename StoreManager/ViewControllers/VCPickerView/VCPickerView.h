//
//  VCPickerView.h
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCPickerView : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, copy, readwrite) void(^didSelectedRow)(NSInteger index, NSString *text);
- (void)reloadPickerView;

@end
