//
//  TimeSeriesRequest.h
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeSeries.h"

@interface TimeSeriesRequest : NSObject

@property (nonatomic, strong) Company *company;


- (id)initWithCompany:(Company *)company;

-(void)makeTimeSeriesRequestSuccess:(void (^)(TimeSeries *timeSeries))successBlock failure:(void (^)(NSString *error))failureBLock;

@end
