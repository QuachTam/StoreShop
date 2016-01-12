//
//  VCShopping.m
//  StoreManager
//
//  Created by Tamqn on 12/30/15.
//  Copyright © 2015 ATam. All rights reserved.
//

#import "VCShopping.h"
#import "CustomCellDropDownMenu.h"
#import "CustomCellBackground.h"
#import "ShoppingModel.h"
#import "ShoppingService.h"
#import "UIAlertView+Blocks.h"
#import "VCShoppingDetail.h"

static NSString *stringIdentify = @"CustomCellDropDownMenu";
@interface VCShopping ()<UIGestureRecognizerDelegate> {
    NSIndexPath *currentIndexPath;
}
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) ShoppingService *service;
@end

@implementation VCShopping

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Rỏ hàng";
    // Do any additional setup after loading the view from its nib.
    if (self.type_from!=from_item) {
        [self setLeftButtonNavicationBar];
    }
    [self rightButtonNavicationBar];
    [self registerTableViewCell];
    
    self.service = [[ShoppingService alloc] init];
    __weak __typeof(self)week = self;
    self.service.didFinshFetchData = ^{
        week.datas = week.service.listTypeItem;
        [week.tbView reloadData];
    };
    [self.service fetchTypeItem];
    if (self.type_from!=from_item) {
        [self initLongPressGesture];
    }
}

- (void)rightButtonNavicationBar {
    UIBarButtonItem *rightRevealButtonItem;
    if (self.type_from!=from_item) {
        rightRevealButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionNewItem)];
    }else{
        rightRevealButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(actionSaveInsertItemToShopping)];
        
    }
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
}

- (void)actionNewItem {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thêm loại mặt hàng mới?" message:@"" delegate:self cancelButtonTitle:@"Huỷ" otherButtonTitles:@"Đồng ý", nil] ;
    alertView.tag = 2;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)actionSaveInsertItemToShopping {
    if (currentIndexPath && self.syncIDItem) {
        ShoppingModel *model = [self.datas objectAtIndex:currentIndexPath.row];
        __weak __typeof(self)week = self;
        [self.service addItemToShopping:model itemID:self.syncIDItem success:^{
            [week.navigationController popViewControllerAnimated:YES];
        }];
    }
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
            ShoppingModel *typeItem = [self.datas objectAtIndex:indexPath.row];
            [UIAlertView showWithTitle:nil message:[NSString stringWithFormat:@"Bạn có muốn xoá: %@ ?", typeItem.name] cancelButtonTitle:@"Huỷ" otherButtonTitles:@[@"Đồng ý"] tapBlock:^(UIAlertView * alertView, NSInteger buttonIndex) {
                NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
                if ([buttonTitle isEqualToString:@"Đồng ý"]) {
                    [self.service deleteItem:[self.datas objectAtIndex:indexPath.row] success:^{
                        [self.service fetchTypeItem];
                    }];
                }
            }];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        UITextField * alertTextField = [alertView textFieldAtIndex:0];
        [self saveNewTypeItem:alertTextField];
    }
}

- (void)saveNewTypeItem:(UITextField *)textField {
    ShoppingModel *model = [[ShoppingModel alloc] init];
    model.name = textField.text;
    [self.service saveTypeItem:model success:^{
        [self.service fetchTypeItem];
    }];
}

#pragma mark - tableView

- (void)registerTableViewCell {
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCellDropDownMenu class]) bundle:nil] forCellReuseIdentifier:stringIdentify];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath tableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self basicCellAtIndexPath:indexPath tableView:tableView];
}

- (CustomCellDropDownMenu *)basicCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    CustomCellDropDownMenu *cell = [self.tbView dequeueReusableCellWithIdentifier:stringIdentify];
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

- (void)configureBasicCell:(CustomCellDropDownMenu *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    // some code for initializing cell content
    ShoppingModel *model = [self.datas objectAtIndex:indexPath.row];
    cell.labelTextQuestion.text = model.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    if (self.type_from!=from_item) {
        ShoppingModel *model = [self.datas objectAtIndex:indexPath.row];
        VCShoppingDetail *shoppingDetail = [[VCShoppingDetail alloc] init];
        shoppingDetail.syncID = model.syncID;
        [self.navigationController pushViewController:shoppingDetail animated:YES];
    }else{
        currentIndexPath = indexPath;
        [[self.tbView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self.tbView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    static CustomCellDropDownMenu *sizingCell = nil;
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
