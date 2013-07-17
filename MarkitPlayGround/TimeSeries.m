//
//  TimeSeries.m
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//


#import "TimeSeries.h"

#define seriesKey @"Series"
#define openKey @"open"
#define highKey @"high"
#define lowKey @"low"
#define closeKey @"close"
#define seriesLabelsKey @"SeriesLabels"
#define xKey @"x"
#define textKey @"text"
#define seriesLabelCoordinatesKey @"SeriesLabelCoordinates"
#define seriesDurationKey @"SeriesDuration"
#define seriesDatesKey @"SeriesDates"

@implementation TimeSeries

- (id)initWithCompany:(Company *)company andDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        if ([dict objectForKey:seriesKey]) {
            NSDictionary *allSeries = [dict objectForKey:seriesKey];
            
            if ([allSeries objectForKey:openKey ]) {
                self.open = [[Series alloc]initWithDict:[allSeries objectForKey:openKey]];
            }
            if ([allSeries objectForKey:highKey]) {
                
                self.high = [[Series alloc]initWithDict:[allSeries objectForKey:highKey]];
            }
            if ([allSeries objectForKey:lowKey ]) {
                
                self.low = [[Series alloc]initWithDict:[allSeries objectForKey:lowKey]];
            }
            if ([allSeries objectForKey:closeKey ]) {
                
                self.close = [[Series alloc]initWithDict:[allSeries objectForKey:closeKey]];
            }
            
        }
        if ([dict objectForKey:seriesLabelsKey]) {
            NSDictionary *seriesLabels = [dict objectForKey:seriesLabelsKey];
            if([seriesLabels objectForKey:xKey]){
                NSDictionary *x = [seriesLabels objectForKey:xKey];
                if ([x objectForKey:textKey]) {
                    self.seriesLabels = [x objectForKey:textKey];
                }
            }
        }
        if ([dict objectForKey:seriesLabelCoordinatesKey]) {
            self.seriesLabelCoordinates = [dict objectForKey:seriesLabelCoordinatesKey];
        }
        if ([dict objectForKey:seriesDurationKey]) {
            self.seriesDuration = [dict objectForKey:seriesDurationKey];
        }
        if ([dict objectForKey:seriesDatesKey]) {
            self.seriesDates = [dict objectForKey:seriesDatesKey];
        }
    
}
return self;
}


@end

