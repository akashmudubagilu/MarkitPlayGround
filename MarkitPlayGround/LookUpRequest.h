//
//  LookUpRequest.h
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/15/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LookUpRequest : NSObject

@property (nonatomic, strong)    NSString *searchString;

- (id)initWithSearchString:(NSString *)st;

-(void)makeCallToLookupRequestSuccess:(void (^)(NSMutableArray *array))successBlock Failure:(void (^)(NSString *error))failureBlock ;



@end
