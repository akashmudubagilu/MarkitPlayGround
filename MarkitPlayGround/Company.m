//
//  Company.m
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/15/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import "Company.h"

#define exchangeKey @"Exchange"
#define nameKey @"Name"
#define symbolKey @"Symbol"

@implementation Company

- (id)initWithCompanyDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        if ([dict objectForKey:exchangeKey]) {
            self.exchange =   [dict objectForKey:exchangeKey];
        }else{
            self.exchange = exchangeKey;
        }
        if ([dict objectForKey:nameKey]) {
            self.name =   [dict objectForKey:nameKey];
        }else{
            self.name = nameKey;
        }
        if ([dict objectForKey:symbolKey]) {
            self.symbol =   [dict objectForKey:symbolKey];
        }else{
            self.symbol = symbolKey;
        }
    }
    return self;
}

@end
