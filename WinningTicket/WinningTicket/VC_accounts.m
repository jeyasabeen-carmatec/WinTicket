//
//  VC_accounts.m
//  WinningTicket
//
//  Created by Test User on 02/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_accounts.h"
#import "cellACCOUNTS.h"
#import "DGActivityIndicatorView.h"

@interface VC_accounts ()
{
    NSArray *section1,*section2;
    UIView *VW_overlay;
    DGActivityIndicatorView *activityIndicatorView;
}

@end

@implementation VC_accounts

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup_VIEW];
//    [_TBL_contents reloadData];
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
    VW_overlay = [[UIView alloc]init];
    VW_overlay.frame = [UIScreen mainScreen].bounds;
    //    VW_overlay.center = self.view.center;
    
    [self.view addSubview:VW_overlay];
    VW_overlay.backgroundColor = [UIColor blackColor];
    VW_overlay.alpha = 0.2;
    
    
    
    
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:[UIColor whiteColor]];
    
    CGRect frame_M = activityIndicatorView.frame;
    frame_M.origin.x = 0;
    frame_M.origin.y = 0;
    frame_M.size.width = VW_overlay.frame.size.width;
    frame_M.size.height = VW_overlay.frame.size.height;
    activityIndicatorView.frame = frame_M;
    
    [VW_overlay addSubview:activityIndicatorView];
    //        activityIndicatorView.center=myview.center;
    
    VW_overlay.hidden = YES;
    
    VW_overlay.hidden = NO;
    [activityIndicatorView startAnimating];
    [self performSelector:@selector(myaccount_API_calling) withObject:activityIndicatorView afterDelay:0.01];
}

-(void) setup_VIEW
{
    [_segment_bottom setSelectedSegmentIndex:2];
    [_tab_HOME setSelectedItem:[_tab_HOME.items objectAtIndex:2]];
    for (int i=0; i<[self.segment_bottom.subviews count]; i++)
    {
        [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:nil];
        if (![[self.segment_bottom.subviews objectAtIndex:i]isSelected])
        {
            UIColor *tintcolor=[UIColor clearColor];
            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
        }
        else
        {
            //            UIColor *tintcolor=[UIColor blueColor];
            //            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
        }
    }
    section1 = [[NSArray alloc]initWithObjects:@"Add Funds",@"Donate",@"Withdrawl",@"Transaction History", nil];
    section2 = [[NSArray alloc]initWithObjects:@"Notification Settings",@"How It Works",@"About Us",@"Contact Us",@"Terms of Use",@"Privacy Policy",@"Edit Account Information",@"Change Password",@"Log Out", nil];
}


#pragma mark - Tabbar deligate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([item.title isEqualToString:@"EVENTS"])
    {
        NSLog(@"Events selected");
        [_segment_bottom setSelectedSegmentIndex:0];
        for (int i=0; i<[self.segment_bottom.subviews count]; i++)
        {
            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:nil];
            if (![[self.segment_bottom.subviews objectAtIndex:i]isSelected])
            {
                UIColor *tintcolor=[UIColor clearColor];
                [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
            }
            else
            {
                //            UIColor *tintcolor=[UIColor blueColor];
                //            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
            }
        }
        [self performSegueWithIdentifier:@"event2identifier" sender:self];
    }
    else if ([item.title isEqualToString:@"COURSES"])
    {
        NSLog(@"COURSES selected");
        [_segment_bottom setSelectedSegmentIndex:1];
        for (int i=0; i<[self.segment_bottom.subviews count]; i++)
        {
            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:nil];
            if (![[self.segment_bottom.subviews objectAtIndex:i]isSelected])
            {
                UIColor *tintcolor=[UIColor clearColor];
                [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
            }
            else
            {
                //            UIColor *tintcolor=[UIColor blueColor];
                //            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
            }
        }
        [self performSegueWithIdentifier:@"course2identifier" sender:self];
    }
    else
    {
        NSLog(@"ACCOUNT selected");
        [_segment_bottom setSelectedSegmentIndex:2];
        for (int i=0; i<[self.segment_bottom.subviews count]; i++)
        {
            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:nil];
            if (![[self.segment_bottom.subviews objectAtIndex:i]isSelected])
            {
                UIColor *tintcolor=[UIColor clearColor];
                [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
            }
            else
            {
                //            UIColor *tintcolor=[UIColor blueColor];
                //            [[self.segment_bottom.subviews objectAtIndex:i] setTintColor:tintcolor];
            }
        }
    }
}

