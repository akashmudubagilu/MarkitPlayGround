//
//  Quote.h
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"

@interface Quote : NSObject

@property(nonatomic, strong) Company *company;
@property(nonatomic, strong) NSString *lastPrice;
@property(nonatomic, strong) NSString *change;
@property(nonatomic, strong) NSString *changePercentage;
@property(nonatomic, strong) NSString *timeStamp;
@property(nonatomic, strong) NSString *marketCap;
@property(nonatomic, strong) NSString *volume;
@property(nonatomic, strong) NSString *changeYTD;
@property(nonatomic, strong) NSString *changePercentageYTD;
@property(nonatomic, strong) NSString *high;
@property(nonatomic, strong) NSString *low;
@property(nonatomic, strong) NSString *open;


- (id)initWithCompany:(Company*)c andDictionary:(NSDictionary*)dict;

@end
