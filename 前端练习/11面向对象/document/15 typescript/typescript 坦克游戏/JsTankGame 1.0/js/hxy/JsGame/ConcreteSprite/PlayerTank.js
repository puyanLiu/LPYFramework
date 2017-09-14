/// <reference name="MicrosoftAjax.js"/>

Type.registerNamespace("hxy.JsGame.ConcreteSprite");

hxy.JsGame.ConcreteSprite.PlayerTank = function() {
    hxy.JsGame.ConcreteSprite.PlayerTank.initializeBase(this);
}

hxy.JsGame.ConcreteSprite.PlayerTank.prototype = {
    OnCollided: function(targetRect, targetCollisionType, isInitiative){
        //collide a enemy tank
        if (targetCollisionType == hxy.JsGame.Enum.CollisionType.EnemyTank) {
            if (isInitiative) {
                this.FarAwayFrom(targetRect);
            }
        }
        //collide a shell of enemy
        else if (targetCollisionType == hxy.JsGame.Enum.CollisionType.EnemyShell) {
            //this.OnShotted();
        }
        else if (targetCollisionType == hxy.JsGame.Enum.CollisionType.Barrier) {
            this.FarAwayFrom(targetRect);
        }
    },
    get_collisionType: function(){
        return hxy.JsGame.Enum.CollisionType.PlayerTank;
    },
    Initialize: function(imagePathes, width, height, manager){
        hxy.JsGame.ConcreteSprite.PlayerTank.callBaseMethod(
            this, 'Initialize',
            [imagePathes, width, height, manager]
            );
    }
}
hxy.JsGame.ConcreteSprite.PlayerTank.registerClass('hxy.JsGame.ConcreteSprite.PlayerTank', hxy.JsGame.ConcreteSprite.TankBase);

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
