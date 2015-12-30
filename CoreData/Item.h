//
//  Item.h
//  StoreManager
//
//  Created by ATam on 12/30/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Base.h"

@class Qrcode, Shopping, TypeItem;

@interface Item : Base

@property (nonatomic, retain) NSDate * dateInput;
@property (nonatomic, retain) NSDate * dateOutput;
@property (nonatomic, retain) NSDate * dateUpdate;
@property (nonatomic, retain) NSNumber * isSell;
@property (nonatomic, retain) NSString * moneyInput;
@property (nonatomic, retain) NSString * moneyOutput;
@property (nonatomic, retain) NSString * qrcode;
@property (nonatomic, retain) Qrcode *qrCode;
@property (nonatomic, retain) TypeItem *typeItem;
@property (nonatomic, retain) Shopping *shopping;

@end
