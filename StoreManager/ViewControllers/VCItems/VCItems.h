//
//  VCItems.h
//  StoreManager
//
//  Created by ATam on 12/21/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCBase.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"

@interface VCItems : VCBase <UITableViewDataSource, UITableViewDelegate, QRCodeReaderDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbView;

@end
