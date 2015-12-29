//
//  TypeItem+CoreDataProperties.h
//  StoreManager
//
//  Created by Tamqn on 12/29/15.
//  Copyright © 2015 ATam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TypeItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface TypeItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<Item *> *item;

@end

@interface TypeItem (CoreDataGeneratedAccessors)

- (void)addItemObject:(Item *)value;
- (void)removeItemObject:(Item *)value;
- (void)addItem:(NSSet<Item *> *)values;
- (void)removeItem:(NSSet<Item *> *)values;

@end

NS_ASSUME_NONNULL_END
