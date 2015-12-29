//
//  CustomCellTextField.m
//  StoreManager
//
//  Created by ATam on 12/21/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "CustomCellTextField.h"

@implementation CustomCellTextField

- (void)awakeFromNib {
    // Initialization code
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidChange:(UITextField*)textField{
    self.model.value = textField.text;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    self.model.value = @"";
    return YES;
}
@end
