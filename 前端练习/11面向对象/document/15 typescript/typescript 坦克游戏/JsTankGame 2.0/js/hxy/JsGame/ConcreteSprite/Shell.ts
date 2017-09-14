module hxy.JsGame.ConcreteSprite {
    export class Shell extends Common.SpriteBase {
        private _myTank: TankBase;

        constructor(imagePathes: string[], width: number, height: number, myTank: TankBase, manager: Interface.ISpriteManager) {
            super(imagePathes, width, height, manager);
            this._myTank = myTank;
            this.imageIndex = this.IsPlayerShell() ? 0 : 1;
        }

        get myTank() {
            return this._myTank;
        }
        get collisionType() {
            return this.IsPlayerShell() ?
                Enum.CollisionType.PlayerShell :
                Enum.CollisionType.EnemyShell;
        }

        OnBoundary() {
            this.manager.Kill(this);
            this.InformMyTank();
        }
        OnCollided(targetRect: Common.Rectangle, targetCollisionType: Enum.CollisionType, isInitiative: boolean) {
            //remove me from applet if collided
            if (this.IsPlayerShell() && targetCollisionType == Enum.CollisionType.EnemyTank ||
                !this.IsPlayerShell() && targetCollisionType == Enum.CollisionType.PlayerTank
                ) {
                this.manager.Kill(this);
                this.InformMyTank();
            }
            else if (targetCollisionType == Enum.CollisionType.Barrier) {
                this.manager.Kill(this);
                this.InformMyTank();
                this.Bomb();
            }
        }
        InformMyTank() {
            var fireAfterMilliSeconds = 20;
            if (!this.IsPlayerShell()) {
                this._myTank.FireAfter(fireAfterMilliSeconds);
            }
        }
        IsPlayerShell() {
            return this._myTank.collisionType == Enum.CollisionType.PlayerTank;
        }
        Bomb() {
            var e = this.manager.AddAExplosion();
            var centerX = this.x + this.width / 2 - e.width / 2;
            var centerY = this.y + this.height / 2 - e.height / 2;
            e.setPos(centerX, centerY);
        }
    }
}