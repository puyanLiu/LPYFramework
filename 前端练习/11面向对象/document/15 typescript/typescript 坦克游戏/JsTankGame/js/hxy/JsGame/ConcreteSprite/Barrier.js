/// <reference path="../common/spritebase.ts" />
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
            var Barrier = (function (_super) {
                __extends(Barrier, _super);
                function Barrier() {
                    _super.apply(this, arguments);
                }
                return Barrier;
            })(JsGame.Common.SpriteBase);
            ConcreteSprite.Barrier = Barrier;
        })(ConcreteSprite = JsGame.ConcreteSprite || (JsGame.ConcreteSprite = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=Barrier.js.map