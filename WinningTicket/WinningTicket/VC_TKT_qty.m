//
//  VC_TKT_qty.m
//  WinningTicket
//
//  Created by Test User on 28/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_TKT_qty.h"
//#import "DejalActivityView.h"
//#import "DGActivityIndicatorView.h"

@interface VC_TKT_qty ()
{
    float original_height;
    UIView *VW_overlay;
    UIActivityIndicatorView *activityIndicatorView;
//    UILabel *loadingLabel;
}

@end

@implementation VC_TKT_qty

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_FRAME];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    VW_overlay.layer.cornerRadius = 10.0;
    
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setup_FRAME
{
    NSError *error;
    NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"upcoming_events"] options:NSASCIIStringEncoding error:&error];
    NSLog(@"thedata is Upcoming:%@",dict);
    
    NSDictionary *temp_dict=[dict valueForKey:@"event"];

    
    [_scroll_contents addSubview:_VW_qtycontent];
    [_scroll_contents addSubview:_VW_line1];
    [_scroll_contents addSubview:_VW_line2];
    [_scroll_contents addSubview:_VW_promo];
    
    NSString *location=[NSString stringWithFormat:@"%@",[temp_dict valueForKey:@"location"]];
    if([location isEqualToString:@"<null>"])
    {
            location=@"Not mentioned";
    }
    _TXT_qty.text = @"1";
    NSString *show = @"Winning Ticket";
    NSString *place = [[temp_dict valueForKey:@"name"] capitalizedString];
    NSString *org_name = [[temp_dict valueForKey:@"organization_name"] capitalizedString];
    NSString *ticketnumber = [temp_dict  valueForKey:@"code"];
    
    NSString *STR_tkt_num_club = [NSString stringWithFormat:@"%@ - %@",ticketnumber,place];
    
    _lbl_price.text=[NSString stringWithFormat:@"$%.02f",[[dict valueForKey:@"price"] floatValue]];
    
    NSArray *arr = [_lbl_price.text componentsSeparatedByString:@"$"];
    _lbl_dataTotal.text = [NSString stringWithFormat:@"$%.02f",[_TXT_qty.text floatValue] * [[arr objectAtIndex:1] floatValue]];
    _lbl_datasubtotal.text = [NSString stringWithFormat:@"$%.02f",[_TXT_qty.text floatValue] * [[arr objectAtIndex:1] floatValue]];
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@\n%@",show,org_name,STR_tkt_num_club];
    
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
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBold" size:22],NSParagraphStyleAttributeName:paragraphStyle1}
                                    range:cmp];
            
            NSMutableParagraphStyle *paragraphStyle2  = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle2.lineSpacing = 2;
            NSRange plce = [text rangeOfString:org_name];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBold" size:18.0],NSParagraphStyleAttributeName:paragraphStyle2}
                                    range:plce];
        
            NSMutableParagraphStyle *paragraphStyle3  = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle3.lineSpacing = 0;
            NSRange tkt_num_range = [text rangeOfString:STR_tkt_num_club];
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBook" size:17.0],NSParagraphStyleAttributeName:paragraphStyle} range:tkt_num_range];
        }
        else
        {
            NSMutableParagraphStyle *paragraphStyle1  = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle1.lineSpacing = 5;
            // Red text attributes
            //            UIColor *redColor = [UIColor redColor];
            NSRange cmp = [text rangeOfString:show];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBold" size:20.0],NSParagraphStyleAttributeName:paragraphStyle1}
                                    range:cmp];
            
            NSMutableParagraphStyle *paragraphStyle2  = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle2.lineSpacing = 2;
            NSRange plce = [text rangeOfString:org_name];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"GothamBold" size:16.0],NSParagraphStyleAttributeName:paragraphStyle2}
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
    
    self.lbl_ticketdetail.numberOfLines = 0;
    [self.lbl_ticketdetail sizeToFit];
    
    float qty_frame_Y = _lbl_ticketdetail.frame.size.height;
    
    CGRect frame_ST = _VW_qtycontent.frame;
    frame_ST.origin.y = _lbl_ticketdetail.frame.origin.y + qty_frame_Y + 10;
    _VW_qtycontent.frame = frame_ST;
    
    frame_ST = _lbl_arrowpromocode.frame;
    frame_ST.origin.y = _VW_qtycontent.frame.origin.y + _VW_qtycontent.frame.size.height + 10;
    _lbl_arrowpromocode.frame = frame_ST;
    
    frame_ST = _BTN_promocode.frame;
    frame_ST.origin.y = _VW_qtycontent.frame.origin.y + _VW_qtycontent.frame.size.height + 10;
    _BTN_promocode.frame = frame_ST;
    
    [_BTN_promocode addTarget:self action:@selector(BTN_promocode_TAP) forControlEvents:UIControlEventTouchUpInside];
    
    frame_ST = _VW_promo.frame;
    frame_ST.origin.y = _BTN_promocode.frame.origin.y + _BTN_promocode.frame.size.height + 10;
    _VW_promo.frame = frame_ST;
    
    frame_ST = _VW_line1.frame;
    frame_ST.origin.y = _BTN_promocode.frame.origin.y + _BTN_promocode.frame.size.height + 10;
    _VW_line1.frame = frame_ST;
    
    frame_ST = _lbl_titleSubtotal.frame;
    frame_ST.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10;
    _lbl_titleSubtotal.frame = frame_ST;
    
    frame_ST = _lbl_datasubtotal.frame;
    frame_ST.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10;
    _lbl_datasubtotal.frame = frame_ST;
    
    frame_ST = _VW_line2.frame;
    frame_ST.origin.y = _lbl_titleSubtotal.frame.origin.y + _lbl_titleSubtotal.frame.size.height + 10;
    _VW_line2.frame = frame_ST;
    
    frame_ST = _lbl_titleTotal.frame;
    frame_ST.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
    _lbl_titleTotal.frame = frame_ST;
    
    frame_ST = _lbl_dataTotal.frame;
    frame_ST.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
    _lbl_dataTotal.frame = frame_ST;
    
    [_BTN_checkout addTarget:self action:@selector(decide_VC) forControlEvents:UIControlEventTouchUpInside];
    
    frame_ST = _BTN_checkout.frame;
    frame_ST.origin.y = _lbl_titleTotal.frame.origin.y + _lbl_titleTotal.frame.size.height + 10;
    _BTN_checkout.frame = frame_ST;
    
