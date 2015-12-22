//
//  TextRLModel.h
//  StoreManager
//
//  Created by ATam on 12/22/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "BaseModel.h"

@interface TextRLModel : BaseModel
@property (nonatomic, strong) NSString *textLeft;
@property (nonatomic, strong) NSString *textRight;

@property (nonatomic, strong) NSDate *date;
@end
