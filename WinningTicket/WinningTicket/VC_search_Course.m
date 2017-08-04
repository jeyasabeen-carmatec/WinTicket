//
//  VC_search_Course.m
//  WinningTicket
//
//  Created by Test User on 31/07/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_search_Course.h"
#import "VC_courses.h"

#import "WinningTicket_Universal-Swift.h"

@interface VC_search_Course ()
{
    UIView *VW_overlay;
    UIActivityIndicatorView *activityIndicatorView;
    
    NSArray *ARR_states,*ARR_courses,*ARR_sorted_states,*ARR_sorted_courses;
    UIButton *clearButton_places,*clearButton_courses;
    
}
@end

@implementation VC_search_Course

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setup_VIEW];
    
    /*Text field event listener*/
//    [_TXT_places addTarget:self action:@selector(TXT_Place_change) forControlEvents:UIControlEventEditingChanged];
//    [_TXT_courses addTarget:self action:@selector(TXT_Course_chage) forControlEvents:UIControlEventEditingChanged];
    /*Text field event listener*/
    
    /*Add clear button in text field*/
    clearButton_places = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton_places setImage:[UIImage imageNamed:@"cross_black"] forState:UIControlStateNormal];
    [clearButton_places setFrame:CGRectMake(-10, 0, 20, 20)];
    
    clearButton_places.layer.cornerRadius = 10.0f;
    clearButton_places.layer.masksToBounds = YES;
    clearButton_places.layer.borderWidth = 1.0f;
    clearButton_places.layer.borderColor = [UIColor blackColor].CGColor;
    
    [clearButton_places addTarget:self action:@selector(clearTextField_places) forControlEvents:UIControlEventTouchUpInside];
    
    _TXT_places.rightViewMode = UITextFieldViewModeWhileEditing;
    [_TXT_places setRightView:clearButton_places];
    
    clearButton_courses = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton_courses setImage:[UIImage imageNamed:@"cross_black"] forState:UIControlStateNormal];
    [clearButton_courses setFrame:CGRectMake(-10, 0, 20, 20)];
    
    clearButton_courses.layer.cornerRadius = 10.0f;
    clearButton_courses.layer.masksToBounds = YES;
    clearButton_courses.layer.borderWidth = 1.0f;
    clearButton_courses.layer.borderColor = [UIColor blackColor].CGColor;
    
    [clearButton_courses addTarget:self action:@selector(clearTextField_courses) forControlEvents:UIControlEventTouchUpInside];
    
    _TXT_courses.rightViewMode = UITextFieldViewModeWhileEditing;
    [_TXT_courses setRightView:clearButton_courses];
    /*Add clear button in text field*/
    
    VW_overlay.hidden = NO;
    [activityIndicatorView startAnimating];
    [self performSelector:@selector(API_searchbylocation) withObject:activityIndicatorView afterDelay:0.01];
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

