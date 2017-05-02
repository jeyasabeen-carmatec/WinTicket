//
//  VC_biddingHistory.m
//  WinningTicket
//
//  Created by Test User on 24/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_biddingHistory.h"
#import "bidding_Cell.h"

@interface VC_biddingHistory ()
@property(nonatomic,strong)NSMutableArray *ARR_sec_one;
@end

@implementation VC_biddingHistory

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupVIew];
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

#pragma mark - Uiview Customisation
-(void) setupVIew
{
    NSDate *date= [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    
    [dateFormatter setDateFormat:@"MMM dd, yyyy HH:mm a zzz"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"Current date is %@",dateString);
    _ARR_sec_one=[[NSMutableArray alloc]init];
    
    NSDictionary *temp_dictin;
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"B******7",@"key1",dateString,@"key2",@"-$200.00",@"key3", nil];
    [_ARR_sec_one addObject:temp_dictin];
    
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"B******7",@"key1",dateString,@"key2",@"-$200.00",@"key3", nil];
    [_ARR_sec_one addObject:temp_dictin];
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"B******7 ",@"key1",dateString,@"key2",@"-$200.00",@"key3", nil];
    [_ARR_sec_one addObject:temp_dictin];
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"B******7",@"key1",dateString,@"key2",@"-$200.00",@"key3", nil];
    [_ARR_sec_one addObject:temp_dictin];temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"B******7",@"key1",dateString,@"key2",@"-$200.00",@"key3",nil];
    [_ARR_sec_one addObject:temp_dictin];
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"B******7",@"key1",dateString,@"key2",@"-$200.00",@"key3", nil];
    [_ARR_sec_one addObject:temp_dictin];
    
}

#pragma mark - Uitableview Datasource/Deligate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ARR_sec_one.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    bidding_Cell *bidcell=[tableView dequeueReusableCellWithIdentifier:@"bidcell"];
    NSDictionary *bidcit=[_ARR_sec_one objectAtIndex:indexPath.row];
    bidcell.AC_no.text=[bidcit objectForKey:@"key1"];
    [bidcell.AC_no sizeToFit];
    bidcell.date.text=[bidcit objectForKey:@"key2"];
    [bidcell.date sizeToFit];
    bidcell.date.textColor= [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1.0];
    bidcell.amount.text=[bidcit objectForKey:@"key3"];
    [bidcell.amount sizeToFit];
    if(indexPath.row==0)
    {
        bidcell.amount.textColor=[UIColor colorWithRed:0.00 green:0.63 blue:0.47 alpha:1.0];
    }
    else if(indexPath.row==4)
    {
        bidcell.amount.textColor=[UIColor colorWithRed:0.00 green:0.63 blue:0.47 alpha:1.0];
        
    }
    else
    {
        bidcell.amount.textColor= [UIColor colorWithRed:0.67 green:0.00 blue:0.00 alpha:1.0];
    }
    return  bidcell;
}
//- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
//    [_tbl_bidding reloadData];
//}
- (IBAction)BTN_back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