//    _VW_promo.layer.borderWidth = 2.0f;
//    _VW_promo.layer.borderColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.0].CGColor;
    _VW_promo.hidden = YES;
    
    _TXT_promocode.layer.borderWidth = 1.0f;
    _TXT_promocode.layer.borderColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.0].CGColor;
    _TXT_promocode.layer.cornerRadius = 5.0f;
    _TXT_promocode.layer.masksToBounds = YES;
    
    original_height = _BTN_checkout.frame.origin.y + _BTN_checkout.frame.size.height + 40;
    
    frame_ST = _scroll_contents.frame;
    frame_ST.size.height = [UIScreen mainScreen].bounds.size.height - self.navigationController.navigationBar.frame.size.height;
    _scroll_contents.frame = frame_ST;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap_DTECt:)];
    [tap setCancelsTouchesInView:NO];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    [self.TXT_qty addTarget:self action:@selector(get_caluculated_text) forControlEvents:UIControlEventEditingChanged];
}

-(void) decide_VC
{
    NSString *STR_chk = _TXT_qty.text;
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    int count = 0;
    
    if (STR_chk.length !=0 )
    {
        for (int i = 0; i < [STR_chk length]; i++)
        {
            unichar c = [STR_chk characterAtIndex:i];
            if ([myCharSet characterIsMember:c])
            {
                count ++;
            }
        }
    }
    
    if ((count = [STR_chk intValue]))
    {
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(update_QTY_api) withObject:activityIndicatorView afterDelay:0.01];
//        BOOL stat = 
//        if (stat)
//        {

    }
}