#pragma mark - Uiview customisation
-(void) setup_VIEW
{
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
    
    _TBL_places.estimatedRowHeight = 10.0;
    _TBL_places.rowHeight = UITableViewAutomaticDimension;
    _TBL_places.hidden = YES;
    
    _TBL_courses.estimatedRowHeight = 10.0;
    _TBL_courses.rowHeight = UITableViewAutomaticDimension;
    _TBL_courses.hidden = YES;
    
    _TXT_courses.layer.borderWidth = 1.0f;
    _TXT_courses.layer.borderColor = [UIColor blackColor].CGColor;
    
    _TXT_places.layer.borderWidth = 1.0f;
    _TXT_places.layer.borderColor = [UIColor blackColor].CGColor;
    
    [_BTN_search_course addTarget:self action:@selector(API_search_BTN) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UIbutton Actions
-(IBAction)button_back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) clearTextField_places
{
    NSLog(@"Tap detected");
    [_TXT_places resignFirstResponder];
    _TXT_places.text = @"";
    _TBL_places.hidden = YES;
//    [_TXT_places becomeFirstResponder];
    [_TXT_places resignFirstResponder];
    _TXT_places.text = @"";
    _TBL_places.hidden = YES;
    
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
}
-(void) clearTextField_courses
{
    NSLog(@"Tap detected");
    [_TXT_courses resignFirstResponder];
    _TXT_courses.text = @"";
    _TBL_courses.hidden = YES;
//    [_TXT_courses becomeFirstResponder];
    [_TXT_courses resignFirstResponder];
    _TXT_courses.text = @"";
    _TBL_courses.hidden = YES;
    
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
}
-(void) API_search_BTN
{
    NSString *str_coursename = _TXT_courses.text;
    NSString *str_location = _TXT_places.text;
    
    if (str_coursename.length != 0 && str_location.length !=0)
    {
        NSDictionary *Dictin_temp = [NSDictionary dictionaryWithObjectsAndKeys:str_location,@"places",str_coursename,@"courses", nil];
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(API_search_BTN_act:) withObject:Dictin_temp afterDelay:0.01];
    }
    else if (str_location.length != 0)
    {
        NSDictionary *Dictin_temp = [NSDictionary dictionaryWithObjectsAndKeys:str_location,@"places",@"",@"courses", nil];
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(API_search_BTN_act:) withObject:Dictin_temp afterDelay:0.01];
    }
    else
    {
        NSDictionary *Dictin_temp = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"places",str_coursename,@"courses", nil];
        VW_overlay.hidden = NO;
        [activityIndicatorView startAnimating];
        [self performSelector:@selector(API_search_BTN_act:) withObject:Dictin_temp afterDelay:0.01];
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _TXT_places)
    {
        clearButton_places.hidden = NO;
        if ([string isEqualToString:@""]) {
            NSLog(@"Backspace");
            
            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",_TXT_places.text];
            ARR_sorted_states = [ARR_states filteredArrayUsingPredicate:bPredicate];
            NSLog(@"HERE %@",ARR_sorted_states);
            [_TBL_places reloadData];
            
            return YES;
        }
        else
        {
            [self TXT_Place_change];
            return YES;
        }
    }
    else
    {
        clearButton_courses.hidden = NO;
        if ([string isEqualToString:@""]) {
            NSLog(@"Backspace");
            
            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",_TXT_courses.text];
            ARR_sorted_courses = [ARR_courses filteredArrayUsingPredicate:bPredicate];
            NSLog(@"HERE %@",ARR_sorted_courses);
            [_TBL_courses reloadData];
            
            return YES;
        }
        else
        {
            [self TXT_Course_chage];
            return YES;
        }
    }
    return YES;
}

#pragma mark - Uitextfield event listener
-(void) TXT_Place_change
{
    NSLog(@"Places textvalue is changed %@",_TXT_places.text);
    NSString *STR_temp = [NSString stringWithFormat:@"%@",_TXT_places.text];
    _TBL_courses.hidden = YES;
    
    clearButton_places.hidden = NO;
    
    BOOL isOdd = [STR_temp length] % 2;
    
    if (STR_temp.length == 0)
    {
        ARR_sorted_states = ARR_states;
        [_TBL_places reloadData];
    }
    else if (!isOdd)
    {
        if ([_TXT_courses.text length] == 0)
        {
            NSDictionary *Dictin_temp = [NSDictionary dictionaryWithObjectsAndKeys:_TXT_places.text,@"places",@"",@"courses", nil];
            VW_overlay.hidden = NO;
            [activityIndicatorView startAnimating];
            [self performSelector:@selector(API_autosuggest_location:) withObject:Dictin_temp afterDelay:0.01];
        }
        else
        {
            NSDictionary *Dictin_temp = [NSDictionary dictionaryWithObjectsAndKeys:_TXT_places.text,@"places",_TXT_courses.text,@"courses", nil];
            VW_overlay.hidden = NO;
            [activityIndicatorView startAnimating];
            [self performSelector:@selector(API_autosuggest_location:) withObject:Dictin_temp afterDelay:0.01];
        }
    }
    else
    {
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",_TXT_places.text];
        ARR_sorted_states = [ARR_states filteredArrayUsingPredicate:bPredicate];
        NSLog(@"HERE %@",ARR_sorted_states);
        [_TBL_places reloadData];
    }
    
    _TBL_places.hidden = NO;
}
-(void) TXT_Course_chage
{
    NSLog(@"Course text value change %@",_TXT_courses.text);
    NSString *STR_temp = [NSString stringWithFormat:@"%@",_TXT_courses.text];
    _TBL_places.hidden = YES;
    
    clearButton_courses.hidden = NO;
    
    BOOL isOdd = [STR_temp length] % 2;
    
    if (STR_temp.length == 0)
    {
        ARR_sorted_courses = ARR_courses;
        [_TBL_courses reloadData];
    }
    else if (!isOdd)
    {
        if ([_TXT_places.text length] == 0)
        {
            NSDictionary *Dictin_temp = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"places",_TXT_courses.text,@"courses", nil];
            VW_overlay.hidden = NO;
            [activityIndicatorView startAnimating];
            [self performSelector:@selector(API_autosuggest_course:) withObject:Dictin_temp afterDelay:0.01];
        }
        else
        {
            NSDictionary *Dictin_temp = [NSDictionary dictionaryWithObjectsAndKeys:_TXT_places.text,@"places",_TXT_courses.text,@"courses", nil];
            VW_overlay.hidden = NO;
            [activityIndicatorView startAnimating];
            [self performSelector:@selector(API_autosuggest_course:) withObject:Dictin_temp afterDelay:0.01];
        }
    }
    else
    {
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",_TXT_courses.text];
        ARR_sorted_courses = [ARR_courses filteredArrayUsingPredicate:bPredicate];
        NSLog(@"HERE %@",ARR_sorted_courses);
        [_TBL_courses reloadData];
    }
    _TBL_courses.hidden = NO;
}

