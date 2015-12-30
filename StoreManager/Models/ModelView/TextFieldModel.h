//
//  TextFieldModel.h
//  StoreManager
//
//  Created by ATam on 12/21/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger, TypeModelTextField) {
    ModelTextFieldType,
    ModelTextFieldDate,
    ModelTextFieldInput,
    ModelTextFieldOutput,
    ModelTextFieldCode
};
@interface TextFieldModel : BaseModel
@property (nonatomic, readwrite) TypeModelTextField modelTextFieldType;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, readwrite) UIKeyboardType keyBoardType;
@end
