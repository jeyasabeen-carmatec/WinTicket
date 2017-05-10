//
//  VC_qty_detail.m
//  WinningTicket
//
//  Created by Test User on 19/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_qty_detail.h"
#import "purchase_Cell.h"

@interface VC_qty_detail ()
{
    int qtynum,t;
}

@end

@implementation VC_qty_detail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup_View];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - button Selectors
-(void) backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void) button_TAPPed
{
    [self performSegueWithIdentifier:@"qtydetailtoplaceorder" sender:self];
}

#pragma mark - Uiview customisation
-(void) setup_View
{
    
//    self.lbl_name_ticket.text=@"Winning Ticket";
    qtynum = [[[NSUserDefaults standardUserDefaults] valueForKey:@"QUANTITY"]intValue];
//    self.lbl_qty.text=[NSString stringWithFormat:@"Qty:%d",qtynum];
    
//    NSString *show = @"Winning Ticket";
//    NSString *place = @"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event";
//    NSString *ticketnumber = @"56A8WQ";
//    NSString *club_name = @"Grand Cypress Country Club";
    
//    NSString *text = [NSString stringWithFormat:@"%@\n%@\n%@ - %@",show,place,ticketnumber,club_name];
    
//    text = [text stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not Mentioned"];
//    text = [text stringByReplacingOccurrencesOfString:@"(null)" withString:@"Not Mentioned"];
    
    // If attributed text is supported (iOS6+)
//    if ([self.lbl_des_cription respondsToSelector:@selector(setAttributedText:)]) {
        
        // Define general attributes for the entire text
//        NSDictionary *attribs = @{
//                                  NSForegroundColorAttributeName: self.lbl_des_cription.textColor,
//                                 NSFontAttributeName: self.lbl_des_cription.font
//                                  };
//        NSMutableAttributedString *attributedText =
//        [[NSMutableAttributedString alloc] initWithString:text
//                                               attributes:attribs];
        
        // Red text attributes
        //            UIColor *redColor = [UIColor redColor];
//        NSRange cmp = [text rangeOfString:show];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
//        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0]}
//                               range:cmp];
        
//        NSRange plce = [text rangeOfString:place];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
//        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]}
//                                range:plce];
        
        
//        self.lbl_des_cription.attributedText = attributedText;
//    }
//    else
//    {
//        self.lbl_des_cription.text = text;
//    }
    
//    _lbl_des_cription.numberOfLines = 0;
//    [_lbl_des_cription sizeToFit];
    
//    CGRect frame_NEW;
    
//    frame_NEW = _VW_line1.frame;
//    frame_NEW.origin.y = _lbl_des_cription.frame.origin.y + _lbl_des_cription.frame.size.height + 10;
//    _VW_line1.frame = frame_NEW;
    
//    frame_NEW = _lbl_sub_total.frame;
//    frame_NEW.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10;
//    _lbl_sub_total.frame = frame_NEW;
    
//    frame_NEW = _lbl_sub_amount.frame;
//    frame_NEW.origin.y = _VW_line1.frame.origin.y + _VW_line1.frame.size.height + 10;
//   _lbl_sub_amount.frame = frame_NEW;
    
//    frame_NEW = _VW_line2.frame;
//    frame_NEW.origin.y = _lbl_sub_total.frame.origin.y + _lbl_sub_total.frame.size.height + 10;
//    _VW_line2.frame = frame_NEW;
    
//    frame_NEW = _lbl_total.frame;
//    frame_NEW.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
//    _lbl_total.frame = frame_NEW;
    
//    frame_NEW = _lbl_total_amount.frame;
//    frame_NEW.origin.y = _VW_line2.frame.origin.y + _VW_line2.frame.size.height + 10;
//    _lbl_total_amount.frame = frame_NEW;
    
//    frame_NEW = _VW_main.frame;
//    frame_NEW.size.height = _lbl_total.frame.origin.y + _VW_line2.frame.size.height + 15;
//    _VW_main.frame = frame_NEW;
    
//    self.VW_main.frame = CGRectMake(0,self.navigationController.navigationBar.frame.size.height + 20,
//                                  self.view.bounds.size.width,_lbl_des_cription.frame.size.height);
//    [self.view addSubview:self.VW_main];
    
//    [self.view addSubview:self.VW_pur];

    
    t = qtynum;
    NSLog(@"the values:%d",t);
    [_tbl_content reloadData];
    
//    float height = self.view.frame.size.height-_VW_main.frame.size.height;
//    self.VW_pur.frame=CGRectMake(0,self.VW_main.frame.size.height+225,self.view.bounds.size.width,height-225);
    
    [_BTN_checkout addTarget:self action:@selector(button_TAPPed) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Uitableview datasource/deligate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return t;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    purchase_Cell *pu_cell=[tableView dequeueReusableCellWithIdentifier:@"pu_cell"];
    pu_cell.VW_contentcell.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    pu_cell.VW_contentcell.layer.borderWidth = 1;
    pu_cell.VW_contentcell.layer.cornerRadius=10;
    pu_cell.VW_contentcell.layer.masksToBounds=YES;
    pu_cell.fname.layer.cornerRadius=5;
    pu_cell.fname.layer.borderWidth = 1;
    
    pu_cell.lname.layer.cornerRadius=5;
    pu_cell.lname.layer.borderWidth = 1;
    
    pu_cell.email.layer.cornerRadius=5;
    pu_cell.email.layer.borderWidth = 1;
    
    
    pu_cell.stat_lbl.text=[NSString stringWithFormat:@"Ticket : %ld",indexPath.row + 1];
    
    
    return pu_cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return  @"Add Recipients";
    
}

#pragma mark - UITextfiel Deligate
- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
    
    purchase_Cell *pu_cell;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        pu_cell = (purchase_Cell *) textField.superview.superview;
        
    } else {
        // Load resources for iOS 7 or later
        pu_cell = (purchase_Cell *) textField.superview.superview.superview;
        // TextField -> UITableVieCellContentView -> (in iOS 7!)ScrollView -> Cell!
    }
    
    NSIndexPath *index_NN = [_tbl_content indexPathForCell:pu_cell];
    NSInteger row = index_NN.row;
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if (row == t-2 || row ==0 || result.height <=1334) {
        [UIView beginAnimations:nil context:NULL];
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            self.view.frame = CGRectMake(0,- 269,self.view.frame.size.width,self.view.frame.size.height);
        }
        else
        {
            self.view.frame = CGRectMake(0,- 212,self.view.frame.size.width,self.view.frame.size.height);
        }
//        self.view.frame = CGRectMake(0,- 212,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }
    [_tbl_content scrollToRowAtIndexPath:[_tbl_content indexPathForCell:pu_cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    purchase_Cell *pu_cell;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        pu_cell = (purchase_Cell *) textField.superview.superview;
        
    } else {
        // Load resources for iOS 7 or later
        pu_cell = (purchase_Cell *) textField.superview.superview.superview;
        // TextField -> UITableVieCellContentView -> (in iOS 7!)ScrollView -> Cell!
    }
    
    NSIndexPath *index_NN = [_tbl_content indexPathForCell:pu_cell];
    NSInteger row = index_NN.row;
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if (row == t-2 || row ==0 || result.height < 1334)
    {
        [UIView beginAnimations:nil context:NULL];
        self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }
}


@end
