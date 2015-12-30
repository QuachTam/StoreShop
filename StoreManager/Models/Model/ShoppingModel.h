//
//  ShoppingModel.h
//  StoreManager
//
//  Created by ATam on 12/30/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "CommonModel.h"
#import "Shopping.h"

@interface ShoppingModel : CommonModel
@property (nonatomic, strong) Shopping *entity;
- (instancetype)initWithEntity:(Shopping *)entity;
@end
