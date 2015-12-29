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
        
        TextFieldModel *modelNumber = [[TextFieldModel alloc] init];
        modelNumber.text = @"Số lượng";
        modelNumber.value = @"1";
        modelNumber.type = ModelTextField;
        modelNumber.modelTextFieldType = ModelTextFieldType;
        modelNumber.keyBoardType = UIKeyboardTypeNumberPad;
        if (!self.modelItem.entity) {
            [array addObject:modelNumber];
        }
        
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
        modelOutPut.modelTextFieldType = ModelTextFieldInput;
        modelOutPut.keyBoardType = UIKeyboardTypeDefault;
        [array addObject:modelOutPut];
        
        PhotoModel *photoModel = [[PhotoModel alloc] init];
        photoModel.text = @"Hình ảnh";
        photoModel.type = ModelPhoto;
        [array addObject:photoModel];
        
        _modelList = [array copy];
    }
    return _modelList;
}


@end
