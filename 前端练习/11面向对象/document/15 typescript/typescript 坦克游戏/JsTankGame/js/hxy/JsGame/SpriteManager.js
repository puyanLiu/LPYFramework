var hxy;
(function (hxy) {
    var JsGame;
    (function (JsGame) {
        //管理所有精灵的生命周期
        var SpriteManager = (function () {
            function SpriteManager(divMain, playerImages, enemyImages, explosionImages, shellImages, barrierImages) {
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
                this._barrierImages = barrierImages;
                this._availHeight = divMain.clientHeight - window.screenTop;
                this._availWidth = divMain.clientWidth - window.screenLeft;
                //this._availHeight = window.screen.availHeight - window.screenTop - 25;
                //this._availWidth = window.screen.availWidth - window.screenLeft - 25;
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
            Object.defineProperty(SpriteManager.prototype, "maxWidth", {
                get: function () {
                    return this._availWidth;
                },
                enumerable: true,
                configurable: true
            });
            Object.defineProperty(SpriteManager.prototype, "maxHeight", {
                get: function () {
                    return this._availHeight;
                },
                enumerable: true,
                configurable: true
            });
            SpriteManager.prototype.AddNewSprite = function (sprite) {
                sprite.maxLeft = this._divMain.offsetLeft;
                sprite.maxTop = this._divMain.offsetTop;
                sprite.maxBottom = this._availHeight - sprite.height;
                sprite.maxRight = this._availWidth - sprite.width;
                this._allSprites.push(sprite);
                this._divMain.appendChild(sprite.div);
            };
            SpriteManager.prototype.addAPlayer = function () {
                var player = new JsGame.ConcreteSprite.PlayerTank(this._playerImages, 45, 45);
                this.AddNewSprite(player);
                player.speed = 5;
                player.isActive = false;
                player.changeARandomDirection();
                this.setRandomPosWithoutCollision(player);
                this._players.push(player);
                return player;
            };
            SpriteManager.prototype.addAEnemy = function () {
                var enemy; //不加这行不能识别，可能是 TypeScript BUG
                var enemy = new JsGame.ConcreteSprite.EnemyTank(this._enemyImages, 45, 45);
                this.AddNewSprite(enemy);
                enemy.speed = 5;
                enemy.isActive = true;
                enemy.changeARandomDirection();
                this.setRandomPosWithoutCollision(enemy);
                this._enemies.push(enemy);
                enemy.addOnBoundary(function (dir) {
                    enemy.changeARandomDirection();
                });
                return enemy;
            };
            SpriteManager.prototype.bombAt = function (sprite) {
                //在某个精灵的位置，放置一个炸弹。
                var exp = this.addAExplosion();
                var centerX = sprite.x + sprite.width / 2 - exp.width / 2;
                var centerY = sprite.y + sprite.height / 2 - exp.height / 2;
                exp.setPos(centerX, centerY);
            };
            SpriteManager.prototype.addABarrier = function () {
                var barrier = new JsGame.ConcreteSprite.Barrier(this._barrierImages, 64, 64);
                //var barrier = new ConcreteSprite.Barrier(this._barrierImages, 32, 32);
                this.AddNewSprite(barrier);
                barrier.isActive = false;
                return barrier;
            };
            SpriteManager.prototype.addAShell = function (fatherTank) {
                var _this = this;
                var shell; //不加这行不能识别，可能是 TypeScript BUG
                var shell = new JsGame.ConcreteSprite.Shell(this._shellImages, 9, 9, fatherTank);
                this.AddNewSprite(shell);
                shell.isActive = true;
                this._shells.push(shell);
                shell.addOnBoundary(function (dir) {
                    _this.kill(shell);
                    _this.autoFireIfEnemy(shell);
                });
                return shell;
            };
            SpriteManager.prototype.addAExplosion = function () {
                var _this = this;
                var explosion; //不加这行不能识别，可能是 TypeScript BUG
                var explosion = new JsGame.ConcreteSprite.Explosion(this._explosionImages, 32, 32);
                this.AddNewSprite(explosion);
                explosion.isActive = true;
                this._explosions.push(explosion);
                explosion.addExploded(function () {
                    _this.kill(explosion);
                });
                return explosion;
            };
            SpriteManager.prototype.kill = function (sprite) {
                if (sprite instanceof JsGame.ConcreteSprite.PlayerTank) {
                    hxy.Helper.removeFromArray(this._players, sprite);
                }
                else if (sprite instanceof JsGame.ConcreteSprite.EnemyTank) {
                    hxy.Helper.removeFromArray(this._enemies, sprite);
                }
                else if (sprite instanceof JsGame.ConcreteSprite.Shell) {
                    hxy.Helper.removeFromArray(this._shells, sprite);
                }
                else if (sprite instanceof JsGame.ConcreteSprite.Explosion) {
                    hxy.Helper.removeFromArray(this._explosions, sprite);
                }
                hxy.Helper.removeFromArray(this._allSprites, sprite);
                this._divMain.removeChild(sprite.div);
            };
            SpriteManager.prototype.setRandomPosWithoutCollision = function (tank) {
                do {
                    var initX = Math.round(Math.random() * (this._availWidth - tank.width));
                    var initY = Math.round(Math.random() * (this._availHeight - tank.height));
                    tank.setPos(initX, initY);
                } while (this.isCollisionHappen(tank));
            };
            SpriteManager.prototype.isCollisionHappen = function (tank) {
                for (var i = 0; i < this._allSprites.length; i++) {
                    var sprite2 = this._allSprites[i];
                    if (tank != sprite2 && tank.isCollided(sprite2)) {
                        return true;
                    }
                }
                return false;
            };
            SpriteManager.prototype.autoFireIfEnemy = function (shell) {
                var _this = this;
                if (!shell.isPlayerShell) {
                    //先检测这个敌方坦克还活着。
                    var tank = shell.ownerTank;
                    var sprites = this._allSprites;
                    var isAlive = sprites.indexOf(tank) >= 0;
                    if (isAlive) {
                        //不要发射得太快。
                        setTimeout(function () { return _this.fire(tank); }, 500);
                    }
                }
            };
            SpriteManager.prototype.fire = function (tank) {
                var frontierX = 0;
                var frontierY = 0;
                switch (tank.direction) {
                    case 2 /* Left */:
                        frontierX = tank.x;
                        frontierY = tank.y + tank.height / 2;
                        break;
                    case 3 /* Right */:
                        frontierX = tank.x + tank.width;
                        frontierY = tank.y + tank.height / 2;
                        break;
                    case 0 /* Up */:
                        frontierX = tank.x + tank.width / 2;
                        frontierY = tank.y;
                        break;
                    case 1 /* Down */:
                        frontierX = tank.x + tank.width / 2;
                        frontierY = tank.y + tank.height;
                        break;
                }
                //在该点产生炮弹
                var shell = this.addAShell(tank);
                shell.setPos(frontierX - shell.width / 2, frontierY - shell.height / 2);
                shell.direction = tank.direction;
                shell.speed = tank.speed + 3;
            };
            return SpriteManager;
        })();
        JsGame.SpriteManager = SpriteManager;
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=SpriteManager.js.map