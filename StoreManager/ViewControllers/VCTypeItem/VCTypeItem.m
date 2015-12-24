//
//  VCTypeItem.m
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "VCTypeItem.h"
#import "CustomCellBackground.h"
#import "CustomCellDropDownMenu.h"
#import "TypeItemService.h"

static NSString *stringIdentify = @"CustomCellDropDownMenu";
@interface VCTypeItem ()<UITextFieldDelegate>
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) TypeItemService *service;
@end

@implementation VCTypeItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Loài mặt hàng";
    [self registerTableViewCell];
    [self rightButtonNavicationBar];
    self.service = [[TypeItemService alloc] init];
    __weak __typeof(self)week = self;
    self.service.didFinshFetchData = ^{
        week.datas = week.service.listTypeItem;
        [week.tbView reloadData];
    };
    [self.service fetchTypeItem];
}

- (void)rightButtonNavicationBar {
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionNewItem)];
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
}

- (void)actionNewItem {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thêm loại mặt hàng mới?" message:@"" delegate:self cancelButtonTitle:@"Huỷ" otherButtonTitles:@"Đồng ý", nil] ;
    alertView.tag = 2;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField * alertTextField = [alertView textFieldAtIndex:0];
    [self saveNewTypeItem:alertTextField];
}

- (void)saveNewTypeItem:(UITextField *)textField {
    
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
    ModelTypeItem *model = [self.datas objectAtIndex:indexPath.row];
    cell.labelTextQuestion.text = model.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    if (self.didSelectedRow) {
        self.didSelectedRow([self.datas objectAtIndex:indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
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
