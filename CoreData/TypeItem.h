//
//  TypeItem.h
//  StoreManager
//
//  Created by ATam on 12/29/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Base.h"

@class Item;

@interface TypeItem : Base

@property (nonatomic, retain) NSSet *item;
@end

@interface TypeItem (CoreDataGeneratedAccessors)

- (void)addItemObject:(Item *)value;
- (void)removeItemObject:(Item *)value;
- (void)addItem:(NSSet *)values;
- (void)removeItem:(NSSet *)values;

@end
