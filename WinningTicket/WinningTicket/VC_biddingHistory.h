//
//  VC_biddingHistory.h
//  WinningTicket
//
//  Created by Test User on 24/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_biddingHistory : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)IBOutlet UITableView *tbl_bidding;

@end
