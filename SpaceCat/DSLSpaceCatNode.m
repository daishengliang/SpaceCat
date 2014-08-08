//
//  DSLSpaceCatNode.m
//  SpaceCat
//
//  Created by shengliang dai on 7/17/14.
//  Copyright (c) 2014 shengliang dai. All rights reserved.
//

#import "DSLSpaceCatNode.h"
#import "DSLUtil.h"
@interface DSLSpaceCatNode()
@property (nonatomic) SKAction *tapAction;

@end

@implementation DSLSpaceCatNode

+ (instancetype) spaceCatAtPosition:(CGPoint)position {
    DSLSpaceCatNode *spaceCat = [self spriteNodeWithImageNamed:@"spacecat_1"];
    spaceCat.position = position;
    spaceCat.anchorPoint = CGPointMake(0.5, 0);
    spaceCat.name = @"SpaceCat";
    return spaceCat;
}

- (SKAction *) tapAction {
    if (_tapAction != nil) {
        return _tapAction;
    }
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"spacecat_2"],
                          [SKTexture textureWithImageNamed:@"spacecat_1"]];
    _tapAction = [SKAction animateWithTextures:textures timePerFrame:0.25];
    return _tapAction;
            
}

- (void) performTap {
    [self runAction:self.tapAction];
}

@end
