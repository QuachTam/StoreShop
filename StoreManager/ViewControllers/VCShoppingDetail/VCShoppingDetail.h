//
//  VCShoppingDetail.h
//  StoreManager
//
//  Created by ATam on 12/30/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCShoppingDetail : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (nonatomic, strong) NSString *syncID;
@end