#pragma mark - Api calling 
//search_by_location
-(void) API_searchbylocation
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@golfcourse/search_by_location",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setHTTPShouldHandleCookies:NO];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(aData)
    {
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:&error];
        
        @try {
            ARR_states = [json_DATA valueForKey:@"course_locations"];
            ARR_sorted_states = ARR_states;
            [_TBL_places reloadData];
            [self API_searchbycourse];
        } @catch (NSException *exception) {
            NSLog(@"Exception %@",exception);
        }
        
        NSLog(@"States array from VC Search Course= %@",ARR_states);
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
}

//Search by course name
-(void) API_searchbycourse
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@golfcourse/search_by_course_name",SERVER_URL];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setHTTPShouldHandleCookies:NO];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(aData)
    {
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:&error];
        
        @try {
            ARR_courses = [json_DATA valueForKey:@"course_names"];
            ARR_sorted_courses = ARR_courses;
            [_TBL_courses reloadData];
        } @catch (NSException *exception) {
            NSLog(@"Exception %@",exception);
        }
        
        NSLog(@"Course array from VC Search Course= %@",ARR_courses);
    }
}

//Search Auto prediction
-(void) API_autosuggest_location :(NSDictionary *)Dictin_autosuggest
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser;
    NSString *STR_location = [Dictin_autosuggest valueForKey:@"places"];
    NSString *STR_courses = [Dictin_autosuggest valueForKey:@"courses"];
    
    if (![STR_courses isEqualToString:@""] && ![STR_location isEqualToString:@""]) {
        urlGetuser =[NSString stringWithFormat:@"%@golfcourse/search_by_location?coursename=%@&location=%@",SERVER_URL,STR_courses,STR_location];
    }
    else if (![STR_location isEqualToString:@""])
    {
        urlGetuser =[NSString stringWithFormat:@"%@golfcourse/search_by_location?location=%@",SERVER_URL,STR_location];
    }
    else
    {
        urlGetuser =[NSString stringWithFormat:@"%@golfcourse/search_by_location?coursename=%@",SERVER_URL,STR_courses];
    }
    
    urlGetuser = [urlGetuser stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setHTTPShouldHandleCookies:NO];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(aData)
    {
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:&error];
        @try {
            ARR_states = [json_DATA valueForKey:@"course_locations"];
            
            if ([_TXT_places.text length] == 0) {
                ARR_sorted_states = ARR_states;
            }
            else
            {
                NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",_TXT_places.text];
                ARR_sorted_states = [ARR_states filteredArrayUsingPredicate:bPredicate];
            }
            
            if ([ARR_sorted_states count] !=0) {
                _TBL_places.hidden = NO;
                [_TBL_places reloadData];
            }
            else
            {
                _TBL_places.hidden = YES;
            }
            
            
        } @catch (NSException *exception) {
            NSLog(@"Exception %@",exception);
        }
        
//        NSLog(@"Course array from VC Search Course= %@",ARR_courses);
    }
    
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
}

