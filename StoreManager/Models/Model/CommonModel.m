//
//  CommonModel.m
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "CommonModel.h"

@implementation CommonModel
- (instancetype)init
{
    if (self = [super init]) {
        self.uuid = [[NSUUID UUID].UUIDString lowercaseString];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    CommonModel * object = [CommonModel new];
    object.uuid = [self.uuid copyWithZone:zone];
    
    return object;
}

@end
