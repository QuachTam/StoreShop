//
//  ModelItem.m
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "ModelItem.h"

@implementation ModelItem
@synthesize uuid = _uuid;
@synthesize name = _name;
@synthesize dateCreate = _dateCreate;

- (instancetype)initWithEntity:(Item *)entity
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

- (NSDate *)dateCreate {
    if (!_dateCreate) {
        _dateCreate = self.entity.dateCreate ? self.entity.dateCreate : [NSDate date];
    }
    return _dateCreate;
}

- (NSDate *)dateUpdate {
    if (!_dateUpdate) {
        _dateUpdate = self.entity.dateUpdate;
    }
    return _dateUpdate;
}

- (NSDate *)dateInput {
    if (!_dateInput) {
        _dateInput = self.entity.dateInput;
    }
    return _dateInput;
}

- (NSDate *)dateOutput {
    if (!_dateOutput) {
        _dateOutput = self.entity.dateOutput;
    }
    return _dateOutput;
}

- (NSNumber *)isSell {
    return self.entity.isSell;
}

- (NSString *)moneyInput {
    if (!_moneyInput) {
        _moneyInput = self.entity.moneyInput ? self.entity.moneyInput : @"";
    }
    return _moneyInput;
}

- (NSString *)moneyOutput {
    if (!_moneyOutput) {
        _moneyOutput = self.entity.moneyOutput ? self.entity.moneyOutput : @"";
    }
    return _moneyOutput;
}

- (ModelTypeItem *)modelTypeItem {
    if (!_modelTypeItem) {
        if (self.entity.typeItem) {
            _modelTypeItem = [[ModelTypeItem alloc] initWithEntity:self.entity.typeItem];
        }else{
            _modelTypeItem = [[ModelTypeItem alloc] init];
        }
    }
    return _modelTypeItem;
}
@end
