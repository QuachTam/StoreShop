//
//  CustomTextRightLeft.h
//  StoreManager
//
//  Created by ATam on 12/22/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWLabel.h"

@interface CustomTextRightLeft : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelLeft;
@property (weak, nonatomic) IBOutlet RWLabel *labelRight;

@end
