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

@end
