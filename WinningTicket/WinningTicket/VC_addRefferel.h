//
//  VC_addRefferel.h
//  WinningTicket
//
//  Created by Test User on 21/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_addRefferel : UIViewController

@property(nonatomic,weak)IBOutlet UIView *VW_content;

@property (weak, nonatomic) IBOutlet UITextField *TXT_referal_name;
@property (weak, nonatomic) IBOutlet UITextField *TXT_referal_phone;
@property (weak, nonatomic) IBOutlet UITextField *TXT_referal_email;
@property (weak, nonatomic) IBOutlet UIButton *BTN_sponsor;
@property (weak, nonatomic) IBOutlet UIButton *BTN_event_organoser;
@property (weak, nonatomic) IBOutlet UIButton *BTN_participant;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_view;

@end
