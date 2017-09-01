//
//  VC_conf_Ordr.m
//  WinningTicket
//
//  Created by Test User on 31/08/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_conf_Ordr.h"
#import "ViewController.h"
#import "BraintreeCore.h"
#import "BraintreeDropIn.h"

@interface VC_conf_Ordr ()
{
    float original_height;
    UIView *VW_overlay;
    UIActivityIndicatorView *activityIndicatorView;
    NSString *wallet_text,*total_text;
    NSMutableDictionary *states,*countrys,*checkout_data;
    float price_deduct;
     NSArray *sorted_STAES,*sorted_Contry;
    
    //    UILabel *loadingLabel;
}

@end

@implementation VC_conf_Ordr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_FRAME];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self setup_VIEW];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width, original_height);
}

-(void) setup_VIEW
{
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FontAwesome" size:32.0f]
       } forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(backAction)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height <= 480)
        {
            // iPhone Classic
            negativeSpacer.width = 0;
        }
        else if(result.height <= 568)
        {
            // iPhone 5
            negativeSpacer.width = -12;
        }
        else
        {
            negativeSpacer.width = -16;
        }
    }
    else
    {
        negativeSpacer.width = -12;
    }
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer, anotherButton ] animated:NO];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f]}];
    self.navigationItem.title = @"Add Quantity";
    
    VW_overlay = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    VW_overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    VW_overlay.clipsToBounds = YES;
    //    VW_overlay.layer.cornerRadius = 10.0;
    
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.frame = CGRectMake(0, 0, activityIndicatorView.bounds.size.width, activityIndicatorView.bounds.size.height);
    
    //    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, 200, 22)];
    //    loadingLabel.backgroundColor = [UIColor clearColor];
    //    loadingLabel.textColor = [UIColor whiteColor];
    //    loadingLabel.adjustsFontSizeToFitWidth = YES;
    //    loadingLabel.textAlignment = NSTextAlignmentCenter;
    //    loadingLabel.text = @"Loading...";
    //
    //    [VW_overlay addSubview:loadingLabel];
    activityIndicatorView.center = VW_overlay.center;
    [VW_overlay addSubview:activityIndicatorView];
    VW_overlay.center = self.view.center;
    [self.view addSubview:VW_overlay];
    
    VW_overlay.hidden = YES;
}

