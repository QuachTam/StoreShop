//
//  VCAddItem.m
//  StoreManager
//
//  Created by ATam on 12/21/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "VCAddItem.h"
#import "CustomCellTextField.h"
#import "CustomCellBackground.h"
#import "CustomCellPhoto.h"
#import "CustomTextRightLeft.h"
#import "TextFieldModel.h"
#import "PhotoModel.h"
#import "ModelManager.h"
#import "BaseModel.h"
#import "TextRLModel.h"

static NSString *customCellTextField = @"CustomCellTextField";
static NSString *customCellPhoto = @"CustomCellPhoto";
static NSString *customTextRightLeft = @"CustomTextRightLeft";
@interface VCAddItem ()
@property (nonatomic, strong) ModelManager *modelManager;
@end

@implementation VCAddItem

- (ModelManager *)modelManager {
    if (!_modelManager) {
        _modelManager = [[ModelManager alloc] init];
    }
    return _modelManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registerTableViewCell];
//    UIColor * lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
//    [self.tbView setBackgroundColor:lightGrayColor];
}

- (void)registerTableViewCell {
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellTextField class]) bundle:nil] forCellReuseIdentifier:customCellTextField];
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellPhoto class]) bundle:nil] forCellReuseIdentifier:customCellPhoto];
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTextRightLeft class]) bundle:nil] forCellReuseIdentifier:customTextRightLeft];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.modelManager.modelList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseModel *baseModel = [self.modelManager.modelList objectAtIndex:indexPath.row];
    if (baseModel.type == ModelPhoto) {
        return 207;
    }
    if (baseModel.type == ModelTextRL) {
        return 44;
    }
    return [self heightForBasicCellAtIndexPath:indexPath tableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseModel *baseModel = [self.modelManager.modelList objectAtIndex:indexPath.row];
    if (baseModel.type == ModelTextField) {
        return [self customCellTextFieldCellAtIndexPath:indexPath tableView:tableView];
    }else if(baseModel.type == ModelTextRL){
        return [self customTextRightLeftCellAtIndexPath:indexPath tableView:tableView];
    }else{
        return [self customCellPhotoCellAtIndexPath:indexPath tableView:tableView];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
}

- (CustomCellTextField *)customCellTextFieldCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomCellTextField *cell = [self.tbView dequeueReusableCellWithIdentifier:customCellTextField];
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * backgroundCell = [[CustomCellBackground alloc] init];
        cell.backgroundView = backgroundCell;
    }
    
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * selectedBackgroundCell = [[CustomCellBackground alloc] init];
        selectedBackgroundCell.selected = YES;
        cell.selectedBackgroundView = selectedBackgroundCell;
    }
    [self configureCustomCellTextFieldCell:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

- (void)configureCustomCellTextFieldCell:(CustomCellTextField *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    TextFieldModel *baseModel = [self.modelManager.modelList objectAtIndex:indexPath.row];
    if (baseModel.modelTextFieldType == ModelTextFieldDate) {
        
    }
    cell.labelText.text = [NSString stringWithFormat:@"%@:", baseModel.text];
}

- (CustomCellPhoto *)customCellPhotoCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomCellPhoto *cell = [self.tbView dequeueReusableCellWithIdentifier:customCellPhoto];
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * backgroundCell = [[CustomCellBackground alloc] init];
        cell.backgroundView = backgroundCell;
    }
    
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * selectedBackgroundCell = [[CustomCellBackground alloc] init];
        selectedBackgroundCell.selected = YES;
        cell.selectedBackgroundView = selectedBackgroundCell;
    }
    [self configureCustomCellPhotoCell:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

- (CustomTextRightLeft *)customTextRightLeftCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomTextRightLeft *cell = [self.tbView dequeueReusableCellWithIdentifier:customTextRightLeft];
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * backgroundCell = [[CustomCellBackground alloc] init];
        cell.backgroundView = backgroundCell;
    }
    
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * selectedBackgroundCell = [[CustomCellBackground alloc] init];
        selectedBackgroundCell.selected = YES;
        cell.selectedBackgroundView = selectedBackgroundCell;
    }
    [self configureCustomTextRightLeftCell:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

- (void)configureCustomCellPhotoCell:(CustomCellPhoto *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    PhotoModel *baseModel = [self.modelManager.modelList objectAtIndex:indexPath.row];
    cell.labelText.text = baseModel.text;
}

- (void)configureCustomTextRightLeftCell:(CustomTextRightLeft *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    TextRLModel *baseModel = [self.modelManager.modelList objectAtIndex:indexPath.row];
    cell.labelLeft.text = [NSString stringWithFormat:@"%@:", baseModel.textLeft];
    cell.labelRight.text = baseModel.textRight;
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    static CustomCellTextField *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tbView dequeueReusableCellWithIdentifier:customCellTextField];
    });
    
    [self configureCustomCellTextFieldCell:sizingCell atIndexPath:indexPath tableView:tableView];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    if (size.height<44) {
        return 44;
    }
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
