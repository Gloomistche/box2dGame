//
//  HelloWorldLayer.mm
//  Mad Genius
//
//  Created by Gloom on 16.12.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


enum {
	kTagParentNode = 1,
};


#pragma mark - HelloWorldLayer

@interface HelloWorldLayer()
@end

@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
		
        screenSize=[[CCDirector sharedDirector] winSize];
        
		self.isTouchEnabled = YES;
		CGSize s = [CCDirector sharedDirector].winSize;
		
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"blocks.png" capacity:100];
		spriteTexture_ = [parent texture];
        hero=[CCSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(0,0,32,32)];
        hero.position=ccp(s.width/2,s.height/2);
        [self addChild:hero];
  
        
        [self addLeftJoystic];
        [self addRightJoystic];
        [self schedule:@selector(update:) interval:0.01];

	}
	return self;
}

-(void) dealloc
{
	[super dealloc];
}	

-(void)update:(ccTime)dt
{
    CGPoint schaledVelocity=ccpMult(leftJoystick.velocity, 240);
    CGPoint newposition=ccp(hero.position.x+dt*schaledVelocity.x,hero.position.y+schaledVelocity.y*dt);
    positionOfTheRobot=newposition;
    [hero setPosition:newposition];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void)addLeftJoystic
{
    SneakyJoystickSkinnedBase *joystickbase = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    joystickbase.backgroundSprite = [CCSprite spriteWithFile:@"joustick.jpeg"];
    joystickbase.thumbSprite = [CCSprite spriteWithFile:@"joystick.png"];
    joystickbase.joystick = [[SneakyJoystick alloc] initWithRect: CGRectMake(0, 0, 120,128)];
    joystickbase.position = ccp(100,100);
    [self addChild:joystickbase];
    leftJoystick = [joystickbase.joystick retain];
}
-(void)addRightJoystic
{
    SneakyJoystickSkinnedBase *joystickbase = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    joystickbase.backgroundSprite = [CCSprite spriteWithFile:@"joustick.jpeg"];
    joystickbase.thumbSprite = [CCSprite spriteWithFile:@"joystick.png"];
    joystickbase.joystick = [[SneakyJoystick alloc] initWithRect: CGRectMake(0, 0, 120,128)];
    joystickbase.position = ccp(screenSize.width-100,100);
    [self addChild:joystickbase];
    rightJoystick = [joystickbase.joystick retain];
}

@end