-(void) backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) setup_FRAME
{
    NSError *error;
    checkout_data=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"checkout_data"] options:NSASCIIStringEncoding error:&error];
    NSLog(@"thedata is check out from item data:%@",checkout_data);
    
    @try
    {
        NSString *STR_error = [checkout_data valueForKey:@"error"];
        if (STR_error)
        {
            [self sessionOUT];
        }
        else
        {
          //  NSDictionary *temp_dict=[dict valueForKey:@"event"];
            
            
//            [_scroll_contents addSubview:_VW_qtycontent];
            [_scroll_contents addSubview:_VW_line1];
            [_scroll_contents addSubview:_VW_line3];
            
           
//            _TXT_qty.text = @"1";
            NSString *show = @"Winning Ticket";
            NSString *place = [checkout_data valueForKey:@"item_name"];
            place = [place stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not Mentioned"];
            
            NSString *location=[NSString stringWithFormat:@"%@",[checkout_data valueForKey:@"location"]];
            location = [location stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not Mentioned"];

            NSString *STR_tkt_num_club = [NSString stringWithFormat:@"%@ ",location];
            
            NSString *str_price = [NSString stringWithFormat:@"$%.2f",[[checkout_data valueForKey:@"price"] floatValue]];
            
            _lbl_price.text=[NSString stringWithFormat:@"%@",str_price];
            
            NSArray *arr = [_lbl_price.text componentsSeparatedByString:@"$"];
            NSString *str = [NSString stringWithFormat:@"%.02f",[[arr objectAtIndex:1] floatValue]];
            _lbl_dataTotal.text = [NSString stringWithFormat:@"$%.02f",[[arr objectAtIndex:1] floatValue]];
            
            total_text = _lbl_dataTotal.text;
            
            [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"total_balance"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            _lbl_datasubtotal.text = [NSString stringWithFormat:@"$%.02f",[[arr objectAtIndex:1] floatValue]];
            
            NSString *text = [NSString stringWithFormat:@"%@\n%@\n%@",show,place,STR_tkt_num_club];
            
            text = [text stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not Mentioned"];
            text = [text stringByReplacingOccurrencesOfString:@"(null)" withString:@"Not Mentioned"];
            
            // If attributed text is supported (iOS6+)
            if ([self.lbl_ticketdetail respondsToSelector:@selector(setAttributedText:)]) {
                
                // Define general attributes for the entire text
                
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                paragraphStyle.alignment = _lbl_ticketdetail.textAlignment;
                
                NSDictionary *attribs = @{
                                          NSForegroundColorAttributeName: self.lbl_ticketdetail.textColor,
                                          NSFontAttributeName: self.lbl_ticketdetail.font
                                          };
                NSMutableAttributedString *attributedText =
                [[NSMutableAttributedString alloc] initWithString:text
                                                       attributes:attribs];
                
                if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
                {
                    NSMutableParagraphStyle *paragraphStyle1  = [[NSMutableParagraphStyle alloc] init];
                    paragraphStyle1.lineSpacing = 5;
                    // Red text attributes
                    //            UIColor *redColor = [UIColor redColor];
                    NSRange cmp = [text rangeOfString:show];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBold" size:17],NSParagraphStyleAttributeName:paragraphStyle1}
                                            range:cmp];
                    
                    NSMutableParagraphStyle *paragraphStyle2  = [[NSMutableParagraphStyle alloc] init];
                    paragraphStyle2.lineSpacing = 2;
                    NSRange plce = [text rangeOfString:place];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBold" size:15.0],NSParagraphStyleAttributeName:paragraphStyle2}
                                            range:plce];
                    
                    NSMutableParagraphStyle *paragraphStyle3  = [[NSMutableParagraphStyle alloc] init];
                    paragraphStyle3.lineSpacing = 0;
                    NSRange tkt_num_range = [text rangeOfString:STR_tkt_num_club];
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBook" size:15.0],NSParagraphStyleAttributeName:paragraphStyle} range:tkt_num_range];
                }
                else
                {
                    NSMutableParagraphStyle *paragraphStyle1  = [[NSMutableParagraphStyle alloc] init];
                    paragraphStyle1.lineSpacing = 5;
                    // Red text attributes
                    //            UIColor *redColor = [UIColor redColor];
                    NSRange cmp = [text rangeOfString:show];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBold" size:17.0],NSParagraphStyleAttributeName:paragraphStyle1}
                                            range:cmp];
                    
                    NSMutableParagraphStyle *paragraphStyle2  = [[NSMutableParagraphStyle alloc] init];
                    paragraphStyle2.lineSpacing = 2;
                    NSRange plce = [text rangeOfString:place];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBold" size:15.0],NSParagraphStyleAttributeName:paragraphStyle2}
                                            range:plce];
                    
                    NSMutableParagraphStyle *paragraphStyle3  = [[NSMutableParagraphStyle alloc] init];
                    paragraphStyle3.lineSpacing = 0;
                    NSRange tkt_num_range = [text rangeOfString:STR_tkt_num_club];
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBook" size:15.0],NSParagraphStyleAttributeName:paragraphStyle3} range:tkt_num_range];
                }
                
                self.lbl_ticketdetail.attributedText = attributedText;
            }
            else
            {
                self.lbl_ticketdetail.text = [text capitalizedString];
            }
            NSString *pricee_STR = [NSString stringWithFormat:@"%.2f",[[checkout_data valueForKey:@"wallet_amount"] floatValue]];
            wallet_text = [NSString stringWithFormat:@"Current Balance: $%@",pricee_STR];
            
            if ([self.lbl_current_bal respondsToSelector:@selector(setAttributedText:)]) {
                
                // Define general attributes for the entire text
                NSDictionary *attribs = @{
                                          NSForegroundColorAttributeName: self.lbl_current_bal.textColor,
                                          NSFontAttributeName: self.lbl_current_bal.font
                                          };
                NSMutableAttributedString *attributedText =
                [[NSMutableAttributedString alloc] initWithString:wallet_text
                                                       attributes:attribs];
                
                // Red text attributes
                //            UIColor *redColor = [UIColor redColor];
                NSRange cmp = [wallet_text rangeOfString:pricee_STR];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
                [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamMedium" size:17.0]}
                                        range:cmp];
                
                
                self.lbl_current_bal.attributedText = attributedText;
            }
            else
            {
                self.lbl_current_bal.text = wallet_text;
            }
            
            //            _lbl_acbalance_amount.text = [NSString stringWithFormat:@"-$%.2f",[[dict valueForKey:@"price"] floatValue]];
            //            price_deduct = [[dict valueForKey:@"wallet"] floatValue] -[[dict valueForKey:@"price"] floatValue];
            
            
            self.lbl_ticketdetail.numberOfLines = 0;
            [self.lbl_ticketdetail sizeToFit];
            
            float qty_frame_Y = _lbl_ticketdetail.frame.size.height;
            
            CGRect frame_ST;
//            = _VW_qtycontent.frame;
//            frame_ST.origin.y = _lbl_ticketdetail.frame.origin.y + qty_frame_Y + 10;
//            _VW_qtycontent.frame = frame_ST;
            
//            frame_ST = _lbl_arrowpromocode.frame;
//            frame_ST.origin.y = _lbl_ticketdetail.frame.origin.y + qty_frame_Y + 10;
//            _lbl_arrowpromocode.frame = frame_ST;
            
//            frame_ST = _BTN_promocode.frame;
//            frame_ST.origin.y = _lbl_ticketdetail.frame.origin.y + qty_frame_Y + 10;
//            _BTN_promocode.frame = frame_ST;
            
//            [_BTN_promocode addTarget:self action:@selector(BTN_promocode_TAP) forControlEvents:UIControlEventTouchUpInside];
            
//            frame_ST = _VW_promo.frame;
//            frame_ST.origin.y = _BTN_promocode.frame.origin.y + _BTN_promocode.frame.size.height + 10;
//            _VW_promo.frame = frame_ST;
            
            frame_ST = _VW_line.frame;
            frame_ST.origin.y = _lbl_ticketdetail.frame.origin.y + qty_frame_Y + 10;
            _VW_line.frame = frame_ST;
            
            frame_ST = _lbl_arrowaccount.frame;
//            frame_ST.origin.x = _lbl_arrowpromocode.frame.origin.x;
            frame_ST.origin.y = _VW_line.frame.origin.y + _VW_line.frame.size.height + 10;
            _lbl_arrowaccount.frame = frame_ST;
            
            frame_ST = _BTN_Account.frame;
            frame_ST.origin.y = _VW_line.frame.origin.y + _VW_line.frame.size.height + 10;
            _BTN_Account.frame = frame_ST;
            
            [_BTN_Account addTarget:self action:@selector(BTN_account_Tap) forControlEvents:UIControlEventTouchUpInside];
            
            frame_ST = _lbl_current_bal.frame;
            frame_ST.origin.x = _BTN_Account.frame.origin.x + 10;
            frame_ST.origin.y = _BTN_Account.frame.origin.y + _BTN_Account.frame.size.height;
            _lbl_current_bal.frame = frame_ST;
            
            
            frame_ST = _VW_Account.frame;
            frame_ST.origin.y = _lbl_current_bal.frame.origin.y + _lbl_current_bal.frame.size.height + 10;
            _VW_Account.frame = frame_ST;
            
            
            
            
            _VW_line2.hidden = YES;
            _lbl_acbalance.hidden = YES;
            _lbl_acbalance_amount.hidden = YES;
            
            frame_ST = _VW_line1.frame;
            frame_ST.origin.y = _BTN_Account.frame.origin.y + _BTN_Account.frame.size.height +10;
            _VW_line1.frame = frame_ST;
            
            frame_ST = _lbl_titleSubtotal.frame;
            frame_ST.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10;
            _lbl_titleSubtotal.frame = frame_ST;
            
            frame_ST = _lbl_datasubtotal.frame;
            frame_ST.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10;
            _lbl_datasubtotal.frame = frame_ST;
            
            frame_ST = _VW_line3.frame;
            frame_ST.origin.y = _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10;
            frame_ST.size.width = self.VW_line.frame.size.width;
            _VW_line3.frame = frame_ST;
            
            frame_ST = _lbl_titleTotal.frame;
            frame_ST.origin.y = _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10;
            _lbl_titleTotal.frame = frame_ST;
            frame_ST = _lbl_dataTotal.frame;
            frame_ST.origin.y = _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10;
            _lbl_dataTotal.frame = frame_ST;
            
            [_BTN_checkout setTitle:@"CHECKOUT" forState:UIControlStateNormal];
            [_BTN_checkout addTarget:self action:@selector(checkout_action) forControlEvents:UIControlEventTouchUpInside];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                frame_ST = _BTN_checkout.frame;
                frame_ST.origin.y = _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 20;
                _BTN_checkout.frame = frame_ST;
            }
            else
            {
                frame_ST = _BTN_checkout.frame;
                frame_ST.origin.y = _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10;
                _BTN_checkout.frame = frame_ST;
            }
            
            //    _VW_promo.layer.borderWidth = 2.0f;
            //    _VW_promo.layer.borderColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.0].CGColor;
//            _VW_promo.hidden = YES;
            _lbl_current_bal.hidden = YES;
            _VW_Account.hidden = YES;
            
            
            _TXT_promocode.layer.borderWidth = 1.0f;
            _TXT_promocode.layer.borderColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.0].CGColor;
            _TXT_promocode.layer.cornerRadius = 5.0f;
            _TXT_promocode.layer.masksToBounds = YES;
            
            
            original_height = _BTN_checkout.frame.origin.y + _BTN_checkout.frame.size.height + 40;
            
            frame_ST = _scroll_contents.frame;
            frame_ST.size.height = [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height;
            _scroll_contents.frame = frame_ST;
            
            
            [_Switch_Ac addTarget:self action:@selector(switch_ction) forControlEvents:UIControlEventTouchUpInside];
            _Switch_Ac.on = NO;
        }
    }
    @catch (NSException *exception)
    {
        [self sessionOUT];
    }
}

