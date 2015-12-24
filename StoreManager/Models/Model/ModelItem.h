//
//  ModelItem.h
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "CommonModel.h"
#import "Item.h"
#import "ModelTypeItem.h"

@interface ModelItem : CommonModel
@property (nonatomic, retain) NSDate * dateUpdate;
@property (nonatomic, retain) NSDate * dateInput;
@property (nonatomic, retain) NSDate * dateOutput;
@property (nonatomic, retain) NSNumber * isSell;
@property (nonatomic, retain) NSString * moneyInput;
@property (nonatomic, retain) NSString * moneyOutput;
@property (nonatomic, retain) ModelTypeItem *modelTypeItem;

@property (nonatomic, strong) Item *entity;
- (instancetype)initWithEntity:(Item *)entity;
@end
