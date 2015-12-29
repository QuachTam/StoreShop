//
//  Qrcode+CoreDataProperties.h
//  StoreManager
//
//  Created by Tamqn on 12/29/15.
//  Copyright © 2015 ATam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Qrcode.h"

NS_ASSUME_NONNULL_BEGIN

@interface Qrcode (CoreDataProperties)

@property (nullable, nonatomic, retain) Item *item;

@end

NS_ASSUME_NONNULL_END
