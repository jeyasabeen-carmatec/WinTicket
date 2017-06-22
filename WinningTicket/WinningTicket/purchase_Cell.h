//
//  purchase_Cell.h
//  winning_ticket_purchaseTicket
//
//  Created by anumolu prakash on 12/04/17.
//  Copyright © 2017 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"

@interface purchase_Cell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *stat_lbl;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *fname;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *lname;
@property (weak, nonatomic) IBOutlet UIView *VW_contentcell;

@property (weak, nonatomic) IBOutlet ACFloatingTextField *email;



@end
