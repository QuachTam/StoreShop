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
        TextRLModel *modelType = [[TextRLModel alloc] init];
        modelType.textLeft = @"Loại mặt hàng";
        modelType.type = ModelTextRL;
        modelType.stringDefine = @"modelType";
        modelType.index = 0;
        [array addObject:modelType];
        
        TextFieldModel *modelNumber = [[TextFieldModel alloc] init];
        modelNumber.text = @"Số lượng";
        modelNumber.value = @"1";
        modelNumber.type = ModelTextField;
        modelNumber.modelTextFieldType = ModelTextFieldType;
        modelNumber.keyBoardType = UIKeyboardTypeNumberPad;
        [array addObject:modelNumber];
        
        TextRLModel *modelDate = [[TextRLModel alloc] init];
        modelDate.textLeft = @"Ngày nhập hàng";
        modelDate.textRight = [NSDate stringFromDate:[NSDate date] withFormat:@"dd-MM-yyy HH:mm"];
        modelDate.type = ModelTextRL;
        modelDate.stringDefine = @"modelDate";
        [array addObject:modelDate];
        
        TextFieldModel *modelInput = [[TextFieldModel alloc] init];
        modelInput.text = @"Nhập vào";
        modelInput.type = ModelTextField;
        modelInput.modelTextFieldType = ModelTextFieldInput;
        modelInput.keyBoardType = UIKeyboardTypeDefault;
        [array addObject:modelInput];
        
        TextFieldModel *modelOutPut = [[TextFieldModel alloc] init];
        modelOutPut.text = @"Bán ra";
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
