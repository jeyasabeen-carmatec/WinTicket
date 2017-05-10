//
//  VC_transactionhistory.m
//  WinningTicket
//
//  Created by Test User on 03/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_transactionhistory.h"
#import "CELL_trans_hstry.h"

@interface VC_transactionhistory ()
{
    NSMutableArray *transaction_history;
    NSMutableArray *ARR_contents;
}

@end

@implementation VC_transactionhistory

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup_VIEW];
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

#pragma mark - View customisation
-(void) setup_VIEW
{
    NSError *error;
   transaction_history=(NSMutableArray *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"transaction_data"] options:NSASCIIStringEncoding error:&error];
    NSLog(@"the user data is:%@",transaction_history);
    ARR_contents = [[NSMutableArray alloc] init];
    NSDictionary *temp_Dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"#0003125",@"ticket_number",@"Nov 29, 2016 5:12pm EST",@"date",@"Donation",@"purpose",@"-200.00",@"amount", nil];
    [ARR_contents addObject:temp_Dictin];
    temp_Dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"#0002919",@"ticket_number",@"Nov 29, 2016 11:46am EST",@"date",@"Ticket purchase",@"purpose",@"-60.00",@"amount", nil];
    [ARR_contents addObject:temp_Dictin];
    temp_Dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"#0001561",@"ticket_number",@"Oct 31, 2016 2:27pm EST",@"date",@"Add Funds",@"purpose",@"60.00",@"amount", nil];
    [ARR_contents addObject:temp_Dictin];
    if(temp_Dictin[@"value"] ==(id)[NSNull null])
    {
        NSLog(@"dict is having null");
    }
    else{
        NSLog(@"Not NUll");
    }

    [_tbl_contents reloadData];
}

#pragma mark - BTN Actions
-(IBAction)BTN_close:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UITableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [transaction_history count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    CELL_trans_hstry *cell = (CELL_trans_hstry *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib;
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"CELL_trans_hstry~iPad" owner:self options:nil];
        }
        else
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"CELL_trans_hstry" owner:self options:nil];
        }
        cell = [nib objectAtIndex:0];
    }
    
//    [NSDictionary dictionaryWithObjectsAndKeys:@"#0003125",@"ticket_number",@"Nov 29, 2016 5:12pm EST",@"date",@"Donation",@"purpose",@"-200.00",@"amount", nil];
    
    NSDictionary *temp_dictin = [transaction_history objectAtIndex:indexPath.row];
    NSString *ticket_number = [NSString stringWithFormat:@"#%@",[temp_dictin valueForKey:@"order_id"]];
    NSString *date = [self getLocalDateTimeFromUTC:[temp_dictin valueForKey:@"created_at"]];
    NSString *purpose = [temp_dictin valueForKey:@"transaction_type"];
    NSString *amount = [NSString stringWithFormat:@"-%@",[temp_dictin valueForKey:@"amount"]];
    
    cell.lbl_ticket_ID.text = ticket_number;
    cell.lbl_datetime.text = date;
    cell.lbl_ticketreson.text = purpose;
    NSString *credit=[temp_dictin valueForKey:@"credit"];
    NSString *debit=[temp_dictin valueForKey:@"debit"];
    if(temp_dictin[@"value" ] !=(id)[NSNull null])
    {
        NSLog(@"dict is having null");
    }
    else{
        NSLog(@"Not NUll");
    }
    
//    if([credit isEqualToString:@"<null>"])
//    {
//        credit=@"No amount";
//    }
//    if([debit isEqualToString:@"<null>"])
//    {
//        debit=@"-you are debited";
//    }
    
    float new_val = [amount floatValue];
    if (new_val < 0) {
        cell.lbl_amount.textColor = [UIColor redColor];
        NSArray *arr = [amount componentsSeparatedByString:@"-"];
        cell.lbl_amount.text = [arr objectAtIndex:1];
        cell.lbl_amount.text = [NSString stringWithFormat:@"-%@$%@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
    else
    {
        cell.lbl_amount.textColor = [UIColor greenColor];
        cell.lbl_amount.text = [NSString stringWithFormat:@"$%@",amount];
    }
    
    cell.preservesSuperviewLayoutMargins = false;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return 116;
    }
    else
    {
        return 95;
    }
}
-(NSString *)getLocalDateTimeFromUTC:(NSString *)strDate
{
    
    NSLog(@"Date Input tbl %@",strDate);
    //
    //    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    //
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    //    NSDate *currentDate = [dateFormatter dateFromString:strDate];
    //
    //    NSLog(@"CurrentDate:%@", currentDate);
    //
    //    NSDateFormatter *newFormat = [[NSDateFormatter alloc] init];
    //    [newFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]]; //MMM dd, yyyy HH:mm a
    //    [newFormat setDateFormat:@"MMM dd, yyyy HH:mm a"];
    //
    //    return [NSString stringWithFormat:@"%@ EST",[newFormat stringFromDate:currentDate]];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"];
    NSDate *currentDate = [dateFormatter dateFromString:strDate];
    NSLog(@"CurrentDate:%@", currentDate);
    NSDateFormatter *newFormat = [[NSDateFormatter alloc] init];
    [newFormat setDateFormat:@"MMM dd, yyyy h:mm a"];
    [newFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
    return [NSString stringWithFormat:@"%@ EST",[newFormat stringFromDate:currentDate]];
}


@end
