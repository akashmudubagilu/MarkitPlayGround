//
//  QuoteViewController.m
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import "QuoteViewController.h"
#import "TimeSeriesViewController.h"
#import "SVProgressHUD.h"
#define tableViewCellReuseIdentifier @"QuoteTableCell"

@interface QuoteViewController ()

@end

@implementation QuoteViewController

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
    self.navigationController.navigationBarHidden = NO;
    
    UIBarButtonItem *plotButton = [[UIBarButtonItem alloc] initWithTitle:@"Plot" style:UIBarButtonItemStylePlain target:self action:@selector(showPlot:)];
    self.navigationItem.rightBarButtonItem = plotButton;
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    refreshControl.tintColor = [UIColor blackColor];
    self.refreshControl = refreshControl;
    [self.refreshControl addTarget:self action:@selector(getDataAgain) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull to get latest Data"];
    [self.detailsTableView addSubview:self.refreshControl];
  }

-(void)getDataAgain{
    [self makeCallToGetQuoteWithCompany:self.quote.company];
}

-(void)viewWillDisappear:(BOOL)animated{
    [UIView beginAnimations:@"animation" context:nil];
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    [UIView commitAnimations];

}


-(void)showPlot:(id)sender{
    TimeSeriesViewController *vc = [[TimeSeriesViewController alloc]initWithNibName:@"TimeSeriesViewController" bundle:nil];
    [vc makeCallToGetTimeSeriesWithCompany:self.quote.company ];
    vc.title = self.quote.company.name;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)makeCallToGetQuoteWithCompany:(Company *)c{
    QuoteRequest *request = [[QuoteRequest alloc]initWithCompany:c];
    [SVProgressHUD showWithStatus:@"Loading"];
    self.navigationItem.rightBarButtonItem.enabled = NO;

    [request makeCallToQuoteRequestSuccess:^(Quote *quote) {
        self.quote = quote;
        dispatch_async(dispatch_get_main_queue(), ^{
             [SVProgressHUD dismiss];
            [self.refreshControl endRefreshing];
            self.navigationItem.rightBarButtonItem.enabled = YES;

            [self.detailsTableView reloadData];
        });
        
    } Failure:^(NSString *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert" message: error delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];

        });
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellReuseIdentifier];
    
    if (!cell){
        cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellReuseIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
            break;
        default:
            cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
            break;
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = self.quote.company.name;

            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"SYMBOL : %@", self.quote.company.symbol];

            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"Last Price : %@", self.quote.lastPrice];
            
            break;
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"Open : %@", self.quote.open];

            break;
        case 4:
            cell.textLabel.text = [NSString stringWithFormat:@"High : %@", self.quote.high];

            break;
        case 5:
            cell.textLabel.text = [NSString stringWithFormat:@"Low : %@", self.quote.low];

            break;
        case 6:
            cell.textLabel.text = [NSString stringWithFormat:@"Change : %@", self.quote.change];

            break;
        case 7:
            cell.textLabel.text = [NSString stringWithFormat:@"Change %% : %@", self.quote.changePercentage];

            break;
        case 8:
             cell.textLabel.text = [NSString stringWithFormat:@"ChangeYTD : %@", self.quote.changeYTD];
            break;
        case 9:
            cell.textLabel.text = [NSString stringWithFormat:@"ChangeYTD %% : %@", self.quote.changePercentageYTD];
            
            break;
        case 10:
            cell.textLabel.text = [NSString stringWithFormat:@"Market Cap : %@", self.quote.marketCap];

            break;
        case 11:
            cell.textLabel.text = [NSString stringWithFormat:@"Volume : %@", self.quote.volume];

            break;
        case 12:
            
            break;
            
        default:
            break;
    }
    
    
       return cell;
    
}



#pragma mark tableView delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 34;
}



@end
