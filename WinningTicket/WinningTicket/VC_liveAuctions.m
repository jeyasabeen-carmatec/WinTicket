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
#import "ViewController.h"

#pragma mark - Image Cache
#import "SDWebImage/UIImageView+WebCache.h"

@interface VC_liveAuctions ()
{
    UIView *VW_overlay;
    UIActivityIndicatorView *activityIndicatorView;
    UIBarButtonItem *anotherButton;
    NSString *titleName;
     NSMutableDictionary *json_DATA;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *liveauction;
@property (weak, nonatomic) IBOutlet UIView *navigation_titlebar;

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
    
    VW_overlay.hidden = NO;
    [activityIndicatorView startAnimating];
    [self performSelector:@selector(API_liveAuctions:) withObject:@"auction/list/" afterDelay:0.01];
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
    
    anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain
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
    
//    _sec_one_ARR = [[NSMutableArray alloc]init];
//    NSDictionary *temp_dictin;
//    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"Jordanspeith Auographed Golf ball with cerficate of authenticity",@"key1",@"US $59.99",@"key2",@"startingbid",@"key3",@"IMG_0002.PNG",@"key4", nil];
//    [_sec_one_ARR addObject:temp_dictin];
//    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"Jordanspeith Auographed Tiltlelist",@"key1",@"US $100.00",@"key2",@"startingbid",@"key3",@"IMG_0003.PNG",@"key4", nil];
//    [_sec_one_ARR addObject:temp_dictin];
//    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"Jordanspeith Auographed Towel From the masters",@"key1",@"US $24.99",@"key2",@"startingbid",@"key3",@"IMG_0004.PNG",@"key4", nil];
//    [_sec_one_ARR addObject:temp_dictin];
//    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"Jordanspeith Auographed Under Armor GolfShoes",@"key1",@"US $15.00",@"key2",@"startingbid",@"key3",@"IMG_0009.PNG",@"key4", nil];
//    [_sec_one_ARR addObject:temp_dictin];temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"TigerWoods Auographed Towel From the masters",@"key1",@"US $24.99",@"key2",@"startingbid",@"key3",@"IMG_0010.PNG",@"key4", nil];
//    [_sec_one_ARR addObject:temp_dictin];
//    temp_dictin = [NSDictionary dictionaryWithObjectsAndKeys:@"TigerWoods Auographed Under Armor GolfShoes",@"key1",@"US $54.50",@"key2",@"startingbid",@"key3",@"IMG_0011.PNG",@"key4", nil];
//    [_sec_one_ARR addObject:temp_dictin];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
//    NSLog(@"the arrayelemts are:%@",_sec_one_ARR);
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
    
    VW_overlay = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    VW_overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    VW_overlay.clipsToBounds = YES;
    //    VW_overlay.layer.cornerRadius = 10.0;
    
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.frame = CGRectMake(0, 0, activityIndicatorView.bounds.size.width, activityIndicatorView.bounds.size.height);
    
    //    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, 200, 22)];
    //    loadingLabel.backgroundColor = [UIColor clearColor];
    //    loadingLabel.textColor = [UIColor whiteColor];
    //    loadingLabel.adjustsFontSizeToFitWidth = YES;
    //    loadingLabel.textAlignment = NSTextAlignmentCenter;
    //    loadingLabel.text = @"Loading...";
    //
    //    [VW_overlay addSubview:loadingLabel];
    activityIndicatorView.center = VW_overlay.center;
    [VW_overlay addSubview:activityIndicatorView];
    VW_overlay.center = self.view.center;
    [self.view addSubview:VW_overlay];
    
    VW_overlay.hidden = YES;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSString *substring = [NSString stringWithString:_search_bar.text];
//    
//    NSArray *arr = [_sec_one_ARR mutableCopy];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF['key1'] CONTAINS %@",substring];
//    
//    _search_arr = [arr filteredArrayUsingPredicate:predicate];
//    NSLog(@"Siegfried %@", _search_arr);
//    
    
//    if(section==0)
//    {
//        return _search_arr.count ;
//    }
//    else
//    {
        return _sec_one_ARR.count;
   // }
    //  return  0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    auction_CellTableViewCell *auc_cell=[tableView dequeueReusableCellWithIdentifier:@"auc_cell"];
//    if(indexPath.section==0)
//    {
        self.cpy_dict=[_sec_one_ARR objectAtIndex:indexPath.row];
        
//        auc_cell.image_display.image =[UIImage imageNamed:[_cpy_dict objectForKey:@"key4"]];
        NSString *url_str = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[_cpy_dict valueForKey:@"item_image"]];
        [auc_cell.image_display sd_setImageWithURL:[NSURL URLWithString:url_str]
                      placeholderImage:[UIImage imageNamed:@"Logo_WT.png"]];
        auc_cell.name_lbl.text = [_cpy_dict objectForKey:@"name"];
        auc_cell.currency_lbl.text = [NSString stringWithFormat:@"US $%.2f",[[_cpy_dict objectForKey:@"starting_bid"] floatValue]];
        auc_cell.bid_Lbl.text= @"Startingbid";//[_cpy_dict objectForKey:@"key3"];
       // return auc_cell;