-(void) api_update_Recipts
{
    NSError *error;
    NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"QUANTITY"] options:NSASCIIStringEncoding error:&error];
    
    
    NSError *err;
    NSHTTPURLResponse *response = nil;
    NSMutableArray *userDetails = [[NSMutableArray alloc] init];
    NSDictionary *parameters = @{ @"recipients": userDetails, @"order_item" : @{ @"id":[dict valueForKey:@"order_item_id"]}};
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSASCIIStringEncoding error:&err];
    NSString *urlGetuser = [NSString stringWithFormat:@"%@events/create_update_recipients",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPBody:postData];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        dict = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"Updated Status %@",dict);
        
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        if ([[dict valueForKey:@"message"] isEqualToString:@"Recipient(s) created/updated successfully."]) {
            [self performSegueWithIdentifier:@"checkouttobillingaddr" sender:self];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

-(void) Tap_DTECt :(UITapGestureRecognizer *)sender
{
}
#pragma mark - Tap Gesture
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [_TXT_qty resignFirstResponder];
    [_TXT_promocode resignFirstResponder];
    
    if ([touch.view isDescendantOfView:_BTN_promocode]) {
        return NO;
    }
    else if ([touch.view isDescendantOfView:_BTN_checkout]) {
        return NO;
    }
    return YES;
}

#define MAX_LENGTH 2
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    if (textField == _TXT_qty)
//    {
//        float width = textField.frame.size.width;
//        if (width  < 200) {
//            
//            CGRect rect = textField.frame;
//            rect.size.width += 10 ;
//            
//            textField.frame =rect;
//        }
//    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIButton Actions
-(void) BTN_promocode_TAP
{
    if (_VW_promo.hidden == YES) {
        //    _BTN_promocode.hidden = YES;
        float btn_ht = _BTN_promocode.frame.size.height + 10;
        CGRect promoFRAME = _VW_promo.frame;
        promoFRAME.origin.y = _BTN_promocode.frame.origin.y + btn_ht;
        _VW_promo.frame = promoFRAME;
        
        _lbl_arrowpromocode.text = @"";
        
        //    [UIView transitionWithView:_BTN_promocode
        //                      duration:0.4
        //                       options:UIViewAnimationOptionTransitionCurlUp
        //                    animations:NULL
        //                    completion:NULL];
        //    [self.BTN_promocode  setHidden:YES];
        //    _lbl_arrowpromocode.hidden = YES;
        
        
        float newHT = _BTN_promocode.frame.size.height + 25;
        
        [UIView animateWithDuration:0.5 animations:^{
            _VW_line1.frame = CGRectMake(_VW_line1.frame.origin.x, _VW_line1.frame.origin.y + newHT, _VW_line1.frame.size.width, _VW_line1.frame.size.height);
            _lbl_titleSubtotal.frame = CGRectMake(_lbl_titleSubtotal.frame.origin.x, _lbl_titleSubtotal.frame.origin.y + newHT, _lbl_titleSubtotal.frame.size.width, _lbl_titleSubtotal.frame.size.height);
            _lbl_datasubtotal.frame = CGRectMake(_lbl_datasubtotal.frame.origin.x, _lbl_datasubtotal.frame.origin.y + newHT, _lbl_datasubtotal.frame.size.width, _lbl_datasubtotal.frame.size.height);
            
            _VW_line2.frame = CGRectMake(_VW_line2.frame.origin.x, _VW_line2.frame.origin.y + newHT, _VW_line2.frame.size.width, _VW_line2.frame.size.height);
            _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _lbl_titleTotal.frame.origin.y + newHT, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
            _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _lbl_dataTotal.frame.origin.y + newHT, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
            
            _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _BTN_checkout.frame.origin.y + newHT, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
            
        }];
        
        
        [UIView beginAnimations:@"LeftFlip" context:nil];
        [UIView setAnimationDuration:0.8];
        _VW_promo.hidden = NO;
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_VW_promo cache:YES];
        [UIView commitAnimations];
        
        original_height = original_height + 100;
        [self viewDidLayoutSubviews];
    }
    else
    {
        [self hide_PROMO];
        original_height = original_height - 100;
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
    
    float btn_ht = _BTN_promocode.frame.size.height + 25;
    
    [UIView animateWithDuration:0.5 animations:^{
        _VW_line1.frame = CGRectMake(_VW_line1.frame.origin.x, _VW_line1.frame.origin.y - btn_ht, _VW_line1.frame.size.width, _VW_line1.frame.size.height);
        _lbl_titleSubtotal.frame = CGRectMake(_lbl_titleSubtotal.frame.origin.x, _lbl_titleSubtotal.frame.origin.y - btn_ht, _lbl_titleSubtotal.frame.size.width, _lbl_titleSubtotal.frame.size.height);
        _lbl_datasubtotal.frame = CGRectMake(_lbl_datasubtotal.frame.origin.x, _lbl_datasubtotal.frame.origin.y - btn_ht, _lbl_datasubtotal.frame.size.width, _lbl_datasubtotal.frame.size.height);
        
        _VW_line2.frame = CGRectMake(_VW_line2.frame.origin.x, _VW_line2.frame.origin.y - btn_ht, _VW_line2.frame.size.width, _VW_line2.frame.size.height);
        _lbl_titleTotal.frame = CGRectMake(_lbl_titleTotal.frame.origin.x, _lbl_titleTotal.frame.origin.y - btn_ht, _lbl_titleTotal.frame.size.width, _lbl_titleTotal.frame.size.height);
        _lbl_dataTotal.frame = CGRectMake(_lbl_dataTotal.frame.origin.x, _lbl_dataTotal.frame.origin.y - btn_ht, _lbl_dataTotal.frame.size.width, _lbl_dataTotal.frame.size.height);
        
        _BTN_checkout.frame = CGRectMake(_BTN_checkout.frame.origin.x, _BTN_checkout.frame.origin.y - btn_ht, _BTN_checkout.frame.size.width, _BTN_checkout.frame.size.height);
        
    }];
    _lbl_arrowpromocode.text = @"";
}


