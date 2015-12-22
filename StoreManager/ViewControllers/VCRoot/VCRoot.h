//
//  VCRoot.h
//  VideoSee
//
//  Created by Quach Ngoc Tam on 12/17/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
@interface VCRoot : UIViewController<SWRevealViewControllerDelegate>
@property (strong, nonatomic) SWRevealViewController *viewController;
@end
