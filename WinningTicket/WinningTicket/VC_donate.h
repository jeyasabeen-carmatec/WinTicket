//
//  VC_donate.h
//  WinningTicket
//
//  Created by Test User on 31/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Braintree/Braintree.h>

@interface VC_donate : UIViewController<UIGestureRecognizerDelegate,BTDropInViewControllerDelegate,BTPaymentMethodCreationDelegate>

@property (nonatomic, strong) Braintree *braintree;

@property (weak, nonatomic) IBOutlet UITextView *TXTVW_organisationname;
@property (nonatomic, strong) UIPickerView *organisation_list;

@property (weak, nonatomic) IBOutlet UILabel *lbl_titledonationAMT;
@property (weak, nonatomic) IBOutlet UILabel *lbl_currencyTYP;
@property (weak, nonatomic) IBOutlet UILabel *lbl_dropdown;
@property (weak, nonatomic) IBOutlet UITextField *TXT_getamount;

@property (weak, nonatomic) IBOutlet UIView *VW_organisationdetail;

//@property (weak, nonatomic) IBOutlet UIView *VW_contents;
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
@property (nonatomic, weak) IBOutlet UITextField *TXT_country;
@property (nonatomic, strong) UIPickerView *contry_pickerView;

@property (weak, nonatomic) IBOutlet UIButton *BTN_edit;

@property (weak, nonatomic) IBOutlet UIPickerView *PICK_state;
@property (weak, nonatomic) IBOutlet UIToolbar *TOOL_state;

@property (weak, nonatomic) IBOutlet UIButton *BTN_deposit;
@property(nonatomic,weak)IBOutlet UILabel *lbl_address;
@property(nonatomic,weak)IBOutlet UIView *VW_titladdress;
@property(nonatomic,weak)IBOutlet UIView *VW_address;
//@property(nonatomic,weak)IBOutlet UIView *VW_Denom;



@end
