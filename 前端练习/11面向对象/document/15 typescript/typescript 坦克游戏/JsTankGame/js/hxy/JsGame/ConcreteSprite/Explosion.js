var __extends = this.__extends || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
/// <reference path="../common/spritebase.ts" />
var hxy;
(function (hxy) {
    var JsGame;
    (function (JsGame) {
        var ConcreteSprite;
        (function (ConcreteSprite) {
            var Explosion = (function (_super) {
                __extends(Explosion, _super);
                function Explosion() {
                    _super.apply(this, arguments);
                    this._handlers = new hxy.EventList();
                }
                Explosion.prototype.updateFrame = function () {
                    this.imageIndex += 1;
                    if (this.imageIndex >= this.images.length) {
                        this.imageIndex = 0;
                        this.onExploded();
                    }
                };
                Explosion.prototype.onExploded = function () {
                    this._handlers.fire(function (t) { return t(); });
                };
                Explosion.prototype.addExploded = function (handler) {
                    this._handlers.add(handler);
                };
                return Explosion;
            })(JsGame.Common.SpriteBase);
            ConcreteSprite.Explosion = Explosion;
        })(ConcreteSprite = JsGame.ConcreteSprite || (JsGame.ConcreteSprite = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=Explosion.js.map