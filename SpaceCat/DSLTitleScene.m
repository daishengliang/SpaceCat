//
//  DSLTitleScene.m
//  SpaceCat
//
//  Created by shengliang dai on 7/16/14.
//  Copyright (c) 2014 shengliang dai. All rights reserved.
//

#import "DSLTitleScene.h"
#import "DSLGamePlayScene.h"
#import <AVFoundation/AVFoundation.h>

@interface DSLTitleScene ()
@property (nonatomic) SKAction *pressStartSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@end

@implementation DSLTitleScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKSpriteNode *greenNode = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(100, 100)];
        greenNode.position = CGPointMake(150, 150);
        greenNode.anchorPoint = CGPointMake(0, 0);
        [self addChild:greenNode];
        
        SKSpriteNode *redNode = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(5, 5)];
        redNode.position = CGPointMake(150, 150);
        redNode.anchorPoint = CGPointMake(0, 0);
        [self addChild:redNode];
         */
         
        /*
         SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
         
         myLabel.text = @"Hello, World!";
         myLabel.fontSize = 30;
         myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
         CGRectGetMidY(self.frame));
         
         [self addChild:myLabel];
         */
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        self.pressStartSFX = [SKAction playSoundFileNamed:@"PressStart.caf" waitForCompletion:NO];
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"StartPress" withExtension:@"mp3"];
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.backgroundMusic.numberOfLoops = -1;
        [self.backgroundMusic prepareToPlay];
    }
    
    return self;
}

- (void) didMoveToView:(SKView *)view{
    [self.backgroundMusic play];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self runAction:self.pressStartSFX];
    DSLGamePlayScene *gamePlayScene = [DSLGamePlayScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1];
    [self.view presentScene:gamePlayScene transition:transition];
}

@end
