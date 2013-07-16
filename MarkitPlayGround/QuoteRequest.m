//
//  QuoteRequest.m
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import "QuoteRequest.h"

#define URL @"http://dev.markitondemand.com/Api/Quote/jsonp?"
#define FUNCTIONNAME @"myFunction"

@implementation QuoteRequest

- (id)initWithCompany:(Company*)c;{
    self = [super init];
    if (self) {
        self.company = c;
    }
    return self;
}

-(void)makeCallToQuoteRequestSuccess:(void (^)(Quote *quote))successBlock Failure:(void (^)(NSString *error))failureBlock {

    NSString *urlString = [NSString stringWithFormat:@"%@symbol=%@&callback=%@",URL, self.company.symbol,FUNCTIONNAME];
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async(queue, ^{
        NSError *error = nil;
        NSData *data = [[NSData alloc]initWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
        
        NSString *st = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        // NSLog(@"%@", st);
        
        
       // NSLog(@"%@",[st substringWithRange:NSMakeRange(FUNCTIONNAME.length+1, st.length -1 - (FUNCTIONNAME.length+1))]);
        
        st = [st substringWithRange:NSMakeRange(FUNCTIONNAME.length+1, st.length -1 - (FUNCTIONNAME.length+1))];
        
        NSData *JSONData = [st dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *e = nil;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&e];
        
        //NSLog(@"%@",[dict objectForKey:@"Data"]);
      

        if(error != nil ){
                failureBlock([error localizedDescription]);
        
        }else{
            Quote *quote = [[Quote alloc]initWithCompany:self.company andDictionary:[dict objectForKey:@"Data"]];
            

            successBlock(quote );
        }
    });

    
    
}



@end
