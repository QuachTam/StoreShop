//
//  PickerViewModel.m
//  StoreManager
//
//  Created by Tamqn on 12/23/15.
//  Copyright © 2015 ATam. All rights reserved.
//

#import "PickerViewModel.h"

@implementation PickerViewModel

- (NSArray *)arrayData {
    if (!_arrayData) {
        _arrayData = @[@"number 1", @"number 2", @"number 3", @"number 4", @"number 5", @"number 6", @"number 6", @"number 7", @"number 8", @"number 9", @"number 10", @"number 11"];
    }
    return _arrayData;
}

@end
