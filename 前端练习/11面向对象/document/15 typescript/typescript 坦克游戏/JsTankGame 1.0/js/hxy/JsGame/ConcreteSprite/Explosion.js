/// <reference name="MicrosoftAjax.js"/>

Type.registerNamespace("hxy.JsGame.ConcreteSprite");

hxy.JsGame.ConcreteSprite.Explosion = function() {
    hxy.JsGame.ConcreteSprite.Explosion.initializeBase(this);
    this._frameNow = 0;
}

hxy.JsGame.ConcreteSprite.Explosion.prototype = {
    Initialize: function(imagePathes, width, height, manager) {
        hxy.JsGame.ConcreteSprite.Explosion.callBaseMethod(
            this, 'Initialize',
            [imagePathes, width, height, manager] 
            );
    },
    get_collisionType: function(){
        return hxy.JsGame.Enum.CollisionType.Explosion;
    },
    UpdateFrame: function(){
        this._frameNow += 1;
        if(this._frameNow >= this.get_images().length){
          this._frameNow = 0;
          //frame is over,kill me.
          this._manager.Kill(this);
        }
        this.set_imageIndex(this._frameNow);
    }
}
hxy.JsGame.ConcreteSprite.Explosion.registerClass('hxy.JsGame.ConcreteSprite.Explosion', hxy.JsGame.Common.SpriteBase);

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
