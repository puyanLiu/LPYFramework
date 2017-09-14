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
            var Shell = (function (_super) {
                __extends(Shell, _super);
                function Shell(imagePathes, width, height, myTank) {
                    _super.call(this, imagePathes, width, height);
                    this._ownerTank = myTank;
                    this.imageIndex = this.isPlayerShell ? 0 : 1;
                }
                Object.defineProperty(Shell.prototype, "ownerTank", {
                    get: function () {
                        return this._ownerTank;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(Shell.prototype, "isPlayerShell", {
                    get: function () {
                        return this._ownerTank instanceof ConcreteSprite.PlayerTank;
                    },
                    enumerable: true,
                    configurable: true
                });
                return Shell;
            })(JsGame.Common.SpriteBase);
            ConcreteSprite.Shell = Shell;
        })(ConcreteSprite = JsGame.ConcreteSprite || (JsGame.ConcreteSprite = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=Shell.js.map