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

@property (nonatomic, strong) IBOutlet UIView *VW_main;
@property (nonatomic, strong) IBOutlet UILabel *lbl_name_ticket;
@property (nonatomic, strong) IBOutlet UILabel *lbl_qty;
@property (nonatomic, strong) IBOutlet UILabel *lbl_des_cription;
@property (nonatomic, strong) IBOutlet UILabel *lbl_amount_des;
@property (nonatomic, strong) IBOutlet UILabel *lbl_sub_total;
@property (nonatomic, strong) IBOutlet UILabel *lbl_sub_amount;
@property (nonatomic, strong) IBOutlet UILabel *lbl_total;
@property (nonatomic, strong) IBOutlet UILabel *lbl_total_amount;
@property (strong, nonatomic) IBOutlet UIView *VW_line1;
@property (strong, nonatomic) IBOutlet UIView *VW_line2;

@end
