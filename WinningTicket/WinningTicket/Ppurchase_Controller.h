//
//  Ppurchase_Controller.h
//  winning_ticket_purchaseTicket
//
//  Created by anumolu prakash on 12/04/17.
//  Copyright © 2017 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ppurchase_Controller : UIViewController
@property(nonatomic,weak)IBOutlet UILabel *name_ticket;
@property(nonatomic,weak)IBOutlet UILabel *qty;
@property(nonatomic,weak)IBOutlet UILabel *des_cription;
//@property(nonatomic,weak)IBOutlet UILabel *amount_des;
@property(nonatomic,weak)IBOutlet UILabel *sub_total;
@property(nonatomic,weak)IBOutlet UILabel *sub_amount;
@property(nonatomic,weak)IBOutlet UILabel *total;
@property(nonatomic,weak)IBOutlet UILabel *total_amount;
@property(nonatomic,weak)IBOutlet UIView *pur_view;
@property (weak, nonatomic) IBOutlet UILabel *status_Label;
@property (weak, nonatomic) IBOutlet UILabel *confirm_mail;
@property (weak, nonatomic) IBOutlet UILabel *order;
@property (weak, nonatomic) IBOutlet UILabel *order_summary;
@property(nonatomic,weak)IBOutlet UIView *start_View;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property(nonatomic,weak)IBOutlet UIView *content_view;
//@property (weak, nonatomic) IBOutlet UILabel *descripton_status;
@property (weak, nonatomic) IBOutlet UILabel *amount;

@property (weak, nonatomic) IBOutlet UIView *subtotal_vw;
@property (weak, nonatomic) IBOutlet UIView *total_vw;

@property (weak, nonatomic) IBOutlet UIView *sec_vw;
@property (weak, nonatomic) IBOutlet UIView *third_vw;
@property (strong, nonatomic) IBOutlet UIView *first_VW;

@end