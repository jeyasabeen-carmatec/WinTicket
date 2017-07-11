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
@property(nonatomic,strong)IBOutlet UILabel *stat_lbl;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *fname;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *lname;
@property (strong, nonatomic) IBOutlet UIView *VW_contentcell;

@property (strong, nonatomic) IBOutlet ACFloatingTextField *email;



@end
