//
//  BaseModel.h
//  StoreManager
//
//  Created by ATam on 12/21/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ModelStyle) {
    ModelTextField,
    ModelTextRL,
    ModelPhoto,
    ModelPickerDate,
    ModelPickerView
};

typedef NS_ENUM(NSInteger, IndexOfObject) {
    ObjectType,
    ObjectCode,
    ObjectDate,
    ObjectMoneyInput,
    ObjectMoneyOutput
};

@interface BaseModel : NSObject
@property (nonatomic, readwrite) ModelStyle type;
@property (nonatomic, readwrite) IndexOfObject indexOfObject;
@end
