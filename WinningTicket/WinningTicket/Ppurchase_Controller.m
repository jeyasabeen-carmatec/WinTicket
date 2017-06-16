//
//  Ppurchase_Controller.m
//  winning_ticket_purchaseTicket
//
//  Created by anumolu prakash on 12/04/17.
//  Copyright © 2017 carmatec. All rights reserved.
//

#import "Ppurchase_Controller.h"

@interface Ppurchase_Controller ()

@end

@implementation Ppurchase_Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.view addSubview:self.scroll];
    [self set_UP_VW];
}

-(void)set_UP_VW
{
    NSError *error;
    NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults] valueForKey:@"PurchaseRESPONSE"] options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"Response from purchase controller :%@",dict);
    
    NSLog(@"Error %@",error);
    
    if (dict)
    {
      /*  CGRect content_frame = _content_view.frame;
        content_frame.size.width =_scroll.frame.size.width;
        _content_view.frame = content_frame;
        [self.scroll addSubview:_content_view];
        self.start_View.frame=CGRectMake(0,self.content_view.frame.origin.y-self.navigationController.navigationBar.frame.size.height+20, self.content_view.bounds.size.width,self.navigationController.navigationBar.frame.size.height+20);
        [self.content_view addSubview:self.start_View];

        [self.content_view addSubview:self.pur_view];
    
        [self.confirm_mail sizeToFit];
        
        
        
        //after displaying the data new FRAME
        CGRect new_Frame=self.confirm_mail.frame;
        new_Frame.origin.y=self.status_Label.frame.origin.y+self.status_Label.frame.size.height+10;
        self.confirm_mail.frame=new_Frame;
        [self.confirm_mail sizeToFit];
        
        new_Frame=self.order.frame;
        new_Frame.origin.y=self.confirm_mail.frame.origin.y+self.confirm_mail.frame.size.height+10;
        self.order.frame=new_Frame;
        
        
        new_Frame=self.order_summary.frame;
        new_Frame.origin.y=self.order.frame.origin.y+self.order.frame.size.height+10;
        self.order_summary.frame=new_Frame;
        
        new_Frame=self.first_VW.frame;
        new_Frame.origin.y=self.order_summary.frame.origin.y+self.order_summary.frame.size.height+10;
        self.first_VW.frame=new_Frame;
        
        
        new_Frame=self.name_ticket.frame;
        new_Frame.origin.y=self.first_VW.frame.origin.y+self.first_VW.frame.size.height+10;
        self.name_ticket.frame=new_Frame;
        
        new_Frame=self.qty.frame;
        new_Frame.origin.y=self.name_ticket.frame.origin.y;
        self.qty.frame=new_Frame;
        
        new_Frame=self.des_cription.frame;
        new_Frame.origin.y=self.name_ticket.frame.origin.y+self.name_ticket.frame.size.height+10;
        self.des_cription.frame=new_Frame;
        
        new_Frame=self.amount.frame;
        new_Frame.origin.y=self.des_cription.frame.origin.y;
        self.amount.frame=new_Frame;
        
        
        new_Frame=self.pur_view.frame;
        new_Frame.origin.y=self.des_cription.frame.origin.y+self.des_cription.frame.size.height+10;
        self.pur_view.frame=new_Frame;
        
        new_Frame=_sub_total.frame;
        new_Frame.origin.y=self.pur_view.frame.origin.y+self.pur_view.frame.size.height+30;
        self.sub_total.frame=new_Frame;
        
        new_Frame=_sub_amount.frame;
        new_Frame.origin.y=self.sub_total.frame.origin.y+10;
        _sub_amount.frame=new_Frame;
       
        
        new_Frame=self.sec_vw.frame;
        new_Frame.origin.y=self.sub_total.frame.origin.y+self.sub_total.frame.size.height+10;
        self.sec_vw.frame=new_Frame;
        
        new_Frame=self.total.frame;
        new_Frame.origin.y=self.sec_vw.frame.origin.y+self.sec_vw.frame.size.height+10;
        self.total.frame=new_Frame;
        
        new_Frame=self.total_amount.frame;
        new_Frame.origin.y=self.total.frame.origin.y+10;
        self.total_amount.frame=new_Frame;
       
        new_Frame=self._BTN_Ok.frame;
        new_Frame.origin.y=self.total.frame.origin.y+self.total.frame.size.height+10;
        self._BTN_Ok.frame = new_Frame;
        
        
        
        [__BTN_Ok addTarget:self action:@selector(Ok_Clicked) forControlEvents:UIControlEventTouchUpInside];
        //  [_start_View addSubview:__BTN_Ok];
        
        CGRect final_frame = _start_View.frame;
        final_frame.size.height = __BTN_Ok.frame.origin.y + __BTN_Ok.frame.size.height + 20;
        _start_View.frame = final_frame;*/
        
        CGRect frame_rect;
        float orginal_width = _status_Label.frame.size.width;
        
        self.status_Label.text = @"Thank You For Purchase";
        frame_rect = _status_Label.frame;
        frame_rect.size.width = orginal_width;
        frame_rect.size.height = _status_Label.frame.size.height;
        _status_Label.frame = frame_rect;
        
        frame_rect = _confirm_mail.frame;
        orginal_width = _confirm_mail.frame.size.width;

        self.confirm_mail.text = [NSString stringWithFormat:@"A Confirmation mail Has been Sent to your Mail %@",[dict valueForKey:@"email"]];
        [self.confirm_mail sizeToFit];
        
        frame_rect.origin.y = _status_Label.frame.origin.y + _status_Label.frame.size.height + 10;
        frame_rect.size.width = orginal_width;
        frame_rect.size.height = _confirm_mail.frame.size.height;
        _confirm_mail.frame = frame_rect;
        
        self.order.text = [NSString stringWithFormat:@"Order #%@",[dict valueForKey:@"order_id"]];
        frame_rect = _order.frame;
        frame_rect.origin.y = _confirm_mail.frame.origin.y + _confirm_mail.frame.size.height + 10;
        _order.frame = frame_rect;
        
        CGRect VW_frame;
        
        VW_frame = _VW_head.frame;
        VW_frame.size.height = _order.frame.origin.y + _order.frame.size.height + 10;
        VW_frame.size.width = _scroll.frame.size.width;
        _VW_head.frame = VW_frame;
        
        
        self.order_summary.text = @"Order Summary";
        frame_rect = _order_summary.frame;
        frame_rect.origin.y = _VW_head.frame.origin.y + _VW_head.frame.size.height;
        _order_summary.frame = frame_rect;
        
        VW_frame = _first_VW.frame;
        VW_frame.origin.y = _order_summary.frame.origin.y + _order_summary.frame.size.height + 10;
        _first_VW.frame = VW_frame;
        
        frame_rect = _name_ticket.frame;
        frame_rect.origin.y = _first_VW.frame.origin.y + _first_VW.frame.size.height + 10;
        _name_ticket.frame = frame_rect;
        
        self.qty.text=[NSString stringWithFormat:@"Qty:%@",[dict valueForKey:@"quantity"]];
        frame_rect = _qty.frame;
        frame_rect.origin.y = _first_VW.frame.origin.y + _first_VW.frame.size.height + 10;
        _qty.frame = frame_rect;
        
       
        
        NSString *des = [dict valueForKey:@"name"];
        NSString *code = [NSString stringWithFormat:@"%@",[dict valueForKey:@"code"]];
        NSString *text = [NSString stringWithFormat:@"%@\n%@",code,des];
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName:[UIColor darkGrayColor],
                                  NSFontAttributeName: [UIFont fontWithName:@"Gotham-Book" size:17]
                                  };
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attribs];
        
        
//        UIFont *boldFont = [UIFont fontWithName:@"Gotham-Book" size:17];
        NSRange range = [text rangeOfString:des];
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Book" size:14.0]}
                                range:range];
        
