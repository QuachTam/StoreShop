//
//  CustomCellDatePicker.m
//  QSoftApp
//
//  Created by Quach Ngoc Tam on 12/21/15.
//  Copyright © 2015 QuangTT. All rights reserved.
//

#import "CustomCellDatePicker.h"

@implementation CustomCellDatePicker

- (void)awakeFromNib {
    // Initialization code
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.datePicker setLocale:[NSLocale systemLocale]];
}

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    if (self.didCompletedDatePicker) {
        self.didCompletedDatePicker (datePicker.date, strDate);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)actionChange:(id)sender {
    
}
@end
