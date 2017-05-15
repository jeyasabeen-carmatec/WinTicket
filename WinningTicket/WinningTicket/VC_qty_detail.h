//
//  VC_qty_detail.h
//  WinningTicket
//
//  Created by Test User on 19/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_qty_detail : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tbl_content;
@property (strong, nonatomic) IBOutlet UIButton *BTN_checkout;

@property (strong, nonatomic) IBOutlet UIScrollView *scroll_TBL;

@end