//        UIColor *greenColor = [UIColor lightGrayColor];
        NSRange greenTextRange = [text rangeOfString:code];
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Book" size:17.0]}
                                range:greenTextRange];
        
        orginal_width = _des_cription.frame.size.width;
        
        self.des_cription.attributedText = attributedText;
        _des_cription.numberOfLines = 0;
        [self.des_cription sizeToFit];
        
        frame_rect = _des_cription.frame;
        
        
        frame_rect.origin.y = _name_ticket.frame.origin.y + _name_ticket.frame.size.height + 10;
        frame_rect.size.width = orginal_width;
        _des_cription.frame = frame_rect;
        
        _amount.text = [NSString stringWithFormat:@"$ %.2f",[[dict valueForKey:@"price"] floatValue]];
        
        frame_rect = _amount.frame;
        frame_rect.origin.y = _name_ticket.frame.origin.y + _name_ticket.frame.size.height + 10;
        _amount.frame = frame_rect;
        
        frame_rect = _pur_view.frame;
        frame_rect.origin.y = _des_cription.frame.origin.y + _des_cription.frame.size.height + 10;
        _pur_view.frame = frame_rect;
        
        frame_rect = _sub_total.frame;
        frame_rect.origin.y = _pur_view.frame.origin.y + _pur_view.frame.size.height + 10;
        _sub_total.frame = frame_rect;
        
        _sub_amount.text = [NSString stringWithFormat:@"$ %.2f",[[dict valueForKey:@"price"] floatValue]];
        frame_rect = _sub_amount.frame;
        frame_rect.origin.y = _pur_view.frame.origin.y + _pur_view.frame.size.height + 10;
        _sub_amount.frame = frame_rect;
        
        frame_rect = _sec_vw.frame;
        frame_rect.origin.y = _sub_amount.frame.origin.y + _sub_amount.frame.size.height + 10;
        _sec_vw.frame = frame_rect;
        
        frame_rect = _total.frame;
        frame_rect.origin.y = _sec_vw.frame.origin.y + _sec_vw.frame.size.height + 10;
        _total.frame = frame_rect;
        
        _total_amount.text = [NSString stringWithFormat:@"$ %.2f",[[dict valueForKey:@"price"] floatValue]];
        frame_rect = _total_amount.frame;
        frame_rect.origin.y = _sec_vw.frame.origin.y + _sec_vw.frame.size.height + 10;
        _total_amount.frame = frame_rect;
        
        frame_rect = __BTN_Ok.frame;
        frame_rect.origin.y = _total.frame.origin.y + _total.frame.size.height + 10;
        __BTN_Ok.frame = frame_rect;
        
        VW_frame = _start_View.frame;
        VW_frame.size.height = __BTN_Ok.frame.origin.y + __BTN_Ok.frame.size.height + 10;
        VW_frame.size.width = _scroll.frame.size.width;
        _start_View.frame = VW_frame;
    }
    
    
    [__BTN_Ok addTarget:self action:@selector(Ok_Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    //    CGRect titleLabelBounds = self.des_cription.bounds;
    //    titleLabelBounds.size.height = CGFLOAT_MAX;
    //    // Change limitedToNumberOfLines to your preferred limit (0 for no limit)
    //    CGRect minimumTextRect = [self.des_cription textRectForBounds:titleLabelBounds limitedToNumberOfLines:2];
    //
    //    CGFloat titleLabelHeightDelta = minimumTextRect.size.height - self.des_cription.frame.size.height;
    //    CGRect titleFrame = self.des_cription.frame;
    //    titleFrame.size.height += titleLabelHeightDelta;
    //    self.des_cription.frame = titleFrame;
    
    [_scroll addSubview:_start_View];

}
-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    [_scroll layoutIfNeeded];
     _scroll.contentSize = CGSizeMake(_scroll.frame.size.width, _start_View.frame.size.height + 10);
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FontAwesome" size:24.0f]
       } forState:UIControlStateNormal];
    
    //    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cross"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
 /*   UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain
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
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer, anotherButton ] animated:NO];*/
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f]}];
    self.navigationItem.title = @"Order Confirmed";
    
    self.navigationItem.hidesBackButton = YES;
}
-(void) backAction
{
//    [self.navigationController popViewControllerAnimated:NO];
     [self performSegueWithIdentifier:@"orderdetailidentifier" sender:self];
}
-(void)Ok_Clicked
{
    [self performSegueWithIdentifier:@"homesegueidentifier" sender:self];

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

@end
