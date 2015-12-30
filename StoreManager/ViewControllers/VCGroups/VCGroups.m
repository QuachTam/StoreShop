//
//  VCVideos.m
//  VideoSee
//
//  Created by Quach Ngoc Tam on 12/17/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "VCGroups.h"

@interface VCGroups ()

@end

@implementation VCGroups

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Nhóm mặt hàng";
    // Do any additional setup after loading the view from its nib.
    [self setLeftButtonNavicationBar];
    [self rightButtonNavicationBar];
}

- (void)rightButtonNavicationBar {
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionNewGroups)];
    
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
}

- (void)actionNewGroups {
    
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
