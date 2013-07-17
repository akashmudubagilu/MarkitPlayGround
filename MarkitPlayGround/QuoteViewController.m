//
//  QuoteViewController.m
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import "QuoteViewController.h"
#import "TimeSeriesViewController.h"

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
    
     
  //  [self presentViewController:vc animated:YES completion:^{
        
    //}];
    vc.title = self.quote.company.name;

    [self.navigationController pushViewController:vc animated:YES];
}


-(void)fillUI{
    if (self.quote) {
        self.nameLabel.text = self.quote.company.name;
        self.symbolLabel.text = self.quote.company.symbol;
        self.openLabel.text = self.quote.open;
        self.highLabel.text = self.quote.high;
        self.lowLabel.text = self.quote.low ;
        self.changeLabel.text = self.quote.change;
        self.changePercentageLabel.text = self.quote.changePercentage;
        self.changeYTDLabel.text = self.quote.changeYTD;
        self.changeYTDPercentageLabel.text = self.quote.changePercentageYTD;
        self.lastPriceLabel.text = self.quote.lastPrice ;
        self.marketCapLabel.text = self.quote.marketCap;
        self.volumeLabel.text = self.quote.volume;
    }


}

-(void)makeCallToGetQuoteWithCompany:(Company *)c{
    QuoteRequest *request = [[QuoteRequest alloc]initWithCompany:c];

    [request makeCallToQuoteRequestSuccess:^(Quote *quote) {
        self.quote = quote;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self fillUI];
        });
        
    } Failure:^(NSString *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
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

@end
