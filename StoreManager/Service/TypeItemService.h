//
//  TypeItemService.h
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeItem.h"
#import "ModelTypeItem.h"
#import <MagicalRecord/MagicalRecord.h>

@interface TypeItemService : NSObject
@property (nonatomic, strong) NSArray *listTypeItem;
@property (nonatomic, copy, readwrite) void(^didFinshFetchData)();

- (void)fetchTypeItem;
- (void)saveTypeItem:(ModelTypeItem*)modelTypeItem success:(void(^)(void))success;
- (void)deleteItem:(ModelTypeItem*)modelType success:(void(^)(void))success;
@end
