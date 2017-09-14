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
            var PlayerTank = (function (_super) {
                __extends(PlayerTank, _super);
                function PlayerTank() {
                    _super.apply(this, arguments);
                }
                Object.defineProperty(PlayerTank.prototype, "collisionType", {
                    get: function () {
                        return 1 /* PlayerTank */;
                    },
                    enumerable: true,
                    configurable: true
                });
                PlayerTank.prototype.OnCollided = function (targetRect, targetCollisionType, isInitiative) {
                    //collide a enemy tank
                    if (targetCollisionType == 2 /* EnemyTank */) {
                        if (isInitiative) {
                            this.FarAwayFrom(targetRect);
                        }
                    }
                    else if (targetCollisionType == 8 /* EnemyShell */) {
                    }
                    else if (targetCollisionType == 32 /* Barrier */) {
                        this.FarAwayFrom(targetRect);
                    }
                };
                return PlayerTank;
            })(ConcreteSprite.TankBase);
            ConcreteSprite.PlayerTank = PlayerTank;
        })(ConcreteSprite = JsGame.ConcreteSprite || (JsGame.ConcreteSprite = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=PlayerTank.js.map