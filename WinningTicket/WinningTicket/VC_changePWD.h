//
//  VC_changePWD.h
//  WinningTicket
//
//  Created by Test User on 05/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_changePWD : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *TXT_currentPWD;
@property (weak, nonatomic) IBOutlet UITextField *TXT_newPWD;
@property (weak, nonatomic) IBOutlet UITextField *TXT_confirmnewPWD;
@property(nonatomic,weak)IBOutlet UILabel *Stat_label;
@property(nonatomic,weak)IBOutlet UIButton *done_Btn;
@property(nonatomic,weak)IBOutlet UIView *actview;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView *actviewone;
@end
