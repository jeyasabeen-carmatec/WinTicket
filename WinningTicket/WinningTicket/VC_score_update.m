//
//  VC_score_update.m
//  WinningTicket
//
//  Created by Test User on 16/08/17.
//  Copyright © 2017 Test User. All rights reserved.
//

#import "VC_score_update.h"
#import "VC_score_collection.h"

@interface VC_score_update ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *collection_arr,*collection_dat;
}

@end

@implementation VC_score_update

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
  

    
    collection_arr = [NSArray arrayWithObjects:@"12",@"11",@"10",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1",@"12",@"11",@"10",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1",nil];//
    collection_dat = [NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"Eagle",@"Birdie",@"parrot",@"Bogey",@"DoubleBogey",@"",@"",@"",@"",@"",@"",@"",@"Eagle",@"Birdie",@"parrot",@"Bogey",@"DoubleBogey",@"",nil];//
    
    
    [_num_vw reloadData];
    [self update_frame];
    
   _num_vw.transform = CGAffineTransformMakeRotation(-M_PI);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
    
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VC_score_collection *cell = (VC_score_collection *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.num_label.text = [collection_arr objectAtIndex:indexPath.row];
    cell.des_lbl.text = [collection_dat objectAtIndex:indexPath.row];
    
    
    cell.transform = CGAffineTransformMakeRotation(-M_PI);
    
    
    
     return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return CGSizeMake(self.view.frame.size.width/3 -10 , 120);
        
    }
    else
    {
        return CGSizeMake(self.view.frame.size.width/3 -10 , 80);
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //cell.layer.cornerRadius = cell.contentView.frame.size.width / 2;
    cell.contentView.backgroundColor = _name_vw.backgroundColor;
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  //  cell.layer.cornerRadius = cell.contentView.frame.size.width / 2;
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)BTN_back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)update_frame
{
    [_num_vw layoutIfNeeded];
    float collection_ht =_num_vw.contentSize.height;
    
    
    CGRect myframe;
    
    //NSLog(@"the screen height is: %@",self.view.frame);
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
//    if(collection_ht < _name_vw.frame.origin.y + _name_vw.frame.size.height)
//    {
//        
//        myframe = _num_vw.frame;
//        myframe.origin.y = self.view.frame.size.height - collection_ht ;
//        //_name_vw.frame.origin.y + _name_vw.frame.size.height + 10;
//        myframe.size.height = collection_ht ;// - _name_vw.frame.size.height;
//        _num_vw.frame = myframe;
//          NSLog(@"%@", NSStringFromCGRect(self.num_vw.frame));
//        myframe = _LBL_gross.frame ;
//        myframe.origin.y = _num_vw.frame.origin.y - 30;
//        _LBL_gross.frame = myframe;
//        
//    }
//    else
//    {
    
        float difference = collection_ht - (_num_vw.frame.origin.y + _num_vw.frame.size.height);
            myframe = _num_vw.frame;
            myframe.origin.y = - difference ;
            myframe.size.height = collection_ht;
          _num_vw.frame = myframe;
    
    
        if(myframe.origin.y < (_name_vw.frame.origin.y + _name_vw.frame.size.height))
        {
          
            myframe = _LBL_gross.frame ;
            myframe.origin.y = _name_vw.frame.origin.y+_name_vw.frame.size.height + 10;
            _LBL_gross.frame = myframe;
            myframe = _num_vw.frame;
            myframe.origin.y = _LBL_gross.frame.origin.y + _LBL_gross.frame.size.height + 20;
            myframe.size.height = self.view.frame.size.height - myframe.origin.y; //- (_LBL_gross .frame.origin.y + _name_vw.frame.size.height + _LBL_gross.frame.size.height);
            _num_vw.frame = myframe;

        }
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
       
        myframe = _LBL_gross.frame ;
        myframe.origin.y = _num_vw.frame.origin.y - 50;
        _LBL_gross.frame = myframe;
    }
    else
    {
        myframe = _LBL_gross.frame ;
        myframe.origin.y = _num_vw.frame.origin.y - 30;
        _LBL_gross.frame = myframe;
    }
    
    

        
       
        
    //}
   
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
