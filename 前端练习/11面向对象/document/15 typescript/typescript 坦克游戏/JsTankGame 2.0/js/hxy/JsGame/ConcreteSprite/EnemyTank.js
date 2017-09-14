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
            var EnemyTank = (function (_super) {
                __extends(EnemyTank, _super);
                function EnemyTank() {
                    _super.apply(this, arguments);
                }
                Object.defineProperty(EnemyTank.prototype, "collisionType", {
                    get: function () {
                        return 2 /* EnemyTank */;
                    },
                    enumerable: true,
                    configurable: true
                });
                EnemyTank.prototype.OnBoundary = function () {
                    this.ChangeARandomDirection();
                };
                EnemyTank.prototype.OnCollided = function (targetRect, targetCollisionType, isInitiative) {
                    if (targetCollisionType == 1 /* PlayerTank */ || targetCollisionType == 2 /* EnemyTank */) {
                        if (isInitiative) {
                            this.FarAwayFrom(targetRect);
                        }
                    }
                    else if (targetCollisionType == 4 /* PlayerShell */) {
                        this.OnShotted();
                    }
                    else if (targetCollisionType == 32 /* Barrier */) {
                        this.FarAwayFrom(targetRect);
                    }
                };
                return EnemyTank;
            })(ConcreteSprite.TankBase);
            ConcreteSprite.EnemyTank = EnemyTank;
        })(ConcreteSprite = JsGame.ConcreteSprite || (JsGame.ConcreteSprite = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=EnemyTank.js.map