//
//  ShoppingDetailService.m
//  StoreManager
//
//  Created by ATam on 1/6/16.
//  Copyright (c) 2016 ATam. All rights reserved.
//

#import "ShoppingDetailService.h"

@implementation ShoppingDetailService

- (void)fetchShoppingWithID:(NSString *)syncID {
    Shopping *entity = [Shopping entityWithUuid:syncID inContext:[NSManagedObjectContext MR_defaultContext]];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *arrayItem = [entity.items allObjects];
    for (NSInteger index=0; index<arrayItem.count; index++) {
        Item *itemEntity = [arrayItem objectAtIndex:index];
        ModelItem *modelItem = [[ModelItem alloc] initWithEntity:itemEntity];
        [array addObject:modelItem];
    }
    if (self.didCompleteFetchData) {
        self.didCompleteFetchData([array copy]);
    }
}

- (void)removeItemFromShopping:(NSString *)shoppingId itemId:(NSString*)itemId {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Shopping *entity = [Shopping entityWithUuid:shoppingId inContext:localContext];
        Item *item = [Item entityWithUuid:itemId inContext:localContext];
        [entity removeItemsObject:item];
    }];
}

@end
