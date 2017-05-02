//
//  VC_qty_detail.h
//  WinningTicket
//
//  Created by Test User on 19/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_qty_detail : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,weak)IBOutlet UIView *VW_main;
@property(nonatomic,weak)IBOutlet UIView *VW_pur;
@property(nonatomic,weak)IBOutlet UILabel *lbl_name_ticket;
@property(nonatomic,weak)IBOutlet UILabel *lbl_qty;
@property(nonatomic,weak)IBOutlet UILabel *lbl_des_cription;
@property(nonatomic,weak)IBOutlet UILabel *lbl_amount_des;
@property(nonatomic,weak)IBOutlet UILabel *lbl_sub_total;
@property(nonatomic,weak)IBOutlet UILabel *lbl_sub_amount;
@property(nonatomic,weak)IBOutlet UILabel *lbl_total;
@property(nonatomic,weak)IBOutlet UILabel *lbl_total_amount;

@property (weak, nonatomic) IBOutlet UITableView *tbl_content;

@property (weak, nonatomic) IBOutlet UIButton *BTN_checkout;
@property (weak, nonatomic) IBOutlet UIView *VW_line1;
@property (weak, nonatomic) IBOutlet UIView *VW_line2;


@end
