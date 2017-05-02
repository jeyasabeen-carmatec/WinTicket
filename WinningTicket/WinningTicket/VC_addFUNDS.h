//
//  VC_addFUNDS.h
//  WinningTicket
//
//  Created by Test User on 30/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_addFUNDS : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *BTN_10;
@property (weak, nonatomic) IBOutlet UIButton *BTN_25;
@property (weak, nonatomic) IBOutlet UIButton *BTN_50;

@property (weak, nonatomic) IBOutlet UITextField *TXT_amount;
@property (weak, nonatomic) IBOutlet UIView *VW_contents;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_Contents;

@property (weak, nonatomic) IBOutlet UITextField *TXT_firstname;
@property (weak, nonatomic) IBOutlet UITextField *TXT_lastname;
@property (weak, nonatomic) IBOutlet UITextField *TXT_address1;
@property (weak, nonatomic) IBOutlet UITextField *TXT_address2;
@property (weak, nonatomic) IBOutlet UITextField *TXT_city;
@property (weak, nonatomic) IBOutlet UITextField *TXT_state;
@property (weak, nonatomic) IBOutlet UITextField *TXT_zip;
@property (weak, nonatomic) IBOutlet UITextField *TXT_phonenumber;

@property (weak, nonatomic) IBOutlet UIButton *BTN_state;

@property (weak, nonatomic) IBOutlet UIPickerView *PICK_state;
@property (weak, nonatomic) IBOutlet UIToolbar *TOOL_state;

@end
