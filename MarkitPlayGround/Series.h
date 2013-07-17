//
//  Series.h
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Series : NSObject

@property(nonatomic, strong)NSNumber *min;
@property(nonatomic, strong)NSNumber *max;
@property(nonatomic, strong)NSArray *values;

- (id)initWithDict:(NSDictionary*)dict;

@end
