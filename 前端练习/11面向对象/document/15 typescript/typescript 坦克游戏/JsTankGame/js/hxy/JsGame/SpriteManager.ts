module hxy.JsGame {
    //管理所有精灵的生命周期
    export class SpriteManager {
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
        private _barrierImages: string[];

        private _availHeight: number;
        private _availWidth: number;

        constructor(
            divMain: HTMLElement,
            playerImages: string[],
            enemyImages: string[],
            explosionImages: string[],
            shellImages: string[],
            barrierImages: string[]
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
            this._barrierImages = barrierImages;

            this._availHeight = divMain.clientHeight - window.screenTop;
            this._availWidth = divMain.clientWidth - window.screenLeft;
            //this._availHeight = window.screen.availHeight - window.screenTop - 25;
            //this._availWidth = window.screen.availWidth - window.screenLeft - 25;
        }

        get allSprites() {
            return this._allSprites;
        }
        get explosions() {
            return this._explosions;
        }
        get maxWidth() {
            return this._availWidth;
        }
        get maxHeight() {
            return this._availHeight;
        }

        private AddNewSprite(sprite: Common.SpriteBase) {
            sprite.maxLeft = this._divMain.offsetLeft;
            sprite.maxTop = this._divMain.offsetTop;
            sprite.maxBottom = this._availHeight - sprite.height;
            sprite.maxRight = this._availWidth - sprite.width;

            this._allSprites.push(sprite);
            this._divMain.appendChild(sprite.div);
        }

        addAPlayer() {
            var player = new ConcreteSprite.PlayerTank(this._playerImages, 45, 45);

            this.AddNewSprite(player);

            player.speed = 5;
            player.isActive = false;
            player.changeARandomDirection();

            this.setRandomPosWithoutCollision(player);

            this._players.push(player);

            return player;
        }
        addAEnemy() {
            var enemy: ConcreteSprite.EnemyTank;//不加这行不能识别，可能是 TypeScript BUG
            var enemy = new ConcreteSprite.EnemyTank(this._enemyImages, 45, 45);

            this.AddNewSprite(enemy);

            enemy.speed = 5;
            enemy.isActive = true;
            enemy.changeARandomDirection();

            this.setRandomPosWithoutCollision(enemy);

            this._enemies.push(enemy);

            enemy.addOnBoundary(dir => {
                enemy.changeARandomDirection();
            });

            return enemy;
        }
        bombAt(sprite: Common.SpriteBase) {
            //在某个精灵的位置，放置一个炸弹。
            var exp = this.addAExplosion();
            var centerX = sprite.x + sprite.width / 2 - exp.width / 2;
            var centerY = sprite.y + sprite.height / 2 - exp.height / 2;
            exp.setPos(centerX, centerY);
        }
        addABarrier() {
            var barrier = new ConcreteSprite.Barrier(this._barrierImages, 64, 64);
            //var barrier = new ConcreteSprite.Barrier(this._barrierImages, 32, 32);

            this.AddNewSprite(barrier);
            barrier.isActive = false;

            return barrier;
        }
        private addAShell(fatherTank) {
            var shell: ConcreteSprite.Shell;//不加这行不能识别，可能是 TypeScript BUG
            var shell = new ConcreteSprite.Shell(this._shellImages, 9, 9, fatherTank);

            this.AddNewSprite(shell);

            shell.isActive = true;

            this._shells.push(shell);

            shell.addOnBoundary(dir => {
                this.kill(shell);
                this.autoFireIfEnemy(shell);
            });

            return shell;
        }
        private addAExplosion() {
            var explosion: ConcreteSprite.Explosion;//不加这行不能识别，可能是 TypeScript BUG
            var explosion = new ConcreteSprite.Explosion(this._explosionImages, 32, 32);
            this.AddNewSprite(explosion);

            explosion.isActive = true;

            this._explosions.push(explosion);

            explosion.addExploded(() => {
                this.kill(explosion);
            });

            return explosion;
        }
        kill(sprite: Common.SpriteBase) {
            if (sprite instanceof ConcreteSprite.PlayerTank) {
                Helper.removeFromArray(this._players, sprite);
            }
            else if (sprite instanceof ConcreteSprite.EnemyTank) {
                Helper.removeFromArray(this._enemies, sprite);
            }
            else if (sprite instanceof ConcreteSprite.Shell) {
                Helper.removeFromArray(this._shells, sprite);
            }
            else if (sprite instanceof ConcreteSprite.Explosion) {
                Helper.removeFromArray(this._explosions, sprite);
            }

            Helper.removeFromArray(this._allSprites, sprite);
            this._divMain.removeChild(sprite.div);
        }
        private setRandomPosWithoutCollision(tank: ConcreteSprite.TankBase) {
            do {
                var initX = Math.round(Math.random() * (this._availWidth - tank.width));
                var initY = Math.round(Math.random() * (this._availHeight - tank.height));
                tank.setPos(initX, initY);
            } while (this.isCollisionHappen(tank));
        }
        private isCollisionHappen(tank: ConcreteSprite.TankBase) {
            for (var i = 0; i < this._allSprites.length; i++) {
                var sprite2 = this._allSprites[i];
                if (tank != sprite2 && tank.isCollided(sprite2)) {
                    return true;
                }
            }
            return false;
        }

        autoFireIfEnemy(shell: ConcreteSprite.Shell) {
            if (!shell.isPlayerShell) {
                //先检测这个敌方坦克还活着。
                var tank = shell.ownerTank;
                var sprites = this._allSprites;
                var isAlive = sprites.indexOf(tank) >= 0;

                if (isAlive) {
                    //不要发射得太快。
                    setTimeout(() => this.fire(tank), 500);
                }
            }
        }
        fire(tank: ConcreteSprite.TankBase) {
            var frontierX = 0;
            var frontierY = 0;
            switch (tank.direction) {
                case Enum.Direction.Left:
                    frontierX = tank.x;
                    frontierY = tank.y + tank.height / 2;
                    break;

                case Enum.Direction.Right:
                    frontierX = tank.x + tank.width;
                    frontierY = tank.y + tank.height / 2;
                    break;

                case Enum.Direction.Up:
                    frontierX = tank.x + tank.width / 2;
                    frontierY = tank.y;
                    break;

                case Enum.Direction.Down:
                    frontierX = tank.x + tank.width / 2;
                    frontierY = tank.y + tank.height;
                    break;
            }

            //在该点产生炮弹
            var shell = this.addAShell(tank);
            shell.setPos(frontierX - shell.width / 2, frontierY - shell.height / 2);
            shell.direction = tank.direction;
            shell.speed = tank.speed + 3;
        }
    }
}