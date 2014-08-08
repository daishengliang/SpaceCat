//
//  DSLSpaceCatNode.h
//  SpaceCat
//
//  Created by shengliang dai on 7/17/14.
//  Copyright (c) 2014 shengliang dai. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DSLSpaceCatNode : SKSpriteNode

+ (instancetype) spaceCatAtPosition:(CGPoint)position;
- (void) performTap;

@end
