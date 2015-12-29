//
//  QRCodeModel.m
//  StoreManager
//
//  Created by Tamqn on 12/29/15.
//  Copyright © 2015 ATam. All rights reserved.
//

#import "QRCodeModel.h"

@implementation QRCodeModel
@synthesize name = _name;

- (instancetype)initWithEntity:(Qrcode *)entity
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
