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
    int t;
    CGRect main_Frame;
    NSMutableArray *userDetails;
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
    NSLog(@"BTN checkout tapped Current values are %@",userDetails);
    
    int i;
    
    purchase_Cell *pu_cell = [[purchase_Cell alloc]init];
    for(i = 0; i < userDetails.count; i++)
        {
           NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
           dict = [userDetails objectAtIndex:i];
            
            NSString *email = [dict objectForKey:@"email"];
            
            if([[dict objectForKey:@"first_name"] isEqual:@""])
                {
                   NSLog(@"emailnull index %i",i);
                   NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                   NSLog(@"path  = %@",path);
                   pu_cell = [self.tbl_content cellForRowAtIndexPath:path];
                   [pu_cell.fname becomeFirstResponder];
                   break;
                 }

            if([[dict objectForKey:@"last_name"] isEqual:@""])
            {
                NSLog(@"first_namenull index %i",i);
                NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                NSLog(@"path  = %@",path);
                pu_cell = [self.tbl_content cellForRowAtIndexPath:path];
                [pu_cell.lname becomeFirstResponder];
                break;
            }
            if([[dict objectForKey:@"email"] isEqual:@""])
             {
                 NSLog(@"last_namenull index %i",i);
                 NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                 NSLog(@"path  = %@",path);
                 pu_cell = [self.tbl_content cellForRowAtIndexPath:path];
                 [pu_cell.email becomeFirstResponder];
                 break;
              }
            if (email.length !=0) {
                    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
                    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
                    
                    if ([emailTest evaluateWithObject:email] == NO)
                    {
                        NSLog(@"last_namenull index %i",i);
                        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                        NSLog(@"path  = %@",path);
                        pu_cell = [self.tbl_content cellForRowAtIndexPath:path];
                        [pu_cell.email becomeFirstResponder];
                        break;
                    }
            }
    }
//
    
    if (i == userDetails.count) {
        [self qty_detailPage];
    }
    
    
}

-(void) qty_detailPage
{
    NSError *error;
    NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"QUANTITY"] options:NSASCIIStringEncoding error:&error];
    
    
    NSError *err;
    NSHTTPURLResponse *response = nil;
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
        
        if ([[dict valueForKey:@"message"] isEqualToString:@"Recipient(s) created/updated successfully."]) {
            [self performSegueWithIdentifier:@"qtydetailtoplaceorder" sender:self];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}


#pragma mark - Uiview customisation
-(void) setup_View
{
    [_scroll_TBL addSubview:_tbl_content];

    NSError *error;
    NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"QUANTITY"] options:NSASCIIStringEncoding error:&error];
    
    NSLog(@"The value stored is %@",dict);
    t = [[dict valueForKey:@"quantity"] intValue];
    
    [[NSUserDefaults standardUserDefaults] setValue:[dict valueForKey:@"quantity"] forKey:@"QTY"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    userDetails = [[NSMutableArray alloc] init];
    if (t-1 != 0)
    {
        for(int i=0; i < t-1; i++)
        {
            NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: @"", @"first_name", @"", @"last_name",@"", @"email", nil];
            [userDetails addObject:userDictionary];
        }
    }
    
    [_tbl_content reloadData];
    main_Frame = _scroll_TBL.frame;
    _tbl_content.scrollEnabled = NO;
    [_BTN_checkout addTarget:self action:@selector(button_TAPPed) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Uitableview datasource/deligate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return t-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    purchase_Cell *pu_cell = (purchase_Cell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (pu_cell == nil)
    {
        NSArray *nib;
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"purchase_Cell~iPad" owner:self options:nil];
        }
        else
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"purchase_Cell" owner:self options:nil];
        }
        pu_cell = [nib objectAtIndex:0];
    }
    
    pu_cell.VW_contentcell.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    pu_cell.VW_contentcell.layer.borderWidth = 1;
    pu_cell.VW_contentcell.layer.cornerRadius=10;
    pu_cell.VW_contentcell.layer.masksToBounds=YES;
    
    NSDictionary *temp_dictin = [userDetails objectAtIndex:indexPath.row];
    
    pu_cell.fname.layer.cornerRadius=5;
    pu_cell.fname.layer.borderWidth = 1;
    pu_cell.fname.tag = 1;
    pu_cell.fname.text = [temp_dictin valueForKey:@"first_name"];
    
    pu_cell.fname.delegate = self;
    [pu_cell.fname setTag:indexPath.row];
    [pu_cell.fname addTarget:self action:@selector(TXT_Fname:) forControlEvents:UIControlEventEditingChanged];
    
    pu_cell.lname.layer.cornerRadius=5;
    pu_cell.lname.layer.borderWidth = 1;
    pu_cell.lname.text = [temp_dictin valueForKey:@"last_name"];
    
    pu_cell.lname.delegate = self;
    [pu_cell.lname setTag:indexPath.row];
    [pu_cell.lname addTarget:self action:@selector(TXT_Lname:) forControlEvents:UIControlEventEditingChanged];
    
    pu_cell.email.layer.cornerRadius=5;
    pu_cell.email.layer.borderWidth = 1;
    pu_cell.email.text = [temp_dictin valueForKey:@"email"];
    
    pu_cell.email.delegate = self;
    [pu_cell.email setTag:indexPath.row];
    [pu_cell.email addTarget:self action:@selector(TXT_Email:) forControlEvents:UIControlEventEditingChanged];
    
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
    if (row == t - 2 && row != 0)
    {
        [UIView beginAnimations:nil context:NULL];
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            float new_Y = _tbl_content.frame.origin.y;
            if (new_Y < 0)
            {
                _scroll_TBL.frame = CGRectMake(_scroll_TBL.frame.origin.x, _scroll_TBL.frame.origin.y + 310,_scroll_TBL.frame.size.width,self.view.frame.size.height);
            }
            
            _scroll_TBL.frame = CGRectMake(_scroll_TBL.frame.origin.x, _scroll_TBL.frame.origin.y - 310,_scroll_TBL.frame.size.width,self.view.frame.size.height);
        }
        else
        {
            float new_Y = _scroll_TBL.frame.origin.y;
            if (new_Y < 0)
            {
                _scroll_TBL.frame = CGRectMake(_scroll_TBL.frame.origin.x, _scroll_TBL.frame.origin.y + 310,_scroll_TBL.frame.size.width,self.view.frame.size.height);
            }
            _scroll_TBL.frame = CGRectMake(_scroll_TBL.frame.origin.x, _scroll_TBL.frame.origin.y - 250,_tbl_content.frame.size.width,self.view.frame.size.height);
        }
        [UIView commitAnimations];
    }
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
    if (row == t - 2 && row != 0)
    {
        _scroll_TBL.frame = main_Frame;
        [UIView commitAnimations];
    }
}

