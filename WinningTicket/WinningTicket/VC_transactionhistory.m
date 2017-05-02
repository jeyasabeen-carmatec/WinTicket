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
    ARR_contents = [[NSMutableArray alloc] init];
    NSDictionary *temp_Dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"#0003125",@"ticket_number",@"Nov 29, 2016 5:12pm EST",@"date",@"Donation",@"purpose",@"-200.00",@"amount", nil];
    [ARR_contents addObject:temp_Dictin];
    temp_Dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"#0002919",@"ticket_number",@"Nov 29, 2016 11:46am EST",@"date",@"Ticket purchase",@"purpose",@"-60.00",@"amount", nil];
    [ARR_contents addObject:temp_Dictin];
    temp_Dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"#0001561",@"ticket_number",@"Oct 31, 2016 2:27pm EST",@"date",@"Add Funds",@"purpose",@"60.00",@"amount", nil];
    [ARR_contents addObject:temp_Dictin];
    
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
    return [ARR_contents count];
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
    
    NSDictionary *temp_dictin = [ARR_contents objectAtIndex:indexPath.row];
    NSString *ticket_number = [temp_dictin valueForKey:@"ticket_number"];
    NSString *date = [temp_dictin valueForKey:@"date"];
    NSString *purpose = [temp_dictin valueForKey:@"purpose"];
    NSString *amount = [temp_dictin valueForKey:@"amount"];
    
    cell.lbl_ticket_ID.text = ticket_number;
    cell.lbl_datetime.text = date;
    cell.lbl_ticketreson.text = purpose;
    
    
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

@end
