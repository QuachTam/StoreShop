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

@interface BaseModel : NSObject
@property (nonatomic, readwrite) ModelStyle type;
@end
