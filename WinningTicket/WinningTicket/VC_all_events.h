//
//  VC_all_events.h
//  WinningTicket
//
//  Created by Test User on 22/03/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_all_events : UIViewController <UITabBarDelegate,UISearchBarDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITabBar *tab_HOME;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment_bottom;

@property (weak, nonatomic) IBOutlet UISearchBar *search_BAR;
@property (weak, nonatomic) IBOutlet UIView *VW_nav_TOP;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Serch_char;
@property (weak, nonatomic) IBOutlet UIView *VW_line;

@property (weak, nonatomic) IBOutlet UIView *VW_filter;
@property (weak, nonatomic) IBOutlet UIView *VW_event_titl;
@property (weak, nonatomic) IBOutlet UIView *tbl_eventlst;

@property (weak, nonatomic) IBOutlet UIButton *BTN_choose;
@property (weak, nonatomic) IBOutlet UIButton *BTN_fromDATE;
@property (weak, nonatomic) IBOutlet UIButton *BTN_toDATE;

@property (weak, nonatomic) IBOutlet UITextField *TXT_state;
@property (weak, nonatomic) IBOutlet UITextField *TXT_fromdate;
@property (weak, nonatomic) IBOutlet UITextField *TXT_todate;

@property (weak, nonatomic) IBOutlet UIPickerView *picker_STATE;
@property (weak, nonatomic) IBOutlet UIDatePicker *picker_DATE;

@property (weak, nonatomic) IBOutlet UIToolbar *tool_STATE;
@property (weak, nonatomic) IBOutlet UIToolbar *tool_DATE;

@end
