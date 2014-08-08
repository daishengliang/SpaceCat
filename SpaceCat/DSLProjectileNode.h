//
//  DSLProjectileNode.h
//  SpaceCat
//
//  Created by shengliang dai on 7/20/14.
//  Copyright (c) 2014 shengliang dai. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DSLProjectileNode : SKSpriteNode
+ (instancetype) projectileAtPosition:(CGPoint)position;
- (void) moveTowardsPosition:(CGPoint)position;
@end