//        
//    }
//    
//    NSDictionary *remain = [_sec_one_ARR objectAtIndex:indexPath.row];
//    NSString *url_str = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[remain valueForKey:@"item_image"]];
//    [auc_cell.image_display sd_setImageWithURL:[NSURL URLWithString:url_str]
//                              placeholderImage:[UIImage imageNamed:@"Logo_WT.png"]];
//    auc_cell.name_lbl.text = [remain objectForKey:@"name"];
//    auc_cell.currency_lbl.text = [NSString stringWithFormat:@"US $%.2f",[[remain objectForKey:@"starting_bid"] floatValue]];
//    auc_cell.bid_Lbl.text = @"Startingbid";//[remain objectForKey:@"key3"];
    return auc_cell;
}
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    [self.auctiontab reloadData];
//    
//}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
   // titleName = @"";
//    if (section == 0) {
        titleName = [NSString stringWithFormat:@"%lu results For %@",(unsigned long)_sec_one_ARR.count,_search_bar.text];
   // }
//    }else{
//        titleName = @"Items Related To your Search";
//    }
    return  titleName;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"auctionstoitemdetailidentifier" sender:self];
}

#pragma mark - API implementation
-(void) API_liveAuctions :(NSString *)url_STR
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    
//    NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults]valueForKey:@"upcoming_events"] options:NSASCIIStringEncoding error:&error];
//    NSDictionary *Dictin_event = [dict valueForKey:@"event"];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSString *urlGetuser =[NSString stringWithFormat:@"%@%@%@",SERVER_URL,url_STR,@"309"];//[Dictin_event valueForKey:@"id"]
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData) {
        NSMutableDictionary *jsonReponse = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"The response Live auctions %@",jsonReponse);
        
        _sec_one_ARR = [[NSMutableArray alloc] initWithArray:[jsonReponse valueForKey:@"auction_items"]];
        NSLog(@"the arrayelemts are:%@",_sec_one_ARR);
        
        [self.auctiontab reloadData];
    }
    
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
}
#pragma search action

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //    NSString *search_text = _search_bar.text;
  //  search_label.text = @"";//[NSString stringWithFormat:@"%@",search_text];
    
    UITextField *searchBarTextField = [self findTextFieldFromControl:_search_bar];
    [searchBarTextField addTarget:self action:@selector(getSearch_TXT) forControlEvents:UIControlEventEditingChanged];
    
    
    if([searchText length] != 0)
    {
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(searcH_API) withObject:activityIndicatorView afterDelay:0.01];
    }
}

-(void) getSearch_TXT
{
    NSString *str = _search_bar.text;
    NSLog(@"Updated Text working %@",str);
    VW_overlay.hidden = NO;
    [activityIndicatorView startAnimating];
    
    if([str isEqualToString:@""])
    {
        [self performSelector:@selector(API_liveAuctions:) withObject:@"auction/list/" afterDelay:0.01];
        VW_overlay.hidden = YES;
        [activityIndicatorView stopAnimating];
    }
    
    if([str length] != 0)
    {
        [self performSelector:@selector(searcH_API) withObject:activityIndicatorView afterDelay:0.01];
    }
}

- (UITextField *) findTextFieldFromControl:(UIView *) view
{
    for (UIView *subview in view.subviews)
    {
        if ([subview isKindOfClass:[UITextField class]])
        {
            return (UITextField *)subview;
        }
        else if ([subview.subviews count] > 0)
        {
            UIView *view = [self findTextFieldFromControl:subview];
            if (view) {
                return (UITextField *)view;
            }
        }
    }
    return nil;
}

#pragma mark - Search API
-(void) searcH_API
{
    @try {
        
    NSString *auth_TOK = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    NSString *search_char = _search_bar.text;
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser =[NSString stringWithFormat:@"%@auction/list/309?query=%@",SERVER_URL,search_char];
    urlGetuser = [urlGetuser stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_TOK forHTTPHeaderField:@"auth_token"];
    [request setHTTPShouldHandleCookies:NO];
    
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
   
        
        if (aData)
        {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
            [self get_DATA];
        NSLog(@"The response %@",json_DATA);
       
        
        
        if(!json_DATA)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Error" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
        }
        
    
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Error" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
        
    }
    @catch (NSException *exception) {
        [self sessionOUT];
    }
}
#pragma mark - Session OUT
- (void) sessionOUT
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Session out" message:@"In some other device same user logged in. Please login again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
    
    ViewController *tncView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
    [tncView setModalInPopover:YES];
    [tncView setModalPresentationStyle:UIModalPresentationFormSheet];
    [tncView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:tncView animated:YES completion:NULL];
}
-(void)get_DATA
{
    NSMutableArray *temp_ARR = [json_DATA valueForKey:@"referrals"];
    [_sec_one_ARR removeAllObjects];
    [_sec_one_ARR addObjectsFromArray:temp_ARR];
    NSString *str = _search_bar.text;
    titleName = [NSString stringWithFormat:@" %lu Results for' %@ '",(unsigned long)[_sec_one_ARR count],str];
    [_auctiontab reloadData];
}

@end
