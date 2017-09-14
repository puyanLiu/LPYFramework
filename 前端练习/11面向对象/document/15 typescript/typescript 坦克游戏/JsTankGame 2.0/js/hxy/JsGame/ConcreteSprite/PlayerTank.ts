module hxy.JsGame.ConcreteSprite {
    export class PlayerTank extends TankBase {
        get collisionType() {
            return Enum.CollisionType.PlayerTank;
        }

        OnCollided(targetRect: Common.Rectangle, targetCollisionType: Enum.CollisionType, isInitiative: boolean) {
            //collide a enemy tank
            if (targetCollisionType == Enum.CollisionType.EnemyTank) {
                if (isInitiative) {
                    this.FarAwayFrom(targetRect);
                }
            }
            //collide a shell of enemy
            else if (targetCollisionType == Enum.CollisionType.EnemyShell) {
                //this.OnShotted();
            }
            else if (targetCollisionType == Enum.CollisionType.Barrier) {
                this.FarAwayFrom(targetRect);
            }
        }
    }
}