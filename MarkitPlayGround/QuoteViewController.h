//
//  QuoteViewController.h
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuoteRequest.h"
#import "Quote.h"

@interface QuoteViewController : UIViewController


@property(nonatomic, strong)Quote *quote;
@property(nonatomic, strong)UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;

-(void)makeCallToGetQuoteWithCompany:(Company *)c;
@end
