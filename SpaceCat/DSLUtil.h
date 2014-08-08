//
//  DSLUtil.h
//  SpaceCat
//
//  Created by shengliang dai on 7/20/14.
//  Copyright (c) 2014 shengliang dai. All rights reserved.
//

#import <Foundation/Foundation.h>
static const int DSLProjectileSpeed = 400;
static const int DSLSpaceDogMinSpeed = -100;
static const int DSLSpaceDogMaxSpeed = -50;
typedef NS_OPTIONS(uint32_t, DSLCollisionCategory) {
    DSLCollisionCategoryEnemy = 1 << 0,         //0001
    DSLCollisionCategoryProjectile = 1 << 1,    //0010
    DSLCollisionCategoryDebris = 1 << 2,        //0100
    DSLCollisionCategoryGround = 1 << 3         //1000
};

@interface DSLUtil : NSObject

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;
@end
