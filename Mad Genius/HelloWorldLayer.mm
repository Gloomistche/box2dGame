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
        [self initPhysics];

		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"blocks.png" capacity:100];
		spriteTexture_ = [parent texture];
        
        hero = [PhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(0,0,32,32)];
        [self addChild:hero z:0];
        
        hero.position = ccp(s.width/2,s.height/2);
        
        // Define the dynamic body.
        //Set up a 1m squared box in the physics world
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(s.width/2/PTM_RATIO, s.height/2/PTM_RATIO);
        b2Body *body = world->CreateBody(&bodyDef);
        // Define another box shape for our dynamic body.
        b2PolygonShape dynamicBox;
        dynamicBox.SetAsBox(.5f, .5f);//These are mid points for our 1m box
        // Define the dynamic body fixture.
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &dynamicBox;
        fixtureDef.density = 1.0f;
        fixtureDef.friction = 0.3f;
        body->CreateFixture(&fixtureDef);
        [hero setPhysicsBody:body];

        
        PhysicsSprite* enimes = [PhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(1,1,32,32)];
        [self addChild:enimes z:1];
        
        enimes.position = ccp(32,32);
        // Define the dynamic body.
        //Set up a 1m squared box in the physics world
        b2BodyDef bodyDef1;
        bodyDef1.type = b2_dynamicBody;
        bodyDef1.position.Set(32/PTM_RATIO, 32/PTM_RATIO);
        b2Body *body1 = world->CreateBody(&bodyDef1);
        // Define another box shape for our dynamic body.
        b2PolygonShape dynamicBox1;
        dynamicBox1.SetAsBox(.5f, .5f);//These are mid points for our 1m box
        // Define the dynamic body fixture.
        b2FixtureDef fixtureDef1;
        fixtureDef1.shape = &dynamicBox1;
        fixtureDef1.density = 1.0f;
        fixtureDef1.friction = 0.3f;
        body1->CreateFixture(&fixtureDef1);
        [enimes setPhysicsBody:body1];

        
        [self addLeftJoystic];
        [self addRightJoystic];
        [self schedule:@selector(update:) interval:0.01];

	}
	return self;
}

-(void) initPhysics
{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	b2Vec2 gravity;
//	gravity.Set(0.0f, -10.0f);
    	gravity.Set(0.0f, 10.0f);
	world = new b2World(gravity);
	// Do we want to let bodies sleep?
	world->SetAllowSleeping(true);
	
	world->SetContinuousPhysics(true);
	
	m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	world->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
	//		flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	//		flags += b2Draw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);
	
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	b2Body* groundBody = world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2EdgeShape groundBox;
	
	// bottom
	
	groundBox.Set(b2Vec2(0,0), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
}


-(void) dealloc
{
	[super dealloc];
}	

-(void)update:(ccTime)dt
{
    int32 velocityIterations = 8;
	int32 positionIterations = 1;	
	world->Step(dt, velocityIterations, positionIterations);
    b2Vec2 gravity;
    
    CGPoint schaledVelocity=ccpMult(leftJoystick.velocity, 10);
/*    if (schaledVelocity.x !=0 && schaledVelocity.y!=0){
        int xScale;
        int yScale;
        if (x>0)
            xScale = 10;
        else
            xScale = -10;
    }
    else{
         gravity.Set(schaledVelocity.x,schaledVelocity.y);
    }
 */
    gravity.Set(schaledVelocity.x,schaledVelocity.y);
    world->SetGravity(gravity);

    // CGPoint newposition=ccp(hero.position.x+dt*schaledVelocity.x,hero.position.y+schaledVelocity.y*dt);
   // positionOfTheRobot=newposition;
   // [hero setPosition:newposition];
    
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
