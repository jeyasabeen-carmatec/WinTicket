//
//  VC_editAccount.h
//  WinningTicket
//
//  Created by Test User on 05/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_editAccount : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *TXT_fname;
@property (weak, nonatomic) IBOutlet UITextField *TXT_lname;
@property (weak, nonatomic) IBOutlet UITextField *TXT_email;
@property (weak, nonatomic) IBOutlet UITextField *TXT_username;
@property (weak, nonatomic) IBOutlet UITextField *TXT_addr1;
@property (weak, nonatomic) IBOutlet UITextField *TXT_addr2;
@property (weak, nonatomic) IBOutlet UITextField *TXT_city;
@property (weak, nonatomic) IBOutlet UITextField *TXT_state;
@property (weak, nonatomic) IBOutlet UITextField *TXT_zip;
@property (weak, nonatomic) IBOutlet UITextField *TXT_phone;
@property (nonatomic, strong) UIPickerView *state_pickerView;

@property (weak, nonatomic) IBOutlet UIView *VW_contents;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_contents;

@end
