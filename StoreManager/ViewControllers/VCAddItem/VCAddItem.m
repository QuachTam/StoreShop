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
#import "CustomCellDatePicker.h"
#import "CameraObject.h"
#import "UIActionSheet+Blocks.h"
#import "PickerViewModel.h"
#import <MZFormSheetController/MZFormSheetController.h>
#import "VCPickerView.h"
#import "VCTypeItem.h"
#import "AddItemService.h"
#import "ModelItem.h"
#import "ModelTypeItem.h"

static NSString *customCellTextField = @"CustomCellTextField";
static NSString *customCellPhoto = @"CustomCellPhoto";
static NSString *customTextRightLeft = @"CustomTextRightLeft";
static NSString *customCellDatePicker = @"CustomCellDatePicker";

@interface VCAddItem ()<CameraObjectDelegate, UIActionSheetDelegate>{
    PhotoModel *photoModel;
}
@property (nonatomic, strong) AddItemService *service;
@property (strong, nonatomic) NSIndexPath *datePickerIndexPath;
@end

@implementation VCAddItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Thêm mới mặt hàng";
    [self registerTableViewCell];
    [self rightButtonNavicationBar];
    self.service = [[AddItemService alloc] initWithUuid:self.uuidItem];
    self.service.qrCode = self.qrcode;
}

- (void)rightButtonNavicationBar {
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveNewItem)];
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
}

- (BaseModel *)findObjectWithType:(IndexOfObject)typeIndex {
    BaseModel *object;
    for (NSInteger index=0; index<self.service.modelList.count; index++) {
        BaseModel *model = [self.service.modelList objectAtIndex:index];
        if (model.indexOfObject==typeIndex) {
            object = model;
            break;
        }
    }
    return object;
}

- (void)saveNewItem {
    [self.view endEditing:YES];
    TextRLModel *modelType = (TextRLModel*)[self findObjectWithType:ObjectType];
    TextRLModel *modelDate = (TextRLModel*)[self findObjectWithType:ObjectDate];
    TextFieldModel *modelInput = (TextFieldModel*)[self findObjectWithType:ObjectMoneyInput];
    TextFieldModel *modelOutPut = (TextFieldModel*)[self findObjectWithType:ObjectMoneyOutput];
    TextFieldModel *modelCode = (TextFieldModel*)[self findObjectWithType:ObjectCode];
    if (modelCode && !self.qrcode) {
        self.qrcode = modelCode.value;
    }
    NSString *message = nil;
    if (!modelOutPut.text.length) {
        message = @"Mời nhập vào giá bán";
    }
    if (!modelInput.text.length) {
        message = @"Mời nhập vào giá mua";
    }
    if (!modelDate.date) {
        modelDate.date = [NSDate date];
    }
    if (!modelType.textRight.length) {
        message = @"Mời nhập chọn loại mặt hàng";
    }
    
    if (!message) {
        self.service.modelItem.dateCreate = modelDate.date;
        self.service.modelItem.moneyInput = modelInput.value;
        self.service.modelItem.moneyOutput = modelOutPut.value;
        
        [self.service saveItem:self.service.modelItem qrcode:self.qrcode success:^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Lưu thành công" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Đồng ý", nil];
            [alert show];
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Đồng ý", nil];
        [alert show];
    }
}

