//
//  DSLUtil.m
//  SpaceCat
//
//  Created by shengliang dai on 7/20/14.
//  Copyright (c) 2014 shengliang dai. All rights reserved.
//

#import "DSLUtil.h"

@implementation DSLUtil

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max {
    return arc4random()%(max - min) + min;
}

@end
