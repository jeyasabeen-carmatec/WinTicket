//
//  VC_orderdetail.m
//  WinningTicket
//
//  Created by Test User on 29/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_orderdetail.h"

@interface VC_orderdetail ()

@end

@implementation VC_orderdetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup_VIEW];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    [_scroll_contents setContentSize:CGSizeMake(self.navigationController.navigationBar.frame.size.width, _BTN_liveAUCTN.frame.origin.y + _BTN_liveAUCTN.frame.size.height + 30)];
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"FontAwesome" size:24.0f]
       } forState:UIControlStateNormal];
    
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
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer, anotherButton] animated:NO];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f]}];
    self.navigationItem.title = @"Event Detail";
}

-(void) backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}


-(void) setup_VIEW
{
    [_tab_HOME setSelectedItem:[_tab_HOME.items objectAtIndex:0]];
    [_segment_bottom setSelectedSegmentIndex:0];
    
    CGRect content_frame;
    content_frame = _VW_contents.frame;
    content_frame.size.width = self.navigationController.navigationBar.frame.size.width;
    _VW_contents.frame = content_frame;
    
    [_scroll_contents addSubview:_VW_contents];
    
    [self set_FRAME];
}

-(void) set_FRAME
{
    _lbl_eventname.text = @"Make A Wish Foundation of Central Florida’s 4th Annual Golf Event";
    _lbl_eventname.numberOfLines = 0;
    [_lbl_eventname sizeToFit];
    
    float image_height = _img_event.frame.size.height;
    float lbl_event_name_ht = _lbl_eventname.frame.size.height;
    
    NSString *location = @"Grand Cypress Country Club";
    NSString *address = @"1 N Jacaranda ST, Orlando, FL 32836";
    
    NSString *text = [NSString stringWithFormat:@"%@\n%@",location,address];
    
    text = [text stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not Mentioned"];
    text = [text stringByReplacingOccurrencesOfString:@"(null)" withString:@"Not Mentioned"];
    
    // If attributed text is supported (iOS6+)
    if ([self.lbl_eventdetail respondsToSelector:@selector(setAttributedText:)]) {
        
        // Define general attributes for the entire text
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: self.lbl_eventdetail.textColor,
                                  NSFontAttributeName: self.lbl_eventdetail.font
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:text
                                               attributes:attribs];
        
        // Red text attributes
        //            UIColor *redColor = [UIColor redColor];
        NSRange cmp = [text rangeOfString:location];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]}
                                range:cmp];
        
        
        self.lbl_eventdetail.attributedText = attributedText;
    }
    else
    {
        self.lbl_eventdetail.text = text;
    }
    
    self.lbl_eventdetail.numberOfLines = 0;
    [self.lbl_eventdetail sizeToFit];
    
    float difference;
    
    if (image_height < lbl_event_name_ht)
    {
        difference = lbl_event_name_ht - image_height;
        
        CGRect frame_NN = _VW_dateandtime.frame;
        frame_NN.origin.y = frame_NN.origin.y + difference;
        _VW_dateandtime.frame = frame_NN;
        
        frame_NN = _img_cstmlbl.frame;
        frame_NN.origin.y = _img_cstmlbl.frame.origin.y + difference;
        _img_cstmlbl.frame = frame_NN;
        
        frame_NN = _lbl_code.frame;
        frame_NN.origin.y = _lbl_code.frame.origin.y + difference;
        _lbl_code.frame = frame_NN;
        
        frame_NN = _lbl_location.frame;
        frame_NN.origin.y = _lbl_location.frame.origin.y + difference;
        _lbl_location.frame = frame_NN;
        
        frame_NN = _lbl_eventdetail.frame;
        frame_NN.origin.y = _lbl_eventdetail.frame.origin.y + difference;
        _lbl_eventdetail.frame = frame_NN;
    }
    CGRect frame_HT = _VW_eventcontent.frame;
    frame_HT.size.height = _lbl_eventdetail.frame.origin.y + _lbl_eventdetail.frame.size.height + 20;
    frame_HT.size.width = _scroll_contents.frame.size.width;
    _VW_eventcontent.frame = frame_HT;
    
    frame_HT = _BTN_viewTKT.frame;
    frame_HT.origin.y = _VW_eventcontent.frame.origin.y + _VW_eventcontent.frame.size.height + 40;
    _BTN_viewTKT.frame = frame_HT;
    
    frame_HT = _BTN_giftBAG.frame;
    frame_HT.origin.y = _BTN_viewTKT.frame.origin.y + _BTN_viewTKT.frame.size.height + 10;
    _BTN_giftBAG.frame = frame_HT;
    
    frame_HT = _BTN_liveSCR.frame;
    frame_HT.origin.y = _BTN_giftBAG.frame.origin.y + _BTN_giftBAG.frame.size.height + 10;
    _BTN_liveSCR.frame = frame_HT;
    
    frame_HT = _BTN_liveAUCTN.frame;
    frame_HT.origin.y = _BTN_liveSCR.frame.origin.y + _BTN_liveSCR.frame.size.height + 10;
    _BTN_liveAUCTN.frame = frame_HT;
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
        [self performSegueWithIdentifier:@"ordertocourseidentifier" sender:self];
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
        [self performSegueWithIdentifier:@"orderdetailtoaccountidentifier" sender:self];
    }
}



@end
