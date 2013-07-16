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

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *symbolLabel;
@property (weak, nonatomic) IBOutlet UILabel *openLabel;
@property (weak, nonatomic) IBOutlet UILabel *highLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeLabel;
@property (weak, nonatomic) IBOutlet UILabel *changePercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeYTDLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeYTDPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketCapLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;

-(void)makeCallToGetQuoteWithCompany:(Company *)c;
@end
