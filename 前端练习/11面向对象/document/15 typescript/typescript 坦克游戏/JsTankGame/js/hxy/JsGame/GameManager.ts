module hxy.JsGame {
    //游戏管理器、游戏引擎入口
    export class GameManager {
        private _spriteManager: SpriteManager;
        private _collisionManager: CollisionManager;
        private _player: ConcreteSprite.PlayerTank;
        private _enemiesCount: number;
        private _enemiesDeadCount = 0;

        constructor(spriteManager: SpriteManager) {
            this._spriteManager = spriteManager;
            this._collisionManager = new CollisionManager(spriteManager);
        }

        startGame(enemiesCount = 5) {
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
            this._collisionManager.addOnEnemyDead(() => {
                this._enemiesDeadCount++;
                if (this._enemiesDeadCount == this._enemiesCount) {
                    alert("恭喜，敌机已全部击杀，游戏胜利！");
                }
            });

            //键盘事件。
            document.addEventListener("keydown", e => this.keyDown(e));
            document.addEventListener("keyup", e => this.keyUp(e));

            //启动线程定时更新精灵状态
            setInterval(() => this.runEngine(), 20);
            setInterval(() => this.updateExplosionFrame(), 100);

            //3秒后关闭玩家的无敌
            this._collisionManager.isPlayerInvincible = true;
            setTimeout(() => {
                this._collisionManager.isPlayerInvincible = false;
            }, 3000);
        }
        private runEngine() {
            for (var i = 0; i < this._spriteManager.allSprites.length; i++) {
                var sprite = this._spriteManager.allSprites[i];
                sprite.move();

                this._collisionManager.dealCollideSprites(sprite);
            
                //change enemy direction by a random time span
                if (Math.random() * 100 < 1 &&
                    sprite instanceof ConcreteSprite.EnemyTank) {
                    sprite.changeARandomDirection();
                }
            }
        }
        private updateExplosionFrame() {
            this._spriteManager.explosions.forEach(function (explosion: ConcreteSprite.Explosion) {
                if (explosion.isVisible) {
                    explosion.updateFrame();
                }
            });
        }

        keyDown(e: KeyboardEvent) {
            switch (e.keyCode) {
                case KeyCodes.left:
                    this._player.direction = Enum.Direction.Left;
                    this._player.isActive = true;
                    break;
                case KeyCodes.up:
                    this._player.direction = Enum.Direction.Up;
                    this._player.isActive = true;
                    break;
                case KeyCodes.right:
                    this._player.direction = Enum.Direction.Right;
                    this._player.isActive = true;
                    break;
                case KeyCodes.down:
                    this._player.direction = Enum.Direction.Down;
                    this._player.isActive = true;
                    break;
            }
        }
        keyUp(e) {
            this._player.isActive = false;
            switch (e.keyCode) {
                case KeyCodes.space:
                    this._spriteManager.fire(this._player);
                    break;
            }
        }
    }
}