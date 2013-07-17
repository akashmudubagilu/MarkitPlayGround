//
//  TimeSeriesViewController.h
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeSeries.h"
#import "TimeSeriesRequest.h"
#import "CorePlot-CocoaTouch.h"


@interface TimeSeriesViewController : UIViewController <CPTPlotDataSource, CPTAxisDelegate>
{
    CPTXYGraph *graph;


}
@property(nonatomic, strong)TimeSeries *timeSeries;
@property (nonatomic, retain) IBOutlet CPTGraphHostingView *graphHost;

-(void)makeCallToGetTimeSeriesWithCompany:(Company *)c;

@end
