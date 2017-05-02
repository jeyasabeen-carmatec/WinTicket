//
//  VC_contactUS.h
//  WinningTicket
//
//  Created by Test User on 04/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_contactUS : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *TXT_fname;
@property (weak, nonatomic) IBOutlet UITextField *TXT_lname;
@property (weak, nonatomic) IBOutlet UITextField *TXT_email;
@property (weak, nonatomic) IBOutlet UITextField *TXT_phone;
@property (weak, nonatomic) IBOutlet UITextField *TXT_subject;


@property (weak, nonatomic) IBOutlet UITextView *TXT_VW_message;


@property (weak, nonatomic) IBOutlet UIView *VW_contents;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_contents;

@end
