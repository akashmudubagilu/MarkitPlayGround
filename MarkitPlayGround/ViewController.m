//
//  ViewController.m
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/15/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import "ViewController.h"
#import "LookUpRequest.h"
#import "Company.h"
#import "QuoteViewController.h"
#import "SVProgressHUD.h"


#define tableViewCellReuseIdentifier @"companyTableCell"
#define companyNameLabelTag 100
#define companyExchangeLabelTag 101
#define companySymbolLabelTag 102

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
     self.navigationController.navigationBarHidden = YES;
    self.companyArray = [NSMutableArray array];
    [self.searchField becomeFirstResponder];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  -

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    
    if(self.searchField.text.length > 0 ){
        LookUpRequest *request = [[LookUpRequest alloc]initWithSearchString:self.searchField.text];
        [SVProgressHUD showWithStatus:@"Loading"];

        [request makeCallToLookupRequestSuccess:^(NSMutableArray *array) {
            NSLog(@"%d", [array count]);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.companyArray  = array;

               [self.CompanyDetailsTable reloadData];
                [SVProgressHUD dismiss];

                [self.searchField resignFirstResponder];
            });

            
        } Failure:^(NSString *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert" message: error delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            });

        }];
        
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Enter Search parameter" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
       
    }
    
}
#pragma mark tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%d",[self.companyArray count]);
    return [self.companyArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellReuseIdentifier];
    
    if (!cell){
        cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellReuseIdentifier];
    }
    
    Company * currentCompany = (Company *)[self.companyArray objectAtIndex:indexPath.row];
    
    UILabel *label = nil ;
    label = (UILabel *)[cell.contentView viewWithTag:companyNameLabelTag];
    
    if(!label){
        label = [[UILabel alloc]init];
        label.tag = companyNameLabelTag;
        label.font = [UIFont boldSystemFontOfSize:17];
        label.frame = CGRectMake(5, 0, self.CompanyDetailsTable.frame.size.width - 5, 25);
         [cell.contentView addSubview:label];
    }
    label.text = currentCompany.name;
    
    label = (UILabel *)[cell.contentView viewWithTag:companySymbolLabelTag];
    
    if(!label){
        label = [[UILabel alloc]init];
        label.tag = companySymbolLabelTag;
        label.font = [UIFont systemFontOfSize:12];
        label.frame = CGRectMake(5, 25, self.CompanyDetailsTable.frame.size.width - 5, 15);
         [cell.contentView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"SYMBOL: %@", currentCompany.symbol];
   
    label = (UILabel *)[cell.contentView viewWithTag:companyExchangeLabelTag];
    
    if(!label){
        label = [[UILabel alloc]init];
        label.tag = companyExchangeLabelTag;
        label.font = [UIFont systemFontOfSize:12];
        label.frame = CGRectMake(5, 43, self.CompanyDetailsTable.frame.size.width - 5, 15);
         [cell.contentView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"EXCHANGE: %@", currentCompany.exchange];
    
    return cell;

}



#pragma tableView delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QuoteViewController *vc = [[QuoteViewController alloc]initWithNibName:@"QuoteViewController" bundle:nil];
    
    
    [vc makeCallToGetQuoteWithCompany:[self.companyArray objectAtIndex:indexPath.row]];
    
    vc.title = [(Company *)[self.companyArray objectAtIndex:indexPath.row] symbol];

    [self.navigationController pushViewController:vc animated:YES];
    
   
}


@end
