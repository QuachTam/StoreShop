//
//  addItemService.m
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "AddItemService.h"
#import <MagicalRecord/MagicalRecord.h>
#import "NSDate+Helper.h"

@implementation AddItemService

- (id)initWithUuid:(NSString*)uuid {
    self = [super init];
    if (self) {
        if (uuid) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"syncID=%@", uuid];
            Item *entity = [Item MR_findFirstWithPredicate:predicate inContext:[NSManagedObjectContext MR_defaultContext]];
            if (entity) {
                self.modelItem = [[ModelItem alloc] initWithEntity:entity];
            }else{
                self.modelItem = [[ModelItem alloc] init];
            }
        }else{
            self.modelItem = [[ModelItem alloc] init];
        }
    }
    return self;
}

- (NSArray *)modelList {
    if (!_modelList) {
        NSMutableArray *array = [NSMutableArray new];
        TextRLModel *modelType = [[TextRLModel alloc] init];
        modelType.textLeft = @"Loại mặt hàng";
        modelType.type = ModelTextRL;
        modelType.stringDefine = @"modelType";
        modelType.index = 0;
        if (self.modelItem.entity) {
            modelType.textRight = self.modelItem.modelTypeItem.name;
        }
        [array addObject:modelType];
        
        TextRLModel *modelDate = [[TextRLModel alloc] init];
        modelDate.textLeft = @"Ngày nhập hàng";
        modelDate.textRight = [NSDate stringFromDate:self.modelItem.dateCreate withFormat:@"dd-MM-yyy HH:mm"];
        modelDate.type = ModelTextRL;
        modelDate.stringDefine = @"modelDate";
        [array addObject:modelDate];
        
        TextFieldModel *modelInput = [[TextFieldModel alloc] init];
        modelInput.text = @"Nhập vào";
        modelInput.value = self.modelItem.moneyInput;
        modelInput.type = ModelTextField;
        modelInput.modelTextFieldType = ModelTextFieldInput;
        modelInput.keyBoardType = UIKeyboardTypeDefault;
        [array addObject:modelInput];
        
        TextFieldModel *modelOutPut = [[TextFieldModel alloc] init];
        modelOutPut.text = @"Bán ra";
        modelOutPut.value = self.modelItem.moneyOutput;
        modelOutPut.type = ModelTextField;
        modelOutPut.modelTextFieldType = ModelTextFieldOutput;
        modelOutPut.keyBoardType = UIKeyboardTypeDefault;
        [array addObject:modelOutPut];
        
        _modelList = [array copy];
    }
    return _modelList;
}

- (void)saveItem:(ModelItem*)itemModel qrcode:(NSString*)qrcode success:(void(^)(void))success {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        NSPredicate *predicateItem = [NSPredicate predicateWithFormat:@"syncID=%@", itemModel.syncID];
        Item *newEntity = [Item MR_findFirstWithPredicate:predicateItem inContext:localContext];
        if (!newEntity) {
            newEntity = [Item MR_createEntityInContext:localContext];
        }
        newEntity.syncID = itemModel.syncID;
        newEntity.dateInput = itemModel.dateCreate;
        newEntity.dateUpdate = itemModel.dateUpdate;
        newEntity.isSell  = itemModel.isSell;
        newEntity.moneyInput = itemModel.moneyInput;
        newEntity.moneyOutput = itemModel.moneyOutput;
        newEntity.typeItem = nil;
        if (qrcode) {
            Qrcode *qrCodeEntity = [Qrcode MR_createEntityInContext:localContext];
            qrCodeEntity.name = qrcode;
            newEntity.qrCode = qrCodeEntity;
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"syncID=%@", itemModel.modelTypeItem.syncID];
        TypeItem *typeEntity = [TypeItem MR_findFirstWithPredicate:predicate inContext:localContext];
        [typeEntity addItemObject:newEntity];
        
    }];
    if (success) {
        success();
    }
}
@end
