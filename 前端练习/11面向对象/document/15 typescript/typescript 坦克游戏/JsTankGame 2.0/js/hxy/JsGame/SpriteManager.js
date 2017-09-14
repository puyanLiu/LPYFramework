var hxy;
(function (hxy) {
    var JsGame;
    (function (JsGame) {
        var SpriteManager = (function () {
            function SpriteManager(divMain, playerImages, enemyImages, explosionImages, shellImages) {
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
            Object.defineProperty(SpriteManager.prototype, "allSprites", {
                get: function () {
                    return this._allSprites;
                },
                enumerable: true,
                configurable: true
            });
            Object.defineProperty(SpriteManager.prototype, "explosions", {
                get: function () {
                    return this._explosions;
                },
                enumerable: true,
                configurable: true
            });
            SpriteManager.prototype.InitAndAdd = function (sprite) {
                sprite.maxLeft = 0;
                sprite.maxTop = 0;
                sprite.maxBottom = this._availHeight - sprite.height;
                sprite.maxRight = this._availWidth - sprite.width;
                this._allSprites.push(sprite);
                this._divMain.appendChild(sprite.div);
            };
            SpriteManager.prototype.AddAPlayer = function () {
                var player = new JsGame.ConcreteSprite.PlayerTank(this._playerImages, 45, 45, this);
                this.InitAndAdd(player);
                player.speed = 5;
                player.isActive = false;
                player.ChangeARandomDirection();
                this.SetRandomPosWithoutCollision(player);
                this._players.push(player);
                return player;
            };
            SpriteManager.prototype.AddAEnemy = function () {
                var enemy = new JsGame.ConcreteSprite.EnemyTank(this._enemyImages, 45, 45, this);
                this.InitAndAdd(enemy);
                enemy.speed = 5;
                enemy.isActive = true;
                enemy.ChangeARandomDirection();
                this.SetRandomPosWithoutCollision(enemy);
                this._enemies.push(enemy);
                return enemy;
            };
            SpriteManager.prototype.AddAShell = function (fatherTank) {
                var shell = new JsGame.ConcreteSprite.Shell(this._shellImages, 9, 9, fatherTank, this);
                this.InitAndAdd(shell);
                shell.isActive = true;
                this._shells.push(shell);
                return shell;
            };
            SpriteManager.prototype.AddAExplosion = function () {
                var explosion = new JsGame.ConcreteSprite.Explosion(this._explosionImages, 32, 32, this);
                this.InitAndAdd(explosion);
                explosion.isActive = true;
                this._explosions.push(explosion);
                return explosion;
            };
            SpriteManager.prototype.Kill = function (sprite) {
                var ct = sprite.collisionType;
                if (ct == 1 /* PlayerTank */) {
                    hxy.Helper.RemoveFromArray(this._players, sprite);
                }
                else if (ct == 2 /* EnemyTank */) {
                    hxy.Helper.RemoveFromArray(this._enemies, sprite);
                }
                else if (ct == 4 /* PlayerShell */ || ct == 8 /* EnemyShell */) {
                    hxy.Helper.RemoveFromArray(this._shells, sprite);
                }
                else if (ct == 16 /* Explosion */) {
                    hxy.Helper.RemoveFromArray(this._explosions, sprite);
                }
                hxy.Helper.RemoveFromArray(this._allSprites, sprite);
                this._divMain.removeChild(sprite.div);
            };
            SpriteManager.prototype.SetRandomPosWithoutCollision = function (tank) {
                var initX, initY;
                do {
                    initX = Math.round(Math.random() * (this._availWidth - tank.width));
                    initY = Math.round(Math.random() * (this._availHeight - tank.height));
                    tank.setPos(initX, initY);
                } while (this.IsCollisionHappen(tank));
            };
            SpriteManager.prototype.IsCollisionHappen = function (tank) {
                if (tank.collisionType == 1 /* PlayerTank */) {
                    for (var i = 0; i < this._enemies.length; i++) {
                        var sprite2 = this._enemies[i];
                        if (tank.IsCollided(sprite2)) {
                            return true;
                        }
                    }
                    return false;
                }
                else {
                    for (var i = 0; i < this._players.length; i++) {
                        var player = this._players[i];
                        if (tank.IsCollided(player)) {
                            return true;
                        }
                    }
                    for (var i = 0; i < this._enemies.length; i++) {
                        var enemy = this._enemies[i];
                        if (tank.IsCollided(enemy)) {
                            return true;
                        }
                    }
                    return false;
                }
            };
            return SpriteManager;
        })();
        JsGame.SpriteManager = SpriteManager;
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=SpriteManager.js.map