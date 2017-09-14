/// <reference name="MicrosoftAjax.js"/>

Type.registerNamespace("hxy.JsGame.ConcreteSprite");

hxy.JsGame.ConcreteSprite.EnemyTank = function() {
    hxy.JsGame.ConcreteSprite.EnemyTank.initializeBase(this);
}

hxy.JsGame.ConcreteSprite.EnemyTank.prototype = {
    OnBoundary: function(){
        this.ChangeARandomDirection();
    },
    OnCollided: function(targetRect, targetCollisionType, isInitiative){
        if (targetCollisionType == hxy.JsGame.Enum.CollisionType.PlayerTank ||
            targetCollisionType == hxy.JsGame.Enum.CollisionType.EnemyTank
            ) {
          if (isInitiative) {
            this.FarAwayFrom(targetRect);
          }
        }
        else if (targetCollisionType == hxy.JsGame.Enum.CollisionType.PlayerShell) {
          this.OnShotted();
        }
        else if (targetCollisionType == hxy.JsGame.Enum.CollisionType.Barrier) {
          this.FarAwayFrom(targetRect);
        }
    },
    get_collisionType: function(){
        return hxy.JsGame.Enum.CollisionType.EnemyTank;
    },
    Initialize: function(imagePathes, width, height, manager){
        hxy.JsGame.ConcreteSprite.EnemyTank.callBaseMethod(
            this, 'Initialize',
            [imagePathes, width, height, manager]
            );
    }
}
hxy.JsGame.ConcreteSprite.EnemyTank.registerClass('hxy.JsGame.ConcreteSprite.EnemyTank', hxy.JsGame.ConcreteSprite.TankBase);

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
