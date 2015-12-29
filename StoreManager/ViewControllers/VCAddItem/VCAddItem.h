//
//  VCAddItem.h
//  StoreManager
//
//  Created by ATam on 12/21/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCAddItem : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (nonatomic, strong) NSString *uuidItem;
@property (nonatomic, strong) NSString *qrcode;
@end
