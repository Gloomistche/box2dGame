//
//  BaseCharacter.h
//  Mad Genius
//
//  Created by Алексей  on 25.12.12.
//
//

#import "PhysicsSprite.h"

@interface BaseCharacter : PhysicsSprite
{
    CCSpriteBatchNode *parent;
    CCTexture2D *spriteTexture_;
    b2BodyDef bodyDef;
    b2FixtureDef fixtureDef;
    
    NSDictionary* moveRightAnimation;
    NSDictionary* moveLeftAnimation;
    NSDictionary* stayAnimation;
    NSDictionary* jumpAnimation;
    NSDictionary* sitAnimation;
    NSDictionary* attackAnimation;
}

-(void)setMoveRightAnimation:(NSDictionary*)animation;
@end
