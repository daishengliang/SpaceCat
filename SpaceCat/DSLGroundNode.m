//
//  DSLGroundNode.m
//  SpaceCat
//
//  Created by shengliang dai on 7/20/14.
//  Copyright (c) 2014 shengliang dai. All rights reserved.
//

#import "DSLGroundNode.h"
#import "DSLUtil.h"
@implementation DSLGroundNode

+ (instancetype) groundWithSize:(CGSize)size {
    DSLGroundNode *ground = [self spriteNodeWithColor:[SKColor greenColor] size:size];
    ground.name = @"Gound";
    ground.position = CGPointMake(size.width/2, size.height/2);
    [ground setUpPhysicBody];
    return  ground;
}

- (void) setUpPhysicBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = DSLCollisionCategoryGround;
    self.physicsBody.collisionBitMask = DSLCollisionCategoryDebris;
    self.physicsBody.contactTestBitMask = DSLCollisionCategoryEnemy;
}


@end
