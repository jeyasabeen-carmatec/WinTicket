//
//  VC_affiliate_HOME.m
//  WinningTicket
//
//  Created by Test User on 19/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_affiliate_HOME.h"

@interface VC_affiliate_HOME ()
@property(nonatomic,strong)NSMutableArray *ARR_sec_one;
@property(nonatomic,strong)NSArray *ARR_search;
@end

@implementation VC_affiliate_HOME

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

#pragma mark - View cutomisation
-(void) setup_VIEW
{
    _search_bar.delegate=self;
    NSDate *date= [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd,HH:MM:SS"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"Current date is %@",dateString);
    _ARR_sec_one=[[NSMutableArray alloc]init];
    
    NSDictionary *temp_dictin;
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"Jordanspeith Auographed Golf ball with cerficate of authenticity   Jordanspeith Auographed Golf ball with cerficate of authenticity Jordanspeith Auographed Golf ball with cerficate of authenticity",@"key1",dateString,@"key2", nil];
    [_ARR_sec_one addObject:temp_dictin];
    
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"Jordanspeith Auographed Tiltlelist",@"key1",dateString,@"key2", nil];
    [_ARR_sec_one addObject:temp_dictin];
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"Jordanspeith Auographed Towel From the masters Jordanspeith Auographed Golf ball with cerficate of authenticity   Jordanspeith Auographed Golf ball with cerficate of authenticity Jordanspeith Auographed Golf ball with cerficate of ",@"key1",dateString,@"key2", nil];
    [_ARR_sec_one addObject:temp_dictin];
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"Jordanspeith Auographed Under Armor GolfShoes",@"key1",dateString,@"key2", nil];
    [_ARR_sec_one addObject:temp_dictin];temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"TigerWoods Auographed Towel From the masters",@"key1",dateString,@"key2",nil];
    [_ARR_sec_one addObject:temp_dictin];
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"TigerWoods Auographed Under Armor GolfShoes",@"key1",dateString,@"key2", nil];
    [_ARR_sec_one addObject:temp_dictin];
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    [numberToolbar sizeToFit];
    
    UIButton *close=[[UIButton alloc]init];
    close.frame=CGRectMake(numberToolbar.frame.size.width - 100, 0, 100, numberToolbar.frame.size.height);
    [close setTitle:@"close" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [numberToolbar addSubview:close];
    _search_bar.inputAccessoryView = numberToolbar;
}

-(void)buttonClick
{
    [self.search_bar resignFirstResponder];
}

#pragma mark - Uitableview Datasource/Deligate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *substring = [NSString stringWithString:_search_bar.text];
    
    NSArray *arr = [_ARR_sec_one mutableCopy];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF['key1'] CONTAINS %@",substring];
    
    _ARR_search = [arr filteredArrayUsingPredicate:predicate];
    
    if(section==0)
    {
        return _ARR_search.count ;
    }
    else
    {
        return _ARR_sec_one.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    referal_cell *cell=[tableView dequeueReusableCellWithIdentifier:@"refcell" forIndexPath:indexPath];
    if(indexPath.section==0)
    {
        NSDictionary *dictdata=[_ARR_search objectAtIndex:indexPath.row];
        
        cell.description_lbl.text = [dictdata objectForKey:@"key1"];
        [cell.description_lbl sizeToFit];
        NSString *list =[dictdata objectForKey:@"key2"];
        NSArray *listItems = [list componentsSeparatedByString:@","];
        NSLog(@"%@",listItems);
        cell.date_time_lbl.text=[NSString stringWithFormat:@"%@\n%@",[listItems objectAtIndex:0],[listItems objectAtIndex:1]];
        
        [cell.BTN_referalDETAIL setTag:indexPath.row];
        [cell.BTN_referalDETAIL addTarget:self action:@selector(BTN_referalDETAIL:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.date_time_lbl sizeToFit];
        
    }
    if(indexPath.section==1)
    {
        NSDictionary *dictdata=[_ARR_sec_one objectAtIndex:indexPath.row];
        
        cell.description_lbl.text = [dictdata objectForKey:@"key1"];
        [cell.description_lbl sizeToFit];
        
        NSString *list =[dictdata objectForKey:@"key2"];
        NSArray *listItems = [list componentsSeparatedByString:@","];
        NSLog(@"%@",listItems);
        cell.date_time_lbl.text=[NSString stringWithFormat:@"%@\n%@",[listItems objectAtIndex:0],[listItems objectAtIndex:1]];
        
        [cell.BTN_referalDETAIL setTag:indexPath.row];
        [cell.BTN_referalDETAIL addTarget:self action:@selector(BTN_referalDETAIL:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.date_time_lbl sizeToFit];
        
    }
    
    if(indexPath.row % 2 == 0){
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        
        
    }else{
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.95 alpha:1.0];
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict=[_ARR_sec_one objectAtIndex:indexPath.row];
    NSString *str = [dict objectForKey:@"key1"];
    CGSize labelWidth;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        labelWidth = CGSizeMake(_tbl_referal.frame.size.width - 140, CGFLOAT_MAX);
    }
    else
    {
        labelWidth = CGSizeMake(_tbl_referal.frame.size.width - 420, CGFLOAT_MAX);
    }
    
    CGRect textRect = [str boundingRectWithSize:labelWidth options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Book" size:19.0]} context:nil];
    int calculatedHeight = textRect.size.height;
    if(calculatedHeight+10 < 75)
    {
        return 75;
    }
    else
    {
        return calculatedHeight;
    }
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *titleName = @"";
    if (section == 0) {
        if(_ARR_search.count==0)
        {
            titleName=@"";
        }else{
            titleName = [NSString stringWithFormat:@"%lu Results for %@",(unsigned long)_ARR_search.count,self.search_bar.text];
        }
    }else{
        titleName = @"Items Related To your Search";
    }
    return  titleName;
    
}

#pragma mark - Uisearch bar

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [_tbl_referal reloadData];
}

#pragma mark - IBActions
- (IBAction)BTN_editReferrel:(id)sender
{
    [self performSegueWithIdentifier:@"afiliatehmetoedtreferlidentifier" sender:self];
}

- (IBAction)BTN_addReferrel:(id)sender
{
    [self performSegueWithIdentifier:@"afilhometoadrefidentifier" sender:self];
}
- (IBAction)BTN_filter:(id)sender
{
    NSLog(@"BTNFilter");
}

#pragma mark - Button Action
-(void) BTN_referalDETAIL : (UIButton *) sender
{
    NSIndexPath *buttonIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    NSLog(@"From Delete Skill %ld",(long)buttonIndexPath.row);
    
    NSString *index_str = [NSString stringWithFormat:@"%ld",(long)buttonIndexPath.row];
    
    NSLog(@"Index path of All Event %@",index_str);
    
    [self performSegueWithIdentifier:@"affliatehmetorefdetailidentifier" sender:self];
}

@end
