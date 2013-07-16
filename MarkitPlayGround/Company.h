//
//  Company.h
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/15/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property(nonatomic, strong) NSString *symbol;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *exchange;

- (id)initWithCompanyDictionary:(NSDictionary *)dict;
@end
