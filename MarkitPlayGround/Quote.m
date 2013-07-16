//
//  Quote.m
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import "Quote.h"

#define lastPriceKey @"LastPrice"
#define changeKey @"Change"
#define changePercentageKey @"ChangePercent"
#define timeStampKey @"Timestamp"
#define marketCapKey @"MarketCap"
#define volumeKey @"Volume"
#define changeYTDKey @"ChangeYTD"
#define changeYTDPercentageKey @"ChangePercentYTD"
#define highKey @"High"
#define lowKey @"Low"
#define openKey @"Open"


@implementation Quote

- (id)initWithCompany:(Company*)c andDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        if (c) {
            self.company = c;
        }
        if ([dict objectForKey:lastPriceKey]) {
            self.lastPrice =  [NSString stringWithFormat:@"%@", [dict objectForKey:lastPriceKey]];;
        }else{
            self.lastPrice = lastPriceKey;
        }
        
        if ([dict objectForKey:changeKey]) {
            self.change =   [NSString stringWithFormat:@"%@", [dict objectForKey:changeKey]];
        }else{
            self.change = changeKey;
        }
        
        if ([dict objectForKey:changePercentageKey]) {
            self.changePercentage =   [NSString stringWithFormat:@"%@", [dict objectForKey:changePercentageKey]];
        }else{
            self.changePercentage = changePercentageKey;
        }
        
        if ([dict objectForKey:timeStampKey]) {
            self.timeStamp =   [dict objectForKey:timeStampKey];
        }else{
            self.timeStamp = timeStampKey;
        }
        
        if ([dict objectForKey:marketCapKey]) {
            self.marketCap =   [NSString stringWithFormat:@"%@", [dict objectForKey:marketCapKey]];
        }else{
            self.marketCap = marketCapKey;
        }
        
        if ([dict objectForKey:volumeKey]) {
            self.volume =   [NSString stringWithFormat:@"%@", [dict objectForKey:volumeKey]];
        }else{
            self.volume = volumeKey;
        }
        
        
        if ([dict objectForKey:changeYTDKey]) {
            self.changeYTD =   [NSString stringWithFormat:@"%@", [dict objectForKey:changeYTDKey]];
        }else{
            self.changeYTD = changeYTDKey;
        }
      
        if ([dict objectForKey:changeYTDPercentageKey]) {
            self.changePercentageYTD =   [NSString stringWithFormat:@"%@", [dict objectForKey:changeYTDPercentageKey]];
        }else{
            self.changePercentageYTD = changeYTDPercentageKey;
        }
        
        if ([dict objectForKey:lowKey]) {
            self.low =   [NSString stringWithFormat:@"%@", [dict objectForKey:lowKey]];
        }else{
            self.low = lowKey;
        }
        
        if ([dict objectForKey:highKey]) {
            self.high =   [NSString stringWithFormat:@"%@", [dict objectForKey:highKey]];
        }else{
            self.high = highKey;
        }
        
        
        if ([dict objectForKey:openKey]) {
            self.open =   [NSString stringWithFormat:@"%@", [dict objectForKey:openKey]];
        }else{
            self.open = openKey;
        }
        
    }
    
    return self;
}

@end
