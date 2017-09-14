/// <reference name="MicrosoftAjax.js"/> 

Type.registerNamespace("hxy.JsGame");

hxy.JsGame.SpriteManager = function(divMain, playerImages, enemyImages, explosionImages, shellImages) {
    this._divMain = divMain;
    
    this._allSprites = [];
    this._players = [];
    this._enemies = [];
    this._explosions = [];
    this._shells = [];
    
    this._playerImages = playerImages;
    this._enemyImages = enemyImages;
    this._explosionImages = explosionImages;
    this._shellImages = shellImages;
    
    this._availHeight = window.screen.availHeight - window.screenTop - 25;
    this._availWidth = window.screen.availWidth - window.screenLeft - 25;
}

hxy.JsGame.SpriteManager.prototype = {
    AddAPlayer: function(){
        var player = new hxy.JsGame.ConcreteSprite.PlayerTank();
        player.Initialize(this._playerImages, 45, 45, this);
        player.set_speed(5);
        player.set_maxLeft(0);
        player.set_maxTop(0);
        player.set_maxBottom(this._availHeight - player.get_height());
        player.set_maxRight(this._availWidth  - player.get_width());
        player.set_isActive(false);
        player.ChangeARandomDirection();
        
        this.SetRandomPosWithoutCollision(player);
        
        Array.add(this._players, player);
        Array.add(this._allSprites, player);
        this._divMain.appendChild(player.get_div());
        return player;
    },
    AddAEnemy : function(){
        var initX, initY;
        var enemy = new hxy.JsGame.ConcreteSprite.EnemyTank();
        enemy.Initialize(this._enemyImages, 45, 45, this);
        enemy.set_speed(5);
        enemy.set_maxLeft(0);
        enemy.set_maxTop(0);
        enemy.set_maxBottom(this._availHeight - enemy.get_height());
        enemy.set_maxRight(this._availWidth  - enemy.get_width());
        enemy.set_isActive(true);
        enemy.ChangeARandomDirection();
        
        this.SetRandomPosWithoutCollision(enemy);
        
        Array.add(this._enemies, enemy);
        Array.add(this._allSprites, enemy);
        this._divMain.appendChild(enemy.get_div());
        return enemy;
    },
    AddAShell: function(fatherTank){
        var shell = new hxy.JsGame.ConcreteSprite.Shell();
        shell.Initialize(this._shellImages, 9, 9, fatherTank, this);
        shell.set_maxLeft(0);
        shell.set_maxTop(0);
        shell.set_maxBottom(this._availHeight - shell.get_height());
        shell.set_maxRight(this._availWidth  - shell.get_width());
        shell.set_isActive(true);
        
        Array.add(this._shells, shell);
        Array.add(this._allSprites, shell);
        this._divMain.appendChild(shell.get_div());
        return shell;
    },
    AddAExplosion: function(){
        var explosion = new hxy.JsGame.ConcreteSprite.Explosion();
        explosion.Initialize(this._explosionImages, 32, 32, this);
        explosion.set_maxLeft(0);
        explosion.set_maxTop(0);
        explosion.set_maxBottom(this._availHeight - explosion.get_height());
        explosion.set_maxRight(this._availWidth  - explosion.get_width());
        explosion.set_isActive(true);
        
        Array.add(this._explosions, explosion);
        Array.add(this._allSprites, explosion);
        this._divMain.appendChild(explosion.get_div());
        return explosion;
    },
    Kill: function(sprite){
        Array.remove(this._allSprites, sprite);
        
        if(sprite.get_collisionType() == hxy.JsGame.Enum.CollisionType.PlayerTank){
            Array.remove(this._players, sprite);
        }
        else if(sprite.get_collisionType() == hxy.JsGame.Enum.CollisionType.EnemyTank){
            Array.remove(this._enemies, sprite);
        }
        else if(sprite.get_collisionType() == hxy.JsGame.Enum.CollisionType.Shell){
            Array.remove(this._shells, sprite);
        }
        else if(sprite.get_collisionType() == hxy.JsGame.Enum.CollisionType.Explosion){
            Array.remove(this._explosions, sprite);
        }
        
        this._divMain.removeChild(sprite.get_div());
    },
    SetRandomPosWithoutCollision: function(tank){
        var initX, initY;
        do{
            initX = Math.round(Math.random() * (this._availWidth - tank.get_width()));
            initY = Math.round(Math.random() * (this._availHeight - tank.get_height()));
            tank.set_pos(initX, initY);
        }while (this.IsCollisionHappen(tank));
    },
    IsCollisionHappen: function(tank){
        if (tank.get_collisionType() == hxy.JsGame.Enum.CollisionType.PlayerTank) { //player
            for (var i = 0; i < this._enemies.length; i++) {
                var sprite2 = this._enemies[i];
                if (tank.IsCollided(sprite2)) {
                    return true;
                }
            }
            return false;
        }
        else {//enemy
            for (var i = 0; i < this._players.length; i++) {
                var sprite2 = this._players[i];
                if (tank.IsCollided(sprite2)) {
                    return true;
                }
            }
            for (var i = 0; i < this._enemies.length; i++) {
                var sprite2 = this._enemies[i];
                if (tank.IsCollided(sprite2)) {
                    return true;
                }
            }
            return false;
        }
    },
    get_allSprites: function(){
        return this._allSprites;
    },
    get_explosions: function(){
        return this._explosions;
    }
}
hxy.JsGame.SpriteManager.registerClass('hxy.JsGame.SpriteManager');

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
