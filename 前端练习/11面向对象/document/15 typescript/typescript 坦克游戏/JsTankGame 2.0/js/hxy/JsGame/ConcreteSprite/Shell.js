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
            var Shell = (function (_super) {
                __extends(Shell, _super);
                function Shell(imagePathes, width, height, myTank, manager) {
                    _super.call(this, imagePathes, width, height, manager);
                    this._myTank = myTank;
                    this.imageIndex = this.IsPlayerShell() ? 0 : 1;
                }
                Object.defineProperty(Shell.prototype, "myTank", {
                    get: function () {
                        return this._myTank;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(Shell.prototype, "collisionType", {
                    get: function () {
                        return this.IsPlayerShell() ? 4 /* PlayerShell */ : 8 /* EnemyShell */;
                    },
                    enumerable: true,
                    configurable: true
                });
                Shell.prototype.OnBoundary = function () {
                    this.manager.Kill(this);
                    this.InformMyTank();
                };
                Shell.prototype.OnCollided = function (targetRect, targetCollisionType, isInitiative) {
                    //remove me from applet if collided
                    if (this.IsPlayerShell() && targetCollisionType == 2 /* EnemyTank */ || !this.IsPlayerShell() && targetCollisionType == 1 /* PlayerTank */) {
                        this.manager.Kill(this);
                        this.InformMyTank();
                    }
                    else if (targetCollisionType == 32 /* Barrier */) {
                        this.manager.Kill(this);
                        this.InformMyTank();
                        this.Bomb();
                    }
                };
                Shell.prototype.InformMyTank = function () {
                    var fireAfterMilliSeconds = 20;
                    if (!this.IsPlayerShell()) {
                        this._myTank.FireAfter(fireAfterMilliSeconds);
                    }
                };
                Shell.prototype.IsPlayerShell = function () {
                    return this._myTank.collisionType == 1 /* PlayerTank */;
                };
                Shell.prototype.Bomb = function () {
                    var e = this.manager.AddAExplosion();
                    var centerX = this.x + this.width / 2 - e.width / 2;
                    var centerY = this.y + this.height / 2 - e.height / 2;
                    e.setPos(centerX, centerY);
                };
                return Shell;
            })(JsGame.Common.SpriteBase);
            ConcreteSprite.Shell = Shell;
        })(ConcreteSprite = JsGame.ConcreteSprite || (JsGame.ConcreteSprite = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=Shell.js.map