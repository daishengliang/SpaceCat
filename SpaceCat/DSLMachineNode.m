//
//  DSLMachineNode.m
//  SpaceCat
//
//  Created by shengliang dai on 7/17/14.
//  Copyright (c) 2014 shengliang dai. All rights reserved.
//

#import "DSLMachineNode.h"

@implementation DSLMachineNode
+ (instancetype) machineAtPosition:(CGPoint)position {
    DSLMachineNode *machine = [self spriteNodeWithImageNamed:@"machine_1"];
    machine.position = position;
    machine.anchorPoint = CGPointMake(0.5, 0);
    machine.name = @"Machine";
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"machine_1"],
                          [SKTexture textureWithImageNamed:@"machine_2"]];
    SKAction *machineAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    SKAction *machineRepeat = [SKAction repeatActionForever:machineAnimation];
    [machine runAction:machineRepeat];
    return machine;
}
@end
