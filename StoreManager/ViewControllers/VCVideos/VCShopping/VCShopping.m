//
//  VCShopping.m
//  StoreManager
//
//  Created by Tamqn on 12/30/15.
//  Copyright © 2015 ATam. All rights reserved.
//

#import "VCShopping.h"

@interface VCShopping ()

@end

@implementation VCShopping

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Rỏ hàng";
    // Do any additional setup after loading the view from its nib.
    [self setLeftButtonNavicationBar];
    [self rightButtonNavicationBar];
}

- (void)rightButtonNavicationBar {
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionNewItem)];
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
}

- (void)actionNewItem {
    
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
