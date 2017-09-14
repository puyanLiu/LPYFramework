module hxy.JsGame.ConcreteSprite {
    export class EnemyTank extends TankBase {
        get collisionType() {
            return Enum.CollisionType.EnemyTank;
        }

        OnBoundary() {
            this.ChangeARandomDirection();
        }

        OnCollided(targetRect: Common.Rectangle, targetCollisionType: Enum.CollisionType, isInitiative: boolean) {
            if (targetCollisionType == Enum.CollisionType.PlayerTank ||
                targetCollisionType == Enum.CollisionType.EnemyTank
                ) {
                if (isInitiative) {
                    this.FarAwayFrom(targetRect);
                }
            }
            else if (targetCollisionType == Enum.CollisionType.PlayerShell) {
                this.OnShotted();
            }
            else if (targetCollisionType == Enum.CollisionType.Barrier) {
                this.FarAwayFrom(targetRect);
            }
        }
    }
}