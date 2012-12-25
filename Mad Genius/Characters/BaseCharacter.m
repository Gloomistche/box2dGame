//
//  BaseCharacter.m
//  Mad Genius
//
//  Created by Алексей  on 25.12.12.
//
//

#import "BaseCharacter.h"

@implementation BaseCharacter

-(BaseCharacter)createCharacter{
    
    parent = [CCSpriteBatchNode batchNodeWithFile:@"blocks.png" capacity:100];
    spriteTexture_ = [parent texture];
    self = [PhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(0,0,32,32)];
    bodyDef.type = b2_dynamicBody;

    b2Body *body = world->CreateBody(&bodyDef);
    body->SetFixedRotation(YES);
    dynamicBox.SetAsBox(.5f, .5f);//These are mid points for our 1m box
    fixtureDef.shape = &dynamicBox;
    fixtureDef.density = 1.0f;
    fixtureDef.friction = 0.3f;
    body->CreateFixture(&fixtureDef);
    [self setPhysicsBody:body];
  
    return self;
}



@end
