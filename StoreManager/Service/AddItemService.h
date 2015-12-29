//
//  addItemService.h
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelManager.h"
#import "ModelItem.h"
#import "Item.h"
#import "TextFieldModel.h"
#import "PhotoModel.h"
#import "TextRLModel.h"
#import "ModelTypeItem.h"
#import "Qrcode.h"
#import "QRCodeModel.h"

@interface AddItemService : NSObject
@property (nonatomic, strong) NSArray *modelList;
@property (nonatomic, strong) ModelItem *modelItem;
- (id)initWithUuid:(NSString*)uuid;

- (void)saveItem:(ModelItem*)itemModel qrcode:(NSString*)qrcode success:(void(^)(void))success;
@end
