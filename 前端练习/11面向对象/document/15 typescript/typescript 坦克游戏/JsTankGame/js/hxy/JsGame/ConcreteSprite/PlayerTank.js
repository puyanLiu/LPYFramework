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
            var PlayerTank = (function (_super) {
                __extends(PlayerTank, _super);
                function PlayerTank() {
                    _super.apply(this, arguments);
                }
                return PlayerTank;
            })(ConcreteSprite.TankBase);
            ConcreteSprite.PlayerTank = PlayerTank;
        })(ConcreteSprite = JsGame.ConcreteSprite || (JsGame.ConcreteSprite = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=PlayerTank.js.map