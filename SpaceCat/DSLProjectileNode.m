//
//  DSLProjectileNode.m
//  SpaceCat
//
//  Created by shengliang dai on 7/20/14.
//  Copyright (c) 2014 shengliang dai. All rights reserved.
//

#import "DSLProjectileNode.h"
#import "DSLUtil.h"
@implementation DSLProjectileNode
+ (instancetype) projectileAtPosition:(CGPoint)position {
    DSLProjectileNode *projectile = [self spriteNodeWithImageNamed:@"projectile_1"];
    projectile.position = position;
    projectile.name = @"Projectile";
    [projectile setupAnimation];
    [projectile setUpPhyiscBody];
    return projectile;
}

- (void) setupAnimation {
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"projectile_1"],
                          [SKTexture textureWithImageNamed:@"projectile_2"],
                          [SKTexture textureWithImageNamed:@"projectile_3"]];
    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    SKAction *repeatAction = [SKAction repeatActionForever:animation];
    [self runAction:repeatAction];
    
    
}

- (void) setUpPhyiscBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = DSLCollisionCategoryProjectile;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = DSLCollisionCategoryEnemy;
    
}

- (void) moveTowardsPosition:(CGPoint)position {
    float slope = (position.y - self.position.y)/(position.x - self.position.x);
    float offscreenX;
    
    if(position.x <= self.position.x) {
        offscreenX = -10;
        
    } else {
        offscreenX = self.parent.frame.size.width + 10;
    }
    
    float offscreenY = slope * offscreenX - slope * self.position.x + self.position.y;
    
    CGPoint pointOFFscreen = CGPointMake(offscreenX, offscreenY);
    
    float distanceA = pointOFFscreen.y - self.position.y;
    float distanceB = pointOFFscreen.x - self.position.x;
    float distanceC = sqrtf(powf(distanceA, 2) + powf(distanceB, 2));
    
    float time = distanceC / DSLProjectileSpeed;
    float waitToFade = time * 0.75;
    float fadeTime = time - waitToFade;
    
    SKAction *moveProjectile = [SKAction moveTo:pointOFFscreen duration:time];
    NSArray *sequence = @[[SKAction waitForDuration:waitToFade],
                          [SKAction fadeOutWithDuration:fadeTime],
                          [SKAction removeFromParent]];
    
    
    [self runAction:moveProjectile];
    [self runAction:[SKAction sequence:sequence]];
}

@end
