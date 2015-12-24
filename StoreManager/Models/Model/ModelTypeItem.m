//
//  ModelTypeItem.m
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "ModelTypeItem.h"

@implementation ModelTypeItem
@synthesize name = _name;

- (instancetype)initWithEntity:(TypeItem *)entity
{
    if (self = [super init]) {
        _entity = entity;
        self.uuid = entity.uuid;
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