#pragma mark - UITableview Datasource/Deligate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [section1 count];
    }
    else
    {
        return [section2 count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    cellACCOUNTS *cell = (cellACCOUNTS *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib;
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"cellACCOUNTS~iPad" owner:self options:nil];
        }
        else
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"cellACCOUNTS" owner:self options:nil];
        }
        cell = [nib objectAtIndex:0];
    }
    
    if (indexPath.section == 0) {
        NSString *icon_name = [NSString stringWithFormat:@"sec0_%ld",(long)indexPath.row];
        cell.img_icon.image = [UIImage imageNamed:icon_name];
        cell.lbl_title.text = [section1 objectAtIndex:indexPath.row];
    }
    else
    {
        NSString *icon_name = [NSString stringWithFormat:@"sec1_%ld",(long)indexPath.row];
        cell.img_icon.image = [UIImage imageNamed:icon_name];
        cell.lbl_title.text = [section2 objectAtIndex:indexPath.row];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    
            view.tintColor = [UIColor clearColor];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 56;
    }
    else
    {
        return 56;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self get_Denominations];
                });
            }
                break;
                
            case 1:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self get_EVENTS];
                });
            }
                
                break;
                
            case 2:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"accounttowithdrawalidentifier" sender:self];
                
                });
            }
                break;
                
            case 3:
            {
                [self transaction_history];
                
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row) {
            case 0:
            {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"accnttonotificationidentifier" sender:self];
                    
                });
            }
                break;
                
            case 1:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"accnttohowitworksidentifier" sender:self];
                    
                });
            }
                break;
                
            case 2:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"accounttoaboutusidentifier" sender:self];
                    
                });
            }
                break;
                
            case 3:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"accounttocontactusIdentifier" sender:self];
                    
                });
            }
                break;
                
            case 4:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"accounttotermsofuseidentifier" sender:self];
                    
                });
            }
                break;
                
            case 5:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"accounttoprivacyidentifier" sender:self];
                    
                });
            }
                break;
                
            case 6:
            {
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"accountstoeditprofileidentifier" sender:self];
                    
                    
                    
                });
            }
                break;
                
            case 7:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"accounttochangepwdidentifier" sender:self];
                    
                });
            }
                break;
                
            case 8:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self performSegueWithIdentifier:@"accounttowelcomescreen" sender:self];
                    VW_overlay.hidden = NO;
                    [activityIndicatorView startAnimating];
                    [self performSelector:@selector(log_OUTAPI) withObject:activityIndicatorView afterDelay:0.01];
                    
                });
            }
                break;
                
            default:
                break;
        }
    }
}
-(void)transaction_history
{
        NSError *error;
        NSHTTPURLResponse *response = nil;
        
        NSString *urlGetuser ;
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
//        if ([UIScreen mainScreen].bounds.size.height > 667)
//        {
//            urlGetuser = [NSString stringWithFormat:@"%@payments/transaction_history",SERVER_URL];
//        }
//        else
//        {
//            urlGetuser =[NSString stringWithFormat:@"%@payments/transaction_history?page=10",SERVER_URL];
//        }
//        }
//       else
//       {
        urlGetuser =[NSString stringWithFormat:@"%@payments/transaction_history",SERVER_URL];
           
//        }
    

        NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
        NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:urlProducts];
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
        [request setHTTPShouldHandleCookies:NO];
        NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (aData)
        {
            
            [activityIndicatorView stopAnimating];
            VW_overlay.hidden = YES;
            [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"transaction_data"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] setObject:urlGetuser forKey:@"URL_SAVED_tran"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            
            //        NSLog(@" THe user data is :%@",[[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"User_data"]);
            [self performSegueWithIdentifier:@"acounttotransactionidentifier" sender:self];
            
            
        }
        else
        {
            [activityIndicatorView stopAnimating];
            VW_overlay.hidden = YES;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Interrupted" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }

}

-(void) get_Denominations
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSString *urlGetuser =[NSString stringWithFormat:@"%@contributors/denominations",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(aData)
    {
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        [[NSUserDefaults standardUserDefaults] setValue:json_DATA forKey:@"denom_collection"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"The response get_Denominations VC Accounts %@",json_DATA);
    }
    [self performSegueWithIdentifier:@"accountstofundsidentifier" sender:self];
}

-(void)get_EVENTS
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser =[NSString stringWithFormat:@"%@contributors/events",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(aData)
    {
        NSMutableDictionary *json_DICTIn = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"oraganisations dictionary is:%@",json_DICTIn);
        [[NSUserDefaults standardUserDefaults] setValue:json_DICTIn forKey:@"eventsStored"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSegueWithIdentifier:@"accountstodateidentifier" sender:self];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Check Connction" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"" , nil];
        [alert show];
    }
}

-(void) log_OUTAPI
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser =[NSString stringWithFormat:@"%@users/sign_out",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(aData)
    {
        NSMutableDictionary *json_DICTIn = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"The log out response %@",json_DICTIn);
    }
    
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
    [self performSegueWithIdentifier:@"accounttowelcomescreen" sender:self];
}

-(void)myaccount_API_calling
{
    NSError *error;
    NSHTTPURLResponse *response = nil;
    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@my_account",SERVER_USR];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"Account_data"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //        NSLog(@" THe user data is :%@",[[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"User_data"]);
        //        [self performSegueWithIdentifier:@"accountstoeditprofileidentifier" sender:self];
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(myprofileapicalling) withObject:activityIndicatorView afterDelay:0.01];
        //        [self myprofileapicalling];
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Interrupted" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
}
-(void)myprofileapicalling
{
    NSData *PFData=[[NSUserDefaults standardUserDefaults]valueForKey:@"Account_data"] ;
    NSError *error;
    if(PFData)
    {
        NSMutableDictionary *account_data=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:PFData options:NSASCIIStringEncoding error:&error];
        NSLog(@"the user data is:%@",account_data);
        
        NSDictionary *temp_dict=[account_data valueForKey:@"user"];
        self.first_name.text=[temp_dict valueForKey:@"first_name"];
        [self.first_name sizeToFit];
        self.last_name.text=[temp_dict valueForKey:@"email"];
        [self.last_name sizeToFit];
        self.amount.text=[NSString stringWithFormat:@"$ %@",[account_data valueForKey:@"wallet"]];
        
    }
    
    

    NSHTTPURLResponse *response = nil;
    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@view_profile",SERVER_USR];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        [[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"User_data"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //        NSLog(@" THe user data is :%@",[[NSUserDefaults standardUserDefaults] setObject:aData forKey:@"User_data"]);
        //        [self performSegueWithIdentifier:@"accountstoeditprofileidentifier" sender:self];
//        [self parse_listEvents_api];
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Interrupted" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
}

@end