- (void)registerTableViewCell {
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellTextField class]) bundle:nil] forCellReuseIdentifier:customCellTextField];
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellPhoto class]) bundle:nil] forCellReuseIdentifier:customCellPhoto];
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTextRightLeft class]) bundle:nil] forCellReuseIdentifier:customTextRightLeft];
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellDatePicker class]) bundle:nil] forCellReuseIdentifier:customCellDatePicker];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.service.modelList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseModel *baseModel = [self.service.modelList objectAtIndex:indexPath.row];
    if (baseModel.type == ModelPhoto) {
        return 207;
    }else if (baseModel.type == ModelTextRL) {
        return [self heightForBasicCellAtIndexPath:indexPath tableView:tableView];
    }else if (baseModel.type == ModelPickerDate) {
        return 160;
    }else if (baseModel.type == ModelPickerView) {
        return 160;
    }else{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseModel *baseModel = [self.service.modelList objectAtIndex:indexPath.row];
    if (baseModel.type == ModelTextField) {
        return [self customCellTextFieldCellAtIndexPath:indexPath tableView:tableView];
    }else if(baseModel.type == ModelTextRL){
        return [self customTextRightLeftCellAtIndexPath:indexPath tableView:tableView];
    }else if(baseModel.type==ModelPickerDate){
        return [self customCellDatePickerAtIndexPath:indexPath tableView:tableView];
    }else{
        return [self customCellPhotoCellAtIndexPath:indexPath tableView:tableView];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    BaseModel *baseModel = [self.service.modelList objectAtIndex:indexPath.row];
    if (baseModel.type==ModelTextRL) {
        TextRLModel *modelRL = (TextRLModel*)baseModel;
        if ([modelRL.stringDefine isEqualToString:@"modelDate"]) {
            if (self.datePickerIndexPath && self.datePickerIndexPath.row-1==indexPath.row) {
                [self deleteCell:self.datePickerIndexPath.row tableView:tableView];
                self.datePickerIndexPath = nil;
            }else{
                if (self.datePickerIndexPath) {
                    [self deleteCell:self.datePickerIndexPath.row tableView:tableView];
                }
                NSIndexPath *newIndexPath = [self calculateIndexPathForNewPicker:indexPath];
                NSMutableArray *array = [NSMutableArray arrayWithArray:self.service.modelList];
                TextRLModel *modelNew = [[TextRLModel alloc] init];
                modelNew.type = ModelPickerDate;
                [array insertObject:modelNew atIndex:indexPath.row+1];
                self.service.modelList = [array copy];
                [self insertCell:newIndexPath typeModel:ModelPickerDate tableView:tableView];
                self.datePickerIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
            }
        }else{
            VCTypeItem *typeItems = [[VCTypeItem alloc] init];
            typeItems.didSelectedRow = ^(ModelTypeItem *modelType){
                self.service.modelItem.modelTypeItem = modelType;
                
                TextRLModel *baseModel = [self.service.modelList objectAtIndex:indexPath.row];
                baseModel.textRight = modelType.name;
                CustomTextRightLeft *cellCurrent = (CustomTextRightLeft*)[tableView cellForRowAtIndexPath:indexPath];
                cellCurrent.labelRight.text = baseModel.textRight;
            };
            [self.navigationController pushViewController:typeItems animated:YES];
        }
    }
}

#pragma mark CustomCellTextField

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
    TextFieldModel *baseModel = [self.service.modelList objectAtIndex:indexPath.row];
    cell.textField.keyboardType = baseModel.keyBoardType;
    cell.labelText.text = [NSString stringWithFormat:@"%@:", baseModel.text];
    if (baseModel.value) {
        cell.textField.text = baseModel.value;
    }
    cell.textField.placeholder = baseModel.placeHolder;
    cell.model = baseModel;
}

