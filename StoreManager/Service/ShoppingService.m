//
//  ShoppingService.m
//  StoreManager
//
//  Created by ATam on 12/30/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "ShoppingService.h"

@implementation ShoppingService
- (void)fetchTypeItem{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *listTypeItem = [Shopping MR_findAllInContext:[NSManagedObjectContext MR_defaultContext]];
    for (NSInteger index=0; index<listTypeItem.count; index++) {
        ShoppingModel *modelItem = [[ShoppingModel alloc] initWithEntity:[listTypeItem objectAtIndex:index]];
        [array addObject:modelItem];
    }
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES comparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString *)obj1 compare:(NSString *)obj2 options:NSNumericSearch];
    }];
    self.listTypeItem = [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    if (self.didFinshFetchData) {
        self.didFinshFetchData();
    }
}

- (void)saveTypeItem:(ShoppingModel*)modelTypeItem success:(void(^)(void))success {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Shopping *entity = [Shopping entityWithUuid:modelTypeItem.syncID inContext:localContext];
        entity.name = modelTypeItem.name;
    }];
    if (success) {
        success();
    }
}

- (void)deleteItem:(ShoppingModel*)modelType success:(void(^)(void))success {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Shopping *entity = [Shopping entityWithUuid:modelType.syncID inContext:localContext];
        [entity MR_deleteEntityInContext:localContext];
    }];
    if (success) {
        success();
    }
}

- (void)addItemToShopping:(ShoppingModel *)shopModel itemID:(NSString*)syncID success:(void(^)(void))success{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Shopping *shoppingEntity = [Shopping entityWithUuid:shopModel.syncID inContext:localContext];
        Item *itemEntity = [Item entityWithUuid:syncID inContext:localContext];
        [shoppingEntity addItemsObject:itemEntity];
    }];
    if (success) {
        success();
    }
}
@end
