//
//  VCShoppingDetail.m
//  StoreManager
//
//  Created by ATam on 12/30/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "VCShoppingDetail.h"
#import "ShoppingDetailService.h"
#import "UIAlertView+Blocks.h"
#import "CustomCellItem.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"

static NSString *stringIdentify = @"CustomCellItem";
@interface VCShoppingDetail ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) ShoppingDetailService *service;
@property (nonatomic, strong) NSArray *listItem;
@end

@implementation VCShoppingDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registerTableViewCell];
    self.service = [[ShoppingDetailService alloc] init];
    __weak __typeof(self)week = self;
    self.service.didCompleteFetchData = ^(NSArray *data){
        week.listItem = [data copy];
        [week.tbView reloadData];
    };
    [self.service fetchShoppingWithID:self.syncID];
    [self initLongPressGesture];
}

- (void)initLongPressGesture {
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1; //seconds
    lpgr.delegate = self;
    [self.tbView addGestureRecognizer:lpgr];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.tbView];
    
    NSIndexPath *indexPath = [self.tbView indexPathForRowAtPoint:p];
    if (indexPath == nil) {
        NSLog(@"long press on table view but not on a row");
    }
    else {
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            // I am not sure why I need to cast here. But it seems to be alright.
            ModelItem *model = [self.listItem objectAtIndex:indexPath.row];
            [UIAlertView showWithTitle:nil message:[NSString stringWithFormat:@"Bạn có muốn xoá: %@ ?", model.modelTypeItem.name] cancelButtonTitle:@"Huỷ" otherButtonTitles:@[@"Đồng ý"] tapBlock:^(UIAlertView * alertView, NSInteger buttonIndex) {
                NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
                if ([buttonTitle isEqualToString:@"Đồng ý"]) {
                    [self.service removeItemFromShopping:self.syncID itemId:model.syncID];
                    [self.service fetchShoppingWithID:self.syncID];
                }
            }];
        }
    }
}

- (NSString *)getTotalMoney {
    float total = 0;
    for (NSInteger index=0; index<self.listItem.count; index++) {
        ModelItem *modelItem = [self.listItem objectAtIndex:index];
        total += [modelItem.moneyOutput floatValue];
    }
    return [NSString stringWithFormat:@"%.2f", total];
}

#pragma mark - tableView


- (void)registerTableViewCell {
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellItem class]) bundle:nil] forCellReuseIdentifier:stringIdentify];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listItem.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath tableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CustomHeader *header = [[CustomHeader alloc] init];
    header.titleLabel.text = [NSString stringWithFormat:@"Tong: %@", [self getTotalMoney]];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self basicCellAtIndexPath:indexPath tableView:tableView];
}

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
    ModelItem *model = [self.listItem objectAtIndex:indexPath.row];
    cell.labelName.text = model.modelTypeItem.name;
    cell.labelValueMoneyInput.text = model.moneyInput;
    cell.labelValueMoneyOutput.text = model.moneyOutput;
    cell.labelStatus.hidden = YES;
    if (model.dateInput) {
        cell.labelValueDateInput.text = [NSDate stringFromDate:model.dateInput withFormat:@"dd-MM-yyyy HH:mm"];
    }
    if (model.dateOutput) {
        cell.labelValueDateOutput.text = [NSDate stringFromDate:model.dateOutput withFormat:@"dd-MM-yyyy HH:mm"];
    }
    [cell.buttonShopping setHidden:YES];
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
