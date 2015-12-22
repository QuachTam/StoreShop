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

static NSString *customCellTextField = @"CustomCellTextField";
static NSString *customCellPhoto = @"CustomCellPhoto";
static NSString *customTextRightLeft = @"CustomTextRightLeft";
static NSString *customCellDatePicker = @"CustomCellDatePicker";

@interface VCAddItem ()<CameraObjectDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) ModelManager *modelManager;
@property (strong, nonatomic) NSIndexPath *datePickerIndexPath;
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
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellDatePicker class]) bundle:nil] forCellReuseIdentifier:customCellDatePicker];
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
    if (baseModel.type == ModelPickerDate) {
        return 160;
    }
    return [self heightForBasicCellAtIndexPath:indexPath tableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseModel *baseModel = [self.modelManager.modelList objectAtIndex:indexPath.row];
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
    BaseModel *baseModel = [self.modelManager.modelList objectAtIndex:indexPath.row];
    if (baseModel.type==ModelTextRL) {
        if (self.datePickerIndexPath && self.datePickerIndexPath.row-1==indexPath.row) {
            if (index>=0) {
                [self deleteCell:self.datePickerIndexPath.row tableView:tableView];
            }
            self.datePickerIndexPath = nil;
        }else{
            if (self.datePickerIndexPath) {
                [self deleteCell:self.datePickerIndexPath.row tableView:tableView];
            }
            NSIndexPath *newIndexPath = [self calculateIndexPathForNewPicker:indexPath];
            [self insertCell:newIndexPath typeModel:ModelPickerDate tableView:tableView];
        }
    }
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
    cell.textField.keyboardType = baseModel.keyBoardType;
    cell.labelText.text = [NSString stringWithFormat:@"%@:", baseModel.text];
    if (baseModel.value) {
        cell.textField.text = baseModel.value;
    }
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
    cell.didTakePhoto = ^{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Chụp ảnh" delegate:self cancelButtonTitle:@"Huỷ" destructiveButtonTitle:nil otherButtonTitles:@"Chụp ảnh", @"Chọn ảnh", nil];
        [actionSheet showInView:self.view];
    };
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

- (void)configureCustomCellPhotoCell:(CustomCellPhoto *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    PhotoModel *baseModel = [self.modelManager.modelList objectAtIndex:indexPath.row];
    cell.labelText.text = baseModel.text;
    if (baseModel.photo) {
        cell.photo.image = baseModel.photo;
    }
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

- (NSIndexPath *)calculateIndexPathForNewPicker:(NSIndexPath *)selectedIndexPath {
    NSIndexPath *newIndexPath;
    if (([self datePickerIsShown]) && (self.datePickerIndexPath.row < selectedIndexPath.row)){
        newIndexPath = [NSIndexPath indexPathForRow:selectedIndexPath.row - 1 inSection:0];
    }else {
        newIndexPath = [NSIndexPath indexPathForRow:selectedIndexPath.row  inSection:0];
    }
    return newIndexPath;
}

- (void)setDateForCell:(NSString *)stringDate date:(NSDate*)date{
    NSIndexPath *parentCellIndexPath = nil;
    if ([self datePickerIsShown]){
        parentCellIndexPath = [NSIndexPath indexPathForRow:self.datePickerIndexPath.row - 1 inSection:0];
    }else {
        return;
    }
    TextRLModel *model = [self.modelManager.modelList objectAtIndex:parentCellIndexPath.row];
    model.date = date;
    CustomTextRightLeft *cell = [self.tbView cellForRowAtIndexPath:parentCellIndexPath];
    cell.labelRight.text = stringDate;
}


- (void)insertCell:(NSIndexPath*)indexPath typeModel:(ModelStyle)typeModel tableView:(UITableView*)tableView{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.modelManager.modelList];
    TextRLModel *modelNew = [[TextRLModel alloc] init];
    modelNew.type = typeModel;
    [array insertObject:modelNew atIndex:indexPath.row+1];
    self.modelManager.modelList = [array copy];
    
    [tableView beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]];
    [[self tbView] insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationTop];
    [tableView endUpdates];
    self.datePickerIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
}

- (void)deleteCell:(NSInteger)index tableView:(UITableView*)tableView{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.modelManager.modelList];
    [array removeObjectAtIndex:index];
    self.modelManager.modelList = [array copy];
    [tableView beginUpdates];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]];
    [[self tbView] deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationTop];
    [tableView endUpdates];
}

- (BOOL)datePickerIsShown {
    return self.datePickerIndexPath != nil;
}

#pragma mark delegate UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
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
}

#pragma mark delegate camera

- (void)didFinishPickingMediaWithInfo:(UIImage *)image {
    
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
