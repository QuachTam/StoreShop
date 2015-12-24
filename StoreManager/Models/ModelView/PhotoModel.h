//
//  PhotoModel.h
//  StoreManager
//
//  Created by ATam on 12/21/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "BaseModel.h"

@interface PhotoModel : BaseModel
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIImage *photo;
@end
