//
//  ShoppingDetailService.h
//  StoreManager
//
//  Created by ATam on 1/6/16.
//  Copyright (c) 2016 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelItem.h"
#import "Item.h"
#import "Shopping.h"

@interface ShoppingDetailService : NSObject
@property (nonatomic, strong) void(^didCompleteFetchData)(NSArray *data);
- (void)fetchShoppingWithID:(NSString*)syncID;

@end
