//
//  Series.m
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/16/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import "Series.h"
#define minKey @"min"
#define maxKey @"max"
#define valuesKey @"values"


@implementation Series
- (id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        
        if ([dict objectForKey:minKey]) {
            self.min =   [dict objectForKey:minKey];
        }else{
            self.min = @0;
        }
        
        if ([dict objectForKey:maxKey]) {
            self.max =   [dict objectForKey:maxKey];
        }else{
            self.max = @0;
        }
        if ([dict objectForKey:valuesKey]) {
            self.values =   [dict objectForKey:valuesKey];
        }else{
            self.values = [NSArray array];
        }
    }
    return self;
}
@end
