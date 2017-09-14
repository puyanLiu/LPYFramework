module hxy.JsGame {
    export class SpriteManager implements Interface.ISpriteManager {
        private _divMain: HTMLElement;

        private _allSprites: Common.SpriteBase[];
        private _players: ConcreteSprite.PlayerTank[];
        private _enemies: ConcreteSprite.EnemyTank[];
        private _explosions: ConcreteSprite.Explosion[];
        private _shells: ConcreteSprite.Shell[];

        private _playerImages: string[];
        private _enemyImages: string[];
        private _explosionImages: string[];
        private _shellImages: string[];

        private _availHeight: number;
        private _availWidth: number;

        constructor(
            divMain: HTMLElement,
            playerImages: string[],
            enemyImages: string[],
            explosionImages: string[],
            shellImages: string[]
            ) {
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

        get allSprites() {
            return this._allSprites;
        }
        get explosions() {
            return this._explosions;
        }

        private InitAndAdd(sprite: Common.SpriteBase) {
            sprite.maxLeft = 0;
            sprite.maxTop = 0;
            sprite.maxBottom = this._availHeight - sprite.height;
            sprite.maxRight = this._availWidth - sprite.width;

            this._allSprites.push(sprite);
            this._divMain.appendChild(sprite.div);
        }

        AddAPlayer() {
            var player = new ConcreteSprite.PlayerTank(this._playerImages, 45, 45, this);

            this.InitAndAdd(player);

            player.speed = 5;
            player.isActive = false;
            player.ChangeARandomDirection();

            this.SetRandomPosWithoutCollision(player);

            this._players.push(player);

            return player;
        }
        AddAEnemy() {
            var enemy = new ConcreteSprite.EnemyTank(this._enemyImages, 45, 45, this);

            this.InitAndAdd(enemy);

            enemy.speed = 5;
            enemy.isActive = true;
            enemy.ChangeARandomDirection();

            this.SetRandomPosWithoutCollision(enemy);

            this._enemies.push(enemy);

            return enemy;
        }
        AddAShell(fatherTank) {
            var shell = new ConcreteSprite.Shell(this._shellImages, 9, 9, fatherTank, this);

            this.InitAndAdd(shell);

            shell.isActive = true;

            this._shells.push(shell);

            return shell;
        }
        AddAExplosion() {
            var explosion = new ConcreteSprite.Explosion(this._explosionImages, 32, 32, this);
            this.InitAndAdd(explosion);

            explosion.isActive = true;

            this._explosions.push(explosion);

            return explosion;
        }
        Kill(sprite: Common.SpriteBase) {
            var ct = sprite.collisionType;
            if (ct == Enum.CollisionType.PlayerTank) {
                Helper.RemoveFromArray(this._players, sprite);
            }
            else if (ct == Enum.CollisionType.EnemyTank) {
                Helper.RemoveFromArray(this._enemies, sprite);
            }
            else if (ct == Enum.CollisionType.PlayerShell || ct == Enum.CollisionType.EnemyShell) {
                Helper.RemoveFromArray(this._shells, sprite);
            }
            else if (ct == Enum.CollisionType.Explosion) {
                Helper.RemoveFromArray(this._explosions, sprite);
            }

            Helper.RemoveFromArray(this._allSprites, sprite);
            this._divMain.removeChild(sprite.div);
        }
        SetRandomPosWithoutCollision(tank: ConcreteSprite.TankBase) {
            var initX, initY;
            do {
                initX = Math.round(Math.random() * (this._availWidth - tank.width));
                initY = Math.round(Math.random() * (this._availHeight - tank.height));
                tank.setPos(initX, initY);
            } while (this.IsCollisionHappen(tank));
        }
        IsCollisionHappen(tank: ConcreteSprite.TankBase) {
            if (tank.collisionType == Enum.CollisionType.PlayerTank) { //player
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
        }
    }
}