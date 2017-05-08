//
//  VC_donate.h
//  WinningTicket
//
//  Created by Test User on 31/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_donate : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *TXTVW_organisationname;
@property (weak, nonatomic) IBOutlet UILabel *lbl_titledonationAMT;
@property (weak, nonatomic) IBOutlet UILabel *lbl_currencyTYP;
@property (weak, nonatomic) IBOutlet UILabel *lbl_dropdown;
@property (weak, nonatomic) IBOutlet UITextField *TXT_getamount;

@property (weak, nonatomic) IBOutlet UIView *VW_organisationdetail;

@property (weak, nonatomic) IBOutlet UIView *VW_contents;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_Contents;

@property (weak, nonatomic) IBOutlet UILabel *lbl_titlbillingaddress;

@property (weak, nonatomic) IBOutlet UITextField *TXT_firstname;
@property (weak, nonatomic) IBOutlet UITextField *TXT_lastname;
@property (weak, nonatomic) IBOutlet UITextField *TXT_address1;
@property (weak, nonatomic) IBOutlet UITextField *TXT_address2;
@property (weak, nonatomic) IBOutlet UITextField *TXT_city;
@property (weak, nonatomic) IBOutlet UITextField *TXT_state;
@property (weak, nonatomic) IBOutlet UITextField *TXT_zip;
@property (weak, nonatomic) IBOutlet UITextField *TXT_phonenumber;
@property (nonatomic, strong) UIPickerView *state_pickerView;

@property (weak, nonatomic) IBOutlet UIButton *BTN_state;

@property (weak, nonatomic) IBOutlet UIPickerView *PICK_state;
@property (weak, nonatomic) IBOutlet UIToolbar *TOOL_state;

@property (weak, nonatomic) IBOutlet UIButton *BTN_deposit;

@end
