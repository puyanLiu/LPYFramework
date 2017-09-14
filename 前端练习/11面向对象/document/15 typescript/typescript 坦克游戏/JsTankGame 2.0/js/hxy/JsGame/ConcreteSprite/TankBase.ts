module hxy.JsGame.ConcreteSprite {
    export class TankBase extends Common.SpriteBase {
        static FIRE_AFTER = 500;

        protected onDirectionChanged(value: Enum.Direction) {
            super.onDirectionChanged(value);
            switch (value) {
                case Enum.Direction.Left:
                    this.imageIndex = 0;
                    break;
                case Enum.Direction.Right:
                    this.imageIndex = 1;
                    break;
                case Enum.Direction.Up:
                    this.imageIndex = 2;
                    break;
                case Enum.Direction.Down:
                    this.imageIndex = 3;
                    break;
            }
        }

        Fire() {
            var sprites = this.manager.allSprites;
            if (sprites.indexOf(this) < 0) {
                return;
            }

            var frontierX = 0;
            var frontierY = 0;
            switch (this.direction) {
                case Enum.Direction.Left:
                    frontierX = this.x;
                    frontierY = this.y + this.height / 2;
                    break;

                case Enum.Direction.Right:
                    frontierX = this.x + this.width;
                    frontierY = this.y + this.height / 2;
                    break;

                case Enum.Direction.Up:
                    frontierX = this.x + this.width / 2;
                    frontierY = this.y;
                    break;

                case Enum.Direction.Down:
                    frontierX = this.x + this.width / 2;
                    frontierY = this.y + this.height;
                    break;
            }
            //在该点产生炮弹
            var shell = this.manager.AddAShell(this);
            shell.setPos(frontierX - shell.width / 2,
                frontierY - shell.height / 2);
            shell.direction = this.direction;
            shell.speed = this.speed + 3;
        }

        FireAfter(time: number) {
            setTimeout(() => {
                this.Fire();
            }, time);
        }

        protected OnShotted() {
            var exp = this.manager.AddAExplosion();
            var centerX = this.x + this.width / 2 - exp.width / 2;
            var centerY = this.y + this.height / 2 - exp.height / 2;
            exp.setPos(centerX, centerY);
            this.manager.Kill(this);
        }
    }
}