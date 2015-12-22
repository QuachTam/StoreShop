//
//  ModelManager.m
//  StoreManager
//
//  Created by ATam on 12/21/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "ModelManager.h"
#import "NSDate+Helper.h"

@implementation ModelManager

- (NSArray *)modelList {
    if (!_modelList) {
        NSMutableArray *array = [NSMutableArray new];
        TextFieldModel *modelType = [[TextFieldModel alloc] init];
        modelType.text = @"Loại mặt hàng";
        modelType.type = ModelTextField;
        modelType.modelTextFieldType = ModelTextFieldType;
        modelType.keyBoardType = UIKeyboardTypeDefault;
        [array addObject:modelType];
        
        TextFieldModel *modelNumber = [[TextFieldModel alloc] init];
        modelNumber.text = @"Số lượng";
        modelNumber.value = @"1";
        modelNumber.type = ModelTextField;
        modelNumber.modelTextFieldType = ModelTextFieldType;
        modelType.keyBoardType = UIKeyboardTypeNumberPad;
        [array addObject:modelNumber];
        
        TextRLModel *modelDate = [[TextRLModel alloc] init];
        modelDate.textLeft = @"Ngày nhập hàng";
        modelDate.textRight = [NSDate stringFromDate:[NSDate date] withFormat:@"dd-MM-yyy HH:mm"];
        modelDate.type = ModelTextRL;
        [array addObject:modelDate];
        
        TextFieldModel *modelInput = [[TextFieldModel alloc] init];
        modelInput.text = @"Nhập vào";
        modelInput.type = ModelTextField;
        modelInput.modelTextFieldType = ModelTextFieldInput;
        modelInput.keyBoardType = UIKeyboardTypeNumberPad;
        [array addObject:modelInput];
        
        TextFieldModel *modelOutPut = [[TextFieldModel alloc] init];
        modelOutPut.text = @"Bán ra";
        modelOutPut.type = ModelTextField;
        modelOutPut.modelTextFieldType = ModelTextFieldInput;
        modelOutPut.keyBoardType = UIKeyboardTypeNumberPad;
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
