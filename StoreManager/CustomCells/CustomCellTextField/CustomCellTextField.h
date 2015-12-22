//
//  CustomCellTextField.h
//  StoreManager
//
//  Created by ATam on 12/21/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellCommon.h"

@interface CustomCellTextField : CustomCellCommon
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
