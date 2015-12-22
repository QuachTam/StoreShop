//
//  VCRoot.m
//  VideoSee
//
//  Created by Quach Ngoc Tam on 12/17/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "VCRoot.h"
#import "VCMenu.h"
#import "VCItems.h"

@interface VCRoot ()
@end

@implementation VCRoot

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpSWRevealViewController];
}

- (void)setUpSWRevealViewController{
    VCItems *centerViewController = [[VCItems alloc] init]; // center viewcontroller
    VCMenu *leftViewController = [[VCMenu alloc] init]; // left viewcontroller
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:leftViewController]; // left
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;
    
    revealController.bounceBackOnOverdraw=NO;
    revealController.stableDragOnOverdraw=YES;
    self.viewController = revealController;
    
    [self addChildViewController:self.viewController];
    self.viewController.view.frame = self.view.bounds;
    [self.view addSubview:self.viewController.view];
}

#pragma mark - SWRevealViewDelegate

- (id <UIViewControllerAnimatedTransitioning>)revealController:(SWRevealViewController *)revealController animationControllerForOperation:(SWRevealControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if ( operation != SWRevealControllerOperationReplaceRightController )
        return nil;
    return nil;
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
