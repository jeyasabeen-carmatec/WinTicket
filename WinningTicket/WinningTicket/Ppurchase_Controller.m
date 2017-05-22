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
    CGRect content_frame = _content_view.frame;
    content_frame.size.width =_scroll.frame.size.width;
    _content_view.frame = content_frame;
    [self.scroll addSubview:_content_view];
    self.start_View.frame=CGRectMake(0,self.content_view.frame.origin.y-self.navigationController.navigationBar.frame.size.height+20, self.content_view.bounds.size.width,self.navigationController.navigationBar.frame.size.height+20);
    [self.content_view addSubview:self.start_View];
    //    self.main_View.frame=CGRectMake(0, self.content_view.frame.origin.y-self.navigationController.navigationBar.frame.size.height+self.start_View.frame.size.height+80, self.content_view.bounds.size.width, self.navigationController.navigationBar.frame.size.height+40-self.start_View.frame.size.height-40);
    //    [self.content_view addSubview:self.main_View];
    //
    //    self.pur_view.frame=CGRectMake(0, self.content_view.frame.origin.y-self.navigationController.navigationBar.frame.size.height+self.start_View.frame.size.height+80+self.main_View.frame.size.height+260, self.content_view.bounds.size.width,self.navigationController.navigationBar.frame.size.height+40-self.start_View.frame.size.height-40-self.main_View.frame.size.height-40);
    [self.content_view addSubview:self.pur_view];
    
    self.status_Label.text=@"Thank You For Purchase";
    
    self.confirm_mail.text=@"A Confirmation mail Has been Sent to your Mail \n abc@samplemail.comA Confirmation mail Has been Sent to your Mail \n abc@samplemail.com";
    [self.confirm_mail sizeToFit];
    self.order.text=@"Order #JN19369";
    self.order_summary.text=@"Order Summary";
    int  qtynum=2;
    self.qty.text=[NSString stringWithFormat:@"Qty:%d",qtynum];
    NSString *des = @"Make a wish Foundation OF Central Florida's Annual Forthevent";
    NSString *code = @"56A8WQ-Grand Cypress Club";
    NSString *text = [NSString stringWithFormat:@"%@,\n%@",des,code];
    // Define general attributes for the entire text
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName:[UIColor darkGrayColor],
                              NSFontAttributeName: [UIFont fontWithName:@"Gotham-Book" size:17]
                              };
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attribs];
    
    
    UIFont *boldFont = [UIFont fontWithName:@"Gotham-Book" size:17];
    NSRange range = [text rangeOfString:des];
    [attributedText setAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                    NSFontAttributeName:boldFont} range:range];
    
    UIColor *greenColor = [UIColor lightGrayColor];
    NSRange greenTextRange = [text rangeOfString:code];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
    [attributedText setAttributes:@{NSForegroundColorAttributeName:greenColor,NSFontAttributeName:boldFont}
                            range:greenTextRange];
    
    
    self.des_cription.attributedText = attributedText;
    
    [self.des_cription sizeToFit];
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
    
    new_Frame=self.subtotal_vw.frame;
    new_Frame.origin.y=self.pur_view.frame.origin.y+self.pur_view.frame.size.height+30;
    self.subtotal_vw.frame=new_Frame;
    
    new_Frame=self.sec_vw.frame;
    new_Frame.origin.y=self.subtotal_vw.frame.origin.y+self.subtotal_vw.frame.size.height+10;
    self.sec_vw.frame=new_Frame;
    
    new_Frame=self.total_vw.frame;
    new_Frame.origin.y=self.sec_vw.frame.origin.y+self.sec_vw.frame.size.height+10;
    self.total_vw.frame=new_Frame;
    
    
    
    
    //    CGRect titleLabelBounds = self.des_cription.bounds;
    //    titleLabelBounds.size.height = CGFLOAT_MAX;
    //    // Change limitedToNumberOfLines to your preferred limit (0 for no limit)
    //    CGRect minimumTextRect = [self.des_cription textRectForBounds:titleLabelBounds limitedToNumberOfLines:2];
    //
    //    CGFloat titleLabelHeightDelta = minimumTextRect.size.height - self.des_cription.frame.size.height;
    //    CGRect titleFrame = self.des_cription.frame;
    //    titleFrame.size.height += titleLabelHeightDelta;
    //    self.des_cription.frame = titleFrame;

}
-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    [_scroll layoutIfNeeded];
     _scroll.contentSize = CGSizeMake(_scroll.frame.size.width, _total_vw.frame.origin.y+_total_vw.frame.size.height+10);
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
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain
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
    self.navigationItem.title = @"Purchase Tickets";
}
-(void) backAction
{
//    [self.navigationController popViewControllerAnimated:NO];
     [self performSegueWithIdentifier:@"orderdetailidentifier" sender:self];
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
