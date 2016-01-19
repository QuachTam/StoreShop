//
//  ShoppingService.h
//  StoreManager
//
//  Created by ATam on 12/30/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingModel.h"
#import "Shopping.h"
#include "Item.h"

@interface ShoppingService : NSObject
@property (nonatomic, strong) NSArray *listTypeItem;
@property (nonatomic, copy, readwrite) void(^didFinshFetchData)();

- (void)fetchTypeItem;
- (void)saveTypeItem:(ShoppingModel*)modelTypeItem success:(void(^)(void))success;
- (void)deleteItem:(ShoppingModel*)modelType success:(void(^)(void))success;
- (void)addItemToShopping:(ShoppingModel *)shopModel itemID:(NSString*)syncID success:(void(^)(void))success;
@end
