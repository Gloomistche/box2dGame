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

        
        CCSpriteBatchNode *sceneSpriteBatchNode;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"stonesTexrutes_UntitledSheet-ipadhd.plist"];
        sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile: @"stonesTexrutes_UntitledSheet.png"];
        [self addChild:sceneSpriteBatchNode z:0];
        

        CCSpriteBatchNode *parent = sceneSpriteBatchNode;
		spriteTexture_ = [parent texture];
        

        CCSpriteBatchNode *heroSpriteBatchNode;
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"walkAnim_UntitledSheet-hd.plist"];
        heroSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile: @"walkAnim_UntitledSheet-hd.png"];
        [self addChild:heroSpriteBatchNode z:1];
        
        
        hero = [PhysicsSprite spriteWithSpriteFrameName:@"walk0001"];
        [self addChild:hero z:1];

        
        // create the animation
        NSMutableArray* animationArray = [NSMutableArray new];
        
        for (int x = 1; x < 19; x++) {
            CCSpriteFrame *frame;
            if (x<10){
                frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"walk000%i",x]];
            }else{
                frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"walk00%i",x]];                
            }
			//	CCSpriteFrame *frame = [CCSpriteFrame spriteWithSpriteFrameName:@"walk0001"];
				[animationArray addObject: frame];
		}

		CCAnimation *danceAnimation = [CCAnimation animationWithSpriteFrames:animationArray delay:0.1f];
        
		// create the action
		CCAnimate *danceAction = [CCAnimate actionWithAnimation:danceAnimation];
		CCRepeatForever *repeat = [CCRepeatForever actionWithAction:danceAction];
        
		// run the action
		[hero runAction:repeat];
        
        
      /*
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"blocks.png" capacity:100];
		spriteTexture_ = [parent texture];
        
        hero = [PhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(0,0,32,32)];
        [self addChild:hero z:1];
        */
        hero.position = ccp(s.width/2,s.height/2);
        
        // Define the dynamic body.
        //Set up a 1m squared box in the physics world
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(s.width/2/PTM_RATIO, s.height/2/PTM_RATIO);
        b2Body *body = world->CreateBody(&bodyDef);
        //запрещаем вращение
        body->SetFixedRotation(YES);
        // Define another box shape for our dynamic body.
  
        b2PolygonShape dynamicBox;
        dynamicBox.SetAsBox(1.5f, 1.5f);//These are mid points for our 1m box
        // Define the dynamic body fixture.

 //       b2CircleShape circle;
  //      circle.m_radius = 16.0/PTM_RATIO;

        
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &dynamicBox;
 //       fixtureDef.shape = &circle;
        fixtureDef.density = 1.0f;
        fixtureDef.friction = 0.3f;
        body->CreateFixture(&fixtureDef);
        [hero setPhysicsBody:body];

        
        PhysicsSprite* enimes = [PhysicsSprite spriteWithSpriteFrameName:@"st_2"];
        //PhysicsSprite* enimes = [PhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(32,0,400,32)];
        [self addChild:enimes z:0];
        
        enimes.position = ccp(0,0);
        // Define the dynamic body.
        //Set up a 1m squared box in the physics world
        b2BodyDef bodyDef1;
        bodyDef1.type = b2_staticBody;
        bodyDef1.position.Set(447/PTM_RATIO, 290/PTM_RATIO);
        b2Body *body1 = world->CreateBody(&bodyDef1);
        // Define another box shape for our dynamic body.
        b2PolygonShape dynamicBox1;
        dynamicBox1.SetAsBox(2.1f, .3f);//These are mid points for our 1m box
        // Define the dynamic body fixture.
        b2FixtureDef fixtureDef1;
        fixtureDef1.shape = &dynamicBox1;
        fixtureDef1.density = 1.0f;
        fixtureDef1.friction = 0.3f;
        body1->CreateFixture(&fixtureDef1);
        [enimes setPhysicsBody:body1];

         PhysicsSprite* enimes1 = [PhysicsSprite spriteWithSpriteFrameName:@"st_1"];
     //   PhysicsSprite* enimes1 = [PhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(0,32,500,32)];
        [self addChild:enimes1 z:0];
        
        enimes.position = ccp(0,0);
        // Define the dynamic body.
        //Set up a 1m squared box in the physics world
        b2BodyDef bodyDef2;
        bodyDef2.type = b2_staticBody;
        bodyDef2.position.Set(600/PTM_RATIO, 270/PTM_RATIO);
        b2Body *body2 = world->CreateBody(&bodyDef2);
        // Define another box shape for our dynamic body.
        b2PolygonShape dynamicBox2;
        dynamicBox2.SetAsBox(2.1f, .3f);//These are mid points for our 1m box
        // Define the dynamic body fixture.
        b2FixtureDef fixtureDef2;
        fixtureDef2.shape = &dynamicBox2;
        fixtureDef2.density = 1.0f;
        fixtureDef2.friction = 0.3f;
        body2->CreateFixture(&fixtureDef2);
        [enimes1 setPhysicsBody:body2];
        
        
        PhysicsSprite* enimes2 = [PhysicsSprite spriteWithSpriteFrameName:@"st_3"];
        [self addChild:enimes2 z:0];
        enimes2.position = ccp(0,0);
        // Define the dynamic body.
        //Set up a 1m squared box in the physics world
        b2BodyDef bodyDef3;
        bodyDef3.type = b2_staticBody;
        bodyDef3.position.Set(280/PTM_RATIO, 310/PTM_RATIO);
        b2Body *body3 = world->CreateBody(&bodyDef3);
        // Define another box shape for our dynamic body.
        b2PolygonShape dynamicBox3;
        dynamicBox3.SetAsBox(2.1f, .3f);//These are mid points for our 1m box
        // Define the dynamic body fixture.
        b2FixtureDef fixtureDef3;
        fixtureDef3.shape = &dynamicBox3;
        fixtureDef3.density = 1.0f;
        fixtureDef3.friction = 0.3f;
        body3->CreateFixture(&fixtureDef3);
        [enimes2 setPhysicsBody:body3];

        
        [self addLeftJoystic];
        [self addRightJoystic];
        [self scheduleUpdate];

     //   [self schedule:@selector(update:) interval:0.01];

	}
	return self;
}