//-(void) decide_VC
//{
//    if (_Switch_Ac.isOn) {
//        [[NSUserDefaults standardUserDefaults] setValue:@"SWITCH_ON" forKey:@"SWITCHSTAT"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setValue:@"SWITCH_OFF" forKey:@"SWITCHSTAT"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }

    
//        VW_overlay.hidden = NO;
//        [activityIndicatorView startAnimating];
//        [self performSelector:@selector(update_QTY_api) withObject:activityIndicatorView afterDelay:0.01];
        //        BOOL stat =
        //        if (stat)
        //        {
    
//}



/*#pragma mark - UIButton Actions
-(void) BTN_promocode_TAP
{
    if (_VW_promo.hidden == YES) {
        //    _BTN_promocode.hidden = YES;
        float btn_ht = _BTN_promocode.frame.size.height + 10;
        CGRect promoFRAME = _VW_promo.frame;
        promoFRAME.origin.y = _BTN_promocode.frame.origin.y + btn_ht;
        _VW_promo.frame = promoFRAME;
        
        _lbl_arrowpromocode.text = @"";
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _VW_line.frame = CGRectMake(_VW_line.frame.origin.x, _VW_promo.frame.origin.y + _VW_promo.frame.size.height +10, _VW_line.frame.size.width, _VW_line.frame.size.height);
            _lbl_arrowaccount.frame = CGRectMake(_lbl_arrowpromocode.frame.origin.x, _VW_line.frame.origin.y + _VW_line.frame.size.height + 10, _lbl_arrowaccount.frame.size.width, _lbl_arrowaccount.frame.size.height);
            
            _BTN_Account.frame = CGRectMake(_BTN_Account.frame.origin.x, _VW_line.frame.origin.y + _VW_line.frame.size.height +10, _BTN_Account.frame.size.width, _BTN_Account.frame.size.height);
            if(_lbl_current_bal.hidden == NO)
            {
                _lbl_current_bal.frame = CGRectMake(_lbl_current_bal.frame.origin.x, _BTN_Account.frame.origin.y + _BTN_Account.frame.size.height , _lbl_current_bal.frame.size.width, _lbl_current_bal.frame.size.height);
                _VW_Account.frame = CGRectMake(_VW_Account.frame.origin.x, _lbl_current_bal.frame.origin.y + _lbl_current_bal.frame.size.height + 10, _VW_Account.frame.size.width, _VW_Account.frame.size.height);
                _VW_line1.frame = CGRectMake(_VW_line1.frame.origin.x, _VW_Account.frame.origin.y + _VW_Account.frame.size.height + 10, _VW_line1.frame.size.width, _VW_line1.frame.size.height);
                
                _lbl_titleSubtotal.frame = CGRectMake(_lbl_titleSubtotal.frame.origin.x, _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10, _lbl_titleSubtotal.frame.size.width, _lbl_titleSubtotal.frame.size.height);
                _lbl_datasubtotal.frame = CGRectMake(_lbl_datasubtotal.frame.origin.x, _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10, _lbl_datasubtotal.frame.size.width, _lbl_datasubtotal.frame.size.height);
                
                if(_Switch_Ac.on)
                {
                    _VW_line2.frame = CGRectMake(_VW_line2.frame.origin.x, _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10, _VW_line2.frame.size.width, _VW_line2.frame.size.height);
                    _lbl_acbalance.frame = CGRectMake(_lbl_acbalance.frame.origin.x, _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10, _lbl_acbalance.frame.size.width, _lbl_acbalance.frame.size.height);
                    _lbl_acbalance_amount.frame = CGRectMake(_lbl_acbalance_amount.frame.origin.x, _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10, _lbl_acbalance_amount.frame.size.width, _lbl_acbalance_amount.frame.size.height);
                    
                    _VW_line3.frame = CGRectMake(_VW_line3.frame.origin.x, _lbl_acbalance.frame.origin.y + _lbl_acbalance.frame.size.height + 10, _VW_line3.frame.size.width, _VW_line3.frame.size.height);
                    
                    _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
                    
                    _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
                    
                    _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
                    
                    
                }
                else
                {
                    
                    _VW_line2.hidden = YES;
                    _lbl_acbalance.hidden = YES;
                    _lbl_acbalance_amount.hidden = YES;
                    
                    _VW_line3.frame = CGRectMake(_VW_line3.frame.origin.x, _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10, _VW_line3.frame.size.width, _VW_line3.frame.size.height);
                    
                    _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
                    
                    _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
                    
                    _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
                }
                
                
            }
            else
            {
                
                
                _VW_line1.frame = CGRectMake(_VW_line1.frame.origin.x, _BTN_Account.frame.origin.y + _BTN_Account.frame.size.height + 10, _VW_line1.frame.size.width, _VW_line1.frame.size.height);
                
                _lbl_titleSubtotal.frame = CGRectMake(_lbl_titleSubtotal.frame.origin.x, _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10, _lbl_titleSubtotal.frame.size.width, _lbl_titleSubtotal.frame.size.height);
                _lbl_datasubtotal.frame = CGRectMake(_lbl_datasubtotal.frame.origin.x, _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10, _lbl_datasubtotal.frame.size.width, _lbl_datasubtotal.frame.size.height);
                
                
                
                _VW_line3.frame = CGRectMake(_VW_line3.frame.origin.x, _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10, _VW_line3.frame.size.width, _VW_line3.frame.size.height);
                
                _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
                
                _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
                
                _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
            }
            
        }];
        
        
        [UIView beginAnimations:@"LeftFlip" context:nil];
        [UIView setAnimationDuration:0.8];
        _VW_promo.hidden = NO;
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_VW_promo cache:YES];
        [UIView commitAnimations];
        
        original_height = _BTN_checkout.frame.origin.y + _BTN_checkout.frame.size.height + 40;
        [self viewDidLayoutSubviews];
    }
    else
    {
        [self hide_PROMO];
        original_height = _BTN_checkout.frame.origin.y + _BTN_checkout.frame.size.height + 40;
        [self viewDidLayoutSubviews];
    }
}
-(void) hide_PROMO
{
    [UIView transitionWithView:_VW_promo
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:NULL
                    completion:NULL];
    [_VW_promo  setHidden:YES];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _VW_line.frame = CGRectMake(_VW_line.frame.origin.x, _BTN_promocode.frame.origin.y + _BTN_promocode.frame.size.height +10, _VW_line.frame.size.width, _VW_line.frame.size.height);
        _lbl_arrowaccount.frame = CGRectMake(_lbl_arrowaccount.frame.origin.x, _VW_line.frame.origin.y + _VW_line.frame.size.height +10, _lbl_arrowaccount.frame.size.width, _lbl_arrowaccount.frame.size.height);
        
        _BTN_Account.frame = CGRectMake(_BTN_Account.frame.origin.x, _VW_line.frame.origin.y + _VW_line.frame.size.height +10, _BTN_Account.frame.size.width, _BTN_Account.frame.size.height);
        if(_lbl_current_bal.hidden == NO)
        {
            _lbl_current_bal.frame = CGRectMake(_lbl_current_bal.frame.origin.x, _BTN_Account.frame.origin.y + _BTN_Account.frame.size.height, _lbl_current_bal.frame.size.width, _lbl_current_bal.frame.size.height);
            _VW_Account.frame = CGRectMake(_VW_Account.frame.origin.x, _lbl_current_bal.frame.origin.y + _lbl_current_bal.frame.size.height , _VW_Account.frame.size.width, _VW_Account.frame.size.height);
            _VW_line1.frame = CGRectMake(_VW_line1.frame.origin.x, _VW_Account.frame.origin.y + _VW_Account.frame.size.height + 10, _VW_line1.frame.size.width, _VW_line1.frame.size.height);
            
            _lbl_titleSubtotal.frame = CGRectMake(_lbl_titleSubtotal.frame.origin.x, _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10, _lbl_titleSubtotal.frame.size.width, _lbl_titleSubtotal.frame.size.height);
            _lbl_datasubtotal.frame = CGRectMake(_lbl_datasubtotal.frame.origin.x, _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10, _lbl_datasubtotal.frame.size.width, _lbl_datasubtotal.frame.size.height);
            
            if(_Switch_Ac.on)
            {
                _VW_line2.frame = CGRectMake(_VW_line2.frame.origin.x, _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10, _VW_line2.frame.size.width, _VW_line2.frame.size.height);
                _lbl_acbalance.frame = CGRectMake(_lbl_acbalance.frame.origin.x, _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10, _lbl_acbalance.frame.size.width, _lbl_acbalance.frame.size.height);
                _lbl_acbalance_amount.frame = CGRectMake(_lbl_acbalance_amount.frame.origin.x, _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10, _lbl_acbalance_amount.frame.size.width, _lbl_acbalance_amount.frame.size.height);
                
                _VW_line3.frame = CGRectMake(_VW_line3.frame.origin.x, _lbl_acbalance.frame.origin.y + _lbl_acbalance.frame.size.height + 10, _VW_line3.frame.size.width, _VW_line3.frame.size.height);
                
                _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
                
                _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
                
                _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
                
                
            }
            else
            {
                _VW_line2.hidden = YES;
                _lbl_acbalance.hidden = YES;
                _lbl_acbalance_amount.hidden = YES;
                
                
                _VW_line3.frame = CGRectMake(_VW_line3.frame.origin.x, _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10, _VW_line3.frame.size.width, _VW_line3.frame.size.height);
                
                _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
                
                _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
                
                _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
            }
            
            
            
            
        }
        else
        {
            _VW_line1.frame = CGRectMake(_VW_line1.frame.origin.x, _BTN_Account.frame.origin.y + _BTN_Account.frame.size.height + 10, _VW_line1.frame.size.width, _VW_line1.frame.size.height);
            
            _lbl_titleSubtotal.frame = CGRectMake(_lbl_titleSubtotal.frame.origin.x, _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10, _lbl_titleSubtotal.frame.size.width, _lbl_titleSubtotal.frame.size.height);
            _lbl_datasubtotal.frame = CGRectMake(_lbl_datasubtotal.frame.origin.x, _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10, _lbl_datasubtotal.frame.size.width, _lbl_datasubtotal.frame.size.height);
            
            
            _VW_line3.frame = CGRectMake(_VW_line3.frame.origin.x, _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10, _VW_line3.frame.size.width, _VW_line3.frame.size.height);
            
            _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
            
            _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
            
            _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
        }
        
        
    }];
    _lbl_arrowpromocode.text = @"";
}
 */
