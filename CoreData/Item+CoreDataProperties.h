//
//  Item+CoreDataProperties.h
//  StoreManager
//
//  Created by Tamqn on 12/29/15.
//  Copyright © 2015 ATam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Item.h"

NS_ASSUME_NONNULL_BEGIN

@interface Item (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateInput;
@property (nullable, nonatomic, retain) NSDate *dateOutput;
@property (nullable, nonatomic, retain) NSDate *dateUpdate;
@property (nullable, nonatomic, retain) NSNumber *isSell;
@property (nullable, nonatomic, retain) NSString *moneyInput;
@property (nullable, nonatomic, retain) NSString *moneyOutput;
@property (nullable, nonatomic, retain) NSString *qrcode;
@property (nullable, nonatomic, retain) TypeItem *typeItem;
@property (nullable, nonatomic, retain) Qrcode *qrCode;

@end

NS_ASSUME_NONNULL_END
