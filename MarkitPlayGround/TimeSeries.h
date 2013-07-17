//
//  TimeSeries.h
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Series.h"

@interface TimeSeries : NSObject

@property(nonatomic, strong)Company *company;
@property(nonatomic, strong)Series *open;
@property(nonatomic, strong)Series *high;
@property(nonatomic, strong)Series *low;
@property(nonatomic, strong)Series *close;
@property(nonatomic, strong)NSArray *seriesLabels;
@property(nonatomic, strong)NSArray *seriesLabelCoordinates;
@property(nonatomic, strong)NSString *seriesDuration;
@property(nonatomic, strong)NSArray *seriesDates;
 

- (id)initWithCompany:(Company *)company andDictionary:(NSDictionary *)dict;

@end