-(void) TXT_Fname : (UITextField *) sender
{
    NSIndexPath *buttonIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    purchase_Cell *pu_cell;
    pu_cell = [self.tbl_content cellForRowAtIndexPath:buttonIndexPath];
    
    NSString *store_TXT = [NSString stringWithFormat:@"%@",pu_cell.fname.text];
    
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
    NSDictionary *oldDict = (NSDictionary *)[userDetails objectAtIndex:buttonIndexPath.row];
    [newDict addEntriesFromDictionary:oldDict];
    [newDict setObject:store_TXT forKey:@"first_name"];
    [userDetails replaceObjectAtIndex:buttonIndexPath.row withObject:newDict];
    
    [newDict release];
}
-(void) TXT_Lname : (UITextField *) sender
{
    NSIndexPath *buttonIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    purchase_Cell *pu_cell;
    pu_cell = [self.tbl_content cellForRowAtIndexPath:buttonIndexPath];
    
    NSString *store_TXT = [NSString stringWithFormat:@"%@",pu_cell.lname.text];
    
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
    NSDictionary *oldDict = (NSDictionary *)[userDetails objectAtIndex:buttonIndexPath.row];
    [newDict addEntriesFromDictionary:oldDict];
    [newDict setObject:store_TXT forKey:@"last_name"];
    [userDetails replaceObjectAtIndex:buttonIndexPath.row withObject:newDict];
    
    [newDict release];
}
-(void) TXT_Email : (UITextField *) sender
{
    NSIndexPath *buttonIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    purchase_Cell *pu_cell;
    pu_cell = [self.tbl_content cellForRowAtIndexPath:buttonIndexPath];
    
    NSString *store_TXT = [NSString stringWithFormat:@"%@",pu_cell.email.text];
    
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
    NSDictionary *oldDict = (NSDictionary *)[userDetails objectAtIndex:buttonIndexPath.row];
    [newDict addEntriesFromDictionary:oldDict];
    [newDict setObject:store_TXT forKey:@"email"];
    [userDetails replaceObjectAtIndex:buttonIndexPath.row withObject:newDict];
    
    [newDict release];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_TBL layoutIfNeeded];
    CGRect frame_NN = _tbl_content.frame;
    frame_NN.size.height = [_tbl_content contentSize].height;
    _tbl_content.frame = frame_NN;
    _scroll_TBL.contentSize = CGSizeMake(_scroll_TBL.frame.size.width, [_tbl_content contentSize].height);
}


@end
