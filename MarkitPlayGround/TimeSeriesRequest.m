//
//  TimeSeriesRequest.m
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import "TimeSeriesRequest.h"

#define URL @"http://dev.markitondemand.com/Api/Timeseries/jsonp?"
#define FUNCTIONNAME @"myFunction"
#define SYMBOLPARAMETER @"symbol"


@implementation TimeSeriesRequest

- (id)initWithCompany:(Company *)company
{
    self = [super init];
    if (self) {
        self.company = company;
    }
    return self;
}

-(void)makeTimeSeriesRequestSuccess:(void (^)(TimeSeries *timeSeries))successBlock failure:(void (^)(NSString *error))failureBlock{
    NSString *urlString = [NSString stringWithFormat:@"%@%@=%@&callback=%@",URL,SYMBOLPARAMETER, self.company.symbol,FUNCTIONNAME];
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async(queue, ^{
        NSError *error = nil;
        NSData *data = [[NSData alloc]initWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
        if (error) {
            failureBlock([error localizedDescription ]);

        }else{
            NSString *st = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"%@",st);
            
          //  NSLog(@"%@",[st substringWithRange:NSMakeRange(FUNCTIONNAME.length+1, st.length -1 - (FUNCTIONNAME.length+1))]);
            
            st = [st substringWithRange:NSMakeRange(FUNCTIONNAME.length+1, st.length -1 - (FUNCTIONNAME.length+1))];
            
            NSData *JSONData = [st dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *e = nil;
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&e];
            
            
            
            if(error != nil || ![dict objectForKey:@"Matches"]){
                if (![dict objectForKey:@"Matches"]) {
                    failureBlock(@"Data doesnt match");
                    
                }else{
                    failureBlock([error localizedDescription ]);
                }
                
            }else{
                TimeSeries *timeSeries = [[TimeSeries alloc]initWithCompany:self.company andDictionary:[dict objectForKey:@"Data"]];
                successBlock(timeSeries );
            }
        }
        
    });
    
    
}


@end
