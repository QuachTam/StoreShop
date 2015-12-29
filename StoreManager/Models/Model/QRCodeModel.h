//
//  QRCodeModel.h
//  StoreManager
//
//  Created by Tamqn on 12/29/15.
//  Copyright © 2015 ATam. All rights reserved.
//

#import "CommonModel.h"
#import "Qrcode.h"

@interface QRCodeModel : CommonModel

@property (nonatomic, strong) Qrcode *entity;
- (instancetype)initWithEntity:(Qrcode *)entity;
@end
