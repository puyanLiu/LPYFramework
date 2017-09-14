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
            var TankBase = (function (_super) {
                __extends(TankBase, _super);
                function TankBase() {
                    _super.apply(this, arguments);
                }
                TankBase.prototype.onDirectionChanged = function (value) {
                    _super.prototype.onDirectionChanged.call(this, value);
                    switch (value) {
                        case 2 /* Left */:
                            this.imageIndex = 0;
                            break;
                        case 3 /* Right */:
                            this.imageIndex = 1;
                            break;
                        case 0 /* Up */:
                            this.imageIndex = 2;
                            break;
                        case 1 /* Down */:
                            this.imageIndex = 3;
                            break;
                    }
                };
                TankBase.FIRE_AFTER = 500;
                return TankBase;
            })(JsGame.Common.SpriteBase);
            ConcreteSprite.TankBase = TankBase;
        })(ConcreteSprite = JsGame.ConcreteSprite || (JsGame.ConcreteSprite = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=tankbase.js.map