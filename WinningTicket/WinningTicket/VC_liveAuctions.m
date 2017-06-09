//
//  VC_liveAuctions.m
//  WinningTicket
//
//  Created by Test User on 06/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_liveAuctions.h"
#import <Foundation/Foundation.h>
#import "auction_CellTableViewCell.h"

@interface VC_liveAuctions ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *liveauction;
@property(nonatomic,strong)NSMutableArray *sec_one_ARR;
@property(nonatomic,strong)NSArray *search_arr,*reverse_order;
@property(nonatomic,strong)NSDictionary *cpy_dict;
@property (weak, nonatomic) IBOutlet UISearchBar *search_bar;
@property(nonatomic,weak)IBOutlet UITableView *auctiontab;

@end

@implementation VC_liveAuctions

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup_VIEW];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    self.navigationItem.rightBarButtonItem = nil;
//    self.navigationItem.leftBarButtonItem = nil;
//    self.navigationItem.title = nil;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UIView Customisation
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
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f]}];
    self.navigationItem.title = @"Live Auction";
    
//    UIBarButtonItem *anotherButton1 = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain
//                                                                     target:self action:@selector(more_ACTION)];
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer, anotherButton ] animated:NO];
//    [self.navigationItem setRightBarButtonItems:@[anotherButton1, negativeSpacer]animated:NO];
    
    _sec_one_ARR = [[NSMutableArray alloc]init];
    NSDictionary *temp_dictin;
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"Jordanspeith Auographed Golf ball with cerficate of authenticity",@"key1",@"US $59.99",@"key2",@"startingbid",@"key3",@"IMG_0002.PNG",@"key4", nil];
    [_sec_one_ARR addObject:temp_dictin];
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"Jordanspeith Auographed Tiltlelist",@"key1",@"US $100.00",@"key2",@"startingbid",@"key3",@"IMG_0003.PNG",@"key4", nil];
    [_sec_one_ARR addObject:temp_dictin];
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"Jordanspeith Auographed Towel From the masters",@"key1",@"US $24.99",@"key2",@"startingbid",@"key3",@"IMG_0004.PNG",@"key4", nil];
    [_sec_one_ARR addObject:temp_dictin];
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"Jordanspeith Auographed Under Armor GolfShoes",@"key1",@"US $15.00",@"key2",@"startingbid",@"key3",@"IMG_0009.PNG",@"key4", nil];
    [_sec_one_ARR addObject:temp_dictin];temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"TigerWoods Auographed Towel From the masters",@"key1",@"US $24.99",@"key2",@"startingbid",@"key3",@"IMG_0010.PNG",@"key4", nil];
    [_sec_one_ARR addObject:temp_dictin];
    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"TigerWoods Auographed Under Armor GolfShoes",@"key1",@"US $54.50",@"key2",@"startingbid",@"key3",@"IMG_0011.PNG",@"key4", nil];
    [_sec_one_ARR addObject:temp_dictin];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    NSLog(@"the arrayelemts are:%@",_sec_one_ARR);
    //    NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    //    NSArray *descriptors=[NSArray arrayWithObject: descriptor];
    //   _reverse_order=[_sec_one_ARR sortedArrayUsingDescriptors:descriptors];
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

#pragma mark - Back Action
-(void) backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void) more_ACTION
{
    NSLog(@"More actions tapped");
}

#pragma mark - UITableview Data/deligate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *substring = [NSString stringWithString:_search_bar.text];
    
    NSArray *arr = [_sec_one_ARR mutableCopy];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF['key1'] CONTAINS %@",substring];
    
    _search_arr = [arr filteredArrayUsingPredicate:predicate];
    NSLog(@"Siegfried %@", _search_arr);
    
    
    if(section==0)
    {
        return _search_arr.count ;
    }
    else
    {
        return _sec_one_ARR.count;
    }
    //  return  0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    auction_CellTableViewCell *auc_cell=[tableView dequeueReusableCellWithIdentifier:@"auc_cell"];
    if(indexPath.section==0)
    {
        self.cpy_dict=[_search_arr objectAtIndex:indexPath.row];
        
        auc_cell.image_display.image=[UIImage imageNamed:[_cpy_dict objectForKey:@"key4"]];
        auc_cell.name_lbl.text=[_cpy_dict objectForKey:@"key1"];
        auc_cell.currency_lbl.text=[_cpy_dict objectForKey:@"key2"];
        auc_cell.bid_Lbl.text=[_cpy_dict objectForKey:@"key3"];
        return auc_cell;
        
    }
    
    NSDictionary *remain=[_sec_one_ARR objectAtIndex:indexPath.row];
    auc_cell.image_display.image=[UIImage imageNamed:[remain objectForKey:@"key4"]];
    auc_cell.name_lbl.text=[remain objectForKey:@"key1"];
    auc_cell.currency_lbl.text=[remain objectForKey:@"key2"];
    auc_cell.bid_Lbl.text=[remain objectForKey:@"key3"];
    return auc_cell;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.auctiontab reloadData];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *titleName = @"";
    if (section == 0) {
        titleName = @"";
    }else{
        titleName = @"Items Related To your Search";
    }
    return  titleName;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"auctionstoitemdetailidentifier" sender:self];
}

@end
