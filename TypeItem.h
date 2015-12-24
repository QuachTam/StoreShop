//
//  TypeItem.h
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Base.h"

@class Item;

@interface TypeItem : Base

@property (nonatomic, retain) Item *item;

@end
