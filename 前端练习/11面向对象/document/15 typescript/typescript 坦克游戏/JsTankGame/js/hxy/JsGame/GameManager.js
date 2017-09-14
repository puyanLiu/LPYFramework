var hxy;
(function (hxy) {
    var JsGame;
    (function (JsGame) {
        //游戏管理器、游戏引擎入口
        var GameManager = (function () {
            function GameManager(spriteManager) {
                this._enemiesDeadCount = 0;
                this._spriteManager = spriteManager;
                this._collisionManager = new JsGame.CollisionManager(spriteManager);
            }
            GameManager.prototype.startGame = function (enemiesCount) {
                var _this = this;
                if (enemiesCount === void 0) { enemiesCount = 5; }
                //添加障碍物
                var maxWidth = this._spriteManager.maxWidth;
                var maxHeight = this._spriteManager.maxHeight;
                var b1 = this._spriteManager.addABarrier();
                b1.setPos(maxWidth / 4, maxHeight / 2);
                var b2 = this._spriteManager.addABarrier();
                b2.setPos(maxWidth / 4 * 3, maxHeight / 2);
                //添加几个 Tank
                this._player = this._spriteManager.addAPlayer();
                this._enemiesCount = enemiesCount;
                for (var i = 0; i < enemiesCount; i++) {
                    var enemy = this._spriteManager.addAEnemy();
                    this._spriteManager.fire(enemy);
                }
                this._collisionManager.addOnEnemyDead(function () {
                    _this._enemiesDeadCount++;
                    if (_this._enemiesDeadCount == _this._enemiesCount) {
                        alert("恭喜，敌机已全部击杀，游戏胜利！");
                    }
                });
                //键盘事件。
                document.addEventListener("keydown", function (e) { return _this.keyDown(e); });
                document.addEventListener("keyup", function (e) { return _this.keyUp(e); });
                //启动线程定时更新精灵状态
                setInterval(function () { return _this.runEngine(); }, 20);
                setInterval(function () { return _this.updateExplosionFrame(); }, 100);
                //3秒后关闭玩家的无敌
                this._collisionManager.isPlayerInvincible = true;
                setTimeout(function () {
                    _this._collisionManager.isPlayerInvincible = false;
                }, 3000);
            };
            GameManager.prototype.runEngine = function () {
                for (var i = 0; i < this._spriteManager.allSprites.length; i++) {
                    var sprite = this._spriteManager.allSprites[i];
                    sprite.move();
                    this._collisionManager.dealCollideSprites(sprite);
                    //change enemy direction by a random time span
                    if (Math.random() * 100 < 1 && sprite instanceof JsGame.ConcreteSprite.EnemyTank) {
                        sprite.changeARandomDirection();
                    }
                }
            };
            GameManager.prototype.updateExplosionFrame = function () {
                this._spriteManager.explosions.forEach(function (explosion) {
                    if (explosion.isVisible) {
                        explosion.updateFrame();
                    }
                });
            };
            GameManager.prototype.keyDown = function (e) {
                switch (e.keyCode) {
                    case hxy.KeyCodes.left:
                        this._player.direction = 2 /* Left */;
                        this._player.isActive = true;
                        break;
                    case hxy.KeyCodes.up:
                        this._player.direction = 0 /* Up */;
                        this._player.isActive = true;
                        break;
                    case hxy.KeyCodes.right:
                        this._player.direction = 3 /* Right */;
                        this._player.isActive = true;
                        break;
                    case hxy.KeyCodes.down:
                        this._player.direction = 1 /* Down */;
                        this._player.isActive = true;
                        break;
                }
            };
            GameManager.prototype.keyUp = function (e) {
                this._player.isActive = false;
                switch (e.keyCode) {
                    case hxy.KeyCodes.space:
                        this._spriteManager.fire(this._player);
                        break;
                }
            };
            return GameManager;
        })();
        JsGame.GameManager = GameManager;
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=GameManager.js.map