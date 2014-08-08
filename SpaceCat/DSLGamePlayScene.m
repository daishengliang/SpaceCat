//
//  DSLGamePlayScene.m
//  SpaceCat
//
//  Created by shengliang dai on 7/17/14.
//  Copyright (c) 2014 shengliang dai. All rights reserved.
//

#import "DSLGamePlayScene.h"
#import "DSLMachineNode.h"
#import "DSLSpaceCatNode.h"
#import "DSLProjectileNode.h"
#import "DSLSpaceDogNode.h"
#import "DSLGroundNode.h"
#import "DSLUtil.h"
#import <AVFoundation/AVFoundation.h>

@interface DSLGamePlayScene ()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;

@property (nonatomic) SKAction *damageSFX;
@property (nonatomic) SKAction *explodeSFX;
@property (nonatomic) SKAction *laserSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;

@end

@implementation DSLGamePlayScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.lastUpdateTimeInterval = 0;
        self.timeSinceEnemyAdded = 0;
        self.addEnemyTimeInterval = 1.5;
        self.totalGameTime = 0;
        self.minSpeed = DSLSpaceDogMinSpeed;
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        DSLMachineNode *machine = [DSLMachineNode machineAtPosition: CGPointMake(CGRectGetMidX(self.frame), 12)];
        
        
        [self addChild:machine];
        DSLSpaceCatNode *spaceCat = [DSLSpaceCatNode spaceCatAtPosition:CGPointMake(machine.position.x
                                                                                    , machine.position.y-2)];
        
        [self addChild:spaceCat];
        
        [self addSpaceDog];
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8);
        self.physicsWorld.contactDelegate = self;
        DSLGroundNode *ground = [DSLGroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
        [self addChild:ground];
        
        [self setUpSounds];
    }
    
    return self;
}

- (void) setUpSounds {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Gameplay" withExtension:@"mp3"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.backgroundMusic.numberOfLoops = -1;
    [self.backgroundMusic prepareToPlay];

    
    self.damageSFX = [SKAction playSoundFileNamed:@"Damage.caf" waitForCompletion:NO];
    self.explodeSFX = [SKAction playSoundFileNamed:@"Explode.caf" waitForCompletion:NO];
    self.laserSFX = [SKAction playSoundFileNamed:@"Laser.caf" waitForCompletion:NO];
    
}

- (void) didMoveToView:(SKView *)view {
    [self.backgroundMusic play];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint position = [touch locationInNode:self];
        [self shootProjectileTowardsPosition:position];
    }
}
    

- (void) shootProjectileTowardsPosition:(CGPoint)position {
    DSLSpaceCatNode *spaceCat = (DSLSpaceCatNode*)[self childNodeWithName:@"SpaceCat"];
    [spaceCat performTap];
    DSLMachineNode *machine = (DSLMachineNode *)[self childNodeWithName:@"Machine"];
    DSLProjectileNode *projectile = [DSLProjectileNode projectileAtPosition:CGPointMake(machine.position.x, machine.position.y + machine.frame.size.height - 15)];
    [self addChild:projectile];
    [projectile moveTowardsPosition:position];
    [self runAction:self.laserSFX];

}

- (void) addSpaceDog {
    NSInteger randomSpaceDog = [DSLUtil randomWithMin:0 max:2];
    DSLSpaceDogNode *spaceDog = [DSLSpaceDogNode spaceDogOfType:randomSpaceDog];
    float y = self.frame.size.height + spaceDog.size.height;
    float x = [DSLUtil randomWithMin:10 + spaceDog.size.width max: self.frame.size.width - spaceDog.frame.size.width - 10];
    spaceDog.position = CGPointMake(x, y);
    float dy = [DSLUtil randomWithMin:DSLSpaceDogMinSpeed max:DSLSpaceDogMaxSpeed];
    spaceDog.physicsBody.velocity = CGVectorMake(0, dy);
    [self addChild:spaceDog];
    
}

- (void) update:(NSTimeInterval)currentTime {
    
    
    if (self.lastUpdateTimeInterval) {
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    
    if (self.timeSinceEnemyAdded > self.addEnemyTimeInterval) {
        [self addSpaceDog];
        self.timeSinceEnemyAdded = 0;
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    if (self.totalGameTime > 40) {
        self.addEnemyTimeInterval = 0.6;
        self.minSpeed = -160;
    } else if (self.totalGameTime >30) {
        self.addEnemyTimeInterval = 0.75;
        self.minSpeed = -150;
    } else if (self.totalGameTime >20) {
        self.addEnemyTimeInterval = 1.00;
        self.minSpeed = -125;
    } else if (self.totalGameTime >10) {
        self.addEnemyTimeInterval = 1.25;
        self.minSpeed = -100;
    }
}

- (void) didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask ) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    
    if ( firstBody.categoryBitMask == DSLCollisionCategoryEnemy && secondBody.categoryBitMask == DSLCollisionCategoryProjectile) {
        DSLSpaceDogNode *spaceDog = (DSLSpaceDogNode *)firstBody.node;
        DSLProjectileNode *projetile = (DSLProjectileNode *)secondBody.node;
        [self runAction:self.explodeSFX];
        [spaceDog removeFromParent];
        [projetile removeFromParent];
        
    } else if ( firstBody.categoryBitMask == DSLCollisionCategoryEnemy && secondBody.categoryBitMask == DSLCollisionCategoryGround){
        DSLSpaceDogNode *spaceDog = (DSLSpaceDogNode *)firstBody.node;
        [self runAction:self.damageSFX];
        [spaceDog removeFromParent];
        
    }
    //[self createDebrisAtPosition:contact.contactPoint];
    
}
/*
- (void) createDebrisAtPosition:(CGPoint)position {
    NSInteger numberOfPieces = 5;//[DSLUtil randomWithMin:5 max:20];
    
    for (int i = 0; i < numberOfPieces; i++) {
        NSInteger randomPiece = [DSLUtil randomWithMin:1 max:3];
        NSString *imageName = [NSString stringWithFormat:@"debri_%d", randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = DSLCollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = DSLCollisionCategoryGround | DSLCollisionCategoryDebris;
        debris.name = @"Debris";
        
        debris.physicsBody.velocity = CGVectorMake([DSLUtil randomWithMin:-150 max:150], [DSLUtil randomWithMin:150 max:350]);
        [debris runAction:[SKAction waitForDuration:2.0] completion:^{
            [debris removeFromParent];
        }];
    }
    
    
}
 */


@end
