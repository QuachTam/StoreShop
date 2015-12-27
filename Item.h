//
//  Item.h
//  StoreManager
//
//  Created by ATam on 12/27/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Base.h"

@class TypeItem;

@interface Item : Base

@property (nonatomic, retain) NSDate * dateInput;
@property (nonatomic, retain) NSDate * dateOutput;
@property (nonatomic, retain) NSDate * dateUpdate;
@property (nonatomic, retain) NSNumber * isSell;
@property (nonatomic, retain) NSString * moneyInput;
@property (nonatomic, retain) NSString * moneyOutput;
@property (nonatomic, retain) TypeItem *typeItem;

@end
