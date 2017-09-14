/// <reference name="MicrosoftAjax.js"/>

Type.registerNamespace("hxy.JsGame.ConcreteSprite");

hxy.JsGame.ConcreteSprite.Shell = function() {
    hxy.JsGame.ConcreteSprite.Shell.initializeBase(this);
    
    this._myTank = null;
}

hxy.JsGame.ConcreteSprite.Shell.prototype = {
    OnBoundary: function(){
        this._manager.Kill(this);
        this.InformMyTank();
    },
    OnCollided: function(targetRect, targetCollisionType, isInitiative){
        //remove me from applet if collided
        if (this.IsPlayerShell() && targetCollisionType == hxy.JsGame.Enum.CollisionType.EnemyTank ||
            !this.IsPlayerShell() && targetCollisionType == hxy.JsGame.Enum.CollisionType.PlayerTank
            ) {
            this._manager.Kill(this);
            this.InformMyTank();
        }
        else if (targetCollisionType == hxy.JsGame.Enum.CollisionType.Barrier) {
            this._manager.Kill(this);
            this.InformMyTank();
            this.Bomb();
        }
    },
    Initialize: function(imagePathes, width, height, myTank, manager){
        hxy.JsGame.ConcreteSprite.Shell.callBaseMethod(
            this, 'Initialize',
            [imagePathes, width, height, manager]
            );
        this._myTank = myTank;
        this.set_imageIndex(this.IsPlayerShell() ? 0 : 1);
    },
    InformMyTank: function(){
        var fireAfterMilliSeconds = 20;
        if(!this.IsPlayerShell()){
            this._myTank.FireAfter(fireAfterMilliSeconds);
        }
    },
    IsPlayerShell: function(){
        return this._myTank.get_collisionType() == hxy.JsGame.Enum.CollisionType.PlayerTank;
    },
    Bomb: function(){
        var e = ths._manager.AddAExplosion();
        var centerX = this.get_x() + this.get_width() / 2 - e.get_width() / 2;
        var centerY = this.get_y() + this.get_height() / 2 - e.get_height() / 2;
        e.set_pos(centerX, centerY);
    },
    get_collisionType: function(){
        return this.IsPlayerShell() ? 
            hxy.JsGame.Enum.CollisionType.PlayerShell :
            hxy.JsGame.Enum.CollisionType.EnemyShell;
    },
    get_myTank: function(){
        return this._myTank;
    }
}
hxy.JsGame.ConcreteSprite.Shell.registerClass('hxy.JsGame.ConcreteSprite.Shell', hxy.JsGame.Common.SpriteBase);

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