#pragma mark - Quantity Update
-(void)get_caluculated_text
{
    NSArray *arr = [_lbl_price.text componentsSeparatedByString:@"$"];
    _lbl_dataTotal.text = [NSString stringWithFormat:@"$%.02f",[_TXT_qty.text floatValue] * [[arr objectAtIndex:1] floatValue]];
    _lbl_datasubtotal.text = [NSString stringWithFormat:@"$%.02f",[_TXT_qty.text floatValue] * [[arr objectAtIndex:1] floatValue]];
}

#pragma mark - API Integration
-(void) update_QTY_api
{
    NSString *STR_chk = _TXT_qty.text;
    
    NSError *error;
    NSError *err;
    NSHTTPURLResponse *response = nil;
    
    NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"upcoming_events"] options:NSASCIIStringEncoding error:&error];
    NSDictionary *temp_dict=[dict valueForKey:@"event"];

    NSDictionary *parameters = @{ @"event_id":  [temp_dict valueForKey:@"id"], @"quantity": STR_chk};
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:NSASCIIStringEncoding error:&err];
    NSString *urlGetuser = [NSString stringWithFormat:@"%@events/create_order",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPBody:postData];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        
        NSLog(@"The value VC TKT Quantity %@",dict);
        
        [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"QUANTITY"];
        [[NSUserDefaults standardUserDefaults] setValue:STR_chk forKey:@"QTY"];
        [[NSUserDefaults standardUserDefaults] setValue:[dict valueForKey:@"price"] forKey:@"PriceSTR"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Error" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    int count = [[[NSUserDefaults standardUserDefaults] valueForKey:@"QTY"] intValue];
    if (count >= 2)
    {
        [self performSegueWithIdentifier:@"checkouttocontinuecheckout" sender:self];
    }
    else
    {
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(api_update_Recipts) withObject:activityIndicatorView afterDelay:0.01];
    }
}

@end
