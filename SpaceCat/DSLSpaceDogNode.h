//
//  DSLSpaceDogNode.h
//  SpaceCat
//
//  Created by shengliang dai on 7/20/14.
//  Copyright (c) 2014 shengliang dai. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, DSLSpaceDogType) {
    DSLSpaceDogTypeA = 0,
    DSLSpaceDogTypeB = 1
    
};

@interface DSLSpaceDogNode : SKSpriteNode
@property (nonatomic, getter = isDamaged) BOOL damaged;
@property (nonatomic) DSLSpaceDogType type;
+ (instancetype) spaceDogOfType: (DSLSpaceDogType) type;

@end
