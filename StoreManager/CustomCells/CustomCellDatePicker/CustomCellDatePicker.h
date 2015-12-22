//
//  CustomCellDatePicker.h
//  QSoftApp
//
//  Created by Quach Ngoc Tam on 12/21/15.
//  Copyright © 2015 QuangTT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellDatePicker : UITableViewCell
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, copy, readwrite) void(^didCompletedDatePicker)(NSDate *currentDate, NSString *stringDate);
- (IBAction)actionChange:(id)sender;

@end
