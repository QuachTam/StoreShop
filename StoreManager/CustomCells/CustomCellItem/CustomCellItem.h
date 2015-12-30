//
//  CustomCellItem.h
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWLabel.h"

@interface CustomCellItem : UITableViewCell
@property (weak, nonatomic) IBOutlet RWLabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelValueDateInput;
@property (weak, nonatomic) IBOutlet UILabel *labelTextDateInput;
@property (weak, nonatomic) IBOutlet UILabel *labelTextDateOutput;
@property (weak, nonatomic) IBOutlet UILabel *labelValueDateOutput;
@property (weak, nonatomic) IBOutlet UILabel *labelTextMoneyInput;
@property (weak, nonatomic) IBOutlet UILabel *labelValueMoneyInput;
@property (weak, nonatomic) IBOutlet UILabel *labelTextMoneyOutput;
@property (weak, nonatomic) IBOutlet UILabel *labelValueMoneyOutput;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTextInput;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintValueInput;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTextDateInput;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintValuteDateInput;


@property (nonatomic, strong) void(^didClickShopping)(NSInteger index);
- (IBAction)actionShopping:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonShopping;

@end
