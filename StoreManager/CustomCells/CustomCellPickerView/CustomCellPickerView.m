//
//  CustomCellPickerView.m
//  StoreManager
//
//  Created by ATam on 12/23/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "CustomCellPickerView.h"
#import <PureLayout/PureLayout.h>

@interface CustomCellPickerView ()
@property (nonatomic, strong) NSArray *arrayData;
@end
@implementation CustomCellPickerView

- (void)awakeFromNib {
    // Initialization code
    self.pickerView = [[UIPickerView alloc] initForAutoLayout];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.contentView addSubview:self.pickerView];
}

- (void)layoutSubviews {
    [self.pickerView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.pickerView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.pickerView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.pickerView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
}

- (void)reloadPickerView {
    self.arrayData = self.model.arrayData;
    [self.pickerView reloadAllComponents];
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.arrayData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.arrayData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.didSelectedRow) {
        self.didSelectedRow (row, self.arrayData[row]);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
