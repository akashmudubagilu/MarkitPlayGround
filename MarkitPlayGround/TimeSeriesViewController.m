//
//  TimeSeriesViewController.m
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reservedmm.
//

#import "TimeSeriesViewController.h"
#import "SVProgressHUD.h"

@interface TimeSeriesViewController ()

@end

@implementation TimeSeriesViewController

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
    [self reloadData];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;

}


-(void)makeCallToGetTimeSeriesWithCompany:(Company *)c{
    
    TimeSeriesRequest *request = [[TimeSeriesRequest alloc]initWithCompany:c];
    [SVProgressHUD showWithStatus:@"Loading"];

    
    [request makeTimeSeriesRequestSuccess:^(TimeSeries *timeSeries) {
        
       NSLog(@"got time series");
        dispatch_async(dispatch_get_main_queue(), ^{
           // [self createPlot];
            self.timeSeries  = timeSeries;
            [SVProgressHUD dismiss];
            [self reloadData];
            [graph reloadData];

        });
        
        
    } failure:^(NSString *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert" message: error delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        });
        
        
        
    }];

}

-(void)reloadData
{
    if ( !graph ) {
        graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
        CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
        [graph applyTheme:theme];
        graph.paddingTop    = 0.0;
        graph.paddingBottom = 0.0;
        graph.paddingLeft   = 0.0;
        graph.paddingRight  = 0.0;
        
        
        CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] initWithFrame:graph.bounds] ;
        dataSourceLinePlot.identifier = @"high";
        dataSourceLinePlot.plotSymbolMarginForHitDetection = 251.0;
        CPTMutableLineStyle *lineStyle = [dataSourceLinePlot.dataLineStyle mutableCopy] ;
        lineStyle.lineWidth              = 1.5f;
        lineStyle.lineColor              = [CPTColor greenColor];
        dataSourceLinePlot.dataLineStyle = lineStyle;
        
        dataSourceLinePlot.dataSource = self;
        dataSourceLinePlot.delegate = self;
        [graph addPlot:dataSourceLinePlot];
        
        CPTColor *areaColor1       = [CPTColor greenColor];
        CPTGradient *areaGradient1 = [CPTGradient gradientWithBeginningColor:areaColor1 endingColor:[CPTColor clearColor]];
        areaGradient1.angle = -90.0f;
        CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient1];
        //dataSourceLinePlot.areaFill      = areaGradientFill;
        //dataSourceLinePlot.areaBaseValue = [[NSDecimalNumber zero] decimalValue];
        
        CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
        symbolLineStyle.lineColor = [CPTColor blackColor];
        CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
        plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor greenColor]];
        plotSymbol.lineStyle     = symbolLineStyle;
        plotSymbol.size          = CGSizeMake(3.0, 3.0);
        dataSourceLinePlot.plotSymbol = plotSymbol;

        
        // Create a blue plot area
        CPTScatterPlot *boundLinePlot  = [[CPTScatterPlot alloc] init];
        lineStyle = [CPTMutableLineStyle lineStyle];
        lineStyle.miterLimit        = 1.0f;
        lineStyle.lineWidth         = 3.0f;
        lineStyle.lineColor         = [CPTColor redColor];
        boundLinePlot.dataLineStyle = lineStyle;
        boundLinePlot.identifier    = @"low";
        boundLinePlot.dataSource    = self;
     //   [graph addPlot:boundLinePlot];
        
        // Do a blue gradient
        areaColor1       = [CPTColor colorWithComponentRed:0.3 green:0.3 blue:1.0 alpha:0.8];
        areaGradient1 = [CPTGradient gradientWithBeginningColor:areaColor1 endingColor:[CPTColor clearColor]];
        areaGradient1.angle = -90.0f;
        areaGradientFill = [CPTFill fillWithGradient:areaGradient1];
     //   boundLinePlot.areaFill      = areaGradientFill;
      //  boundLinePlot.areaBaseValue = [[NSDecimalNumber zero] decimalValue];
        
        // Add plot symbols
        symbolLineStyle = [CPTMutableLineStyle lineStyle];
        symbolLineStyle.lineColor = [CPTColor blackColor];
        plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
        plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor redColor]];
        plotSymbol.lineStyle     = symbolLineStyle;
        plotSymbol.size          = CGSizeMake(3.0, 3.0);
        boundLinePlot.plotSymbol = plotSymbol;

             
    }
    
    self.graphHost.hostedGraph = graph;
    
    NSDecimalNumber *high   = [NSDecimalNumber zero];
    NSDecimalNumber *low    =[NSDecimalNumber zero];
    NSDecimalNumber *length = [NSDecimalNumber zero];
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    if (self.timeSeries) {
         high   =   [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.timeSeries.high.max]];
        low    =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.timeSeries.high.min]] ;
        length = [high decimalNumberBySubtracting:low];
        

    }
   //[NSDecimalNumber decimalNumberWithDecimal:[self.timeSeries.high.max decimalValue]];
     //  NSLog(@"high = %@, low = %@, length = %@", high, low, length);
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0) length:CPTDecimalFromUnsignedInteger([self.timeSeries.high.values count])];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:[low decimalValue] length:[length decimalValue]];
    // Axes
    
    plotSpace.allowsUserInteraction = YES;
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
    CPTXYAxis *x = axisSet.xAxis;
    x.majorIntervalLength         = CPTDecimalFromDouble(50.0);
    x.orthogonalCoordinateDecimal = [low decimalValue] ;//CPTDecimalFromInteger(0);
    x.minorTicksPerInterval       = 0;
    x.title = @"Time";
    x.titleOffset = 0;
    x.titleLocation = CPTDecimalFromString(@"1.25");
    CPTMutableTextStyle *style = [CPTMutableTextStyle textStyle];
    style.color = [CPTColor whiteColor];
    x.titleTextStyle =      style;
    
    CPTXYAxis *y  = axisSet.yAxis;
    NSDecimal six = CPTDecimalFromInteger(6);
    y.majorIntervalLength         = CPTDecimalDivide([length decimalValue], six);
    y.majorTickLineStyle          = nil;
    y.minorTicksPerInterval       = 4;
    y.minorTickLineStyle          = nil;
    y.orthogonalCoordinateDecimal = CPTDecimalFromInteger(0);
    y.alternatingBandFills        = [NSArray arrayWithObjects:[[CPTColor whiteColor] colorWithAlphaComponent:0.1], [NSNull null], nil];
    x.tickDirection = CPTSignPositive;
    y.tickDirection = CPTSignPositive;
    [graph reloadData];
    
    
    graph.legend                 = [CPTLegend legendWithGraph:graph];
    graph.legend.textStyle       = x.titleTextStyle;
    graph.legend.fill            = [CPTFill fillWithColor:[CPTColor darkGrayColor]];
    graph.legend.borderLineStyle = x.axisLineStyle;
    graph.legend.cornerRadius    = 5.0;
    graph.legend.swatchSize      = CGSizeMake(25.0, 25.0);
    graph.legendAnchor           = CPTRectAnchorBottom;
    graph.legendDisplacement     = CGPointMake(0.0, 12.0);

    
   // [[self navigationItem] setTitle:[dataPuller symbol]];
}
#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
  //  NSLog(@"returned number is %d", [self.timeSeries.high.values count]);
    return [self.timeSeries.high.values count];
}


