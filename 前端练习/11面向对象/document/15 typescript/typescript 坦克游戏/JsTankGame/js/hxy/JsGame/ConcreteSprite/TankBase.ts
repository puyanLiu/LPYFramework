/// <reference path="../Common/SpriteBase.ts" />
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
    }
}