//
//  PODetailViewController.h
//  pōsi
//
//  Created by Chase Zhang on 11/25/13.
//  Copyright (c) 2013 cute. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PODetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
