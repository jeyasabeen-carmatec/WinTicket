//
//  VC_accounts.h
//  WinningTicket
//
//  Created by Test User on 02/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_accounts : UIViewController <UITabBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITabBar *tab_HOME;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment_bottom;

@property (weak, nonatomic) IBOutlet UITableView *TBL_contents;

@end