-(void) initPhysics
{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
    gravity.Set(0.0f, -30.0f);
	world = new b2World(gravity);
	// Do we want to let bodies sleep?
	world->SetAllowSleeping(YES);
	
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
    CGPoint schaledVelocity=ccpMult(leftJoystick.velocity, 300);
    CGPoint newposition=ccp(hero.position.x+dt*schaledVelocity.x,hero.position.y+schaledVelocity.y*dt);
    
    //physicSprite
    if (leftJoystick.velocity.x!=0 || leftJoystick.velocity.y!=0){
    b2Body *heroBody = [hero getPhysicsBody];
        if (newposition.x - hero.position.x <0){
            hero.flipX = YES;
         //   hero
        }else{
            hero.flipX = NO;
        }
//    heroBody->SetLinearVelocity(b2Vec2(newposition.x -hero.position.x-gravity.x,newposition.y - hero.position.y+gravity.y));
    heroBody->SetLinearVelocity(b2Vec2(newposition.x -hero.position.x,newposition.y - hero.position.y));
//    heroBody->SetTransform(b2Vec2(newposition.x -hero.position.x,newposition.y - hero.position.y), 10);
    }


    
    //обычный спрайт
    /*    b2Vec2 gravity;
    gravity.Set(schaledVelocity.x,schaledVelocity.y);
    world->SetGravity(gravity);

     CGPoint newposition=ccp(hero.position.x+dt*schaledVelocity.x,hero.position.y+schaledVelocity.y*dt);
    positionOfTheRobot=newposition;
    [hero setPosition:newposition];
    */
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
-(void) addNewSpriteAtPosition:(CGPoint)p
{
	CCLOG(@"Add sprite %0.2f x %02.f",p.x,p.y);
	CCNode *parent = [self getChildByTag:kTagParentNode];
	
    
    CCSpriteBatchNode *sceneSpriteBatchNode;
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"stonesTexrutes_UntitledSheet-ipadhd.plist"];
    sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile: @"stonesTexrutes_UntitledSheet.png"];
    [self addChild:sceneSpriteBatchNode z:0];
    PhysicsSprite *sprite = [PhysicsSprite spriteWithSpriteFrameName:@"box"];
  	[self addChild:sprite];
  
    
//	PhysicsSprite *sprite = [PhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(32 * idx,32 * idy,32,32)];
//	[parent addChild:sprite];
	
	sprite.position = ccp( p.x, p.y);
	
	// Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
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
	
	[sprite setPhysicsBody:body];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		[self addNewSpriteAtPosition: location];
	}
}

-(void) draw
{
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	world->DrawDebugData();
	
	kmGLPopMatrix();
}

@end
