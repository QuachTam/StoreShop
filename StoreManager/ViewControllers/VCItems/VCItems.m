//
//  VCItems.m
//  StoreManager
//
//  Created by ATam on 12/21/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "VCItems.h"
#import "VCAddItem.h"
#import "CustomCellItem.h"
#import "CustomCellBackground.h"
#import "ItemService.h"
#import "UIAlertView+Blocks.h"

static NSString *stringIdentify = @"CustomCellItem";
@interface VCItems ()
@property (nonatomic, strong) ItemService *service;
@end

@implementation VCItems

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Các loại mặt hàng";
    [self setLeftButtonNavicationBar];
    [self rightButtonNavicationBar];
    [self registerTableViewCell];
    self.service = [[ItemService alloc] init];
    __weak __typeof(self)week = self;
    self.service.beginUpdates = ^{
        [week.tbView beginUpdates];
    };
    self.service.endUpdates = ^{
        [week.tbView endUpdates];
    };
    self.service.insertSections = ^(NSUInteger sectionIndex){
        [[week tbView] insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
    };
    self.service.deleteSections = ^(NSUInteger sectionIndex){
        [[week tbView] deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
    };
    self.service.insertRowsAtIndexPaths = ^(NSArray *newIndexPath){
        [[week tbView] insertRowsAtIndexPaths:newIndexPath withRowAnimation:UITableViewRowAnimationFade];
    };
    self.service.deleteRowsAtIndexPaths = ^(NSArray *indexPath){
        [[week tbView] deleteRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationFade];
    };
    self.service.changeUpdate = ^(NSIndexPath *indexPath){
        [week configureBasicCell:(CustomCellItem*)[[week tbView] cellForRowAtIndexPath:indexPath] atIndexPath:indexPath tableView:week.tbView];
    };
    // Delete cache first, if a cache is used
    [NSFetchedResultsController deleteCacheWithName:@"Root"];
    NSError *error;
    if (![[self.service fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

- (void)rightButtonNavicationBar {
    UIButton *buttonQrcode = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonQrcode setFrame:CGRectMake(0, 0, 25, 25)];
    [buttonQrcode setImage:[UIImage imageNamed:@"qrCode"] forState:UIControlStateNormal];
    [buttonQrcode addTarget:self action:@selector(actionQRCode) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonQrcode];
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
}

- (void)actionQRCode {
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *vc = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            vc                   = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
            vc.modalPresentationStyle = UIModalPresentationFormSheet;
        });
        vc.delegate = self;
        
        [vc setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
        [self presentViewController:vc animated:YES completion:NULL];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        ModelItem *modelItem = [self.service findModelWithQrcode:result];
        
        if (modelItem.entity) {
            if ([modelItem.entity.isSell boolValue]) {
                [UIAlertView showWithTitle:modelItem.modelTypeItem.name message:@"Đã bán" cancelButtonTitle:nil otherButtonTitles:@[@"Đồng ý"] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
                }];
            }else{
                [UIAlertView showWithTitle:modelItem.modelTypeItem.name message:[NSString stringWithFormat:@"Giá bán: %@", modelItem.moneyOutput] cancelButtonTitle:@"Huỷ" otherButtonTitles:@[@"Bán"] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
                    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
                    if ([buttonTitle isEqualToString:@"Bán"]) {
                        [self.service updateItemForSell:modelItem success:^{
                            [UIAlertView showWithTitle:nil message:@"Bán thành công" cancelButtonTitle:nil otherButtonTitles:@[@"Đồng ý"] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
                            }];
                        }];
                    }
                }];
            }
        }else {
            VCAddItem *newItem = [[VCAddItem alloc] init];
            newItem.qrcode = result;
            [self.navigationController pushViewController:newItem animated:YES];
        }
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)actionNewItem {
    
    UIGraphicsBeginImageContext(self.tbView.contentSize);
    [self.tbView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self.tbView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    int rows = [self.tbView numberOfRowsInSection:0];
    int numberofRowsInView = 4;
    for (int i =0; i < rows/numberofRowsInView; i++) {
        [self.tbView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(i+1)*numberofRowsInView inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [self.tbView.layer renderInContext:UIGraphicsGetCurrentContext()];
        
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIImageView *myImage=[[UIImageView alloc]initWithImage:image];
    UIGraphicsEndImageContext();
    
    
    [self createPDFfromUIViews:myImage saveToDocumentsWithFileName:@"PDF Name"];
    
    VCAddItem *newItem = [[VCAddItem alloc] init];
    [self.navigationController pushViewController:newItem animated:YES];
}

- (void)createPDFfromUIViews:(UIView *)myImage saveToDocumentsWithFileName:(NSString *)string
{
    NSMutableData *pdfData = [NSMutableData data];
    
    UIGraphicsBeginPDFContextToData(pdfData, myImage.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    
    
    // draws rect to the view and thus this is captured by UIGraphicsBeginPDFContextToData
    
    [myImage.layer renderInContext:pdfContext];
    
    // remove PDF rendering context
    UIGraphicsEndPDFContext();
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:string];
    
    NSLog(@"%@",documentDirectoryFilename);
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    
}

- (void)registerTableViewCell {
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellItem class]) bundle:nil] forCellReuseIdentifier:stringIdentify];
}

#pragma mark - tableView
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return [[self.service.fetchedResultsController sections] count];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id< NSFetchedResultsSectionInfo> sectionInfo = [[self.service fetchedResultsController] sections][section];
    return [sectionInfo numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath tableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self basicCellAtIndexPath:indexPath tableView:tableView];
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return [self.service.fetchedResultsController sectionIndexTitles];
//}

- (CustomCellItem *)basicCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomCellItem *cell = [self.tbView dequeueReusableCellWithIdentifier:stringIdentify];
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * backgroundCell = [[CustomCellBackground alloc] init];
        cell.backgroundView = backgroundCell;
    }
    
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        CustomCellBackground * selectedBackgroundCell = [[CustomCellBackground alloc] init];
        selectedBackgroundCell.selected = YES;
        cell.selectedBackgroundView = selectedBackgroundCell;
    }
    [self configureBasicCell:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

- (void)configureBasicCell:(CustomCellItem *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    ModelItem *model = [self.service fetchModelAtIndexPath:indexPath];
    cell.labelName.text = model.modelTypeItem.name;
    if ([model.isSell boolValue]) {
        cell.labelStatus.text = @"Đã bán";
        [cell.labelStatus setTextColor:[UIColor redColor]];
    }else{
        cell.labelStatus.text = @"Còn hàng";
        [cell.labelStatus setTextColor:[UIColor greenColor]];
    }
    if (model.dateInput) {
        cell.labelValueDateInput.text = [NSDate stringFromDate:model.dateInput];
    }
    if (model.dateOutput) {
        cell.labelValueDateOutput.text = [NSDate stringFromDate:model.dateOutput];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ModelItem * model = [self.service fetchModelAtIndexPath:indexPath];
    VCAddItem *newItem = [[VCAddItem alloc] init];
    newItem.uuidItem = model.syncID;
    [self.navigationController pushViewController:newItem animated:YES];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    static CustomCellItem *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tbView dequeueReusableCellWithIdentifier:stringIdentify];
    });
    
    [self configureBasicCell:sizingCell atIndexPath:indexPath tableView:tableView];
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
