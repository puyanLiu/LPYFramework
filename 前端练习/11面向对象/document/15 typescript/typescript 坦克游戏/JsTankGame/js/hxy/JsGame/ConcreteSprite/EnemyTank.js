var __extends = this.__extends || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
/// <reference path="tankbase.ts" />
var hxy;
(function (hxy) {
    var JsGame;
    (function (JsGame) {
        var ConcreteSprite;
        (function (ConcreteSprite) {
            var EnemyTank = (function (_super) {
                __extends(EnemyTank, _super);
                function EnemyTank() {
                    _super.apply(this, arguments);
                }
                return EnemyTank;
            })(ConcreteSprite.TankBase);
            ConcreteSprite.EnemyTank = EnemyTank;
        })(ConcreteSprite = JsGame.ConcreteSprite || (JsGame.ConcreteSprite = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=EnemyTank.js.map