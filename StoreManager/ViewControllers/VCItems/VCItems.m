//
//  VCItems.m
//  StoreManager
//
//  Created by ATam on 12/21/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "VCItems.h"
#import "VCAddItem.h"

@interface VCItems ()

@end

@implementation VCItems

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Các loại mặt hàng";
    [self setLeftButtonNavicationBar];
    [self rightButtonNavicationBar];
}

- (void)rightButtonNavicationBar {
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionNewItem)];
    
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
}

- (void)actionNewItem {
    VCAddItem *newItem = [[VCAddItem alloc] init];
    [self.navigationController pushViewController:newItem animated:YES];
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
