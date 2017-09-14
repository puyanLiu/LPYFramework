module hxy.JsGame.ConcreteSprite {
    export class Explosion extends Common.SpriteBase {
        private _frameNow: number = 0;
        get collisionType() {
            return Enum.CollisionType.Explosion;
        }
        UpdateFrame(){
            this._frameNow += 1;
            if(this._frameNow >= this.images.length){
              this._frameNow = 0;
              //frame is over,kill me.
              this.manager.Kill(this);
            }
            this.imageIndex  = this._frameNow;
        }
    }
}