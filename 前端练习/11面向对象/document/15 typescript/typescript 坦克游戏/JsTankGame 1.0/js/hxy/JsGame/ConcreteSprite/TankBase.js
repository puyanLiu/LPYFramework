/// <reference name="MicrosoftAjax.js"/>

Type.registerNamespace("hxy.JsGame.ConcreteSprite");

hxy.JsGame.ConcreteSprite.TankBase = function() {
    hxy.JsGame.ConcreteSprite.TankBase.initializeBase(this);
}

hxy.JsGame.ConcreteSprite.TankBase.FIRE_AFTER = 500;

hxy.JsGame.ConcreteSprite.TankBase.prototype = {
    //change image index when setting directin
    set_direction: function(value){//overwite method
        hxy.JsGame.ConcreteSprite.TankBase.callBaseMethod(
            this, 'set_direction', [value] 
            );
        switch(value)
        {
            case hxy.JsGame.Enum.Direction.Left:
                this.set_imageIndex(0);
            break;
            case hxy.JsGame.Enum.Direction.Right:
                this.set_imageIndex(1);
            break;
            case hxy.JsGame.Enum.Direction.Up:
                this.set_imageIndex(2);
            break;
            case hxy.JsGame.Enum.Direction.Down:
                this.set_imageIndex(3);
            break;
        }
    },
    Initialize: function(imagePathes, width, height, manager){
        hxy.JsGame.ConcreteSprite.TankBase.callBaseMethod(
            this, 'Initialize',
            [imagePathes, width, height, manager] 
            );
    },
    Fire: function(){
        if(!Array.contains(this._manager.get_allSprites(), this)){
            return;
        }
        
        var frontierX = 0;
        var frontierY = 0;
        switch (this.get_direction()) {
          case hxy.JsGame.Enum.Direction.Left:
            frontierX = this.get_x();;
            frontierY = this.get_y() + this.get_height() / 2;
            break;

          case hxy.JsGame.Enum.Direction.Right:
            frontierX = this.get_x() + this.get_width();
            frontierY = this.get_y() + this.get_height() / 2;
            break;

          case hxy.JsGame.Enum.Direction.Up:
            frontierX = this.get_x() + this.get_width() / 2;
            frontierY = this.get_y();
            break;

          case hxy.JsGame.Enum.Direction.Down:
            frontierX = this.get_x() + this.get_width() / 2;
            frontierY = this.get_y() + this.get_height();
            break;
        }
        //在该点产生炮弹
        var shell = this._manager.AddAShell(this);
        shell.set_pos(frontierX - shell.get_width() / 2,
                     frontierY - shell.get_height() / 2);
        shell.set_direction(this.get_direction());
        shell.set_speed(this.get_speed() + 3);
    },
    FireAfter: function(time){
        window.setTimeout(
            Function.createDelegate(this,this.Fire),
            time
            );
    },
    OnShotted: function(){
        var exp = this._manager.AddAExplosion();
        var centerX = this.get_x() + this.get_width() / 2 - exp.get_width() / 2;
        var centerY = this.get_y() + this.get_height() / 2 - exp.get_height() / 2;
        exp.set_pos(centerX, centerY);
        this._manager.Kill(this);
    }
}
hxy.JsGame.ConcreteSprite.TankBase.registerClass('hxy.JsGame.ConcreteSprite.TankBase',hxy.JsGame.Common.SpriteBase);

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
