//
//  VCShopping.h
//  StoreManager
//
//  Created by Tamqn on 12/30/15.
//  Copyright © 2015 ATam. All rights reserved.
//

#import "VCBase.h"
typedef NS_ENUM(NSInteger, FROM_VC){
    from_none,
    from_item
};
@interface VCShopping : VCBase
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (nonatomic, readwrite) FROM_VC type_from;
@property (nonatomic, strong) NSString *syncIDItem;

@end
