//
//  Normal_sighnUP.h
//  WinningTicket
//
//  Created by Test User on 23/02/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Get_custom_TXTT.h"

@interface Normal_sighnUP : UIViewController <UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *TXT_F_name;
@property (nonatomic, weak) IBOutlet UITextField *TXT_L_name;
@property (nonatomic, weak) IBOutlet UITextField *TXT_email;
@property (nonatomic, weak) IBOutlet UITextField *TXT_phone_number;
@property (nonatomic, weak) IBOutlet UITextField *TXT_country;
@property (nonatomic, weak) IBOutlet UITextField *TXT_state;
@property (nonatomic, weak) IBOutlet UITextField *TXT_addressLine_one;
@property (nonatomic, weak) IBOutlet UITextField *TXT_addressLine_two;
@property (nonatomic, weak) IBOutlet UITextField *TXT_city;
@property (nonatomic, strong) UIPickerView *contry_pickerView;
@property (nonatomic, strong) UIPickerView *state_pickerView;




@property (nonatomic, weak) IBOutlet UIView *VW_contents;
@property (nonatomic, weak) IBOutlet UIScrollView *scroll_contents;

@property (nonatomic, weak) IBOutlet UIButton *BTN_affiliateorcharity;
@property (nonatomic, weak) IBOutlet UIButton *BTN_sighnUP;

@property (nonatomic, weak) IBOutlet UIImageView *IMG_BG;
@property (nonatomic, weak) IBOutlet UIImageView *IMG_logo_WT;

@end