-(void) BTN_account_Tap
{
    if (_VW_Account.hidden == YES) {
        
        _Switch_Ac.on = NO;
        
        _lbl_current_bal.frame = CGRectMake(_BTN_Account.frame.origin.x + 10, _BTN_Account.frame.origin.y + _BTN_Account.frame.size.height, _lbl_current_bal.frame.size.width, _lbl_current_bal.frame.size.height);
        _lbl_current_bal.hidden = NO;
        _VW_Account.frame = CGRectMake(_VW_Account.frame.origin.x, _lbl_current_bal.frame.origin.y + _lbl_current_bal.frame.size.height , _VW_Account.frame.size.width, _VW_Account.frame.size.height);
        
        _lbl_arrowaccount.text = @"";
        
        
        
        [UIView animateWithDuration:0.4 animations:^{
            
            
            
            
            
            _VW_line1.frame = CGRectMake(_VW_line1.frame.origin.x, _VW_Account.frame.origin.y + _VW_Account.frame.size.height + 10, _VW_line1.frame.size.width, _VW_line1.frame.size.height);
            
            _lbl_titleSubtotal.frame = CGRectMake(_lbl_titleSubtotal.frame.origin.x, _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10, _lbl_titleSubtotal.frame.size.width, _lbl_titleSubtotal.frame.size.height);
            _lbl_datasubtotal.frame = CGRectMake(_lbl_datasubtotal.frame.origin.x, _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10, _lbl_datasubtotal.frame.size.width, _lbl_datasubtotal.frame.size.height);
            if(_Switch_Ac.on)
            {
                
                _VW_line2.frame = CGRectMake(_VW_line2.frame.origin.x, _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10, _VW_line2.frame.size.width, _VW_line2.frame.size.height);
                _lbl_acbalance.frame = CGRectMake(_lbl_acbalance.frame.origin.x, _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10, _lbl_acbalance.frame.size.width, _lbl_acbalance.frame.size.height);
                _lbl_acbalance_amount.frame = CGRectMake(_lbl_acbalance_amount.frame.origin.x, _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10, _lbl_acbalance_amount.frame.size.width, _lbl_acbalance_amount.frame.size.height);
                
                _VW_line3.frame = CGRectMake(_VW_line3.frame.origin.x, _lbl_acbalance.frame.origin.y + _lbl_acbalance.frame.size.height + 10, _VW_line3.frame.size.width, _VW_line3.frame.size.height);
                
                _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
                
                _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
                
                _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
                
                
                
            }
            else
            {
                _VW_line2.hidden = YES;
                _lbl_acbalance.hidden = YES;
                _lbl_acbalance_amount.hidden = YES;
                
                
                _VW_line3.frame = CGRectMake(_VW_line3.frame.origin.x, _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10, _VW_line3.frame.size.width, _VW_line3.frame.size.height);
                
                _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
                
                _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
                
                _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
                
            }
            
            
            
        }];
        
        
        [UIView beginAnimations:@"LeftFlip" context:nil];
        [UIView setAnimationDuration:0.8];
        _VW_Account.hidden = NO;
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_VW_Account cache:YES];
        [UIView commitAnimations];
        
        original_height = _BTN_checkout.frame.origin.y + _BTN_checkout.frame.size.height + 40;
        [self viewDidLayoutSubviews];
    }
    else
    {
        [self hide_account];
        original_height = _BTN_checkout.frame.origin.y + _BTN_checkout.frame.size.height + 40;
        [self viewDidLayoutSubviews];
    }
}
-(void) hide_account
{
    [UIView transitionWithView:_VW_Account
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:NULL
                    completion:NULL];
    [_VW_Account  setHidden:YES];
    _Switch_Ac.on = NO;
    
    _lbl_dataTotal.text = _lbl_datasubtotal.text;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        
        _lbl_current_bal.hidden = YES;
        _VW_line1.frame = CGRectMake(_VW_line1.frame.origin.x, _BTN_Account.frame.origin.y + _BTN_Account.frame.size.height + 10, _VW_line1.frame.size.width, _VW_line1.frame.size.height);
        
        _lbl_titleSubtotal.frame = CGRectMake(_lbl_titleSubtotal.frame.origin.x, _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10, _lbl_titleSubtotal.frame.size.width, _lbl_titleSubtotal.frame.size.height);
        _lbl_datasubtotal.frame = CGRectMake(_lbl_datasubtotal.frame.origin.x, _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10, _lbl_datasubtotal.frame.size.width, _lbl_datasubtotal.frame.size.height);
        
        _VW_line2.hidden = YES;
        _lbl_acbalance.hidden = YES;
        _lbl_acbalance_amount.hidden = YES;
        
        _VW_line3.frame = CGRectMake(_VW_line3.frame.origin.x, _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10, _VW_line3.frame.size.width, _VW_line3.frame.size.height);
        
        _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
        
        _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
        
        _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
        
        
        // }
        
    }];
    _lbl_arrowaccount.text = @"";
}
-(void)switch_ction
{
    _VW_line2.hidden = NO;
    _lbl_acbalance.hidden = NO;
    _lbl_acbalance_amount.hidden = NO;
    if(_Switch_Ac.on)
    {
        
        //        wallet_text = [NSString stringWithFormat:@"Current Balance: $%.2f",price_deduct decide_VC
        //                       ];
        //   _lbl_current_bal.text = [NSString stringWithFormat:@"%@",wallet_text];
        
        //        NSArray *arr = [_lbl_datasubtotal.text componentsSeparatedByString:@"$"];
        //        NSArray *arr1 = [_lbl_current_bal.text componentsSeparatedByString:@"$"];
        //        float amount = [[arr objectAtIndex:[arr count]-1] floatValue] - [[arr1 objectAtIndex:[arr1 count]-1] floatValue];
        //        NSString *str = [NSString stringWithFormat:@"%.2f",amount];
        //        _lbl_dataTotal.text = str;
        //        NSLog(@"the swiych of text:%@",_lbl_dataTotal.text);
        
        float total;
        NSArray *ARR_waletmoney = [_lbl_current_bal.text componentsSeparatedByString:@"$"];
        float waletMoney = [[ARR_waletmoney objectAtIndex:[ARR_waletmoney count]-1]floatValue];
        
        NSArray *ARR_subtotal = [_lbl_datasubtotal.text componentsSeparatedByString:@"$"];
        float subtotal = [[ARR_subtotal objectAtIndex:[ARR_subtotal count]-1]floatValue];
        
        float difference;
        
        if (waletMoney > subtotal) {
            total = 0.00f;
            difference = subtotal;
        }
        else
        {
            total = subtotal - waletMoney;
            difference = subtotal - total;
        }
               _lbl_acbalance_amount.text = [NSString stringWithFormat:@"-$%.2f",difference];
        price_deduct = total;
        NSString *STR_total = [NSString stringWithFormat:@"$%.2f",total];
        _lbl_dataTotal.text = STR_total;
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%.2f",total] forKey:@"total_balance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"SWITCH_ON" forKey:@"SWITCHSTAT"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        

        
        [UIView animateWithDuration:0.4 animations:^{
            CGRect switchframe = _VW_line2.frame ;
            switchframe.origin.y = _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10;
            _VW_line2.frame = switchframe;
            
            switchframe = _lbl_acbalance.frame ;
            switchframe.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
            _lbl_acbalance.frame = switchframe;
            
            switchframe = _lbl_acbalance_amount.frame ;
            switchframe.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
            _lbl_acbalance_amount.frame = switchframe;
            
            switchframe = _VW_line3.frame;
            switchframe.origin.y = _lbl_acbalance.frame.origin.y + _lbl_acbalance.frame.size.height + 10;
            _VW_line3.frame = switchframe;
            
            
            switchframe = _lbl_titleTotal.frame;
            switchframe.origin.y = _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10;
            _lbl_titleTotal.frame = switchframe;
            
            switchframe = _lbl_dataTotal.frame;
            switchframe.origin.y = _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10;
            _lbl_dataTotal.frame = switchframe;
            
            switchframe = _BTN_checkout.frame;
            switchframe.origin.y = _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10;
            _BTN_checkout.frame = switchframe;
        }];
        
        [UIView beginAnimations:@"LeftFlip" context:nil];
        [UIView commitAnimations];
        
        original_height = _BTN_checkout.frame.origin.y + _BTN_checkout.frame.size.height + 40;
        [self viewDidLayoutSubviews];
    }
    else if(_Switch_Ac.on == NO)
    {
        
        
        [[NSUserDefaults standardUserDefaults] setValue:@"SWITCH_OFF" forKey:@"SWITCHSTAT"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        _VW_line2.hidden = YES;
        _lbl_acbalance.hidden = YES;
        _lbl_acbalance_amount.hidden = YES;
        //        _lbl_dataTotal.text = total_text;
        
        NSArray *ARR_subtotal = [_lbl_datasubtotal.text componentsSeparatedByString:@"$"];
        float total =[[ARR_subtotal objectAtIndex:[ARR_subtotal count]-1] floatValue];
        NSString *STR_total = [NSString stringWithFormat:@"$%.2f",total];
        _lbl_dataTotal.text = STR_total;
        
        [[NSUserDefaults standardUserDefaults] setValue:STR_total forKey:@"total_balance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [UIView animateWithDuration:0.4 animations:^{
            CGRect switchframe = _VW_line3.frame;
            switchframe.origin.y = _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10;
            _VW_line3.frame = switchframe;
            
            switchframe = _lbl_titleTotal.frame;
            switchframe.origin.y = _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10;
            _lbl_titleTotal.frame = switchframe;
            
            switchframe = _lbl_dataTotal.frame;
            switchframe.origin.y = _VW_line3.frame.origin.y + _VW_line3.frame.size.height + 10;
            _lbl_dataTotal.frame = switchframe;
            
            switchframe = _BTN_checkout.frame;
            switchframe.origin.y = _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10;
            _BTN_checkout.frame = switchframe;
            
        }];
        [UIView beginAnimations:@"LeftFlip" context:nil];
        [UIView commitAnimations];
        
        original_height = _BTN_checkout.frame.origin.y + _BTN_checkout.frame.size.height + 40;
        [self viewDidLayoutSubviews];
        
        
    }
    
    
}
-(void)checkout_action
{
    VW_overlay.hidden = NO;
    [activityIndicatorView startAnimating];
    [self performSegueWithIdentifier:@"auction_checkout_to_auction_biling" sender:self];
    
    VW_overlay.hidden = YES;
    [activityIndicatorView stopAnimating];
    
    
    
    
//    float total;
//    total = [[[NSUserDefaults standardUserDefaults] valueForKey:@"total_balance"] floatValue];
//    NSString *switch_STAT = [[NSUserDefaults standardUserDefaults] valueForKey:@"SWITCHSTAT"];
//    
//    if(total == 0.00 && [switch_STAT isEqualToString:@"SWITCH_ON"])
//    {
//        [self performSelector:@selector(billing_Address) withObject:activityIndicatorView afterDelay:0.01];
//    }
//    else
//    {
//        [self performSelector:@selector(get_client_TOKEN) withObject:activityIndicatorView afterDelay:0.01];
//        
//    }

}


