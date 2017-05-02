//
//  VC_affiliate_sighnUP.h
//  WinningTicket
//
//  Created by Test User on 17/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Get_custom_TXTT.h"

@interface VC_affiliate_sighnUP : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIView *VW_contents;
@property (nonatomic, weak) IBOutlet UIScrollView *scroll_contents;

//@property (nonatomic, weak) IBOutlet UIButton *BTN_affiliateorcharity;

@property (nonatomic, weak) IBOutlet UIImageView *IMG_BG;
@property (nonatomic, weak) IBOutlet UIImageView *IMG_logo_WT;

@property (nonatomic, weak) IBOutlet Get_custom_TXTT *TXT_F_name;
@property (nonatomic, weak) IBOutlet Get_custom_TXTT *TXT_L_name;
@property (nonatomic, weak) IBOutlet Get_custom_TXTT *TXT_titl;
@property (nonatomic, weak) IBOutlet Get_custom_TXTT *TXT_email;
@property (nonatomic, weak) IBOutlet Get_custom_TXTT *TXT_phone_num;
@property (nonatomic, weak) IBOutlet Get_custom_TXTT *TXT_golfcoursename;
@property (nonatomic, weak) IBOutlet Get_custom_TXTT *TXT_addr1;
@property (nonatomic, weak) IBOutlet Get_custom_TXTT *TXT_addr2;
@property (nonatomic, weak) IBOutlet Get_custom_TXTT *TXT_city;
@property (nonatomic, weak) IBOutlet Get_custom_TXTT *TXT_state;
@property (nonatomic, weak) IBOutlet Get_custom_TXTT *TXT_zip;
@property (nonatomic, weak) IBOutlet Get_custom_TXTT *TXT_country;

@end
