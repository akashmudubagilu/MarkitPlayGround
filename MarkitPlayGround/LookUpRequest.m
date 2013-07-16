//
//  LookUpRequest.m
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/15/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import "LookUpRequest.h"
#import "Company.h"

#define URL @"http://dev.markitondemand.com/Api/Lookup/jsonp?"
#define FUNCTIONNAME @"myFunction"

@implementation LookUpRequest

- (id)initWithSearchString:(NSString *)st
{
    self = [super init];
    if (self) {
        self.searchString = st;
    }
    return self;
}

-(void)makeCallToLookupRequestSuccess:(void (^)(NSMutableArray *array))successBlock Failure:(void (^)(NSString *error))failureBlock {

    NSString *urlString = [NSString stringWithFormat:@"%@input=%@&callback=%@",URL, self.searchString,FUNCTIONNAME];
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async(queue, ^{
        NSError *error = nil;
        NSData *data = [[NSData alloc]initWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
        
        NSString *st = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
       // NSLog(@"%@", st);
        
        
//NSLog(@"%@",[st substringWithRange:NSMakeRange(FUNCTIONNAME.length+1, st.length -1 - (FUNCTIONNAME.length+1))]);
        
        st = [st substringWithRange:NSMakeRange(FUNCTIONNAME.length+1, st.length -1 - (FUNCTIONNAME.length+1))];
        
        NSData *JSONData = [st dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *e = nil;

        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&e];

       // NSLog(@"%@", array);
        NSMutableArray *companyArray = [NSMutableArray array];
        Company *tempCompany;
        for (id company  in array) {
            tempCompany = [[Company alloc]initWithCompanyDictionary:company];
            [companyArray addObject:tempCompany];
        }
        
        
        
        if(error != nil || [companyArray count]== 0){
            NSLog(@"its zero0");
            if ([companyArray count]== 0){
                
                failureBlock(@"Company not found");

            }else{
                failureBlock([error localizedDescription]);
            }
         }else{
            successBlock(companyArray );
        }
    });

    
    

}


@end
