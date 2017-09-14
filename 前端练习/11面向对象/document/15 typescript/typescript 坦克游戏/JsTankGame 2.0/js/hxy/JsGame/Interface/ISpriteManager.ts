module hxy.JsGame.Interface {
    export interface ISpriteManager {
        //collisionType: Enum.CollisionType
        allSprites: Common.SpriteBase[];
        AddAShell(tank: ConcreteSprite.TankBase): ConcreteSprite.Shell;
        AddAExplosion(): ConcreteSprite.Explosion;
        Kill(sprite: Common.SpriteBase);
    }
}