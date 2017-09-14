/// <reference path="../Common/SpriteBase.ts" />
module hxy.JsGame.ConcreteSprite {
    export class Explosion extends Common.SpriteBase {
        private _handlers = new EventList<Action>();

        updateFrame() {
            this.imageIndex += 1;
            if (this.imageIndex >= this.images.length) {
                this.imageIndex = 0;

                this.onExploded();
            }
        }
        private onExploded() {
            this._handlers.fire(t => t());
        }
        addExploded(handler: Action) {
            this._handlers.add(handler);
        }
    }
}