#pragma mark CustomCellPhoto
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
    photoModel = [self.service.modelList objectAtIndex:indexPath.row];
    cell.didTakePhoto = ^{
        [UIActionSheet showInView:self.view
                        withTitle:nil
                cancelButtonTitle:@"Huỷ"
           destructiveButtonTitle:nil
                otherButtonTitles:@[@"Chụp ảnh", @"Chọn ảnh"]
                         tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex){
                             NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
                             if (![title isEqualToString:@"Huỷ"]) {
                                 CameraObject *camera = [CameraObject shareInstance];
                                 camera.delegate = self;
                                 camera.supperView = self;
                                 if([title isEqualToString:@"Chụp ảnh"]){
                                     camera.sourceType = UIImagePickerControllerSourceTypeCamera;
                                 }
                                 if ([title isEqualToString:@"Chọn ảnh"]) {
                                     camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                 }
                                 [camera showCamera];
                             }
                         }];
    };
    [self configureCustomCellPhotoCell:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

- (void)configureCustomCellPhotoCell:(CustomCellPhoto *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    PhotoModel *baseModel = [self.service.modelList objectAtIndex:indexPath.row];
    cell.labelText.text = baseModel.text;
    if (baseModel.photo) {
        cell.photo.image = baseModel.photo;
    }
}

#pragma mark CustomTextRightLeft
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

- (void)configureCustomTextRightLeftCell:(CustomTextRightLeft *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    TextRLModel *baseModel = [self.service.modelList objectAtIndex:indexPath.row];
    cell.labelLeft.text = [NSString stringWithFormat:@"%@:", baseModel.textLeft];
    cell.labelRight.text = baseModel.textRight;
}

#pragma mark CustomCellDatePicker
- (CustomCellDatePicker *)customCellDatePickerAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomCellDatePicker *cell = [self.tbView dequeueReusableCellWithIdentifier:customCellDatePicker];
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * backgroundCell = [[CustomCellBackground alloc] init];
        cell.backgroundView = backgroundCell;
    }
    
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * selectedBackgroundCell = [[CustomCellBackground alloc] init];
        selectedBackgroundCell.selected = YES;
        cell.selectedBackgroundView = selectedBackgroundCell;
    }
    
    cell.didCompletedDatePicker = ^(NSDate *dateCurrent, NSString *stringDate){
        [self setDateForCell:stringDate date:dateCurrent];
    };
    return cell;
}

- (void)setDateForCell:(NSString *)stringDate date:(NSDate*)date{
    NSIndexPath *parentCellIndexPath = nil;
    if (self.datePickerIndexPath){
        parentCellIndexPath = [NSIndexPath indexPathForRow:self.datePickerIndexPath.row - 1 inSection:0];
    }else {
        return;
    }
    TextRLModel *model = [self.service.modelList objectAtIndex:parentCellIndexPath.row];
    model.date = date;
    CustomTextRightLeft *cell = (CustomTextRightLeft*)[self.tbView cellForRowAtIndexPath:parentCellIndexPath];
    cell.labelRight.text = stringDate;
}


- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    static CustomTextRightLeft *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tbView dequeueReusableCellWithIdentifier:customTextRightLeft];
    });
    
    [self configureCustomTextRightLeftCell:sizingCell atIndexPath:indexPath tableView:tableView];
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

- (NSIndexPath *)calculateIndexPathForNewPicker:(NSIndexPath *)selectedIndexPath {
    NSIndexPath *newIndexPath;
    if (self.datePickerIndexPath && (self.datePickerIndexPath.row < selectedIndexPath.row)){
        newIndexPath = [NSIndexPath indexPathForRow:selectedIndexPath.row - 1 inSection:0];
    }else {
        newIndexPath = [NSIndexPath indexPathForRow:selectedIndexPath.row  inSection:0];
    }
    return newIndexPath;
}

- (void)insertCell:(NSIndexPath*)indexPath typeModel:(ModelStyle)typeModel tableView:(UITableView*)tableView{
    [tableView beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]];
    [[self tbView] insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationTop];
    [tableView endUpdates];
}

- (void)deleteCell:(NSInteger)index tableView:(UITableView*)tableView{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.service.modelList];
    [array removeObjectAtIndex:index];
    self.service.modelList = [array copy];
    [tableView beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]];
    [[self tbView] deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationTop];
    [tableView endUpdates];
}

- (BOOL)datePickerIsShown {
    return self.datePickerIndexPath != nil;
}

#pragma mark delegate camera

- (void)didFinishPickingMediaWithInfo:(UIImage *)image {
    photoModel.photo = image;
    [self.tbView reloadData];
}

- (void)imagePickerControllerDidCancel {
    
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