//Search Auto prediction
-(void) API_autosuggest_course :(NSDictionary *)Dictin_autosuggest
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser;
    NSString *STR_location = [Dictin_autosuggest valueForKey:@"places"];
    NSString *STR_courses = [Dictin_autosuggest valueForKey:@"courses"];
    
    if (![STR_location isEqualToString:@""] && ![STR_courses isEqualToString:@""]) {
        urlGetuser =[NSString stringWithFormat:@"%@golfcourse/search_by_course_name?coursename=%@&location=%@",SERVER_URL,STR_courses,STR_location];
    }
    else if (![STR_courses isEqualToString:@""])
    {
        urlGetuser =[NSString stringWithFormat:@"%@golfcourse/search_by_course_name?coursename=%@",SERVER_URL,STR_courses];
    }
    else
    {
        urlGetuser =[NSString stringWithFormat:@"%@golfcourse/search_by_course_name?location=%@",SERVER_URL,STR_location];
    }
    
    urlGetuser = [urlGetuser stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setHTTPShouldHandleCookies:NO];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(aData)
    {
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:&error];
        @try {
            ARR_courses = [json_DATA valueForKey:@"course_names"];
            
            if ([_TXT_courses.text length] == 0) {
                ARR_sorted_courses = ARR_courses;
            }
            else
            {
                NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",_TXT_courses.text];
                ARR_sorted_courses = [ARR_courses filteredArrayUsingPredicate:bPredicate];
            }
            
            if ([ARR_sorted_courses count] != 0) {
                _TBL_courses.hidden = NO;
                [_TBL_courses reloadData];
            }
            else
            {
                _TBL_courses.hidden = YES;
            }
            
        } @catch (NSException *exception) {
            NSLog(@"Exception %@",exception);
        }
        
        //        NSLog(@"Course array from VC Search Course= %@",ARR_courses);
    }
    
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
}

//Search BTN search
-(void) API_search_BTN_act :(NSDictionary *)Dictin_autosuggest
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *urlGetuser;
    NSString *STR_location = [Dictin_autosuggest valueForKey:@"places"];
    NSString *STR_courses = [Dictin_autosuggest valueForKey:@"courses"];
    
    if (![STR_location isEqualToString:@""] && ![STR_courses isEqualToString:@""]) {
        urlGetuser =[NSString stringWithFormat:@"%@golfcourse/search_courses?course_name=%@&location=%@",SERVER_URL,STR_courses,STR_location];
    }
    else if (![STR_location isEqualToString:@""])
    {
        urlGetuser =[NSString stringWithFormat:@"%@golfcourse/search_courses?location=%@",SERVER_URL,STR_location];
    }
    else
    {
        urlGetuser =[NSString stringWithFormat:@"%@golfcourse/search_courses?course_name=%@",SERVER_URL,STR_courses];
    }
    
    urlGetuser = [urlGetuser stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *urlProducts=[NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setHTTPShouldHandleCookies:NO];
    NSString *auth_tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"auth_token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:auth_tok forHTTPHeaderField:@"auth_token"];
    
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(aData)
    {
        NSMutableDictionary *json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:&error];
        
        NSArray *all_courses,*private_course,*public;
    
        @try {
            NSDictionary *all_course_arr = [json_DATA valueForKey:@"courses"];
            all_courses = [all_course_arr valueForKey:@"all"];
            private_course = [all_course_arr valueForKey:@"private"];
            public = [all_course_arr valueForKey:@"public"];
        } @catch (NSException *exception) {
            [self navigate_courses];
        }
        
        
        if ([all_courses count] != 0) {
            [[NSUserDefaults standardUserDefaults] setValue:aData forKey:@"COURSESDICTIN"];
            [[NSUserDefaults standardUserDefaults] setValue:@"SearchVC" forKey:@"SEARCH_STAT"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self navigate_courses];
        }
        else if ([private_course count] != 0)
        {
            [[NSUserDefaults standardUserDefaults] setValue:aData forKey:@"COURSESDICTIN"];
            [[NSUserDefaults standardUserDefaults] setValue:@"SearchVC" forKey:@"SEARCH_STAT"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self navigate_courses];
        }
        else if ([public count] !=0)
        {
            [[NSUserDefaults standardUserDefaults] setValue:aData forKey:@"COURSESDICTIN"];
            [[NSUserDefaults standardUserDefaults] setValue:@"SearchVC" forKey:@"SEARCH_STAT"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self navigate_courses];
        }
        else
        {
            [self navigate_courses];
        }
    }
    else
    {
        [activityIndicatorView stopAnimating];
        VW_overlay.hidden = YES;
    }
}

