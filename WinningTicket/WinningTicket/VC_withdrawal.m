//
//  VC_withdrawal.m
//  WinningTicket
//
//  Created by Test User on 03/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_withdrawal.h"

@interface VC_withdrawal ()
{
    float scroll_View_HT;
}

@end

@implementation VC_withdrawal

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_View];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(self.scroll_contents.frame.size.width, scroll_View_HT);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Customise UIView
-(void) setup_View
{
    _TXT_amtbank.layer.cornerRadius = 5.0f;
    _TXT_amtbank.layer.masksToBounds = YES;
    _TXT_amtbank.layer.borderWidth = 2.0f;
    _TXT_amtbank.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
    
    _TXT_amtpaypal.layer.cornerRadius = 5.0f;
    _TXT_amtpaypal.layer.masksToBounds = YES;
    _TXT_amtpaypal.layer.borderWidth = 2.0f;
    _TXT_amtpaypal.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
    
    _TXT_accholdername.layer.cornerRadius = 5.0f;
    _TXT_accholdername.layer.masksToBounds = YES;
    _TXT_accholdername.layer.borderWidth = 2.0f;
    _TXT_accholdername.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
    
    _TXT_acconroutingnumber.layer.cornerRadius = 5.0f;
    _TXT_acconroutingnumber.layer.masksToBounds = YES;
    _TXT_acconroutingnumber.layer.borderWidth = 2.0f;
    _TXT_acconroutingnumber.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
    
    _TXT_accountnumber.layer.cornerRadius = 5.0f;
    _TXT_accountnumber.layer.masksToBounds = YES;
    _TXT_accountnumber.layer.borderWidth = 2.0f;
    _TXT_accountnumber.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
    
    _TXT_email.layer.cornerRadius = 5.0f;
    _TXT_email.layer.masksToBounds = YES;
    _TXT_email.layer.borderWidth = 2.0f;
    _TXT_email.layer.borderColor = [UIColor colorWithRed:0.43 green:0.48 blue:0.51 alpha:1.0].CGColor;
    
    NSString *pricee_STR = @"$10.00";
    NSString *text = [NSString stringWithFormat:@"Available balance: %@",pricee_STR];
    
    if ([self.lbl_availableBAL respondsToSelector:@selector(setAttributedText:)]) {
        
        // Define general attributes for the entire text
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: self.lbl_availableBAL.textColor,
                                  NSFontAttributeName: self.lbl_availableBAL.font
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:text
                                               attributes:attribs];
        
        // Red text attributes
        //            UIColor *redColor = [UIColor redColor];
        NSRange cmp = [text rangeOfString:pricee_STR];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Book" size:17.0]}
                                range:cmp];
        
        
        self.lbl_availableBAL.attributedText = attributedText;
    }
    else
    {
        self.lbl_availableBAL.text = text;
    }
    
    NSString *cur = @"$";
    NSString *print_TXT = [NSString stringWithFormat:@"Amount  %@",cur];
    
    if ([self.lbl_titleAMT respondsToSelector:@selector(setAttributedText:)]) {
        
        // Define general attributes for the entire text
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: self.lbl_titleAMT.textColor,
                                  NSFontAttributeName: self.lbl_titleAMT.font
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:print_TXT
                                               attributes:attribs];
        
        // Red text attributes
        //            UIColor *redColor = [UIColor redColor];
        NSRange cmp = [print_TXT rangeOfString:cur];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"FontAwesome" size:21.0f],NSForegroundColorAttributeName : [UIColor colorWithRed:0.42 green:0.45 blue:0.49 alpha:1.0]}
                                range:cmp];
        
        
        self.lbl_titleAMT.attributedText = attributedText;
    }
    else
    {
        self.lbl_titleAMT.text = print_TXT;
    }
    
    if ([self.lbl_titleAMT1 respondsToSelector:@selector(setAttributedText:)]) {
        
        // Define general attributes for the entire text
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: self.lbl_titleAMT1.textColor,
                                  NSFontAttributeName: self.lbl_titleAMT1.font
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:print_TXT
                                               attributes:attribs];
        
        // Red text attributes
        //            UIColor *redColor = [UIColor redColor];
        NSRange cmp = [print_TXT rangeOfString:cur];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"FontAwesome" size:21.0f],NSForegroundColorAttributeName : [UIColor colorWithRed:0.42 green:0.45 blue:0.49 alpha:1.0]}
                                range:cmp];
        
        
        self.lbl_titleAMT1.attributedText = attributedText;
    }
    else
    {
        self.lbl_titleAMT1.text = print_TXT;
    }
    
    [_BTN_banktransfer addTarget:self action:@selector(action_Banktransfer) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_paypal addTarget:self action:@selector(action_Paypal) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect frameRECt;
    frameRECt = _VW_banktransfer.frame;
    frameRECt.origin.y = _VW_holdBTN.frame.origin.y + _VW_holdBTN.frame.size.height ;
    _VW_banktransfer.frame = frameRECt;
    
    [_VW_Contents addSubview:_VW_banktransfer];
    _VW_banktransfer.hidden = YES;
    
    frameRECt = _VW_paypal.frame;
    frameRECt.origin.y = _VW_holdBTN.frame.origin.y + _VW_holdBTN.frame.size.height ;
    _VW_paypal.frame = frameRECt;
    
    scroll_View_HT = _VW_holdBTN.frame.origin.y + _VW_holdBTN.frame.size.height +  _VW_banktransfer.frame.size.height;
    
    [_VW_Contents addSubview:_VW_paypal];
    _VW_paypal.hidden = YES;
    
    frameRECt = _VW_Contents.frame;
    frameRECt.size.width = _scroll_contents.frame.size.width;
    frameRECt.size.height = scroll_View_HT;
    _VW_Contents.frame = frameRECt;
    
    [_scroll_contents addSubview:_VW_Contents];
}


#pragma mark - BTN Actions
-(IBAction)BTN_close:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UIButton Actions
-(void) action_Banktransfer
{
    _VW_banktransfer.hidden = YES;
//    if (_VW_paypal.hidden == YES)
//    {
        _VW_paypal.hidden = NO;
//    }
}

-(void) action_Paypal
{
//    if (_VW_banktransfer.hidden == YES)
//    {
        _VW_banktransfer.hidden = NO;
//    }
    _VW_paypal.hidden = YES;
}

@end
