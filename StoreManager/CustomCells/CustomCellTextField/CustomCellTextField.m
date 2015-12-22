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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeTextField:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didChangeTextField:(NSNotification*)notification {
    UITextField *textField = notification.object;
    self.model.text = textField.text;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    self.model.text = nil;
    return YES;
}
@end
