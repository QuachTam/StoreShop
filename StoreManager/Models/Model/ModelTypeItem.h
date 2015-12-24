//
//  ModelTypeItem.h
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "CommonModel.h"
#import "TypeItem.h"

@interface ModelTypeItem : CommonModel
@property (nonatomic, strong) TypeItem *entity;
- (instancetype)initWithEntity:(TypeItem *)entity;
@end
