//
//  VC_referralDETAIL.m
//  WinningTicket
//
//  Created by Test User on 25/04/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_referralDETAIL.h"
#import "add_referal_detail_cell.h"

@interface VC_referralDETAIL ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *ARR_sec_one;
@property (weak, nonatomic) IBOutlet UITableView *TBL_referal;
@end

@implementation VC_referralDETAIL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
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

#pragma mark - UIView Customisation
-(void) setupView
{
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
    
    
    
    NSString *des = @"Royal Golf Clubs USA";
    NSString *code = @"Sponsor";
    NSString *text = [NSString stringWithFormat:@"%@,\n%@",des,code];
    // Define general attributes for the entire text
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName:[UIColor darkGrayColor],
                              NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:12]
                              };
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attribs];
    
    
    UIFont *boldFont = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    NSRange range = [text rangeOfString:des];
    [attributedText setAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                    NSFontAttributeName:boldFont} range:range];
    
    UIColor *greenColor = [UIColor lightGrayColor];
    NSRange greenTextRange = [text rangeOfString:code];// * Notice that usage of rangeOfString in this case may cause some bugs - I use it here only for demonstration
    [attributedText setAttributes:@{NSForegroundColorAttributeName:greenColor,NSFontAttributeName:boldFont}
                            range:greenTextRange];
    
    self.lbl_title.attributedText = attributedText;
}

#pragma mark - UITableviewDatasource/Deligate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ARR_sec_one.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    add_referal_detail_cell *cell=[tableView dequeueReusableCellWithIdentifier:@"addrefcell" forIndexPath:indexPath];
    NSDictionary *dictdata=[_ARR_sec_one objectAtIndex:indexPath.row];
    
    cell.description_lbl.text = [dictdata objectForKey:@"key1"];
    [cell.description_lbl sizeToFit];
    NSString *list =[dictdata objectForKey:@"key2"];
    NSArray *listItems = [list componentsSeparatedByString:@","];
    NSLog(@"%@",listItems);
    cell.date_time_lbl.text=[NSString stringWithFormat:@"%@\n%@",[listItems objectAtIndex:0],[listItems objectAtIndex:1]];
    
    [cell.date_time_lbl sizeToFit];
    
    
    
    
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
    CGSize labelWidth = CGSizeMake(self.TBL_referal.frame.size.width - 40, CGFLOAT_MAX);
    CGRect textRect = [str boundingRectWithSize:labelWidth options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:15.0]} context:nil];
    int calculatedHeight = textRect.size.height;
    if(calculatedHeight+10<40)
    {
        return 44;
        
    }
    else{
        return calculatedHeight+10;
    }
}

#pragma mark - IBActions
- (IBAction)BTN_back:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
