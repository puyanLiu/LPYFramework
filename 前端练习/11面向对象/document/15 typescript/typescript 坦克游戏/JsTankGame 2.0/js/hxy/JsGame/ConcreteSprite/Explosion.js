var __extends = this.__extends || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
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
                    this._frameNow = 0;
                }
                Object.defineProperty(Explosion.prototype, "collisionType", {
                    get: function () {
                        return 16 /* Explosion */;
                    },
                    enumerable: true,
                    configurable: true
                });
                Explosion.prototype.UpdateFrame = function () {
                    this._frameNow += 1;
                    if (this._frameNow >= this.images.length) {
                        this._frameNow = 0;
                        //frame is over,kill me.
                        this.manager.Kill(this);
                    }
                    this.imageIndex = this._frameNow;
                };
                return Explosion;
            })(JsGame.Common.SpriteBase);
            ConcreteSprite.Explosion = Explosion;
        })(ConcreteSprite = JsGame.ConcreteSprite || (JsGame.ConcreteSprite = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=Explosion.js.map