//
//  VCTypeItem.h
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelTypeItem.h"

@interface VCTypeItem : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (nonatomic, copy, readwrite) void(^didSelectedRow)(ModelTypeItem *modelType);
@end
