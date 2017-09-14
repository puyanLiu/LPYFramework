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
            var TankBase = (function (_super) {
                __extends(TankBase, _super);
                function TankBase() {
                    _super.apply(this, arguments);
                }
                TankBase.prototype.onDirectionChanged = function (value) {
                    _super.prototype.onDirectionChanged.call(this, value);
                    switch (value) {
                        case 4 /* Left */:
                            this.imageIndex = 0;
                            break;
                        case 8 /* Right */:
                            this.imageIndex = 1;
                            break;
                        case 1 /* Up */:
                            this.imageIndex = 2;
                            break;
                        case 2 /* Down */:
                            this.imageIndex = 3;
                            break;
                    }
                };
                TankBase.prototype.Fire = function () {
                    var sprites = this.manager.allSprites;
                    if (sprites.indexOf(this) < 0) {
                        return;
                    }
                    var frontierX = 0;
                    var frontierY = 0;
                    switch (this.direction) {
                        case 4 /* Left */:
                            frontierX = this.x;
                            frontierY = this.y + this.height / 2;
                            break;
                        case 8 /* Right */:
                            frontierX = this.x + this.width;
                            frontierY = this.y + this.height / 2;
                            break;
                        case 1 /* Up */:
                            frontierX = this.x + this.width / 2;
                            frontierY = this.y;
                            break;
                        case 2 /* Down */:
                            frontierX = this.x + this.width / 2;
                            frontierY = this.y + this.height;
                            break;
                    }
                    //在该点产生炮弹
                    var shell = this.manager.AddAShell(this);
                    shell.setPos(frontierX - shell.width / 2, frontierY - shell.height / 2);
                    shell.direction = this.direction;
                    shell.speed = this.speed + 3;
                };
                TankBase.prototype.FireAfter = function (time) {
                    var _this = this;
                    setTimeout(function () {
                        _this.Fire();
                    }, time);
                };
                TankBase.prototype.OnShotted = function () {
                    var exp = this.manager.AddAExplosion();
                    var centerX = this.x + this.width / 2 - exp.width / 2;
                    var centerY = this.y + this.height / 2 - exp.height / 2;
                    exp.setPos(centerX, centerY);
                    this.manager.Kill(this);
                };
                TankBase.FIRE_AFTER = 500;
                return TankBase;
            })(JsGame.Common.SpriteBase);
            ConcreteSprite.TankBase = TankBase;
        })(ConcreteSprite = JsGame.ConcreteSprite || (JsGame.ConcreteSprite = {}));
    })(JsGame = hxy.JsGame || (hxy.JsGame = {}));
})(hxy || (hxy = {}));
//# sourceMappingURL=TankBase.js.map