-(NSUInteger)numberOfRecords
{
    return [self.timeSeries.high.values count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    
    NSDecimalNumber *num = [NSDecimalNumber zero];
    
    if ([(NSString *)plot.identifier isEqualToString:@"high"]) {
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            num = (NSDecimalNumber *)[NSDecimalNumber numberWithInt:index + 1];
        }
        else if ( fieldEnum == CPTScatterPlotFieldY ) {
            NSArray *financialData = self.timeSeries.high.values;
            
            num = [NSDecimalNumber  decimalNumberWithDecimal:[[financialData objectAtIndex:index ] decimalValue] ];
            NSAssert([num isMemberOfClass:[NSDecimalNumber class]], @"grrr");
        }

    }else if ([(NSString *)plot.identifier isEqualToString:@"low"]){
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            num = (NSDecimalNumber *)[NSDecimalNumber numberWithInt:index + 1];
        }
        else if ( fieldEnum == CPTScatterPlotFieldY ) {
            NSArray *financialData = self.timeSeries.low.values;
            
            num = [NSDecimalNumber  decimalNumberWithDecimal:[[financialData objectAtIndex:index ] decimalValue] ];
            NSAssert([num isMemberOfClass:[NSDecimalNumber class]], @"grrr");
        }
        

    
    }
     //   NSLog(@"returned number is %@", num);
    return num;

}

#pragma mark -
#pragma mark Axis Delegate Methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
