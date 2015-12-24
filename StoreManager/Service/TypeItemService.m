//
//  TypeItemService.m
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "TypeItemService.h"

@implementation TypeItemService

- (void)fetchTypeItem{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *listTypeItem = [TypeItem MR_findAllInContext:[NSManagedObjectContext MR_defaultContext]];
    for (NSInteger index=0; index<listTypeItem.count; index++) {
        ModelTypeItem *modelItem = [[ModelTypeItem alloc] initWithEntity:[listTypeItem objectAtIndex:index]];
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

@end