#pragma mark - API Integration
#pragma  mark payment methods



-(void) billing_Address
{
    // [self dismissViewControllerAnimated:YES completion:NULL];
    
    NSError *error;
    NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"User_data"] options:NSASCIIStringEncoding error:&error];
    
    NSDictionary *user_data = [dict valueForKey:@"user"];
    NSLog(@"the user data is:%@",user_data);
    @try
    {
        NSString *STR_error = [dict valueForKey:@"error"];
        if (STR_error)
        {
            [self sessionOUT];
        }
        else
        {
            NSLog(@"the user data is:%@",dict);
            NSHTTPURLResponse *response = nil;
            NSDictionary *parameters;
            
            NSString *order_ID = [checkout_data valueForKey:@"order_id"];

            NSString *first_name = [NSString stringWithFormat:@"%@",[user_data valueForKey:@"first_name"]];
            first_name = [first_name stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
            first_name = [first_name stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
          
            NSString *last_name = [NSString stringWithFormat:@"%@",[user_data valueForKey:@"last_name"]];
            last_name = [last_name stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
            last_name = [last_name stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
          
            NSString *address_line1 = [NSString stringWithFormat:@"%@",[user_data valueForKey:@"address1"]];
            address_line1 = [address_line1 stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
            address_line1 = [address_line1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            
            NSString *address_line2 = [NSString stringWithFormat:@"%@",[user_data valueForKey:@"address2"]];
            address_line2 = [address_line2 stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
            address_line2 = [address_line2 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            
            NSString *city = [NSString stringWithFormat:@"%@",[user_data valueForKey:@"city"]];
            city = [city stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
            city = [city stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            
          
            NSString *country = [NSString stringWithFormat:@"%@",[user_data valueForKey:@"country"]];
            country = [country stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
            country = [country stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            
            [self Country_api];
            NSString *contry_Code = [countrys valueForKey:country];

            NSString *state = [NSString stringWithFormat:@"%@",[user_data valueForKey:@"state"]];
            state = [state stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
            state = [state stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            
            [self State_api:country];
            NSString *state_code = [states valueForKey:state];

            
            
            NSString *zip_code = [NSString stringWithFormat:@"%@",[user_data valueForKey:@"zipcode"]];
            zip_code = [zip_code stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
            zip_code = [zip_code stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            
            
            NSString *phone = [NSString stringWithFormat:@"%@",[user_data valueForKey:@"phone"]];
            phone = [phone stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
            phone = [phone stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

            
            NSString *switch_STAT = [[NSUserDefaults standardUserDefaults] valueForKey:@"SWITCHSTAT"];
            
            if([switch_STAT isEqualToString:@"SWITCH_ON"])
            {
                parameters = @{@"billing_address":@{ @"first_name": first_name,@"last_name": last_name,@"address_line1": address_line1,@"address_line2": address_line2,@"city": city,@"country": contry_Code,@"zip_code": zip_code,@"state": state_code,@"order_id": order_ID,@"phone": phone},@"fund_amount":@"yes"};
                
                
            }
            else
            {
                parameters = @{@"billing_address":@{ @"first_name": first_name,@"last_name": last_name,@"address_line1": address_line1,@"address_line2": address_line2,@"city": city,@"country": contry_Code,@"zip_code": zip_code,@"state": state_code,@"order_id": order_ID,@"phone": phone }};
            }
            
            NSLog(@"Post contents VC Billing Address %@",parameters);
            
            NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSASCIIStringEncoding error:&error];
            NSString *urlGetuser =[NSString stringWithFormat:@"%@events/billing_address",SERVER_URL];
            NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
            NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:urlProducts];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
            [request setHTTPBody:postData];
            [request setHTTPShouldHandleCookies:NO];
            NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            if (aData)
            {
                [activityIndicatorView stopAnimating];
                VW_overlay.hidden = YES;
                
                //                @try
                //                {
                //                    NSString *STR_error1 = [aData valueForKey:@"error"];
                //                    if (STR_error1)
                //                    {
                //                        [self sessionOUT];
                //                    }
                //                    else
                //                    {
                [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"CHKOUTDETAIL"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self performSegueWithIdentifier:@"checkout_Detail_auction" sender:self];
             //   [self  parse_listEvents_api];
                //                    }
                //                }
                //                @catch (NSException *exception)
                //                {
                //                    [self sessionOUT];
                //                }
            }
            else
            {
                [activityIndicatorView stopAnimating];
                VW_overlay.hidden = YES;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Error" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
            }
        }
    }
    @catch (NSException *exception)
    {
        [self sessionOUT];
    }
    
    
}
-(void) get_client_TOKEN
{
    NSError *error;
    NSHTTPURLResponse *response = nil;
    
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    
    NSString *urlGetuser = [NSString stringWithFormat:@"%@contributors/client_token",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        
        @try
        {
            NSString *STR_error = [dict valueForKey:@"error"];
            if (STR_error)
            {
                [self sessionOUT];
            }
            else
            {
                NSLog(@"Client Token = %@",[dict valueForKey:@"client_token"]);
                [self braintree_Dropin_UI:[dict valueForKey:@"client_token"]];
            }
        }
        @catch (NSException *exception)
        {
            [self sessionOUT];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please retry" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

-(void) braintree_Dropin_UI :(NSString *) client_TOK
{
        @try
    {
        BTDropInRequest *request = [[BTDropInRequest alloc] init];
        BTDropInController *dropIn = [[BTDropInController alloc] initWithAuthorization:client_TOK request:request handler:^(BTDropInController * _Nonnull controller, BTDropInResult * _Nullable result, NSError * _Nullable error) {
            
            if (error != nil) {
                NSLog(@"ERROR");
            } else if (result.cancelled) {
                NSLog(@"CANCELLED");
                [self dismissViewControllerAnimated:YES completion:NULL];
            } else {
                //                [self performSelector:@selector(dismiss_BT)
                //                           withObject:nil
                //                           afterDelay:0.0];
                [self postNonceToServer:result.paymentMethod.nonce];
                [self dismissViewControllerAnimated:YES completion:NULL];
            }
        }];
        [self presentViewController:dropIn animated:YES completion:nil];
    }
    @catch (NSException *exception)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection error" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}


-(void) dismiss_BT
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void) postNonceToServer :(NSString *)str
{
    NSLog(@"Post %@",str);
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nonce" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    //    [alert show];
    @try {
    if (str)
    {
        [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"NAUNCETOK"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //        [self billing_Address];
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(billing_Address) withObject:activityIndicatorView afterDelay:0.01];
        //         [self dismissViewControllerAnimated:YES completion:NULL];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Payment Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    }
    @catch (NSException *exception)
    {
        [self sessionOUT];
    }

}



#pragma  mark state and country api
-(void)Country_api
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser =[NSString stringWithFormat:@"%@city_states/countries",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData) {
        countrys = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"The response %@",countrys);
        //self.countrypicker = sorted_Contry;
//        
//        if ([[countrys allKeys] count] == 1)
//        {
//         //   _TXT_country.text = [[countryS allKeys]objectAtIndex:0];
//            VW_overlay.hidden = NO;
//            [activityIndicatorView startAnimating];
//            [self performSelector:@selector(State_api:) withObject:activityIndicatorView afterDelay:0.01];
//        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}
-(void)State_api:(NSString *)state
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser =[NSString stringWithFormat:@"%@city_states/states?country=%@",SERVER_URL,state];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [activityIndicatorView startAnimating];
    VW_overlay.hidden = NO;
    if (aData)
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
       
        states = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"The response %@",states);
        sorted_STAES = [[states allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        [activityIndicatorView startAnimating];
        VW_overlay.hidden = NO;

       // self.statepicker = sorted_STAES;
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
}

#pragma mark - Session OUT
- (void) sessionOUT
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Session out" message:@"In some other device same user logged in. Please login again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
    
    ViewController *tncView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
    [tncView setModalInPopover:YES];
    [tncView setModalPresentationStyle:UIModalPresentationFormSheet];
    [tncView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:tncView animated:YES completion:NULL];
}

@end