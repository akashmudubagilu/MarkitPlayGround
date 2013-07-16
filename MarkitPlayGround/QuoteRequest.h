//
//  QuoteRequest.h
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Quote.h"


@interface QuoteRequest : NSObject

@property(strong, nonatomic)Company *company;


-(void)makeCallToQuoteRequestSuccess:(void (^)(Quote *quote))successBlock Failure:(void (^)(NSString *error))failureBlock ;

- (id)initWithCompany:(Company*)c;
@end
