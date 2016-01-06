//
//  ShoppingModel.m
//  StoreManager
//
//  Created by ATam on 12/30/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "ShoppingModel.h"

@implementation ShoppingModel
@synthesize name = _name;

- (instancetype)initWithEntity:(Shopping *)entity
{
    if (self = [super init]) {
        _entity = entity;
        self.syncID = entity.syncID;
    }
    return self;
}

- (NSString *)name {
    if (!_name) {
        _name = self.entity.name ? self.entity.name : @"";
    }
    return _name;
}

- (NSArray *)modelItem {
    if (!_modelItem) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *arrayItem = [self.entity.items allObjects];
        for (NSInteger index=0; index<arrayItem.count; index++) {
            Item *itemEntity = [arrayItem objectAtIndex:index];
            ModelItem *modelItem = [[ModelItem alloc] initWithEntity:itemEntity];
            [array addObject:modelItem];
        }
        _modelItem = [array copy];
    }
    return _modelItem;
}

@end
