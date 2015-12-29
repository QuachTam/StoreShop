//
//  Base+CoreDataProperties.h
//  StoreManager
//
//  Created by Tamqn on 12/29/15.
//  Copyright © 2015 ATam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Base.h"

NS_ASSUME_NONNULL_BEGIN

@interface Base (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateCreate;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *syncID;

@end

NS_ASSUME_NONNULL_END
