/// <reference path="../Common/SpriteBase.ts" />
module hxy.JsGame.ConcreteSprite {
    export class Shell extends Common.SpriteBase {
        private _ownerTank: TankBase;

        constructor(imagePathes: string[], width: number, height: number, myTank: TankBase) {
            super(imagePathes, width, height);

            this._ownerTank = myTank;
            this.imageIndex = this.isPlayerShell ? 0 : 1;
        }

        get ownerTank() {
            return this._ownerTank;
        }

        get isPlayerShell() {
            return this._ownerTank instanceof ConcreteSprite.PlayerTank;
        }
    }
}