#pragma mark - Tableview Datasource/Deligate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _TBL_courses) {
        return [ARR_sorted_courses count];
    }
    else
    {
        return [ARR_sorted_states count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    Cell_search *cell = (Cell_search *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib;
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"Cell_search~iPad" owner:self options:nil];
        }
        else
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"Cell_search" owner:self options:nil];
        }
        cell = [nib objectAtIndex:0];
    }
    
    if (tableView == _TBL_courses) {
        cell.lbl_eventName.text = [ARR_sorted_courses objectAtIndex:indexPath.row];
    }
    else
    {
        cell.lbl_eventName.text = [ARR_sorted_states objectAtIndex:indexPath.row];
    }
    cell.lbl_eventName.numberOfLines = 0;
    [cell.lbl_eventName sizeToFit];
    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _TBL_courses) {
        clearButton_courses.hidden = YES;
        NSLog(@"Selected course = %@",[ARR_sorted_courses objectAtIndex:indexPath.row]);
        _TXT_courses.text = [ARR_sorted_courses objectAtIndex:indexPath.row];
        _TBL_courses.hidden = YES;
    }
    else
    {
        clearButton_places.hidden = YES;
        NSLog(@"Selected course = %@",[ARR_sorted_states objectAtIndex:indexPath.row]);
        _TXT_places.text = [ARR_sorted_states objectAtIndex:indexPath.row];
        _TBL_places.hidden = YES;
    }
}

#pragma mark - Uitextfielddeligate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    [textField resignFirstResponder];
    if (textField == _TXT_courses) {
        [_TXT_courses resignFirstResponder];
        _TBL_courses.hidden = YES;
    }
    else
    {
        [_TXT_places resignFirstResponder];
        _TBL_places.hidden = YES;
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _TXT_places) {
        if ([_TXT_courses.text length] == 0) {
            _TBL_places.hidden = NO;
            _TBL_courses.hidden = YES;
            ARR_sorted_states = ARR_states;
            
            if ([ARR_sorted_states count] == 0) {
                VW_overlay.hidden = NO;
                [activityIndicatorView startAnimating];
                [self performSelector:@selector(API_searchbylocation) withObject:activityIndicatorView afterDelay:0.01];
            }
            
            [_TBL_places reloadData];
        }
        else
        {
            NSDictionary *Dictin_temp = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"places",_TXT_courses.text,@"courses", nil];
            VW_overlay.hidden = NO;
            [activityIndicatorView startAnimating];
            [self performSelector:@selector(API_autosuggest_location:) withObject:Dictin_temp afterDelay:0.01];
        }
    }
    else
    {
        if ([_TXT_places.text length] == 0) {
            _TBL_places.hidden = YES;
            _TBL_courses.hidden = NO;
            ARR_sorted_courses = ARR_courses;
            
            if ([ARR_sorted_courses count] == 0) {
                VW_overlay.hidden = NO;
                [activityIndicatorView startAnimating];
                [self performSelector:@selector(API_searchbycourse) withObject:activityIndicatorView afterDelay:0.01];
            }
            [_TBL_courses reloadData];
        }
        else
        {
            NSDictionary *Dictin_temp = [NSDictionary dictionaryWithObjectsAndKeys:_TXT_places.text,@"places",@"",@"courses", nil];
            VW_overlay.hidden = NO;
            [activityIndicatorView startAnimating];
            [self performSelector:@selector(API_autosuggest_course:) withObject:Dictin_temp afterDelay:0.01];
        }
    }
    
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
}

#pragma mark - navigate courses
-(void) navigate_courses
{
    [activityIndicatorView stopAnimating];
    VW_overlay.hidden = YES;
    
    VC_courses *tncView = [self.storyboard instantiateViewControllerWithIdentifier:@"coursesScreen"];
    [tncView setModalInPopover:YES];
    [tncView setModalPresentationStyle:UIModalPresentationFormSheet];
    [tncView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:tncView animated:YES completion:NULL];
}




@end
